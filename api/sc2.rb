# frozen_string_literal: true

require 'blizzard_api'
require 'sinatra'

sc2_api_client = BlizzardApi::Starcraft

# ######################################################################################################################
# Game data
# ######################################################################################################################

# StarCraft II League API

get '/data/sc2/league/:season_id/:queue_id/:team_type/:league_id' do |season_id, queue_id, team_type, league_id|
  sc2_api_client.league(**@options).get(season_id, queue_id, team_type, league_id, **@options)&.to_json
end

# ######################################################################################################################
# Community
# ######################################################################################################################

get '/sc2/static/profile/:region_id' do |region_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(**@options).static(region_id.to_sym, **@options)&.to_json
end

get '/sc2/metadata/profile/:region_id/:realm_id/:profile_id ' do |region_id, realm_id, profile_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(**@options).metadata(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id' do |region_id, realm_id, profile_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(**@options).profile(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id/ladder/summary ' do |region_id, realm_id, profile_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(**@options).ladder_summary(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id/ladder/:id ' do |region_id, realm_id, profile_id, id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(**@options).ladder(region_id.to_sym, realm_id, profile_id, id, **@options)&.to_json
end

# Ladder API

get '/sc2/ladder/grandmaster/:region_id' do |region_id|
  sc2_api_client.ladder(**@options).grandmaster(region_id.to_sym, **@options)&.to_json
end

get '/sc2/ladder/season/:region_id' do |region_id|
  sc2_api_client.ladder(**@options).season(region_id.to_sym, **@options)&.to_json
end

# Player API

get '/sc2/player/:account_id' do |account_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.account(**@options).player(account_id, **@options)&.to_json
end

# Legacy API

get '/sc2/legacy/profile/:region_id/:realm_id/:profile_id' do |region_id, realm_id, profile_id|
  sc2_api_client.legacy(**@options).profile(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/legacy/profile/:region_id/:realm_id/:profile_id/ladders' do |region_id, realm_id, profile_id|
  sc2_api_client.legacy(**@options).ladders(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/legacy/profile/:region_id/:realm_id/:profile_id/matches' do |region_id, realm_id, profile_id|
  sc2_api_client.legacy(**@options).match(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/legacy/ladder/:region_id/:ladder_id' do |region_id, ladder_id|
  sc2_api_client.legacy(**@options).ladder(region_id.to_sym, ladder_id, **@options)&.to_json
end

get '/sc2/legacy/data/achievements/:region_id' do |region_id|
  sc2_api_client.legacy(**@options).achievements(region_id.to_sym, **@options)&.to_json
end

get '/sc2/legacy/data/rewards/:region_id' do |region_id|
  sc2_api_client.legacy(**@options).rewards(region_id.to_sym, **@options)&.to_json
end
