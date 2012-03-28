class ClassController < ApplicationController
  def show
    @class = NjClass.find(params[:id])
  end
end
