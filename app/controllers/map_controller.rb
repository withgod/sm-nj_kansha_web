class MapController < ApplicationController
  def index
    @maps    = NjMap.all();
  end
  def ranking
    @mapname = params[:mapname]
    @mapid   = NjMap.find_by_mapname(@mapname).id;
    @rank_start = 0;
    if params[:page].to_i > 1 then
      @rank_start = (params[:page].to_i - 1 )* 50
    end
    @ranking = NjSteamid.ranking_scope_xxx(@mapid).page(params[:page])
  end
end
