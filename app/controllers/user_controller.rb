class UserController < ApplicationController
  def index
  #  @ranking= NjSteamid.find(:all,
  #                           :select => 'nj_steamids.*, sum(nj_kansha_results.jump_count) as jump_count',
  #                           :joins => 'left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id',
  #                           :group => 'nj_steamids.id',
  #                           :order => "jump_count desc",
  #                           :conditions => 'jump_count > 0'
  #                          )
    @rank_start = 0;
    if params[:page].to_i > 1 then
      @rank_start = (params[:page].to_i - 1 )* 50
    end
    @ranking = NjSteamid.ranking_scope.page(params[:page])
    @ranking_demo = NjSteamid.ranking_scope_demo.page(params[:page])
    @ranking_sol  = NjSteamid.ranking_scope_sol.page(params[:page])
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

    @ranking = NjSteamid.select('nj_steamids.*, count(nj_kansha_results.id) as challenge_count, sum(nj_kansha_results.jump_count) as jump_count, nj_map_id, nj_kansha_results.created_at')
    .joins('left join nj_kansha_results on nj_kansha_results.nj_steamid_id = nj_steamids.id')
    .group('nj_steamids.id')
    .order('jump_count desc')
    .where('jump_count > 0 and ' + _type).page(params[:page])
  end

  def detail
    @user    = NjSteamid.find_by_steamcomid(params[:id])
  end
end
