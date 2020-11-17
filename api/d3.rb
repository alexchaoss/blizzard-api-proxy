# frozen_string_literal: true

require 'blizzard_api'
require 'sinatra'

d3_api_client = BlizzardApi::Diablo

# ######################################################################################################################
# Community
# ######################################################################################################################

# D3 Act API

get '/d3/data/act' do
  d3_api_client.act(@region).index.to_json
end

get '/d3/data/act/:id' do |id|
  d3_api_client.act(@region).get(id).to_json
end

# D3 Artisan and Recipe API

get '/d3/data/artisan/:slug' do |slug|
  d3_api_client.artisan(@region).get(slug).to_json
end

get '/d3/data/artisan/:slug/recipe/:recipe_slug' do |slug, recipe_slug|
  d3_api_client.artisan(@region).recipe(slug, recipe_slug).to_json
end

# D3 Follower API

get '/d3/data/follower/:slug' do |slug|
  d3_api_client.follower(@region).get(slug).to_json
end

# D3 Character Class and Skill API

get '/d3/data/hero/:slug' do |slug|
  d3_api_client.character(@region).get(slug, @options).to_json
end

get '/d3/data/hero/:slug/skill/:skill_slug' do |slug, skill_slug|
  d3_api_client.character(@region).skill(slug, skill_slug, @options).to_json
end

# D3 Item Type API

get '/d3/data/item-type' do
  d3_api_client.item_type(@region).index(@options).to_json
end

get '/d3/data/item-type/:slug' do |slug|
  d3_api_client.item_type(@region).get(slug, @options).to_json
end

# D3 Item API

get '/d3/data/item/:slug' do |slug|
  d3_api_client.item(@region).get(slug, @options).to_json
end

# D3 Profile API

get '/d3/profile/:account/' do |account|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(@region).index(account, access_token, @options).to_json
end

get '/d3/profile/:account/hero/:id' do |account, slug|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(@region).hero(account, access_token, slug, @options).to_json
end

get '/d3/profile/:account/hero/:id/items' do |account, slug|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(@region).hero_items(account, access_token, slug, @options).to_json
end

get '/d3/profile/:account/hero/:id/follower-items' do |account, slug|
  access_token = TokenMap.instance.get params[:token]
  d3_api_client.profile(@region).hero_follower_items(account, access_token, slug, @options).to_json
end

# ######################################################################################################################
# Game Data
# ######################################################################################################################

get '/data/d3/season/' do
  d3_api_client.season(@region).index(@options).to_json
end

get '/data/d3/season/:id' do |id|
  d3_api_client.season(@region).get(id, @options).to_json
end

get '/data/d3/season/:id/leaderboard/:leaderboard' do |id, leaderboard_id|
  d3_api_client.season(@region).leaderboard(id, leaderboard_id, @options).to_json
end

get '/data/d3/era/' do
  d3_api_client.era(@region).index(@options).to_json
end

get '/data/d3/era/:id' do |id|
  d3_api_client.era(@region).get(id, @options).to_json
end

get '/data/d3/era/:id/leaderboard/:leaderboard' do |id, leaderboard_id|
  d3_api_client.era(@region).leaderboard(id, leaderboard_id, @options).to_json
end
