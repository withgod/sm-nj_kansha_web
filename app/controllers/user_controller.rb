class UserController < ApplicationController
  require 'steam-condenser'
  def search
    @nicks = NjSteamNickname.where('nickname like ?', "%#{params[:q]}%").order(:nickname)
  end
  def index
    @rank_start = 0;
    if params[:page].to_i > 1 then
      @rank_start = (params[:page].to_i - 1 )* 50
    end
    @ranking          = NjSteamid.ranking_scope.page(params[:page])
    @ranking_demo     = NjSteamid.ranking_scope_demo.page(params[:page])
    @ranking_sol      = NjSteamid.ranking_scope_sol.page(params[:page])
    @ranking_starters = NjSteamid.ranking_scope_starters.page(params[:page])

    @infoc            = SteamId.class_variable_get(:@@cache)
  end

  def recent_20_activity
      @result =  NjSteamid.find_all_by_steamcomid(params[:id]).last.results.daily_count.limit(20)

    respond_to do |format|
      format.json {render :json => @result.reverse.to_json}
    end
  end

  def most_played_map20
      @result =  NjSteamid.find_all_by_steamcomid(params[:id]).last.results
                .all(:select => 'nj_map_id, count(id) as cnt, sum(jump_count) as jump_total', :group => 'nj_map_id', :order => 'cnt desc', :limit => 20)

    respond_to do |format|
      format.json {render :json => @result, :include => {:nj_map => {:only => [:mapname, :id]}}}
    end
  end

  def rank
    @rank_start = 0;
    if params[:page].to_i > 1 then
      @rank_start = (params[:page].to_i - 1 )* 50
    end

    _type = 'nj_kansha_results.nj_class_id in (3, 4)'
    if params[:type] == 'demo' then
      _type = 'nj_kansha_results.nj_class_id = 4'
    elsif params[:type] == 'sol' then
      _type = 'nj_kansha_results.nj_class_id = 3'
    end

    @ranking = NjSteamid
    .select('nj_steamids.*,  nj_maps.mapname as last_mapname, count(nj_kansha_results.id) as challenge_count, sum(nj_kansha_results.jump_count) as jump_count, nj_map_id, nj_kansha_results.created_at')
    .joins('left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id')
    .group('nj_steamids.id')
    .order('jump_count desc')
    .where('jump_count > 0 and ' + _type)
    .joins('left join nj_steam_nicknames on nj_steamids.id = nj_steam_nicknames.nj_steamid_id')
    .joins('left join nj_maps on nj_kansha_results.nj_map_id = nj_maps.id')
    .page(params[:page])

    respond_to do |format|
      format.html
      format.json {render :json => @ranking.to_json(:include => [:nicknames])}
    end
  end

  def detail
    require 'pp'
    begin
      @steaminfo = SteamId.new(params[:id].to_i)
      if Rails.env.development? ||
        @steaminfo.fetch.to_i + 60 * 5 < Time.now.to_i then
        @steaminfo.fetch
      end
    rescue SteamCondenserError => e
      @steaminfo = SteamIdDummy.new(params[:id].to_i);
    end
    @user      = NjSteamid.find_all_by_steamcomid(params[:id]).last
  end
end
class SteamIdDummy
  def initialize(id)
    @id = id
  end
  def dummy
    return true;
  end
  def full_avatar_url
    return 'http://media.steampowered.com/steamcommunity/public/images/avatars/fe/fef49e7fa7e1997310d705b2a6158ff8dc1cdfeb_full.jpg'
  end
  def is_online?
    return nil
  end
  def nickname
    return ''
  end
  def member_since
    return '0000-00-00 00:00:00'
  end
  def limited?
    return true
  end
  def head_line
    return ''
  end
  def privacy_state
    return 'private'
  end
  def base_url
    return 'http://steamcommunity.com/profiles/' + @id.to_s
  end
end
