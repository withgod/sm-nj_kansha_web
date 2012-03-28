class MapController < ApplicationController
  def index
    @maps    = NjMap.all();
  end
end
