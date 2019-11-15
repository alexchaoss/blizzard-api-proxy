# frozen_string_literal: true

require 'sinatra'
require 'blizzard_api'

set :bind, '0.0.0.0'

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

api_client = BlizzardApi::Wow

before do
  content_type :json
end

error BlizzardApi::ApiException do |e|
  status 500
  { error: e.message }.to_json
end

get '/' do
  { status: "Running" }.to_json
end

# ######################################################################################################################
# Game data
# ######################################################################################################################

# Achievements

get '/data/wow/achievement-category/index' do
  api_client.achievement.categories.to_json
end

get '/data/wow/achievement-category/:id' do |id|
  api_client.achievement.category(id).to_json
end

get '/data/wow/achievement/index' do
  api_client.achievement.index.to_json
end

get '/data/wow/achievement/:id' do |id|
  api_client.achievement.get(id).to_json
end

get '/data/wow/media/achievement/:id' do |id|
  api_client.achievement.media(id).to_json
end

# Azerite essence
get '/data/wow/azerite-essence/index' do
  api_client.azerite_essence.index.to_json
end

get '/data/wow/azerite-essence/:id' do |id|
  api_client.azerite_essence.get(id).to_json
end

get '/data/wow/media/azerite-essence/:id' do |id|
  api_client.azerite_essence.media(id).to_json
end

# Region and realms

get '/data/wow/connected-realm/index' do
  api_client.connected_realm.index.to_json
end

get '/data/wow/connected-realm/:id' do |id|
  api_client.connected_realm.get(id).to_json
end

get '/data/wow/realm/index' do
  api_client.realm.index.to_json
end

get '/data/wow/realm/:realm' do |realm|
  api_client.realm.get(realm).to_json
end

get '/data/wow/region/index' do
  api_client.region.index.to_json
end

get '/data/wow/region/:id' do |id|
  api_client.region.get(id).to_json
end

# Creature

get '/data/wow/creature-family/index' do
  api_client.creature.families.to_json
end

get '/data/wow/creature-family/:id' do |id|
  api_client.creature.family(id).to_json
end

get '/data/wow/media/creature-family/:id' do |id|
  api_client.creature.family_media(id).to_json
end

get '/data/wow/creature-type/index' do
  api_client.creature.types.to_json
end

get '/data/wow/creature-type/:id' do |id|
  api_client.creature.type(id).to_json
end

get '/data/wow/creature/:id' do |id|
  api_client.creature.get(id).to_json
end

get '/data/wow/media/creature-display/:id' do |id|
  api_client.creature.display_media(id).to_json
end

# Guild crest

get '/data/wow/guild-crest/index' do
  api_client.guild_crest.index.to_json
end

get '/data/wow/media/guild-crest/border/:id' do |id|
  api_client.guild_crest.border_media(id).to_json
end

get '/data/wow/media/guild-crest/emblem/:id' do |id|
  api_client.guild_crest.emblem_media(id).to_json
end

# Items

get '/data/wow/item-class/index' do
  api_client.item.classes.to_json
end

get '/data/wow/item-class/:id' do |id|
  api_client.item.class(id).to_json
end

get '/data/wow/item-class/:class_id/item-subclass/:subclass_id' do |class_id, subclass_id|
  api_client.item.subclass(class_id, subclass_id).to_json
end

get '/data/wow/item/:id' do |id|
  api_client.item.get(id).to_json
end

get '/data/wow/media/item/:id' do |id|
  api_client.item.media(id).to_json
end

# Keystone affix

get '/data/wow/keystone-affix/index' do
  api_client.mythic_keystone_affix.index.to_json
end

get '/data/wow/keystone-affix/:id' do |id|
  api_client.mythic_keystone_affix.get(id).to_json
end

# Leaderboard

get '/data/wow/leaderboard/hall-of-fame/:raid/:faction' do |raid, faction|
  api_client.mythic_raid_leaderboard.get(raid, faction).to_json
end

# Mounts

get '/data/wow/mount/index' do
  api_client.mount.index.to_json
end

get '/data/wow/mount/:id' do |id|
  api_client.mount.get(id).to_json
end

get '/data/wow/mythic-keystone/dungeon/index' do
  api_client.mythic_keystone.index.to_json
end

# Mythic keystones

get '/data/wow/mythic-keystone/dungeon/:id' do |id|
  api_client.mythic_keystone.dungeon(id).to_json
end

get '/data/wow/mythic-keystone/index' do
  api_client.mythic_keystone.index.to_json
end

get '/data/wow/mythic-keystone/period/index' do
  api_client.mythic_keystone.periods.to_json
end

get '/data/wow/mythic-keystone/period/:id' do |id|
  api_client.mythic_keystone.period(id).to_json
end

get '/data/wow/mythic-keystone/season/index' do
  api_client.mythic_keystone.seasons.to_json
end

get '/data/wow/mythic-keystone/season/:id' do |id|
  api_client.mythic_keystone.season(id).to_json
end

# Mythic dungeon leaderboard

get '/data/wow/connected-realm/:connected_realm_id/mythic-leaderboard/index' do |connected_realm_id|
  api_client.mythic_keystone_leaderboard.index(connected_realm_id).to_json
end

get '/data/wow/connected-realm/:connected_realm_id/mythic-leaderboard/:dungeon_id/period/:period_id' do |connected_realm_id, dungeon_id, period_id|
  api_client.mythic_keystone_leaderboard.get(connected_realm_id, dungeon_id, period_id).to_json
end

# Pets

get '/data/wow/pet/index' do
  api_client.pet.index.to_json
end

get '/data/wow/pet/:id' do |id|
  api_client.pet.get(id).to_json
end

# Playable classes

get '/data/wow/playable-class/index' do
  api_client.playable_class.index.to_json
end

get '/data/wow/playable-class/:id' do |id|
  api_client.playable_class.get(id).to_json
end

get '/data/wow/playable-class/:id/pvp-talent-slots' do |id|
  api_client.playable_class.talent_slots(id).to_json
end

# Playable races

get '/data/wow/playable-race/index' do
  api_client.race.index.to_json
end

get '/data/wow/playable-race/:id' do |id|
  api_client.race.get(id).to_json
end

# Playable specializations

get '/data/wow/playable-specialization/index' do
  api_client.playable_specialization.index.to_json
end

get '/data/wow/playable-specialization/:id' do |id|
  api_client.playable_specialization.get(id).to_json
end

# Power types

get '/data/wow/power-type/index' do
  api_client.power_type.index.to_json
end

get '/data/wow/power-type/:id' do |id|
  api_client.power_type.get(id).to_json
end

# PvP

get '/data/wow/pvp-season/index' do
  api_client.pvp_season.index.to_json
end

get '/data/wow/pvp-season/:id' do |id|
  api_client.pvp_season.get(id).to_json
end

get '/data/wow/pvp-season/:season_id/pvp-leaderboard/index' do |season_id|
  api_client.pvp_season.leaderboards(season_id).to_json
end

get '/data/wow/pvp-season/:season_id/pvp-leaderboard/:bracket' do |season_id, bracket|
  api_client.pvp_season.leaderboard(season_id, bracket).to_json
end

get '/data/wow/pvp-season/:season_id/pvp-reward/index' do |season_id|
  api_client.pvp_season.rewards(season_id).to_json
end

get '/data/wow/media/pvp-tier/:tier_id' do |tier_id|
  api_client.pvp_tier.tier_media(tier_id).to_json
end

get '/data/wow/pvp-tier/index' do
  api_client.pvp_tier.index.to_json
end

get '/data/wow/pvp-tier/:id' do |id|
  api_client.pvp_tier.get(id).to_json
end

# Reputation

get '/data/wow/reputation-faction/index' do
  api_client.reputation_faction.index.to_json
end

get '/data/wow/reputation-faction/:id' do |id|
  api_client.reputation_faction.get(id).to_json
end

get '/data/wow/reputation-tiers/index' do
  api_client.reputation_tier.index.to_json
end

get '/data/wow/reputation-tiers/:id' do |id|
  api_client.reputation_tier.get(id).to_json
end

# Titles

get '/data/wow/title/index' do
  api_client.title.index.to_json
end

get '/data/wow/title/:id' do |id|
  api_client.title.get(id).to_json
end

# Token

get '/data/wow/token/index' do
  api_client.wow_token.get.to_json
end

# ######################################################################################################################
# Profile
# ######################################################################################################################

get '/profile/wow/character/:realm/:character/achievements' do |realm, character|
  api_client.character_profile.achievements(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/appearance' do |realm, character|
  api_client.character_profile.appearance(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/collections' do |realm, character|
  api_client.character_profile.collections(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/collections/mounts' do |realm, character|
  api_client.character_profile.mounts(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/collections/pets' do |realm, character|
  api_client.character_profile.pets(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/equipment' do |realm, character|
  api_client.character_profile.equipment(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/hunter-pets' do |realm, character|
  api_client.character_profile.hunter_pets(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/character-media' do |realm, character|
  api_client.character_profile.media(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/mythic-keystone-profile' do |realm, character|
  api_client.character_profile.mythic_keystone_profile(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/mythic-keystone-profile/season/:season' do |realm, character, season|
  api_client.character_profile.mythic_keystone_seasons(realm, character, season).to_json
end

get '/profile/wow/character/:realm/:character' do |realm, character|
  api_client.character_profile.get(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/status' do |realm, character|
  api_client.character_profile.status(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/pvp-bracket/:bracket' do |realm, character, bracket|
  api_client.character_profile.pvp_bracket(realm, character, bracket).to_json
end

get '/profile/wow/character/:realm/:character/pvp-summary' do |realm, character|
  api_client.character_profile.pvp_summary(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/reputations' do |realm, character|
  api_client.character_profile.reputation(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/specializations' do |realm, character|
  api_client.character_profile.specializations(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/statistics' do |realm, character|
  api_client.character_profile.statistics(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/titles' do |realm, character|
  api_client.character_profile.titles(realm, character).to_json
end

get '/data/wow/guild/:realm/:guild' do |realm, guild|
  api_client.guild.get(realm, guild).to_json
end

get '/data/wow/guild/:realm/:guild/achievements' do |realm, guild|
  api_client.guild.achievements(realm, guild).to_json
end

get '/data/wow/guild/:realm/:guild/roster' do |realm, guild|
  api_client.guild.roster(realm, guild).to_json
end
