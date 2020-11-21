# frozen_string_literal: true

require 'net/http'
require 'uri'

get '/oauth/token' do
  region = params[:region] || BlizzardApi.region
  redirect_uri = params[:redirect_uri]
  code = params[:code]
  if region.casecmp("cn")
    uri = URI.parse("www.battlenet.com.cn/oauth/token")
  else
    uri = URI.parse("https://#{region}.battle.net/oauth/token")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Post.new(uri.path)
  request.basic_auth(BlizzardApi.app_id, BlizzardApi.app_secret)
  request['Content-Type'] = 'application/x-www-form-urlencoded'
  request.set_form_data grant_type: 'authorization_code', redirect_uri: redirect_uri, code: code

  response = http.request(request)

  data = JSON.parse(response.body)

  if response.code.to_i == 200
    session_key = TokenMap.instance.set(data['access_token'])
    data['access_token'] = session_key
  end

  data.to_json
end

get '/oauth/userinfo' do
  region = params[:region] || BlizzardApi.region
  access_token = TokenMap.instance.get params[:token]
  if region.casecmp("cn")
    uri = URI.parse("www.battlenet.com.cn/oauth/userinfo")
  else  
    uri = URI.parse("https://#{region}.battle.net/oauth/userinfo")

  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true

  request = Net::HTTP::Get.new(uri.path)
  request['Authorization'] = "Bearer #{access_token}"

  response = http.request(request)
  response.body
end
