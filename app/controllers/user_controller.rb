class UserController < ApplicationController
  def index
    @users = NjSteamid.all()
  end

  def detail
    @user    = NjSteamid.find_by_steamcomid(params[:id])
  end
end
