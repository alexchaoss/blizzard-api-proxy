# frozen_string_literal: true

require 'blizzard_api'
require 'sinatra'

hs_api_client = BlizzardApi::Hearthstone

# ######################################################################################################################
# Game data
# ######################################################################################################################

# Cards

get '/hearthstone/cards' do
  search_options = params.select { |key| BlizzardApi::Hearthstone::Card::VALID_SEARCH_OPTIONS.include? key.to_sym }
  hs_api_client.card(**@options).search(search_options, **@options)&.to_json
end

get '/hearthstone/cards/:slug' do |slug|
  hs_api_client.card(**@options).get(slug, 'constructed', **@options)&.to_json
end

# Card backs

get '/hearthstone/cardbacks' do
  search_options = params.select { |key| BlizzardApi::Hearthstone::Back::VALID_SEARCH_OPTIONS.include? key.to_sym }
  hs_api_client.back(**@options).search(search_options, **@options)&.to_json
end

get '/hearthstone/cards/:slug' do |slug|
  hs_api_client.back(**@options).get(slug, **@options)&.to_json
end

# Deck

get '/hearthstone/deck/:slug' do |slug|
  hs_api_client.deck(**@options).get(slug, **@options)&.to_json
end

# Metadata

get '/hearthstone/metadata' do
  hs_api_client.metadata(**@options).index(**@options)&.to_json
end

get '/hearthstone/metadata/:type' do |type|
  hs_api_client.metadata(**@options).get(type, **@options)&.to_json
end
