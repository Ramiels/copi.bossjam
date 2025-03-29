local replace = {}
function OnMagicNumbersAndWorldSeedInitialized()
	SetRandomSeed(1111, 4)
	local output = { "boss_meat/boss_meat", "boss_limbs/boss_limbs", "boss_ghost/boss_ghost", "boss_pit/boss_pit", "boss_robot/boss_robot", "boss_fish/fish_giga", "boss_spirit/islandspirit", "boss_centipede/boss_centipede", "boss_alchemist/boss_alchemist", "boss_wizard/boss_wizard", --[["boss_sky/boss_sky",]] "maggot_tiny", "boss_dragon", }
	local input = { "boss_meat/boss_meat", "boss_limbs/boss_limbs", "boss_ghost/boss_ghost", "boss_pit/boss_pit", "boss_robot/boss_robot", "boss_fish/fish_giga", "boss_spirit/islandspirit", "boss_centipede/boss_centipede", "boss_alchemist/boss_alchemist", "boss_wizard/boss_wizard", --[["boss_sky/boss_sky",]] "maggot_tiny", "boss_dragon", }
	repeat replace[table.concat{"data/entities/animals/", table.remove(input, Random(1, #input)), ".xml"}]=table.concat{"data/entities/animals/", table.remove(output, Random(1, #output)), ".xml"} until #output==0

	local file_tbl = {
		["data/scripts/biomes/meatroom.lua"]						= "boss_meat/boss_meat",
		["data/scripts/biomes/boss_limbs_arena.lua"]				= "boss_limbs/boss_limbs",
		["data/entities/animals/boss_limbs/boss_limbs_spawn.lua"]	= "boss_limbs/boss_limbs",
		["data/entities/animals/boss_ghost/spawn_ghost.lua"]		= "boss_ghost/boss_ghost",
		["data/entities/animals/boss_pit/boss_pit_spawner.lua"]		= "boss_pit/boss_pit",
		["data/scripts/buildings/orb_07_pitcheck_b.lua"]			= "boss_pit/boss_pit",
		["data/scripts/biomes/roboroom.lua"]						= "boss_robot/boss_robot",
		["data/biome/_pixel_scenes.xml"]							= "boss_fish/fish_giga",
		["data/biome/_pixel_scenes_newgame_plus.xml"]				= "boss_fish/fish_giga",
		["data/entities/animals/boss_spirit/spawn_spirit.lua"]		= "boss_spirit/islandspirit",
		["data/scripts/biomes/boss_arena.lua"]						= "boss_centipede/boss_centipede",
		["data/scripts/biomes/secret_lab.lua"]						= "boss_alchemist/boss_alchemist",
		["data/scripts/biomes/mestari_secret.lua"]					= "boss_wizard/boss_wizard",
		--["data/biome_impl/static_tile/temples_common.lua"]			= "boss_sky/boss_sky",
		["data/scripts/buildings/maggotspot.lua"]					= "maggot_tiny",
		["data/scripts/buildings/dragonspot.lua"]					= "boss_dragon",
		["data/scripts/buildings/egg_damage.lua"]					= "boss_dragon",
		["data/scripts/buildings/egg.lua"]							= "boss_dragon",
		["data/scripts/buildings/end_egg.lua"]						= "boss_dragon",
	}

	for path, animal in pairs(file_tbl) do
		local file_data = table.concat{"data/entities/animals/", animal, ".xml"}
		ModTextFileSetContent(path, ModTextFileGetContent(path):gsub(file_data, replace[file_data]))
	end
end

--[==[ bad approach
	-- Generate a monkey patch to target arbitrary function/bosspath and append it to said file
	local new_path = path:gsub("data", "mods/copi.bossjam/")
	ModTextFileSetContent(new_path, ([=[local EntityLoad_old = EntityLoad
	function EntityLoad(filename, pos_x, pos_y)
		if filename:find("BOSSNAME.xml") then filename = GlobalsGetValue("BOSSNAME") end
		EntityLoad_old(filename, pos_x, pos_y)
	end]=]):gsub('BOSSNAME', file_data))
	ModLuaFileAppend(path, new_path)
]==]

-- todo apoth compatible method