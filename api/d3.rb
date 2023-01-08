# frozen_string_literal: true

require 'blizzard_api'
require 'sinatra'

d3_api_client = BlizzardApi::Diablo

# ######################################################################################################################
# Community
# ######################################################################################################################

# D3 Act API

get '/d3/data/act' do
  d3_api_client.act(**@options).index&.to_json
end

get '/d3/data/act/:id' do |id|
  d3_api_client.act(**@options).get(id)&.to_json
end

# D3 Artisan and Recipe API

get '/d3/data/artisan/:slug' do |slug|
  d3_api_client.artisan(**@options).get(slug)&.to_json
end

get '/d3/data/artisan/:slug/recipe/:recipe_slug' do |slug, recipe_slug|
  d3_api_client.artisan(**@options).recipe(slug, recipe_slug)&.to_json
end

# D3 Follower API

get '/d3/data/follower/:slug' do |slug|
  d3_api_client.follower(**@options).get(slug)&.to_json
end

# D3 Character Class and Skill API

get '/d3/data/hero/:slug' do |slug|
  d3_api_client.character(**@options).get(slug, **@options)&.to_json
end

get '/d3/data/hero/:slug/skill/:skill_slug' do |slug, skill_slug|
  d3_api_client.character(**@options).skill(slug, skill_slug, **@options)&.to_json
end

# D3 Item Type API

get '/d3/data/item-type' do
  d3_api_client.item_type(**@options).index(**@options)&.to_json
end

get '/d3/data/item-type/:slug' do |slug|
  d3_api_client.item_type(**@options).get(slug, **@options)&.to_json
end

# D3 Item API

get '/d3/data/item/:slug' do |slug|
  d3_api_client.item(**@options).get(slug, **@options)&.to_json
end

# D3 Profile API

get '/d3/profile/:account/' do |account|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(**@options).index(account, access_token, **@options)&.to_json
end

get '/d3/profile/:account/hero/:id' do |account, slug|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(**@options).hero(account, access_token, slug, **@options)&.to_json
end

get '/d3/profile/:account/hero/:id/items' do |account, slug|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(**@options).hero_items(account, access_token, slug, **@options)&.to_json
end

get '/d3/profile/:account/hero/:id/follower-items' do |account, slug|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(**@options).hero_follower_items(account, access_token, slug, **@options)&.to_json
end

# ######################################################################################################################
# Game Data
# ######################################################################################################################

get '/data/d3/season/' do
  d3_api_client.season(**@options).index(**@options)&.to_json
end

get '/data/d3/season/:id' do |id|
  d3_api_client.season(**@options).get(id, **@options)&.to_json
end

get '/data/d3/season/:id/leaderboard/:leaderboard' do |id, leaderboard_id|
  d3_api_client.season(**@options).leaderboard(id, leaderboard_id, **@options)&.to_json
end

get '/data/d3/era/' do
  d3_api_client.era(**@options).index(**@options)&.to_json
end

get '/data/d3/era/:id' do |id|
  d3_api_client.era(**@options).get(id, **@options)&.to_json
end

get '/data/d3/era/:id/leaderboard/:leaderboard' do |id, leaderboard_id|
  d3_api_client.era(**@options).leaderboard(id, leaderboard_id, **@options)&.to_json
end
