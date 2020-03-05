# frozen_string_literal: true

require 'sinatra'
require 'blizzard_api'
require 'thread'
require 'thwait'

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

# Achievement API

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

# Auction API

get '/data/wow/connected-realm/:connected_realm_id/auctions' do |connected_realm_id|
  api_client.auction.get(connected_realm_id).to_json
end

# Azerite Essence API
get '/data/wow/azerite-essence/index' do
  api_client.azerite_essence.index.to_json
end

get '/data/wow/azerite-essence/:id' do |id|
  api_client.azerite_essence.get(id).to_json
end

get '/data/wow/media/azerite-essence/:id' do |id|
  api_client.azerite_essence.media(id).to_json
end

# Connected Realm API

get '/data/wow/connected-realm/index' do
  api_client.connected_realm.index.to_json
end

get '/data/wow/connected-realm/:id' do |id|
  api_client.connected_realm.get(id).to_json
end

# Creature API

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

# Guild Crest API

get '/data/wow/guild-crest/index' do
  api_client.guild_crest.index.to_json
end

get '/data/wow/media/guild-crest/border/:id' do |id|
  api_client.guild_crest.border_media(id).to_json
end

get '/data/wow/media/guild-crest/emblem/:id' do |id|
  api_client.guild_crest.emblem_media(id).to_json
end

# Item API

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

# Journal API

get '/data/wow/journal-expansion/index' do
  api_client.journal.expansions.to_json
end

get '/data/wow/journal-expansion/:id' do |id|
  api_client.journal.expansion(id).to_json
end

get '/data/wow/journal-encounter/index' do
  api_client.journal.encounters.to_json
end

get '/data/wow/journal-encounter/:id' do |id|
  api_client.journal.encounter(id).to_json
end

get '/data/wow/journal-instance/index' do
  api_client.journal.instances.to_json
end

get '/data/wow/journal-instance/:id' do |id|
  api_client.journal.instance(id).to_json
end

# Mount API

get '/data/wow/mount/index' do
  api_client.mount.index.to_json
end

get '/data/wow/mount/:id' do |id|
  api_client.mount.get(id).to_json
end

# Mythic Keystone Affix API

get '/data/wow/keystone-affix/index' do
  api_client.mythic_keystone_affix.index.to_json
end

get '/data/wow/keystone-affix/:id' do |id|
  api_client.mythic_keystone_affix.get(id).to_json
end

get '/data/wow/media/keystone-affix/:id' do |id|
  api_client.mythic_keystone_affix.media(id).to_json
end

# Mythic Keystone Dungeon API

get '/data/wow/mythic-keystone/dungeon/index' do
  api_client.mythic_keystone.index.to_json
end

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

# Mythic Keystone Leaderboard API

get '/data/wow/connected-realm/:connected_realm_id/mythic-leaderboard/index' do |connected_realm_id|
  api_client.mythic_keystone_leaderboard.index(connected_realm_id).to_json
end

get '/data/wow/connected-realm/:connected_realm_id/mythic-leaderboard/:dungeon_id/period/:period_id' do |connected_realm_id, dungeon_id, period_id|
  api_client.mythic_keystone_leaderboard.get(connected_realm_id, dungeon_id, period_id).to_json
end

# Mythic Raid Leaderboard API

get '/data/wow/leaderboard/hall-of-fame/:raid/:faction' do |raid, faction|
  api_client.mythic_raid_leaderboard.get(raid, faction).to_json
end

# Pet API

get '/data/wow/pet/index' do
  api_client.pet.index.to_json
end

get '/data/wow/pet/:id' do |id|
  api_client.pet.get(id).to_json
end

# Playable classe API

get '/data/wow/playable-class/index' do
  api_client.playable_class.index.to_json
end

get '/data/wow/playable-class/:id' do |id|
  api_client.playable_class.get(id).to_json
end

get '/data/wow/media/playable-class/:id' do |id|
  api_client.playable_class.media(id).to_json
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

get '/data/wow/media/playable-specialization/:id' do |id|
  api_client.playable_specialization.media(id).to_json
end

# Power Type API

get '/data/wow/power-type/index' do
  api_client.power_type.index.to_json
end

get '/data/wow/power-type/:id' do |id|
  api_client.power_type.get(id).to_json
end

# PvP Season API

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

# PvP Tier API

get '/data/wow/media/pvp-tier/:tier_id' do |tier_id|
  api_client.pvp_tier.tier_media(tier_id).to_json
end

get '/data/wow/pvp-tier/index' do
  api_client.pvp_tier.index.to_json
end

get '/data/wow/pvp-tier/:id' do |id|
  api_client.pvp_tier.get(id).to_json
end

# Quest API

get '/data/wow/quest/index' do
  api_client.quest.index.to_json
end

get '/data/wow/quest/:id' do |id|
  api_client.quest.get(id).to_json
end

get '/data/wow/quest/category/index' do
  api_client.quest.categories.to_json
end

get '/data/wow/quest/category/:id' do |id|
  api_client.quest.category(id).to_json
end

get '/data/wow/quest/area/index' do
  api_client.quest.areas.to_json
end

get '/data/wow/quest/area/:id' do |id|
  api_client.quest.area(id).to_json
end

get '/data/wow/quest/type/index' do
  api_client.quest.types.to_json
end

get '/data/wow/quest/type/:id' do |id|
  api_client.quest.type(id).to_json
end

# Realm API

get '/data/wow/realm/index' do
  api_client.realm.index.to_json
end

get '/data/wow/realm/:realm' do |realm|
  api_client.realm.get(realm).to_json
end

# Region API

get '/data/wow/region/index' do
  api_client.region.index.to_json
end

get '/data/wow/region/:id' do |id|
  api_client.region.get(id).to_json
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

# Spell API

get '/data/wow/spell/:id' do |id|
  api_client.spell.get(id).to_json
end

get '/data/wow/media/spell/:id' do |id|
  api_client.spell.display_media(id).to_json
end

# Talents API

get '/data/wow/talent/index' do
  api_client.talent.index
end

get '/data/wow/talent/:id' do |id|
  api_client.talent.get(id).to_json
end

get '/data/wow/pvp-talent/index' do
  api_client.talent.pvp_talents.to_json
end

get '/data/wow/pvp-talent/:id' do |id|
  api_client.talent.pvp_talent(id).to_json
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

# Character Achievements API

get '/profile/wow/character/:realm/:character/achievements' do |realm, character|
  api_client.character_profile.achievements(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/achievements/statistics' do |realm, character|
  api_client.character_profile.achievement_statistics(realm, character).to_json
end

# Character Appearance API

get '/profile/wow/character/:realm/:character/appearance' do |realm, character|
  api_client.character_profile.appearance(realm, character).to_json
end

# Character Collections API

get '/profile/wow/character/:realm/:character/collections' do |realm, character|
  api_client.character_profile.collections(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/collections/mounts' do |realm, character|
  api_client.character_profile.mounts(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/collections/pets' do |realm, character|
  api_client.character_profile.pets(realm, character).to_json
end

# Character Encounters API

get '/profile/wow/character/:realm/:character/encounters' do |realm, character|
  api_client.character_profile.encounters(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/encounters/dungeon' do |realm, character|
  api_client.character_profile.dungeons(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/encounters/raids' do |realm, character|
  api_client.character_profile.raids(realm, character).to_json
end

# Character Equipment API

get '/profile/wow/character/:realm/:character/equipment' do |realm, character|
  api_client.character_profile.equipment(realm, character).to_json
end

# Character Hunter Pets API

get '/profile/wow/character/:realm/:character/hunter-pets' do |realm, character|
  api_client.character_profile.hunter_pets(realm, character).to_json
end

# Character Media API

get '/profile/wow/character/:realm/:character/character-media' do |realm, character|
  api_client.character_profile.media(realm, character).to_json
end

# Character Mythic Keystone Profile API

get '/profile/wow/character/:realm/:character/mythic-keystone-profile' do |realm, character|
  api_client.character_profile.mythic_keystone_profile(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/mythic-keystone-profile/season/:season' do |realm, character, season|
  api_client.character_profile.mythic_keystone_seasons(realm, character, season).to_json
end

# Character Profile API

get '/profile/wow/character/:realm/:character' do |realm, character|
  api_client.character_profile.get(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/status' do |realm, character|
  api_client.character_profile.status(realm, character).to_json
end

# Character PvP API

get '/profile/wow/character/:realm/:character/pvp-bracket/:bracket' do |realm, character, bracket|
  api_client.character_profile.pvp_bracket(realm, character, bracket).to_json
end

get '/profile/wow/character/:realm/:character/pvp-summary' do |realm, character|
  api_client.character_profile.pvp_summary(realm, character).to_json
end

# Character Quests API

get '/profile/wow/character/:realm/:character/quests' do |realm, character|
  api_client.character_profile.quests(realm, character).to_json
end

get '/profile/wow/character/:realm/:character/quests/completed' do |realm, character|
  api_client.character_profile.quests(realm, character, true).to_json
end

# Character Reputations API

get '/profile/wow/character/:realm/:character/reputations' do |realm, character|
  api_client.character_profile.reputation(realm, character).to_json
end

# Character Specializations API

get '/profile/wow/character/:realm/:character/specializations' do |realm, character|
  api_client.character_profile.specializations(realm, character).to_json
end

# Character Statistics API

get '/profile/wow/character/:realm/:character/statistics' do |realm, character|
  api_client.character_profile.statistics(realm, character).to_json
end

# Character Titles API

get '/profile/wow/character/:realm/:character/titles' do |realm, character|
  api_client.character_profile.titles(realm, character).to_json
end

# Guild API

get '/data/wow/guild/:realm/:guild' do |realm, guild|
  api_client.guild.get(realm, guild).to_json
end

get '/data/wow/guild/:realm/:guild/activity' do
  api_client.guild.activity(realm, guild).to_json
end

get '/data/wow/guild/:realm/:guild/achievements' do |realm, guild|
  api_client.guild.achievements(realm, guild).to_json
end

get '/data/wow/guild/:realm/:guild/roster' do |realm, guild|
  api_client.guild.roster(realm, guild).to_json
end

# Account Profile API
get '/profile/user/wow' do
  api_client.profile(params[:token]).get.to_json
end

get '/profile/user/wow/protected-character/:realm_character' do |realm_character|
  realm, character = realm_character.split('-')
  api_client.profile(params[:token]).protected_character(realm, character).to_json
end

get '/profile/user/wow/collections' do
  api_client.profile(params[:token]).collections.to_json
end

get '/profile/user/wow/collections/mounts' do
  api_client.profile(params[:token]).mounts.to_json
end

get '/profile/user/wow/collections/pets' do
  api_client.profile(params[:token]).pets.to_json
end

# ######################################################################################################################
# Enhancements
# ######################################################################################################################

get '/profile/user/wow/complete' do
  profile_data = api_client.profile(params[:token]).get
  character_list = []

  threads = []
  profile_data[:wow_accounts].each do |account|
    account[:characters].each do |character|
      threads << Thread.new do
        character_data = api_client.character_profile.get(character[:realm][:slug], character[:name])
        character_data[:media] = api_client.character_profile.media(character[:realm][:slug], character[:name])
        character_list << character_data
      end
    end
  end
  ThreadsWait.all_waits(*threads)
  character_list.to_json
end