require 'net/http'
require 'uri'

get 'oauth/token' do
  region = params[:region]
  redirect_uri = params[:redirect_uri]
  code = params[:code]

  uri = URI.parse("https://#{region}.battle.net/oauth/token")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.path)
  request.basic_auth(BlizzardApi.app_id, BlizzardApi.app_secret)
  request['Content-Type'] = 'application/x-www-form-urlencoded'
  request.set_form_data grant_type: 'authorization_code', redirect_uri: redirect_uri, code: code

  response = http.request(request)
  JSON.parse(response.body)['access_token']
end
