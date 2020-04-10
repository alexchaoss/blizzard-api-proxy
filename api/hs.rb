require 'blizzard_api'
require 'sinatra'

hs_api_client = BlizzardApi::Hearthstone

# ######################################################################################################################
# Game data
# ######################################################################################################################

# Cards

get '/hearthstone/cards' do
  options = params.select { |key| BlizzardApi::Hearthstone::Card::VALID_SEARCH_OPTIONS.include? key.to_sym }
  hs_api_client.card(@region).search(options).to_json
end

get '/hearthstone/cards/:slug' do |slug|
  hs_api_client.card(@region).get(slug).to_json
end

# Card backs

get '/hearthstone/cardbacks' do
  options = params.select { |key| BlizzardApi::Hearthstone::Back::VALID_SEARCH_OPTIONS.include? key.to_sym }
  hs_api_client.back(@region).search(options).to_json
end

get '/hearthstone/cards/:slug' do |slug|
  hs_api_client.back(@region).get(slug).to_json
end

# Deck

get '/hearthstone/deck/:slug' do |slug|
  hs_api_client.deck(@region).get(slug).to_json
end

# Metadata

get '/hearthstone/metadata' do
  hs_api_client.metadata(@region).index.to_json
end

get '/hearthstone/metadata/:type' do |type|
  hs_api_client.metadata(@region).get(type).to_json
end