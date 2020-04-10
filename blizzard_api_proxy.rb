# frozen_string_literal: true

require 'sinatra'
require 'blizzard_api'
require 'thread'
require 'thwait'

set :bind, '0.0.0.0'

BlizzardApi.configure do |config|
  config.region = ENV.fetch 'REGION', 'kr'
  config.app_id = ENV.fetch 'BNET_APPLICATION_ID'
  config.app_secret = ENV.fetch 'BNET_APPLICATION_SECRET'

  if ENV.fetch('USE_CACHE', 'false') == 'true'
    config.use_cache = true
    config.redis_host = ENV.fetch 'REDIS_HOST', ''
    config.redis_port = ENV.fetch 'REDIS_PORT', ''
  end
end

before do
  content_type :json
end

error BlizzardApi::ApiException do |e|
  status 500
  { error: e.message }.to_json
end

get '/' do
  { status: "Running" }.to_json
end

require_relative 'api/hs'
require_relative 'api/wow'
require_relative 'api/d3'
require_relative 'api/sc2'