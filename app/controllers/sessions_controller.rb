require 'steam-condenser'
class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    steamid_url = auth.uid
    steamid = steamid_url.split('/')[5]
    steaminfo = SteamId.new(steamid.to_i)
    info = {:steamid_url => steamid_url, :steamid => steamid, :nickname => steaminfo.nickname}

    session[:user_info] = info
    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_info] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
