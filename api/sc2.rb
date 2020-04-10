require 'blizzard_api'
require 'sinatra'

sc2_api_client = BlizzardApi::Starcraft

# ######################################################################################################################
# Game data
# ######################################################################################################################

# StarCraft II League API

get '/data/sc2/league/:season_id/:queue_id/:team_type/:league_id' do |season_id, queue_id, team_type, league_id|
  sc2_api_client.league.get(season_id, queue_id, team_type, league_id).to_json
end

# ######################################################################################################################
# Community
# ######################################################################################################################

get '/sc2/static/profile/:region_id' do |region_id|
  sc2_api_client.profile.static(region_id.to_sym).to_json
end

get '/sc2/metadata/profile/:region_id/:realm_id/:profile_id ' do |region_id, realm_id, profile_id|
  sc2_api_client.profile.metadata(region_id.to_sym, realm_id, profile_id).to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id' do |region_id, realm_id, profile_id|
  sc2_api_client.profile.profile(region_id.to_sym, realm_id, profile_id).to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id/ladder/summary ' do |region_id, realm_id, profile_id|
  sc2_api_client.profile.ladder_summary(region_id.to_sym, realm_id, profile_id).to_json
end

get '/sc2/profile/:region_id/:realm_id/:profile_id/ladder/:id ' do |region_id, realm_id, profile_id, id|
  sc2_api_client.profile.ladder(region_id.to_sym, realm_id, profile_id, id).to_json
end

# Ladder API

get '/sc2/ladder/grandmaster/:region_id' do |region_id|
  sc2_api_client.ladder.grandmaster(region_id.to_sym).to_json
end

get '/sc2/ladder/season/:region_id' do |region_id|
  sc2_api_client.ladder.season(region_id.to_sym).to_json
end

# Player API

get '/sc2/player/:account_id' do |account_id|
  opts = {}
  opts[:token] = params[:token] if params[:token]
  sc2_api_client.account.player(account_id, opts).to_json
end