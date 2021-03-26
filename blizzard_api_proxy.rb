# frozen_string_literal: true

require 'sinatra'
require 'sinatra/cors'
require 'blizzard_api'
COMMON_OPTIONS = %w[locale classic ignore_cache ttl].freeze

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

module BlizzardApi
  class Request
    CHINESE_URLS = {
      game_data: 'https://gateway.battlenet.com.cn/data/%s',
      community: 'https://gateway.battlenet.com.cn/%s',
      profile: 'https://gateway.battlenet.com.cn/profile/%s',
      media: 'https://gateway.battlenet.com.cn/data/%s/media',
      user_profile: 'https://gateway.battlenet.com.cn/profile/user/%s',
      search: 'https://gateway.battlenet.com.cn/data/%s/search'
    }.freeze

    def base_url(scope)
      def base_url(scope)
        raise ArgumentError, 'Invalid scope' unless BASE_URLS.include? scope

        if region.eql? :cn
          format CHINESE_BASE_URLS[scope], @game
        else
          format BASE_URLS[scope], region, @game
        end
      end
    end
  end
end

before do
  content_type :json
  @region = BlizzardApi.region
  @region = @request.params['region'] if @request.params.key? 'region'
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
