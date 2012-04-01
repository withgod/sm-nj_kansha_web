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

  def detail
    @user    = NjSteamid.find_by_steamcomid(params[:id])
  end
end
