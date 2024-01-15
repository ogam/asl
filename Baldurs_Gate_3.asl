//	currently supported versions
//		Patch 3
//		hotfix 7
//		hotfix 9
//		patch 4
//		patch 4_1
//		hotfix 10
//		hotfix 11
//		hotfix 12
//		hotfix 13
//		hotfix 14
//		hotfix 15
//		hotfix 16
//		hotfix 17

/*
	@notes:
	if the game patches and you have `debug` on and the values still look good 
	(proper map name, `is_playing` is set whenever match is joinable, logging message updates as you load up levels)
	then just grab the ModuleSize and add it to the respective versions along with the pointer offsets from labels
	`Debug_Server_offset` and `Debug_Log_offset`
	otherwise do the following to find the updated pointers

	when server is running and available to join/play
	"bg3_dx11.exe"+05020A70, A8 == 265 //	A9 should be a single byte, 0 for not in a server. 1 for in a running server
	whenever game patches, look for any of the level names, alternatively look up the server room name. example `Ogam's lobby`
	"bg3_dx11.exe"+05020A70, A8 + 18 //	lobby name
	"bg3_dx11.exe"+05020A70, A8 + 59 //	player names(?)
	"bg3_dx11.exe"+05020A70, A8 + 9A //	level name
	"bg3_dx11.exe"+05020A70, A8 + DB //	level nice name
	"bg3_dx11.exe"+05020A70, A8 + 11C //	version

	logging message to check if we're currenting in a playble state
	whenever game patches look for `CLIENT STATE SWAP` and pointer scan `to: Running`
	"bg3_dx11.exe"+05023CC0, 0, 28 //	logging current state change
	
	once you have these 2, generate pointermap and check what accesses the pointer. grab any pointers and offsets
	and update in respective state(binary_name, game_version)
*/

/*
level_name		-	Descriptive Level Name

SYS_CC_I		-	Character Creation
TUT_Avernus_C	-	A Nautiloid in Hell
WLD_Main_A		-	Wilderness
CRE_Main_A		-	Githyanki Creche
SCL_Main_A		-	Shadow-Cursed-Lands
INT_Main_A		-	Wyrm's Lookout (Gith intermission)
BGO_Main_A		-	Wyrm's Crossing
CTY_Main_A		-	Baldur's Gate
END_Main		-	High Hall
EPI_MAIN_A		-	Reunion Camp
*/

//	vulkan
state("bg3", "gog_patch_3")
{
	byte is_playable : 0x52A8A70, 0xA9;
	string64 level_name : 0x52A8A70, 0x142;
	string64 level_descriptive_name : 0x52A8A70, 0x183;
	string32 game_version : 0x52A8A70, 0x284;
	string256 log_message : 0x52ACD70, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "gog_patch_3")
{
	byte is_playable : 0x4FF5370, 0xA9;
	string64 level_name : 0x4FF5370, 0x142;
	string64 level_descriptive_name : 0x4FF5370, 0x183;
	string32 game_version : 0x4FF5370, 0x284;
	string256 log_message : 0x4FF85C0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "steam_patch_3")
{
	byte is_playable : 0x52B2E90, 0xA9;
	string64 level_name : 0x52B2E90, 0x142;
	string64 level_descriptive_name : 0x52B2E90, 0x183;
	string32 game_version : 0x52B2E90, 0x284;
	string256 log_message : 0x52B7190, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "steam_patch_3")
{
	byte is_playable : 0x5020A70, 0xA9;
	string64 level_name : 0x5020A70, 0x142;
	string64 level_descriptive_name : 0x5020A70, 0x183;
	string32 game_version : 0x5020A70, 0x284;
	string256 log_message : 0x5023CC0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "gog_hotfix_7")
{
	byte is_playable : 0x528DB50, 0xA9;
	string64 level_name : 0x528DB50, 0x142;
	string64 level_descriptive_name : 0x528DB50, 0x183;
	string32 game_version : 0x528DB50, 0x284;
	string256 log_message : 0x5291E50, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "gog_hotfix_7")
{
	byte is_playable : 0x501E920, 0xA9;
	string64 level_name : 0x501E920, 0x142;
	string64 level_descriptive_name : 0x501E920, 0x183;
	string32 game_version : 0x501E920, 0x284;
	string256 log_message : 0x5021B70, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "steam_hotfix_7")
{
	byte is_playable : 0x52BA1A0, 0xA9;
	string64 level_name : 0x52BA1A0, 0x142;
	string64 level_descriptive_name : 0x52BA1A0, 0x183;
	string32 game_version : 0x52BA1A0, 0x284;
	string256 log_message : 0x52BE4A0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "steam_hotfix_7")
{
	byte is_playable : 0x5027D90, 0xA9;
	string64 level_name : 0x5027D90, 0x142;
	string64 level_descriptive_name : 0x5027D90, 0x183;
	string32 game_version : 0x5027D90, 0x284;
	string256 log_message : 0x502AFE0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "gog_hotfix_9")
{
	byte is_playable : 0x5291CC0, 0xA9;
	string64 level_name : 0x5291CC0, 0x142;
	string64 level_descriptive_name : 0x5291CC0, 0x183;
	string32 game_version : 0x5291CC0, 0x284;
	string256 log_message : 0x5295FC0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "gog_hotfix_9")
{
	byte is_playable : 0x501EA00, 0xA9;
	string64 level_name : 0x501EA00, 0x142;
	string64 level_descriptive_name : 0x501EA00, 0x183;
	string32 game_version : 0x501EA00, 0x284;
	string256 log_message : 0x5021C50, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "steam_hotfix_9")
{
	byte is_playable : 0x52BD2B0, 0xA9;
	string64 level_name : 0x52BD2B0, 0x142;
	string64 level_descriptive_name : 0x52BD2B0, 0x183;
	string32 game_version : 0x52BD2B0, 0x284;
	string256 log_message : 0x52C15B0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "steam_hotfix_9")
{
	byte is_playable : 0x5027E40, 0xA9;
	string64 level_name : 0x5027E40, 0x142;
	string64 level_descriptive_name : 0x5027E40, 0x183;
	string32 game_version : 0x5027E40, 0x284;
	string256 log_message : 0x502B090, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "gog_patch_4")
{
	byte is_playable : 0x5BA0BA8, 0xA9;
	string64 level_name : 0x5BA0BA8, 0x142;
	string64 level_descriptive_name : 0x5BA0BA8, 0x183;
	string32 game_version : 0x5BA0BA8, 0x284;
	string256 log_message : 0x5BA13F0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "gog_patch_4")
{
	byte is_playable : 0x590B8D8, 0xA9;
	string64 level_name : 0x590B8D8, 0x142;
	string64 level_descriptive_name : 0x590B8D8, 0x183;
	string32 game_version : 0x590B8D8, 0x284;
	string256 log_message : 0x590C0D0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "steam_patch_4")
{
	byte is_playable : 0x5BB2060, 0xA9;
	string64 level_name : 0x5BB2060, 0x142;
	string64 level_descriptive_name : 0x5BB2060, 0x183;
	string32 game_version : 0x5BB2060, 0x284;
	string256 log_message : 0x5BB28C0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}


//	directx 11
state("bg3_dx11", "steam_patch_4")
{
	byte is_playable : 0x591DBF0, 0xA9;
	string64 level_name : 0x591DBF0, 0x142;
	string64 level_descriptive_name : 0x591DBF0, 0x183;
	string32 game_version : 0x591DBF0, 0x284;
	string256 log_message : 0x591E3E0, 0x0, 0x28;
	float node_x : 0;	//	unsupported
	float node_y : 0;	//	unsupported
	float node_z : 0;	//	unsupported
}

//	vulkan
state("bg3", "gog_patch_4_1")
{
	byte is_playable : 0x5B9FBA8, 0xA9;
	string64 level_name : 0x5B9FBA8, 0x142;
	string64 level_descriptive_name : 0x5B9FBA8, 0x183;
	string32 game_version : 0x5B9FBA8, 0x284;
	string256 log_message : 0x5BA03F0, 0x0, 0x28;
	float node_x : 0x5B01AE0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B01AE0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B01AE0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "gog_patch_4_1")
{
	byte is_playable : 0x590B8C8, 0xA9;
	string64 level_name : 0x590B8C8, 0x142;
	string64 level_descriptive_name : 0x590B8C8, 0x183;
	string32 game_version : 0x590B8C8, 0x284;
	string256 log_message : 0x590C0C0, 0x0, 0x28;
	float node_x : 0x586DB00, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x586DB00, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x586DB00, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_patch_4_1")
{
	byte is_playable : 0x5BB2040, 0xA9;
	string64 level_name : 0x5BB2040, 0x142;
	string64 level_descriptive_name : 0x5BB2040, 0x183;
	string32 game_version : 0x5BB2040, 0x284;
	string256 log_message : 0x5BB28A0, 0x0, 0x28;
	float node_x : 0x5B13BA0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B13BA0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B13BA0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "steam_patch_4_1")
{
	byte is_playable : 0x591DBD0, 0xA9;
	string64 level_name : 0x591DBD0, 0x142;
	string64 level_descriptive_name : 0x591DBD0, 0x183;
	string32 game_version : 0x591DBD0, 0x284;
	string256 log_message : 0x591E3C0, 0x0, 0x28;
	float node_x : 0x587FC60, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x587FC60, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x587FC60, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_10")
{
	byte is_playable : 0x5BA0B88, 0xA9;
	string64 level_name : 0x5BA0B88, 0x142;
	string64 level_descriptive_name : 0x5BA0B88, 0x183;
	string32 game_version : 0x5BA0B88, 0x284;
	string256 log_message : 0x5BA13D0, 0x0, 0x28;
	float node_x : 0x5B02AC0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B02AC0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B02AC0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "gog_hotfix_10")
{
	byte is_playable : 0x590B8E8, 0xA9;
	string64 level_name : 0x590B8E8, 0x142;
	string64 level_descriptive_name : 0x590B8E8, 0x183;
	string32 game_version : 0x590B8E8, 0x284;
	string256 log_message : 0x590C0E0, 0x0, 0x28;
	float node_x : 0x586DB20, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x586DB20, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x586DB20, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_10")
{
	byte is_playable : 0x5BB2060, 0xA9;
	string64 level_name : 0x5BB2060, 0x142;
	string64 level_descriptive_name : 0x5BB2060, 0x183;
	string32 game_version : 0x5BB2060, 0x284;
	string256 log_message : 0x5BB28B0, 0x0, 0x28;
	float node_x : 0x5B13BC0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B13BC0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B13BC0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "steam_hotfix_10")
{
	byte is_playable : 0x591DBF0, 0xA9;
	string64 level_name : 0x591DBF0, 0x142;
	string64 level_descriptive_name : 0x591DBF0, 0x183;
	string32 game_version : 0x591DBF0, 0x284;
	string256 log_message : 0x591E3E0, 0x0, 0x28;
	float node_x : 0x587FC60, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x587FC60, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x587FC60, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_11")
{
	byte is_playable : 0x5BA0E48, 0xA9;
	string64 level_name : 0x5BA0E48, 0x142;
	string64 level_descriptive_name : 0x5BA0E48, 0x183;
	string32 game_version : 0x5BA0E48, 0x284;
	string256 log_message : 0x5BA16A0, 0x0, 0x28;
	float node_x : 0x5B02AE0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B02AE0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B02AE0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "gog_hotfix_11")
{
	byte is_playable : 0x590BAC8, 0xA9;
	string64 level_name : 0x590BAC8, 0x142;
	string64 level_descriptive_name : 0x590BAC8, 0x183;
	string32 game_version : 0x590BAC8, 0x284;
	string256 log_message : 0x590C2C8, 0x0, 0x28;
	float node_x : 0x586DB60, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x586DB60, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x586DB60, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_11")
{
	byte is_playable : 0x5BB1E00, 0xA9;
	string64 level_name : 0x5BB1E00, 0x142;
	string64 level_descriptive_name : 0x5BB1E00, 0x183;
	string32 game_version : 0x5BB1E00, 0x284;
	string256 log_message : 0x5BB2650, 0x0, 0x28;
	float node_x : 0x5B13C20, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B13C20, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B13C20, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "steam_hotfix_11")
{
	byte is_playable : 0x591DB10, 0xA9;
	string64 level_name : 0x591DB10, 0x142;
	string64 level_descriptive_name : 0x591DB10, 0x183;
	string32 game_version : 0x591DB10, 0x284;
	string256 log_message : 0x591E300, 0x0, 0x28;
	float node_x : 0x587FC60, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x587FC60, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x587FC60, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_12")
{
	byte is_playable : 0x5B1E1D8, 0xA9;
	string64 level_name : 0x5B1E1D8, 0x142;
	string64 level_descriptive_name : 0x5B1E1D8, 0x183;
	string32 game_version : 0x5B1E1D8, 0x284;
	string256 log_message : 0x5B1E9F0, 0x0, 0x28;
	float node_x : 0x5A7E8C0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A7E8C0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A7E8C0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "gog_hotfix_12")
{
	byte is_playable : 0x588E6C8, 0xA9;
	string64 level_name : 0x588E6C8, 0x142;
	string64 level_descriptive_name : 0x588E6C8, 0x183;
	string32 game_version : 0x588E6C8, 0x284;
	string256 log_message : 0x588EE78, 0x0, 0x28;
	float node_x : 0x57EF5E0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x57EF5E0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x57EF5E0, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_12")
{
	byte is_playable : 0x5B304E0, 0xA9;
	string64 level_name : 0x5B304E0, 0x142;
	string64 level_descriptive_name : 0x5B304E0, 0x183;
	string32 game_version : 0x5B304E0, 0x284;
	string256 log_message : 0x5B30CF0, 0x0, 0x28;
	float node_x : 0x5A90A60, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A90A60, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A90A60, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "steam_hotfix_12")
{
	byte is_playable : 0x58A0BC0, 0xA9;
	string64 level_name : 0x58A0BC0, 0x142;
	string64 level_descriptive_name : 0x58A0BC0, 0x183;
	string32 game_version : 0x58A0BC0, 0x284;
	string256 log_message : 0x58A1368, 0x0, 0x28;
	float node_x : 0x58017C0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58017C0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58017C0, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_13")
{
	byte is_playable : 0x5B1F2D8, 0xA9;
	string64 level_name : 0x5B1F2D8, 0x142;
	string64 level_descriptive_name : 0x5B1F2D8, 0x183;
	string32 game_version : 0x5B1F2D8, 0x284;
	string256 log_message : 0x5B1FAF0, 0x0, 0x28;
	float node_x : 0x5A7F8E0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A7F8E0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A7F8E0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "gog_hotfix_13")
{
	byte is_playable : 0x58906E8, 0xA9;
	string64 level_name : 0x58906E8, 0x142;
	string64 level_descriptive_name : 0x58906E8, 0x183;
	string32 game_version : 0x58906E8, 0x284;
	string256 log_message : 0x5890EA0, 0x0, 0x28;
	float node_x : 0x57F1640, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x57F1640, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x57F1640, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_13")
{
	byte is_playable : 0x5B31540, 0xA9;
	string64 level_name : 0x5B31540, 0x142;
	string64 level_descriptive_name : 0x5B31540, 0x183;
	string32 game_version : 0x5B31540, 0x284;
	string256 log_message : 0x5B31D48, 0x0, 0x28;
	float node_x : 0x5A91A80, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A91A80, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A91A80, 0x260, 0x38, 0x38, 0x18;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_13")
{
	byte is_playable : 0x58A2B60, 0xA9;
	string64 level_name : 0x58A2B60, 0x142;
	string64 level_descriptive_name : 0x58A2B60, 0x183;
	string32 game_version : 0x58A2B60, 0x284;
	string256 log_message : 0x58A3318, 0x0, 0x28;
	float node_x : 0x58037A0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58037A0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58037A0, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_14")
{
	byte is_playable : 0x5B222E8, 0xA9;
	string64 level_name : 0x5B222E8, 0x142;
	string64 level_descriptive_name : 0x5B222E8, 0x183;
	string32 game_version : 0x5B222E8, 0x284;
	string256 log_message : 0x5B22AF0, 0x0, 0x28;
	float node_x : 0x5A828E0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A828E0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A828E0, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "gog_hotfix_14")
{
	byte is_playable : 0x58927E8, 0xA9;
	string64 level_name : 0x58927E8, 0x142;
	string64 level_descriptive_name : 0x58927E8, 0x183;
	string32 game_version : 0x58927E8, 0x284;
	string256 log_message : 0x5892FA0, 0x0, 0x28;
	float node_x : 0x57F3600, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x57F3600, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x57F3600, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_14")
{
	byte is_playable : 0x5B334E0, 0xA9;
	string64 level_name : 0x5B334E0, 0x142;
	string64 level_descriptive_name : 0x5B334E0, 0x183;
	string32 game_version : 0x5B334E0, 0x284;
	string256 log_message : 0x5B33CF0, 0x0, 0x28;
	float node_x : 0x5A93A40, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A93A40, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A93A40, 0x260, 0x38, 0x38, 0x18;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_14")
{
	byte is_playable : 0x58A39E0, 0xA9;
	string64 level_name : 0x58A39E0, 0x142;
	string64 level_descriptive_name : 0x58A39E0, 0x183;
	string32 game_version : 0x58A39E0, 0x284;
	string256 log_message : 0x58A4190, 0x0, 0x28;
	float node_x : 0x5804780, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5804780, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5804780, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_15")
{
	byte is_playable : 0x5B25478, 0xA9;
	string64 level_name : 0x5B25478, 0x142;
	string64 level_descriptive_name : 0x5B25478, 0x183;
	string32 game_version : 0x5B25478, 0x284;
	string256 log_message : 0x5B25C90, 0x0, 0x28;
	float node_x : 0x5A85900, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A85900, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A85900, 0x260, 0x38, 0x38, 0x18;
}


//	directx 11
state("bg3_dx11", "gog_hotfix_15")
{
	byte is_playable : 0x5896898, 0xA9;
	string64 level_name : 0x5896898, 0x142;
	string64 level_descriptive_name : 0x5896898, 0x183;
	string32 game_version : 0x5896898, 0x284;
	string256 log_message : 0x5897040, 0x0, 0x28;
	float node_x : 0x57F7640, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x57F7640, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x57F7640, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_15")
{
	byte is_playable : 0x5B375B0, 0xA9;
	string64 level_name : 0x5B375B0, 0x142;
	string64 level_descriptive_name : 0x5B375B0, 0x183;
	string32 game_version : 0x5B375B0, 0x284;
	string256 log_message : 0x5B37DB0, 0x0, 0x28;
	float node_x : 0x5A97A80, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A97A80, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A97A80, 0x260, 0x38, 0x38, 0x18;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_15")
{
	byte is_playable : 0x58A8CE0, 0xA9;
	string64 level_name : 0x58A8CE0, 0x142;
	string64 level_descriptive_name : 0x58A8CE0, 0x183;
	string32 game_version : 0x58A8CE0, 0x284;
	string256 log_message : 0x58A9490, 0x0, 0x28;
	float node_x : 0x5809780, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5809780, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5809780, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_16")
{
	byte is_playable : 0x5B38D08, 0xA9;
	string64 level_name : 0x5B38D08, 0x142;
	string64 level_descriptive_name : 0x5B38D08, 0x183;
	string32 game_version : 0x5B38D08, 0x284;
	string256 log_message : 0x5B39520, 0x0, 0x28;
	float node_x : 0x5A99080, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5A99080, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5A99080, 0x260, 0x38, 0x38, 0x18;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_16")
{
	byte is_playable : 0x58AA268, 0xA9;
	string64 level_name : 0x58AA268, 0x142;
	string64 level_descriptive_name : 0x58AA268, 0x183;
	string32 game_version : 0x58AA268, 0x284;
	string256 log_message : 0x58AAA10, 0x0, 0x28;
	float node_x : 0x580ADC0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x580ADC0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x580ADC0, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_16")
{
	byte is_playable : 0x5B49F10, 0xA9;
	string64 level_name : 0x5B49F10, 0x142;
	string64 level_descriptive_name : 0x5B49F10, 0x183;
	string32 game_version : 0x5B49F10, 0x284;
	string256 log_message : 0x5B4A718, 0x0, 0x28;
	float node_x : 0x5AAA200, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5AAA200, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5AAA200, 0x260, 0x38, 0x38, 0x18;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_16")
{
	byte is_playable : 0x58BB4B0, 0xA9;
	string64 level_name : 0x58BB4B0, 0x142;
	string64 level_descriptive_name : 0x58BB4B0, 0x183;
	string32 game_version : 0x58BB4B0, 0x284;
	string256 log_message : 0x58BBC70, 0x0, 0x28;
	float node_x : 0x581BF20, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x581BF20, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x581BF20, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "gog_hotfix_17")
{
	byte is_playable : 0x5BA3D48, 0xA9;
	string64 level_name : 0x5BA3D48, 0x142;
	string64 level_descriptive_name : 0x5BA3D48, 0x183;
	string32 game_version : 0x5BA3D48, 0x284;
	string256 log_message : 0x5BA4560, 0x0, 0x28;
	float node_x : 0x5B04160, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B04160, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B04160, 0x260, 0x38, 0x38, 0x18;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_17")
{
	byte is_playable : 0x5915328, 0xA9;
	string64 level_name : 0x5915328, 0x142;
	string64 level_descriptive_name : 0x5915328, 0x183;
	string32 game_version : 0x5915328, 0x284;
	string256 log_message : 0x5915AD0, 0x0, 0x28;
	float node_x : 0x5875E60, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5875E60, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5875E60, 0x260, 0x38, 0x38, 0x18;
}

//	vulkan
state("bg3", "steam_hotfix_17")
{
	byte is_playable : 0x5BB6F10, 0xA9;
	string64 level_name : 0x5BB6F10, 0x142;
	string64 level_descriptive_name : 0x5BB6F10, 0x183;
	string32 game_version : 0x5BB6F10, 0x284;
	string256 log_message : 0x5BB7718, 0x0, 0x28;
	float node_x : 0x5B172A0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B172A0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B172A0, 0x260, 0x38, 0x38, 0x18;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_17")
{
	byte is_playable : 0x59275A0, 0xA9;
	string64 level_name : 0x59275A0, 0x142;
	string64 level_descriptive_name : 0x59275A0, 0x183;
	string32 game_version : 0x59275A0, 0x284;
	string256 log_message : 0x5927D60, 0x0, 0x28;
	float node_x : 0x5887FE0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5887FE0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5887FE0, 0x260, 0x38, 0x38, 0x18;
}


state("bg3", "unsupported")
{
}


//	directx 11
state("bg3_dx11", "unsupported")
{
}

startup
{
	//	internal_split_name = Tuple<display_name, old_level, new_level>
	vars.splits = new Dictionary<string, Tuple<string, string, string>>();
	vars.splits.Add("split_on_nautiloid_to_wilderness", new Tuple<string, string, string>("Split on Nautiloid to Wilderness", "TUT_Avernus_C", "WLD_Main_A"));
	vars.splits.Add("split_on_wilderness_to_mountain_pass", new Tuple<string, string, string>("Split on Wilderness to Mountain Pass", "WLD_Main_A", "CRE_Main_A"));
	vars.splits.Add("split_on_mountain_pass_to_shadow_cursed_lands", new Tuple<string, string, string>("Split on Mountain_Pass to Shadow Cursed Lands", "CRE_Main_A", "SCL_Main_A"));
	vars.splits.Add("split_on_shadow_cursed_lands_to_intermission_gith", new Tuple<string, string, string>("Split on Shadow Cursed Lands to Intermission Gith", "SCL_Main_A", "INT_Main_A"));
	vars.splits.Add("split_on_intermission_gith_to_wyrms_crossing", new Tuple<string, string, string>("Split on Intermission Gith to Wyrms Crossing", "INT_Main_A", "BGO_Main_A"));
	vars.splits.Add("split_on_wyrms_crossing_to_baldurs_gate", new Tuple<string, string, string>("Split on Wyrms Crossing to Baldurs Gate", "BGO_Main_A", "CTY_Main_A"));
	vars.splits.Add("split_on_baldurs_gate_to_high_hall", new Tuple<string, string, string>("Split on Baldurs Gate to High Hall", "CTY_Main_A", "END_Main"));

	vars.split_mapping = new Dictionary<string, Tuple<string, string, string>>();

	foreach(KeyValuePair<string, Tuple<string, string, string>> split_pair in vars.splits)
	{
		settings.Add(split_pair.Key, false, split_pair.Value.Item1);
	}
	
	settings.Add("debug", false, "Debug");
	settings.Add("debug_node_fling", false, "Debug - Node Fling");
	settings.Add("debug_no_cached_addresses", false, "Debug - No Cached Addresses, Always scan (Splitter will slow whenever game starts up. Requires game or livesplit to restart)");

	//	https://github.com/ogam/asl/blob/master/dust%20aet.asl
	//	debug labels
	vars.textMap = new Dictionary<string, object>();
	vars.FindOrCreateTextComponentSettings = (Func<string, object>)((name) => {		
		object textSettings = null;
		foreach(dynamic component in timer.Layout.Components) {
			if(component.GetType().Name == "TextComponent") {
				if(component.Settings.Text1 == name) {
					textSettings = component.Settings;
					break;
				}
			}
		}
		
		if(textSettings == null) {
			var assembly = Assembly.LoadFrom(@"Components\LiveSplit.Text.dll");
			dynamic textComponent = Activator.CreateInstance(assembly.GetType("LiveSplit.UI.Components.TextComponent"), timer);
			timer.Layout.LayoutComponents.Add(new LiveSplit.UI.Components.LayoutComponent("LiveSplit.Text.dll", textComponent as LiveSplit.UI.Components.IComponent));
			textComponent.Settings.Text1 = name;
			textSettings = textComponent.Settings;
		}
		
		return textSettings;
	});

	vars.SetText = (Action<string, string>)((name, text) => {
		if(!vars.textMap.ContainsKey(name)){
			vars.textMap.Add(name, vars.FindOrCreateTextComponentSettings(name));
		}
		
		if(vars.textMap[name] == null){
			vars.textMap[name] = vars.FindOrCreateTextComponentSettings(name);
		}
		if(vars.textMap[name].GetType().ToString().Contains("Settings")) {
			vars.textMap[name].Text2 = text;
		}
	});

	//	@todo:	speed or separate this into a simd scanner tool
	//	this is slow, updated to do this in chunks per memory page as bg3 reserves a lot up front now since
	//	patch 4, previously it did this after engine finished initialized so it was fine
	//	now chunks are a bit bigger than int32, and SignatureScanner doesn't support larger types or unsigned
	//	we'll just do this in smaller batches
	vars.Scanner = (Func<Process, SigScanTarget, IntPtr>)((proc, scan_target) => {
		IntPtr result_ptr = IntPtr.Zero;
		int page_index = 0;
		foreach (var page in proc.MemoryPages(true))
		{
			UInt64 size = (UInt64)page.RegionSize;
			int current_position = 0;
			int block_size = 0x7FFFFFFF >> 1;
			int region_size = 0;
			while (size > 0)
			{
				region_size = block_size;
				if (size < (UInt64)block_size)
				{
					region_size = (int)size;
				}

				print(String.Format("[BG3 ASL] {0} scanning for region - {1} => {2}", page_index, page.BaseAddress + current_position, region_size));
				var scanner = new SignatureScanner(proc, page.BaseAddress + current_position, region_size);
				if (result_ptr == IntPtr.Zero)
				{
					result_ptr = scanner.Scan(scan_target);
				}
				else
				{
					break;
				}
				current_position += region_size;
				size -= (UInt64)region_size;
			}
			if (result_ptr != IntPtr.Zero)
			{
				break;
			}
			page_index++;
		}
		
		return result_ptr;
	});
}

init
{
/*
		//	logging_message, any of these 3
		bg3_dx11.exe+313415D - 0FB6 F8               - movzx edi,al
		bg3_dx11.exe+3134160 - 48 8B 0D 59FBEE01     - mov rcx,[bg3_dx11.exe+5023CC0] { (1E8040E21C0) }
		bg3_dx11.exe+3134167 - 48 85 C9              - test rcx,rcx
		--
		bg3_dx11.exe+31343C6 - 88 07                 - mov [rdi],al
		bg3_dx11.exe+31343C8 - 48 8B 0D F1F8EE01     - mov rcx,[bg3_dx11.exe+5023CC0] { (192) }
		bg3_dx11.exe+31343CF - 48 85 C9              - test rcx,rcx
		--
		bg3_dx11.exe+3133CAC - 4D 8D 43 E8           - lea r8,[r11-18]
		bg3_dx11.exe+3133CB0 - 48 8B 35 0900EF01     - mov rsi,[bg3_dx11.exe+5023CC0] { (192) }
		bg3_dx11.exe+3133CB7 - 4C 8B F2              - mov r14,rdx
		bg3_dx11.exe+3133CBA - 48 8B F9              - mov rdi,rcx
*/
/*
		//	server_state
		bg3_dx11.exe+30485C0 - 0FB6 51 08            - movzx edx,byte ptr [rcx+08]
		bg3_dx11.exe+30485C4 - 48 8B 0D A584FD01     - mov rcx,[bg3_dx11.exe+5020A70] { (1E806274800) }
		--
		bg3_dx11.exe+30485E0 - 44 0FB6 41 09         - movzx r8d,byte ptr [rcx+09]
		bg3_dx11.exe+30485E5 - 0FB6 51 08            - movzx edx,byte ptr [rcx+08]
		bg3_dx11.exe+30485E9 - 48 8B 0D 8084FD01     - mov rcx,[bg3_dx11.exe+5020A70] { (1E806274800) }		
*/

	vars.scan_target_logging_message = new SigScanTarget(6,
/*
		bg3_dx11.exe+313415D - 0FB6 F8               - movzx edi,al
		bg3_dx11.exe+3134160 - 48 8B 0D 59FBEE01     - mov rcx,[bg3_dx11.exe+5023CC0] { (1E8040E21C0) }
		bg3_dx11.exe+3134167 - 48 85 C9              - test rcx,rcx
*/
		"0F B6 F8",
		"48 8B 0D ????????",
		"48 85 C9"

/*
		bg3_dx11.exe+3133CAC - 4D 8D 43 E8           - lea r8,[r11-18]
		bg3_dx11.exe+3133CB0 - 48 8B 35 0900EF01     - mov rsi,[bg3_dx11.exe+5023CC0] { (192) }
		bg3_dx11.exe+3133CB7 - 4C 8B F2              - mov r14,rdx
		bg3_dx11.exe+3133CBA - 48 8B F9              - mov rdi,rcx

		"4D 8D 43 E8",
		"48 8B 35 ????????",
		"4C 8B F2",
		"48 8B F9"
*/
/*
		bg3_dx11.exe+3133CB0 - 48 8B 35 0900EF01     - mov rsi,[bg3_dx11.exe+5023CC0] { (192) }
		bg3_dx11.exe+3133CB7 - 4C 8B F2              - mov r14,rdx
		bg3_dx11.exe+3133CBA - 48 8B F9              - mov rdi,rcx
		bg3_dx11.exe+3133CBD - BB A00C0000           - mov ebx,00000CA0 { 3232 }

		"48 8B 35 ????????",
		"4C 8B F2",
		"48 8B F9",
		"BB A00C0000"
*/
	);

	vars.scan_target_server_state = new SigScanTarget(7,
/*
		bg3.exe+379F652 - 48 83 EC 40           - sub rsp,40 { 64 }
		bg3.exe+379F656 - 48 8B 2D 4B154002     - mov rbp,[bg3.exe+5BA0BA8] { (1FBDDBF4000) }
		bg3.exe+379F65D - 83 BD C4020000 FF     - cmp dword ptr [rbp+000002C4],-01 { 255 }
*/
		"48 83 EC 40",
		"48 8B 2D ????????",
		"83 BD C4020000 FF"
	);

	//	world object position x, y = x + 4, z = x + 8
	//	<x,y,z> => <x,z> maps to what you see on the minimap
	//	y is height of the position in world space
	//	0x260, 38, 38, 10
	vars.scan_target_node_fling = new SigScanTarget(3,
/*
	bg3_dx11.exe+28E9692 - 48 8B 0D 6744F802     - mov rcx,[bg3_dx11.exe+586DB00] { (1E8C2860600) }
	bg3_dx11.exe+28E9699 - 4C 8D 44 24 40        - lea r8,[rsp+40]
	bg3_dx11.exe+28E969E - 48 8D 54 24 20        - lea rdx,[rsp+20]
*/
	"48 8B 0D ????????",
	"4C 8D 44 24 40",
	"48 8D 54 24 20"
	);

	//	try to use hardcoded pointers so it's a bit faster
	//	if version is not supported then take the slow "unsupported" path
	//	slow path does require livesplit to be running before the game does, otherwise it'll take too long
	//	trying to comb through memory pages for logging and server pointers

	vars.game_version = modules.First().FileVersionInfo.ProductVersion;
	bool is_gog_version = false;
	foreach (var module in modules)
	{
		if (module.ModuleName == "Galaxy64.dll")
		{
			is_gog_version = true;
			break;
		}
	}
	
	Dictionary<string, String> gog_version_map = new Dictionary<string, String>()
	{
		{ "4.1.1.3732833", "gog_patch_3" },
		{ "4.1.1.3735951", "gog_hotfix_7" },
		{ "4.1.1.3767641", "gog_hotfix_9" },
		{ "4.1.1.3882084", "gog_patch_4" },
		{ "4.1.1.3905231", "gog_patch_4_1" },
		{ "4.1.1.3911062", "gog_hotfix_10" },
		{ "4.1.1.3956130", "gog_hotfix_11" },
		{ "4.1.1.4079877", "gog_hotfix_12" },
		{ "4.1.1.4145012", "gog_hotfix_13" },
		{ "4.1.1.4216792", "gog_hotfix_14" },
		{ "4.1.1.4251417", "gog_hotfix_15" },
		{ "4.1.1.4425968", "gog_hotfix_16" },
		{ "4.1.1.4494476", "gog_hotfix_17" },
	};
	Dictionary<string, String> steam_version_map = new Dictionary<string, String>()
	{
		{ "4.1.1.3732833", "steam_patch_3" },
		{ "4.1.1.3735951", "steam_hotfix_7" },
		{ "4.1.1.3767641", "steam_hotfix_9" },
		{ "4.1.1.3882084", "steam_patch_4" },
		{ "4.1.1.3905231", "steam_patch_4_1" },
		{ "4.1.1.3911062", "steam_hotfix_10" },
		{ "4.1.1.3956130", "steam_hotfix_11" },
		{ "4.1.1.4079877", "steam_hotfix_12" },
		{ "4.1.1.4145012", "steam_hotfix_13" },
		{ "4.1.1.4216792", "steam_hotfix_14" },
		{ "4.1.1.4251417", "steam_hotfix_15" },
		{ "4.1.1.4425968", "steam_hotfix_16" },
		{ "4.1.1.4494476", "steam_hotfix_17" },
	};

	String mapped_version;
	if (is_gog_version)
	{
		if (gog_version_map.TryGetValue(vars.game_version, out mapped_version))
		{
			version = mapped_version;
		}
	}
	else
	{
		if (steam_version_map.TryGetValue(vars.game_version, out mapped_version))
		{
			version = mapped_version;
		}
	}
	
	vars.is_version_unsupported = false;
	if (String.IsNullOrEmpty(mapped_version) || settings["debug_no_cached_addresses"])
	{
		version = "unsupported";
		vars.is_version_unsupported = true;
	}
   

	print(String.Format("[BG3_ASL]: {0} - {1}", game.ProcessName, version));

	vars.logging_message_code_ptr = IntPtr.Zero;
	vars.logging_message_code_offset = 0;	
	vars.logging_message_offset = 0;
	vars.logging_message_ptr = IntPtr.Zero;
	
	vars.server_state_code_ptr = IntPtr.Zero;
	vars.server_state_code_offset = 0;
	vars.server_state_offset = 0;
	vars.server_state_ptr = IntPtr.Zero;
	
	vars.node_fling_code_ptr = IntPtr.Zero;
	vars.node_fling_code_offset = 0;
	vars.node_fling_offset = 0;
	vars.node_fling_offset = 0;
	vars.node_fling_ptr = IntPtr.Zero;
	vars.node_fling_x_ptr = null;
	vars.node_fling_y_ptr = null;
	vars.node_fling_z_ptr = null;

	/*
	bg3_dx11.CAkRegistryMgr::GetObjAndAddref+1A70 - 40 53                 - push rbx
    bg3_dx11.CAkRegistryMgr::GetObjAndAddref+1A72 - 48 83 EC 20           - sub rsp,20 { 32 }
    bg3_dx11.CAkRegistryMgr::GetObjAndAddref+1A76 - 48 8B 1D 4BB9D501     - mov rbx,[bg3_dx11.exe+5070E58] { (23C53651B80) }
    bg3_dx11.CAkRegistryMgr::GetObjAndAddref+1A7D - 48 85 DB              - test rbx,rbx
    0x218, 0xD0, 0x30, 0x220, 0x580
	*/

	if (vars.is_version_unsupported)
	{
		//	this grabs address in the code pages for pointer address above marked in ????????
		//	we'll want to dereference that code pointer value and use that as an offset to actual base module memory
		//	code_ptr - base_address + code_ptr_value + 4
		//	this will give the above module offset, example with the above being `0x5023CC0`

		vars.logging_message_code_ptr = vars.Scanner(game, vars.scan_target_logging_message);
		if (vars.logging_message_code_ptr == IntPtr.Zero)
		{
			throw new Exception("Couldn't find logging message pointer");
		}

		vars.logging_message_code_offset = game.ReadValue<int>((IntPtr)vars.logging_message_code_ptr);
		vars.logging_message_offset = vars.logging_message_code_ptr.ToInt64() - modules.First().BaseAddress.ToInt64() + 4;
		vars.logging_message_offset = vars.logging_message_offset + vars.logging_message_code_offset;
		vars.logging_message_ptr = new IntPtr(modules.First().BaseAddress.ToInt64() + vars.logging_message_offset);	
		vars.logging_message = new DeepPointer(vars.logging_message_ptr, 0x0, 0x28);

		vars.server_state_code_ptr = vars.Scanner(game, vars.scan_target_server_state);
		if (vars.server_state_code_ptr == IntPtr.Zero)
		{
			throw new Exception("Couldn't find server state pointer");
		}
		vars.server_state_code_offset = game.ReadValue<int>((IntPtr)vars.server_state_code_ptr);
		vars.server_state_offset = vars.server_state_code_ptr.ToInt64() - modules.First().BaseAddress.ToInt64() + 4;
		vars.server_state_offset = vars.server_state_offset + vars.server_state_code_offset;
		vars.server_state_ptr = new IntPtr(modules.First().BaseAddress.ToInt64() + vars.server_state_offset);
		vars.server_state_is_playable = new DeepPointer(vars.server_state_ptr, 0xA9);
		vars.server_state_level_name = new DeepPointer(vars.server_state_ptr, 0x142);
		vars.server_state_level_descriptive_name = new DeepPointer(vars.server_state_ptr, 0x183);

		if (settings["debug_node_fling"])
		{

			vars.node_fling_code_ptr = vars.Scanner(game, vars.scan_target_node_fling);
			if (vars.server_state_code_ptr != IntPtr.Zero)
			{
				vars.node_fling_code_offset = game.ReadValue<int>((IntPtr)vars.node_fling_code_ptr);
				vars.node_fling_offset = vars.node_fling_code_ptr.ToInt64() - modules.First().BaseAddress.ToInt64() + 4;
				vars.node_fling_offset = vars.node_fling_offset + vars.node_fling_code_offset;
				vars.node_fling_ptr = new IntPtr(modules.First().BaseAddress.ToInt64() + vars.node_fling_offset);
				vars.node_fling_x_ptr = new DeepPointer(vars.node_fling_ptr, 0x260, 0x38, 0x38, 0x10);
				vars.node_fling_y_ptr = new DeepPointer(vars.node_fling_ptr, 0x260, 0x38, 0x38, 0x14);
				vars.node_fling_z_ptr = new DeepPointer(vars.node_fling_ptr, 0x260, 0x38, 0x38, 0x18);
			}
		}
	}

	vars.current_is_playable = 0;
	vars.current_level_name = String.Empty;
	vars.current_level_descriptive_name = String.Empty;
	vars.current_log_message = String.Empty;
	vars.current_node_x = 0;
	vars.current_node_y = 0;
	vars.current_node_z = 0;
	vars.old_is_playable = 0;
	vars.old_level_name = String.Empty;
	vars.old_level_descriptive_name = String.Empty;
	vars.old_log_message = String.Empty;
	vars.old_node_x = 0;
	vars.old_node_y = 0;
	vars.old_node_z = 0;
}

update
{
	vars.old_is_playable = vars.current_is_playable;
	vars.old_level_name = vars.current_level_name;
	vars.old_level_descriptive_name = vars.current_level_descriptive_name;
	vars.old_log_message = vars.current_log_message;
	vars.old_node_x = vars.current_node_x;
	vars.old_node_y = vars.current_node_y;
	vars.old_node_z = vars.current_node_z;

	if (vars.is_version_unsupported)
	{
		vars.current_is_playable = vars.server_state_is_playable.Deref<byte>(game);
		vars.current_level_name = vars.server_state_level_name.DerefString(game, 32, "Failed");
		vars.current_level_descriptive_name = vars.server_state_level_descriptive_name.DerefString(game, 64, "Failed");
		vars.current_log_message = vars.logging_message.DerefString(game, 256, "Failed");
		if (vars.node_fling_x_ptr != null && vars.node_fling_y_ptr != null && vars.node_fling_z_ptr != null)
		{
			vars.current_node_x = vars.node_fling_x_ptr.Deref<float>(game);
			vars.current_node_y = vars.node_fling_y_ptr.Deref<float>(game);
			vars.current_node_z = vars.node_fling_z_ptr.Deref<float>(game);
		}
	}
	else
	{
		vars.current_is_playable = current.is_playable;
		vars.current_level_name = current.level_name;
		vars.current_level_descriptive_name = current.level_descriptive_name;
		vars.current_log_message = current.log_message;
		if (settings["debug_node_fling"])
		{
			vars.current_node_x = current.node_x;
			vars.current_node_y = current.node_y;
			vars.current_node_z = current.node_z;
		}
	}

	if (settings["debug"])
	{
		vars.SetText("Debug_Game_Version", String.Format("{0}", vars.game_version));
		vars.SetText("Debug_Log_Ptr", String.Format("{0}", vars.logging_message_code_ptr.ToString("X")));
		vars.SetText("Debug_Log_code_offset", vars.logging_message_code_offset.ToString("X"));
		vars.SetText("*Debug_Log_offset*", vars.logging_message_offset.ToString("X"));
		vars.SetText("Debug_Log", vars.current_log_message);

		vars.SetText("Debug_Server_Ptr", String.Format("{0}", vars.server_state_code_ptr.ToString("X")));
		vars.SetText("Debug_Server_code_offset", vars.server_state_code_offset.ToString("X"));
		vars.SetText("*Debug_Server_offset*", vars.server_state_offset.ToString("X"));
		vars.SetText("Debug_Server_is_playable", String.Format("{0}", vars.current_is_playable));
		vars.SetText("Debug_Server_level_name", vars.current_level_name);
		vars.SetText("Debug_Server_level_descriptive_name", vars.current_level_descriptive_name);
	}

	if (settings["debug_node_fling"])
	{
		vars.SetText("Map X,Y", String.Format("{0:0.0}, {1:0.0}", vars.current_node_x, vars.current_node_z));
		vars.SetText("World X,Y,Z", String.Format("{0:0.0}, {1:0.0}, {2:0.0}", vars.current_node_x, vars.current_node_y, vars.current_node_z));
		if (settings["debug"])
		{
			vars.SetText("Debug_Node_Ptr", String.Format("{0}", vars.node_fling_code_ptr.ToString("X")));
			vars.SetText("Debug_Node_code_offset", vars.node_fling_code_offset.ToString("X"));
			vars.SetText("*Debug_Node_offset*", vars.node_fling_offset.ToString("X"));
		}
	}
}

start
{
	bool is_tutorial = vars.current_level_name.Contains("TUT_Avernus_C");
	bool is_running = vars.current_log_message.Contains("to: Running") && !vars.old_log_message.Contains("to: Running");
	return is_tutorial && vars.current_is_playable != 0 && is_running;
}

isLoading
{
	return !(vars.current_is_playable != 0 && vars.current_log_message.Contains("to: Running")) && !vars.current_log_message.Contains("to: Save");
}

split
{
	bool has_level_changed = vars.current_level_name != vars.old_level_name;
	bool is_level_change_progressive = false;
	foreach (KeyValuePair<string, Tuple<string, string, string>> split_pair in vars.splits)
	{
		if (settings[split_pair.Key])
		{
			if (split_pair.Value.Item2 == vars.old_level_name && split_pair.Value.Item3 == vars.current_level_name)
			{
				is_level_change_progressive = true;
				break;
			}
		}
	}

	return has_level_changed && is_level_change_progressive;
}

exit
{
    timer.IsGameTimePaused = true;
}