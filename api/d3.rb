require 'blizzard_api'
require 'sinatra'

d3_api_client = BlizzardApi::Diablo

# ######################################################################################################################
# Community
# ######################################################################################################################

# D3 Act API

get '/d3/data/act' do
  d3_api_client.act.index.to_json
end

get '/d3/data/act/:id' do |id|
  d3_api_client.act.get(id).to_json
end

# D3 Artisan and Recipe API

get '/d3/data/artisan/:slug' do |slug|
  d3_api_client.artisan.get(slug).to_json
end

get '/d3/data/artisan/:slug/recipe/:recipe_slug' do |slug, recipe_slug|
  d3_api_client.artisan.recipe(slug, recipe_slug).to_json
end

# D3 Follower API

get '/d3/data/follower/:slug' do |slug|
  d3_api_client.follower.get(slug).to_json
end

# D3 Character Class and Skill API

get '/d3/data/hero/:slug' do |slug|
  d3_api_client.character.get(slug).to_json
end

get '/d3/data/hero/:slug/skill/:skill_slug' do |slug, skill_slug|
  d3_api_client.character.skill(slug, skill_slug).to_json
end

# D3 Item Type API

get '/d3/data/item-type' do
  d3_api_client.item_type.index.to_json
end

get '/d3/data/item-type/:slug' do |slug|
  d3_api_client.item_type.get(slug).to_json
end

# D3 Item API

get '/d3/data/item/:slug' do |slug|
  d3_api_client.item.get(slug).to_json
end

# D3 Profile API

get '/d3/profile/:account/' do |account|
  d3_api_client.profile.index(account, params[:token]).to_json
end

get '/d3/profile/:account/hero/:id' do |account, slug|
  d3_api_client.profile.hero(account, params[:token], slug).to_json
end

get '/d3/profile/:account/hero/:id/items' do |account, slug|
  d3_api_client.profile.hero_items(account, params[:token], slug).to_json
end

get '/d3/profile/:account/hero/:id/follower-items' do |account, slug|
  d3_api_client.profile.hero_follower_items(account, params[:token], slug).to_json
end

# ######################################################################################################################
# Game Data
# ######################################################################################################################

get '/data/d3/season/' do
  d3_api_client.season.index.to_json
end

get '/data/d3/season/:id' do |id|
  d3_api_client.season.get(id).to_json
end

get '/data/d3/season/:id/leaderboard/:leaderboard' do |id, leaderboard_id|
  d3_api_client.season.leaderboard(id, leaderboard_id).to_json
end

get '/data/d3/era/' do
  d3_api_client.season.index.to_json
end

get '/data/d3/era/:id' do |id|
  d3_api_client.season.get(id).to_json
end

get '/data/d3/era/:id/leaderboard/:leaderboard' do |id, leaderboard_id|
  d3_api_client.season.leaderboard(id, leaderboard_id).to_json
end