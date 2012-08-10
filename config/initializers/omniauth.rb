require 'omniauth-openid'
require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, :store => OpenID::Store::Filesystem.new(Rails.root.join('tmp','openid'))
  provider :open_id, :name => 'steam', :identifier => 'http://steamcommunity.com/openid'
end

