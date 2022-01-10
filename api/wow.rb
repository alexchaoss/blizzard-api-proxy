# frozen_string_literal: true

require 'blizzard_api'
require 'sinatra'
require 'thwait'

wow_api_client = BlizzardApi::Wow

# ######################################################################################################################
# Game data
# ######################################################################################################################

# Achievement API

get '/data/wow/achievement-category/index' do
  wow_api_client.achievement(region: @region).categories(**@options)&.to_json
end

get '/data/wow/achievement-category/:id' do |id|
  wow_api_client.achievement(region: @region).category(id, **@options)&.to_json
end

get '/data/wow/achievement/index' do
  wow_api_client.achievement(region: @region).index(**@options)&.to_json
end

get '/data/wow/achievement/:id' do |id|
  wow_api_client.achievement(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/achievement/:id' do |id|
  wow_api_client.achievement(region: @region).media(id, **@options)&.to_json
end

# Auction API

get '/data/wow/connected-realm/:connected_realm_id/auctions' do |connected_realm_id|
  wow_api_client.auction(region: @region).get(connected_realm_id, **@options)&.to_json
end

# Azerite Essence API
get '/data/wow/azerite-essence/index' do
  wow_api_client.azerite_essence(region: @region).index(**@options)&.to_json
end

get '/data/wow/azerite-essence/:id' do |id|
  wow_api_client.azerite_essence(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/azerite-essence/:id' do |id|
  wow_api_client.azerite_essence(region: @region).media(id, **@options)&.to_json
end

# Connected Realm API

get '/data/wow/connected-realm/index' do
  wow_api_client.connected_realm(region: @region).index(**@options)&.to_json
end

get '/data/wow/connected-realm/:id' do |id|
  wow_api_client.connected_realm(region: @region).get(id, **@options)&.to_json
end

# Covenant API

get '/data/wow/covenant/index' do
  wow_api_client.covenant(region: @region).index(**@options)&.to_json
end

get '/data/wow/covenant/:id' do |id|
  wow_api_client.covenant(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/covenant/:id' do |id|
  wow_api_client.covenant(region: @region).media(id, **@options)&.to_json
end

get '/data/wow/covenant/soulbind/index' do
  wow_api_client.covenant(region: @region).soulbinds(**@options)&.to_json
end

get '/data/wow/covenant/soulbind/:id' do
  wow_api_client.covenant(region: @region).soulbind(id, **@options)&.to_json
end

get '/data/wow/covenant/conduit/index' do
  wow_api_client.covenant(region: @region).conduits(**@options)&.to_json
end

get '/data/wow/covenant/conduit/:id' do
  wow_api_client.covenant(region: @region).conduit(id, **@options)&.to_json
end

# Creature API

get '/data/wow/creature-family/index' do
  wow_api_client.creature(region: @region).families(**@options)&.to_json
end

get '/data/wow/creature-family/:id' do |id|
  wow_api_client.creature(region: @region).family(id, **@options)&.to_json
end

get '/data/wow/media/creature-family/:id' do |id|
  wow_api_client.creature(region: @region).family_media(id, **@options)&.to_json
end

get '/data/wow/creature-type/index' do
  wow_api_client.creature(region: @region).types(**@options)&.to_json
end

get '/data/wow/creature-type/:id' do |id|
  wow_api_client.creature(region: @region).type(id, **@options)&.to_json
end

get '/data/wow/creature/:id' do |id|
  wow_api_client.creature(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/creature-display/:id' do |id|
  wow_api_client.creature(region: @region).display_media(id, **@options)&.to_json
end

# Guild Crest API

get '/data/wow/guild-crest/index' do
  wow_api_client.guild_crest(region: @region).index(**@options)&.to_json
end

get '/data/wow/media/guild-crest/border/:id' do |id|
  wow_api_client.guild_crest(region: @region).border_media(id, **@options)&.to_json
end

get '/data/wow/media/guild-crest/emblem/:id' do |id|
  wow_api_client.guild_crest(region: @region).emblem_media(id, **@options)&.to_json
end

# Item API

get '/data/wow/item-class/index' do
  wow_api_client.item(region: @region).classes(**@options)&.to_json
end

get '/data/wow/item-class/:id' do |id|
  wow_api_client.item(region: @region).class(id, **@options)&.to_json
end

get '/data/wow/item-class/:class_id/item-subclass/:subclass_id' do |class_id, subclass_id|
  wow_api_client.item(region: @region).subclass(class_id, subclass_id, **@options)&.to_json
end

get '/data/wow/item/:id' do |id|
  wow_api_client.item(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/item/:id' do |id|
  wow_api_client.item(region: @region).media(id, **@options)&.to_json
end

# Journal API

get '/data/wow/journal-expansion/index' do
  wow_api_client.journal(region: @region).expansions(**@options)&.to_json
end

get '/data/wow/journal-expansion/:id' do |id|
  wow_api_client.journal(region: @region).expansion(id, **@options)&.to_json
end

get '/data/wow/journal-encounter/index' do
  wow_api_client.journal(region: @region).encounters(**@options)&.to_json
end

get '/data/wow/journal-encounter/:id' do |id|
  wow_api_client.journal(region: @region).encounter(id, **@options)&.to_json
end

get '/data/wow/journal-instance/index' do
  wow_api_client.journal(region: @region).instances(**@options)&.to_json
end

get '/data/wow/journal-instance/:id' do |id|
  wow_api_client.journal(region: @region).instance(id, **@options)&.to_json
end

# Modified Crafting API

get '/data/wow/modified-crafting/index' do
  wow_api_client.modified_crafting(region: @region).index(**@options)&.to_json
end

get '/data/wow/modified-crafting/category/index' do
  wow_api_client.modified_crafting(region: @region).categories(**@options)&.to_json
end

get '/data/wow/modified-crafting/category/:id' do |id|
  wow_api_client.modified_crafting(region: @region).category(id, **@options)&.to_json
end

get '/data/wow/modified-crafting/reagent-slot-type/index' do
  wow_api_client.modified_crafting(region: @region).slot_types(**@options)&.to_json
end

get '/data/wow/modified-crafting/reagent-slot-type/:id' do |id|
  wow_api_client.modified_crafting(region: @region).slot_type(id, **@options)&.to_json
end

# Mount API

get '/data/wow/mount/index' do
  wow_api_client.mount(region: @region).index(**@options)&.to_json
end

get '/data/wow/mount/:id' do |id|
  wow_api_client.mount(region: @region).get(id, **@options)&.to_json
end

# Mythic Keystone Affix API

get '/data/wow/keystone-affix/index' do
  wow_api_client.mythic_keystone_affix(region: @region).index(**@options)&.to_json
end

get '/data/wow/keystone-affix/:id' do |id|
  wow_api_client.mythic_keystone_affix(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/keystone-affix/:id' do |id|
  wow_api_client.mythic_keystone_affix(region: @region).media(id, **@options)&.to_json
end

# Mythic Keystone Dungeon API

get '/data/wow/mythic-keystone/dungeon/index' do
  wow_api_client.mythic_keystone(region: @region).index(**@options)&.to_json
end

get '/data/wow/mythic-keystone/dungeon/:id' do |id|
  wow_api_client.mythic_keystone(region: @region).dungeon(id, **@options)&.to_json
end

get '/data/wow/mythic-keystone/index' do
  wow_api_client.mythic_keystone(region: @region).index(**@options)&.to_json
end

get '/data/wow/mythic-keystone/period/index' do
  wow_api_client.mythic_keystone(region: @region).periods(**@options)&.to_json
end

get '/data/wow/mythic-keystone/period/:id' do |id|
  wow_api_client.mythic_keystone(region: @region).period(id, **@options)&.to_json
end

get '/data/wow/mythic-keystone/season/index' do
  wow_api_client.mythic_keystone(region: @region).seasons(**@options)&.to_json
end

get '/data/wow/mythic-keystone/season/:id' do |id|
  wow_api_client.mythic_keystone(region: @region).season(id, **@options)&.to_json
end

# Mythic Keystone Leaderboard API

get '/data/wow/connected-realm/:connected_realm_id/mythic-leaderboard/index' do |connected_realm_id|
  wow_api_client.mythic_keystone_leaderboard(region: @region).index(connected_realm_id, **@options)&.to_json
end

get '/data/wow/connected-realm/:connected_realm_id/mythic-leaderboard/:dungeon_id/period/:period_id' do |connected_realm_id, dungeon_id, period_id|
  wow_api_client.mythic_keystone_leaderboard(region: @region).get(connected_realm_id, dungeon_id, period_id, **@options)&.to_json
end

# Mythic Raid Leaderboard API

get '/data/wow/leaderboard/hall-of-fame/:raid/:faction' do |raid, faction|
  wow_api_client.mythic_raid_leaderboard(region: @region).get(raid, faction, **@options)&.to_json
end

# Pet API

get '/data/wow/pet/index' do
  wow_api_client.pet(region: @region).index(**@options)&.to_json
end

get '/data/wow/pet/:id' do |id|
  wow_api_client.pet(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/pet/:id' do |id|
  wow_api_client.pet(region: @region).media(id, **@options)&.to_json
end

get '/data/wow/pet-ability/index' do
  wow_api_client.pet(region: @region).abilities(**@options)&.to_json
end

get '/data/wow/pet-ability/:id' do |id|
  wow_api_client.pet(region: @region).ability(id, **@options)&.to_json
end

get '/data/wow/media/pet-ability/:id' do |id|
  wow_api_client.pet(region: @region).ability_media(id, **@options)&.to_json
end

# Playable classe API

get '/data/wow/playable-class/index' do
  wow_api_client.playable_class(region: @region).index(**@options)&.to_json
end

get '/data/wow/playable-class/:id' do |id|
  wow_api_client.playable_class(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/playable-class/:id' do |id|
  wow_api_client.playable_class(region: @region).media(id, **@options)&.to_json
end

get '/data/wow/playable-class/:id/pvp-talent-slots' do |id|
  wow_api_client.playable_class(region: @region).talent_slots(id, **@options)&.to_json
end

# Playable races

get '/data/wow/playable-race/index' do
  wow_api_client.playable_race(region: @region).index(**@options)&.to_json
end

get '/data/wow/playable-race/:id' do |id|
  wow_api_client.playable_race(region: @region).get(id, **@options)&.to_json
end

# Playable specializations

get '/data/wow/playable-specialization/index' do
  wow_api_client.playable_specialization(region: @region).index(**@options)&.to_json
end

get '/data/wow/playable-specialization/:id' do |id|
  wow_api_client.playable_specialization(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/playable-specialization/:id' do |id|
  wow_api_client.playable_specialization(region: @region).media(id, **@options)&.to_json
end

# Power Type API

get '/data/wow/power-type/index' do
  wow_api_client.power_type(region: @region).index(**@options)&.to_json
end

get '/data/wow/power-type/:id' do |id|
  wow_api_client.power_type(region: @region).get(id, **@options)&.to_json
end

# Profession API

get '/data/wow/profession/index' do
  wow_api_client.profession(region: @region).index(**@options)&.to_json
end

get '/data/wow/profession/:id' do |id|
  wow_api_client.profession(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/profession/:id' do |id|
  wow_api_client.profession(region: @region).media(id, **@options)&.to_json
end

get '/data/wow/profession/:id/skill-tier/:skill_tier_id' do |id, skill_tier_id|
  wow_api_client.profession(region: @region).skill_tier(id, skill_tier_id, **@options)&.to_json
end

get '/data/wow/recipe/:id' do |id|
  wow_api_client.profession(region: @region).recipe(id, **@options)&.to_json
end

get '/data/wow/media/recipe/:id' do |id|
  wow_api_client.profession(region: @region).recipe_media(id, **@options)&.to_json
end

# PvP Season API

get '/data/wow/pvp-season/index' do
  wow_api_client.pvp_season(region: @region).index(**@options)&.to_json
end

get '/data/wow/pvp-season/:id' do |id|
  wow_api_client.pvp_season(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/pvp-season/:season_id/pvp-leaderboard/index' do |season_id|
  wow_api_client.pvp_season(region: @region).leaderboards(season_id, **@options)&.to_json
end

get '/data/wow/pvp-season/:season_id/pvp-leaderboard/:bracket' do |season_id, bracket|
  wow_api_client.pvp_season(region: @region).leaderboard(season_id, bracket, **@options)&.to_json
end

get '/data/wow/pvp-season/:season_id/pvp-reward/index' do |season_id|
  wow_api_client.pvp_season(region: @region).rewards(season_id, **@options)&.to_json
end

# PvP Tier API

get '/data/wow/media/pvp-tier/:tier_id' do |tier_id|
  wow_api_client.pvp_tier(region: @region).tier_media(tier_id, **@options)&.to_json
end

get '/data/wow/pvp-tier/index' do
  wow_api_client.pvp_tier(region: @region).index(**@options)&.to_json
end

get '/data/wow/pvp-tier/:id' do |id|
  wow_api_client.pvp_tier(region: @region).get(id, **@options)&.to_json
end

# Quest API

get '/data/wow/quest/index' do
  wow_api_client.quest(region: @region).index(**@options)&.to_json
end

get '/data/wow/quest/:id' do |id|
  wow_api_client.quest(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/quest/category/index' do
  wow_api_client.quest(region: @region).categories(**@options)&.to_json
end

get '/data/wow/quest/category/:id' do |id|
  wow_api_client.quest(region: @region).category(id, **@options)&.to_json
end

get '/data/wow/quest/area/index' do
  wow_api_client.quest(region: @region).areas(**@options)&.to_json
end

get '/data/wow/quest/area/:id' do |id|
  wow_api_client.quest(region: @region).area(id, **@options)&.to_json
end

get '/data/wow/quest/type/index' do
  wow_api_client.quest(region: @region).types(**@options)&.to_json
end

get '/data/wow/quest/type/:id' do |id|
  wow_api_client.quest(region: @region).type(id, **@options)&.to_json
end

# Realm API

get '/data/wow/realm/index' do
  wow_api_client.realm(region: @region).index(**@options)&.to_json
end

get '/data/wow/realm/:realm' do |realm|
  wow_api_client.realm(region: @region).get(realm, **@options)&.to_json
end

# Region API

get '/data/wow/region/index' do
  wow_api_client.region(region: @region).index(**@options)&.to_json
end

get '/data/wow/region/:id' do |id|
  wow_api_client.region(region: @region).get(id, **@options)&.to_json
end

# Reputation

get '/data/wow/reputation-faction/index' do
  wow_api_client.reputation(region: @region).factions(**@options)&.to_json
end

get '/data/wow/reputation-faction/:id' do |id|
  wow_api_client.reputation(region: @region).faction(id, **@options)&.to_json
end

get '/data/wow/reputation-tiers/index' do
  wow_api_client.reputation(region: @region).tiers(**@options)&.to_json
end

get '/data/wow/reputation-tiers/:id' do |id|
  wow_api_client.reputation(region: @region).tier(id, **@options)&.to_json
end

# Spell API

get '/data/wow/spell/:id' do |id|
  wow_api_client.spell(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/spell/:id' do |id|
  wow_api_client.spell(region: @region).display_media(id, **@options)&.to_json
end

# Talents API

get '/data/wow/talent/index' do
  wow_api_client.talent(region: @region).index(**@options)&.to_json
end

get '/data/wow/talent/:id' do |id|
  wow_api_client.talent(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/pvp-talent/index' do
  wow_api_client.talent(region: @region).pvp_talents(**@options)&.to_json
end

get '/data/wow/pvp-talent/:id' do |id|
  wow_api_client.talent(region: @region).pvp_talent(id, **@options)&.to_json
end

# Tech talent API

get '/data/wow/tech-talent-tree/index' do
  wow_api_client.tech_talent(region: @region).tech_talent_trees(**@options)&.to_json
end

get '/data/wow/tech-talent-tree/:id' do |id|
  wow_api_client.tech_talent(region: @region).tech_talent_tree(id, **@options)&.to_json
end

get '/data/wow/tech-talent/index' do
  wow_api_client.tech_talent(region: @region).index(**@options)&.to_json
end

get '/data/wow/tech-talent/:id' do |id|
  wow_api_client.tech_talent(region: @region).get(id, **@options)&.to_json
end

get '/data/wow/media/tech-talent/:id' do |id|
  wow_api_client.tech_talent(region: @region).media(id, **@options)&.to_json
end

# Titles

get '/data/wow/title/index' do
  wow_api_client.title(region: @region).index(**@options)&.to_json
end

get '/data/wow/title/:id' do |id|
  wow_api_client.title(region: @region).get(id, **@options)&.to_json
end

# Token

get '/data/wow/token/index' do
  wow_api_client.wow_token(region: @region).get(**@options)&.to_json
end

# ######################################################################################################################
# Profile
# ######################################################################################################################

# Character Achievements API

get '/profile/wow/character/:realm/:character/achievements' do |realm, character|
  wow_api_client.character_profile(region: @region).achievements(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/achievements/statistics' do |realm, character|
  wow_api_client.character_profile(region: @region).achievement_statistics(realm, character, **@options)&.to_json
end

# Character Appearance API

get '/profile/wow/character/:realm/:character/appearance' do |realm, character|
  wow_api_client.character_profile(region: @region).appearance(realm, character, **@options)&.to_json
end

# Character Collections API

get '/profile/wow/character/:realm/:character/collections' do |realm, character|
  wow_api_client.character_profile(region: @region).collections(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/collections/mounts' do |realm, character|
  wow_api_client.character_profile(region: @region).mounts(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/collections/pets' do |realm, character|
  wow_api_client.character_profile(region: @region).pets(realm, character, **@options)&.to_json
end

# Character Encounters API

get '/profile/wow/character/:realm/:character/encounters' do |realm, character|
  wow_api_client.character_profile(region: @region).encounters(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/encounters/dungeon' do |realm, character|
  wow_api_client.character_profile(region: @region).dungeons(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/encounters/raids' do |realm, character|
  wow_api_client.character_profile(region: @region).raids(realm, character, **@options)&.to_json
end

# Character Equipment API

get '/profile/wow/character/:realm/:character/equipment' do |realm, character|
  wow_api_client.character_profile(region: @region).equipment(realm, character, **@options)&.to_json
end

# Character Hunter Pets API

get '/profile/wow/character/:realm/:character/hunter-pets' do |realm, character|
  wow_api_client.character_profile(region: @region).hunter_pets(realm, character, **@options)&.to_json
end

# Character Media API

get '/profile/wow/character/:realm/:character/character-media' do |realm, character|
  wow_api_client.character_profile(region: @region).media(realm, character, **@options)&.to_json
end

# Character Mythic Keystone Profile API

get '/profile/wow/character/:realm/:character/mythic-keystone-profile' do |realm, character|
  wow_api_client.character_profile(region: @region).mythic_keystone_profile(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/mythic-keystone-profile/season/:season' do |realm, character, season|
  wow_api_client.character_profile(region: @region).mythic_keystone_seasons(realm, character, season, **@options)&.to_json
end

# Character Profile API

get '/profile/wow/character/:realm/:character' do |realm, character|
  wow_api_client.character_profile(region: @region).get(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/status' do |realm, character|
  wow_api_client.character_profile(region: @region).status(realm, character, **@options)&.to_json
end

# Character PvP API

get '/profile/wow/character/:realm/:character/pvp-bracket/:bracket' do |realm, character, bracket|
  wow_api_client.character_profile(region: @region).pvp_bracket(realm, character, bracket, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/pvp-summary' do |realm, character|
  wow_api_client.character_profile(region: @region).pvp_summary(realm, character, **@options)&.to_json
end

# Character Quests API

get '/profile/wow/character/:realm/:character/quests' do |realm, character|
  wow_api_client.character_profile(region: @region).quests(realm, character, **@options)&.to_json
end

get '/profile/wow/character/:realm/:character/quests/completed' do |realm, character|
  wow_api_client.character_profile(region: @region).quests(realm, character, **{ completed: true }.merge(@options))&.to_json
end

# Character Soulbinds API

get '/profile/wow/character/:realm/:character/soulbinds' do |realm, character|
  wow_api_client.character_profile(region: @region).soulbinds(realm, character, **@options)&.to_json
end

# Character Reputations API

get '/profile/wow/character/:realm/:character/reputations' do |realm, character|
  wow_api_client.character_profile(region: @region).reputation(realm, character, **@options)&.to_json
end

# Character Specializations API

get '/profile/wow/character/:realm/:character/specializations' do |realm, character|
  wow_api_client.character_profile(region: @region).specializations(realm, character, **@options)&.to_json
end

# Character Statistics API

get '/profile/wow/character/:realm/:character/statistics' do |realm, character|
  wow_api_client.character_profile(region: @region).statistics(realm, character, **@options)&.to_json
end

# Character Titles API

get '/profile/wow/character/:realm/:character/titles' do |realm, character|
  wow_api_client.character_profile(region: @region).titles(realm, character, **@options)&.to_json
end

# Guild API

get '/data/wow/guild/:realm/:guild' do |realm, guild|
  wow_api_client.guild(region: @region).get(realm, guild, **@options)&.to_json
end

get '/data/wow/guild/:realm/:guild/activity' do |realm, guild|
  wow_api_client.guild(region: @region).activity(realm, guild, **@options)&.to_json
end

get '/data/wow/guild/:realm/:guild/achievements' do |realm, guild|
  wow_api_client.guild(region: @region).achievements(realm, guild, **@options)&.to_json
end

get '/data/wow/guild/:realm/:guild/roster' do |realm, guild|
  wow_api_client.guild(region: @region).roster(realm, guild, **@options)&.to_json
end

# Account Profile API
get '/profile/user/wow' do
  access_token = TokenMap.instance.get params[:token]
  wow_api_client.profile(access_token, @region).get(**@options)&.to_json
end

get '/profile/user/wow/protected-character/:realm_character' do |realm_character|
  access_token = TokenMap.instance.get params[:token]
  realm, character = realm_character.split('-')
  wow_api_client.profile(access_token, @region).protected_character(realm, character, **@options)&.to_json
end

get '/profile/user/wow/collections' do
  access_token = TokenMap.instance.get params[:token]
  wow_api_client.profile(access_token, @region).collections(**@options)&.to_json
end

get '/profile/user/wow/collections/mounts' do
  access_token = TokenMap.instance.get params[:token]
  wow_api_client.profile(access_token, @region).mounts(**@options)&.to_json
end

get '/profile/user/wow/collections/pets' do
  access_token = TokenMap.instance.get params[:token]
  wow_api_client.profile(access_token, @region).pets(**@options)&.to_json
end

# ######################################################################################################################
# Enhancements
# ######################################################################################################################

get '/profile/user/wow/complete' do
  access_token = TokenMap.instance.get params[:token]
  opts = {}
  opts[:locale] = params[:locale] if params.key? :locale

  profile_data = wow_api_client.profile(access_token, @region).get
  character_list = []

  threads = []
  profile_data[:wow_accounts].each do |account|
    account[:characters].each do |character|
      threads << Thread.new do
        character_data = wow_api_client.character_profile(region: @region).get(character[:realm][:slug], character[:name], **opts)
        character_data[:media] = wow_api_client.character_profile(region: @region).media(character[:realm][:slug], character[:name], **opts)
        character_list << character_data
      end
    end
  end
  ThreadsWait.all_waits(*threads)
  character_list.to_json
end

get '/data/wow/guild/:realm/:guild/roster/complete' do |realm, guild|
  guild_data = wow_api_client.guild(region: @region).roster(realm, guild, **@options)

  members = guild_data[:members]
  complete_data = []
  threads = []

  90.times do
    threads << Thread.new do
      loop do
        member = members.pop
        break unless member

        begin
          character_data = wow_api_client.character_profile(region: @region).get(member[:character][:realm][:slug], member[:character][:name], **@options)
          complete_data << character_data
        rescue StandardError
          # Ignore any exception
        end
      end
    end
  end
  ThreadsWait.all_waits(*threads)
  guild_data[:members] = complete_data
  guild_data&.to_json
end
