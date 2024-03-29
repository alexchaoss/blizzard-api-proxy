# frozen_string_literal: true

require 'sinatra'
require 'sinatra/cors'
require 'blizzard_api'
COMMON_OPTIONS = %w[region locale classic classic1x ignore_cache ttl].freeze

set :bind, '0.0.0.0'
set :allow_origin, ENV.fetch('CORS_ORIGIN', '*')

use Rack::Deflater

BlizzardApi.configure do |config|
  config.region = ENV.fetch 'REGION', 'us'
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
  @options = {}
  @request.params.each do |key, value|
    next unless COMMON_OPTIONS.include? key

    @options[key.to_sym] = if %w[classic ignore_cache].include? :key
                             true
                           elsif key.eql? 'ttl'
                             value.to_i
                           else
                             value
                           end
  end
  next unless @request.post?

  @request.body.rewind
  payload = @request.body.read
  @body = JSON.parse payload, symbolize_names: true
end

not_found do
  { status: 'Not found' }.to_json
end

get '/' do
  { status: 'Running' }.to_json
end

require_relative 'api/token_map'
require_relative 'api/hs'
require_relative 'api/wow'
require_relative 'api/d3'
require_relative 'api/sc2'
require_relative 'api/oauth'

error BlizzardApi::ApiException do |e|
  status e.code
  { error: e.message }.to_json
end
