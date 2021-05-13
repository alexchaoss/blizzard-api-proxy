# frozen_string_literal: true

require 'blizzard_api'
require 'sinatra'

sc2_api_client = BlizzardApi::Starcraft

# ######################################################################################################################
# Game data
# ######################################################################################################################

# StarCraft II League API

get '/data/sc2/league/:season_id/:queue_id/:team_type/:league_id' do |season_id, queue_id, team_type, league_id|
  sc2_api_client.league(@region).get(season_id, queue_id, team_type, league_id, **@options)&.to_json
end

# ######################################################################################################################
# Community
# ######################################################################################################################

get '/sc2/static/profile/:region_id' do |region_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(@region).static(region_id.to_sym, **@options)&.to_json
end

get '/sc2/metadata/profile/:region_id/:realm_id/:profile_id ' do |region_id, realm_id, profile_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(@region).metadata(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id' do |region_id, realm_id, profile_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(@region).profile(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id/ladder/summary ' do |region_id, realm_id, profile_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(@region).ladder_summary(region_id.to_sym, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id/ladder/:id ' do |region_id, realm_id, profile_id, id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.profile(@region).ladder(region_id.to_sym, realm_id, profile_id, id, **@options)&.to_json
end

# Ladder API

get '/sc2/ladder/grandmaster/:region_id' do |region_id|
  sc2_api_client.ladder(@region).grandmaster(region_id.to_sym, **@options)&.to_json
end

get '/sc2/ladder/season/:region_id' do |region_id|
  sc2_api_client.ladder(@region).season(region_id.to_sym, **@options)&.to_json
end

# Player API

get '/sc2/player/:account_id' do |account_id|
  @options[:token] = TokenMap.instance.get(params[:token]) if params[:token]
  sc2_api_client.account(@region).player(account_id, **@options)&.to_json
end

# Legacy API

get '/sc2/legacy/profile/:region_id/:realm_id/:profile_id' do |region_id, realm_id, profile_id|
  sc2_api_client.legacy(@region).profile(region_id, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/legacy/profile/:region_id/:realm_id/:profile_id/ladders' do |region_id, realm_id, profile_id|
  sc2_api_client.legacy(@region).ladders(region_id, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/legacy/profile/:region_id/:realm_id/:profile_id/matches' do |region_id, realm_id, profile_id|
  sc2_api_client.legacy(@region).match(region_id, realm_id, profile_id, **@options)&.to_json
end

get '/sc2/legacy/ladder/:region_id/:ladder_id' do |region_id, ladder_id|
  sc2_api_client.legacy(@region).ladder(region_id, ladder_id, **@options)&.to_json
end

get '/sc2/legacy/data/achievements/:region_id' do |region_id|
  sc2_api_client.legacy(@region).achievements(region_id, **@options)&.to_json
end

get '/sc2/legacy/data/rewards/:region_id' do |region_id|
  sc2_api_client.legacy(@region).rewards(region_id, **@options)&.to_json
end
