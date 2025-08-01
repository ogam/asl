//	currently supported versions
//		hotfix 6 *steam only, unable to get gog hotfix 6 version
//		Patch 3
//		hotfix 7
//		hotfix 9
//		patch 4
//		patch 4_1
//		hotfix 10
//		hotfix 11
//		patch 5 *missing gog vulkan, gog dx11, steam vulkan
//		hotfix 12
//		hotfix 13
//		hotfix 14
//		hotfix 15
//		hotfix 16
//		hotfix 17
//		patch 6
//		hotfix 18
//		hotfix 19
//		hotfix 20
//		hotfix 21
//		hotfix 21_1 *minor crash fix patch
//		hotfix 22
//		hotfix 25
//		patch 7
//		hotfix 28
//		patch 8
//		hotfix 30
//		hotfix 31
//		hotfix 32
//		hotfix 33

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
state("bg3", "steam_hotfix_6")
{
	byte is_playable : 0x0574E9F0, 0xA9;
	string64 level_name : 0x0574E9F0, 0x142;
	string64 level_descriptive_name : 0x0574E9F0, 0x183;
	string32 game_version : 0x0574E9F0, 0x284;
	string256 log_message : 0x05752CF0, 0x0, 0x44;
	float node_x : 0x055CE928, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x055CE928, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x055CE928, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x056B34E0, 0x8, 0xF0, 0x18, 0x0, 0x220, 0x580;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_6")
{
	byte is_playable : 0x054D0580, 0xA9;
	string64 level_name : 0x054D0580, 0x142;
	string64 level_descriptive_name : 0x054D0580, 0x183;
	string32 game_version : 0x054D0580, 0x284;
	string256 log_message : 0x054D37C0, 0x0, 0x44;
	float node_x : 0x05350488, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x05350488, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x05350488, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x05435100, 0x8, 0xF0, 0x18, 0x0, 0x220, 0x580;
}

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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
}

//  @todo: patch 5 - gog vulkan, gog dx11, steam vulkan

//	directx 11
state("bg3_dx11", "steam_patch_5")
{
	byte is_playable : 0x58A0BC0, 0xA9;
	string64 level_name : 0x58A0BC0, 0x142;
	string64 level_descriptive_name : 0x58A0BC0, 0x183;
	string32 game_version : 0x58A0BC0, 0x284;
	string256 log_message : 0x58A1368, 0x0, 0x28;
	float node_x : 0x58017C0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58017C0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58017C0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x0; // unsupported
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

	string32 ui_state : 0x5B19218, 0x8, 0x120, 0x18, 0, 0x1C8, 0x230, 0x580;
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

	string32 ui_state : 0x588AF00, 0x8, 0x120, 0x18, 0, 0x1C8, 0x230, 0x580;
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

	string32 ui_state : 0x5B2C360, 0x8, 0x120, 0x18, 0, 0x1C8, 0x230, 0x580;
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

	string32 ui_state : 0x589D088, 0x8, 0x120, 0x18, 0, 0x1C8, 0x230, 0x580;
}

//	vulkan
state("bg3", "gog_patch_6")
{
	byte is_playable : 0x5BDC398, 0xA9;
	string64 level_name : 0x5BDC398, 0x183;
	string64 level_descriptive_name : 0x5BDC398, 0x1C4;
	string32 game_version : 0x5BDC398, 0x284;
	string256 log_message : 0x5BDCBA8, 0x0, 0x28;
	float node_x : 0x5B3C070, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B3C070, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B3C070, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B510F8, 0x8, 0x108, 0x18, 0x10, 0x208, 0x3F0, 0x598;
}

//	directx 11
state("bg3_dx11", "gog_patch_6")
{
	byte is_playable : 0x594E988, 0xA9;
	string64 level_name : 0x594E988, 0x183;
	string64 level_descriptive_name : 0x594E988, 0x1C4;
	string32 game_version : 0x594E988, 0x284;
	string256 log_message : 0x594F148, 0x0, 0x28;
	float node_x : 0x58AED90, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58AED90, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58AED90, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58C3E00, 0x8, 0x108, 0x18, 0x10, 0x208, 0x3F0, 0x598;
}

//	vulkan
state("bg3", "steam_patch_6")
{
	byte is_playable : 0x5BEE6A0, 0xA9;
	string64 level_name : 0x5BEE6A0, 0x183;
	string64 level_descriptive_name : 0x5BEE6A0, 0x1C4;
	string32 game_version : 0x5BEE6A0, 0x284;
	string256 log_message : 0x5BEEEB8, 0x0, 0x28;
	float node_x : 0x5B4E230, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B4E230, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B4E230, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B632C0, 0x8, 0x108, 0x18, 0x10, 0x208, 0x3F0, 0x598;
}

//	directx 11
state("bg3_dx11", "steam_patch_6")
{
	byte is_playable : 0x5960D20, 0xA9;
	string64 level_name : 0x5960D20, 0x183;
	string64 level_descriptive_name : 0x5960D20, 0x1C4;
	string32 game_version : 0x5960D20, 0x284;
	string256 log_message : 0x59614D8, 0x0, 0x28;
	float node_x : 0x58C0F30, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58C0F30, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58C0F30, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58D5FA8, 0x8, 0x108, 0x18, 0x10, 0x208, 0x3F0, 0x598;
}

//	vulkan
state("bg3", "gog_hotfix_18")
{
	byte is_playable : 0x530DEE0, 0xA9;
	string64 level_name : 0x530DEE0, 0x183;
	string64 level_descriptive_name : 0x530DEE0, 0x1C4;
	string32 game_version : 0x530DEE0, 0x284;
	string256 log_message : 0x5311C08, 0x0, 0x28;
	float node_x : 0x514D2E0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x514D2E0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x514D2E0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5389800, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598; 
}

//	directx 11
state("bg3_dx11", "gog_hotfix_18")
{
	byte is_playable : 0x5081630, 0xA9;
	string64 level_name : 0x5081630, 0x183;
	string64 level_descriptive_name : 0x5081630, 0x1C4;
	string32 game_version : 0x5081630, 0x284;
	string256 log_message : 0x5085008, 0x0, 0x28;
	float node_x : 0x4EC0AE0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x4EC0AE0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x4EC0AE0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x50FCC10, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598; 
}

//	vulkan
state("bg3", "steam_hotfix_18")
{
	byte is_playable : 0x5318110, 0xA9;
	string64 level_name : 0x5318110, 0x183;
	string64 level_descriptive_name : 0x5318110, 0x1C4;
	string32 game_version : 0x5318110, 0x284;
	string256 log_message : 0x531BE38, 0x0, 0x28;
	float node_x : 0x51573C0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x51573C0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x51573C0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5393910, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598; 
}

//	directx 11
state("bg3_dx11", "steam_hotfix_18")
{
	byte is_playable : 0x508A880, 0xA9;
	string64 level_name : 0x508A880, 0x183;
	string64 level_descriptive_name : 0x508A880, 0x1C4;
	string32 game_version : 0x508A880, 0x284;
	string256 log_message : 0x508E258, 0x0, 0x28;
	float node_x : 0x4EC9BE0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x4EC9BE0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x4EC9BE0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5105D40, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598; 
}

//	vulkan
state("bg3", "gog_hotfix_19")
{
	byte is_playable : 0x5BF93B8, 0xA9;
	string64 level_name : 0x5BF93B8, 0x183;
	string64 level_descriptive_name : 0x5BF93B8, 0x1C4;
	string32 game_version : 0x5BF93B8, 0x284;
	string256 log_message : 0x5BF9BB8, 0x0, 0x28;
	float node_x : 0x5B590D0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B590D0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B590D0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B6E158, 0x8, 0x120, 0x18, 0x0, 0x208, 0x88, 0x598;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_19")
{
	byte is_playable : 0x596B968, 0xA9;
	string64 level_name : 0x596B968, 0x183;
	string64 level_descriptive_name : 0x596B968, 0x1C4;
	string32 game_version : 0x596B968, 0x284;
	string256 log_message : 0x596C118, 0x0, 0x28;
	float node_x : 0x58CBD90, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58CBD90, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58CBD90, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58E0E00, 0x8, 0x120, 0x18, 0x0, 0x208, 0x88, 0x598;
}

//	vulkan
state("bg3", "steam_hotfix_19")
{
	byte is_playable : 0x5C0B570, 0xA9;
	string64 level_name : 0x5C0B570, 0x183;
	string64 level_descriptive_name : 0x5C0B570, 0x1C4;
	string32 game_version : 0x5C0B570, 0x284;
	string256 log_message : 0x5C0BD78, 0x0, 0x28;
	float node_x : 0x5B6B1F0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B6B1F0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B6B1F0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B80280, 0x8, 0x120, 0x18, 0x0, 0x208, 0x88, 0x598;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_19")
{
	byte is_playable : 0x597DA00, 0xA9;
	string64 level_name : 0x597DA00, 0x183;
	string64 level_descriptive_name : 0x597DA00, 0x1C4;
	string32 game_version : 0x597DA00, 0x284;
	string256 log_message : 0x597E1B0, 0x0, 0x28;
	float node_x : 0x58DDF30, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58DDF30, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58DDF30, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58F2FA8, 0x8, 0x120, 0x18, 0x0, 0x208, 0x88, 0x598;
}

//	vulkan
state("bg3", "gog_hotfix_20")
{
	byte is_playable : 0x5BF5328, 0xA9;
	string64 level_name : 0x5BF5328, 0x183;
	string64 level_descriptive_name : 0x5BF5328, 0x1C4;
	string32 game_version : 0x5BF5328, 0x284;
	string256 log_message : 0x5BF5B38, 0x0, 0x28;
	float node_x : 0x5B55050, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B55050, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B55050, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B6A0D8, 0x8, 0x120, 0x18, 0x0, 0x208, 0x578;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_20")
{
	byte is_playable : 0x59679F8, 0xA9;
	string64 level_name : 0x59679F8, 0x183;
	string64 level_descriptive_name : 0x59679F8, 0x1C4;
	string32 game_version : 0x59679F8, 0x284;
	string256 log_message : 0x59681B0, 0x0, 0x28;
	float node_x : 0x58C7DD0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58C7DD0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58C7DD0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58DCE40, 0x8, 0x120, 0x18, 0x0, 0x208, 0x578;
}

//	vulkan
state("bg3", "steam_hotfix_20")
{
	byte is_playable : 0x5C06480, 0xA9;
	string64 level_name : 0x5C06480, 0x183;
	string64 level_descriptive_name : 0x5C06480, 0x1C4;
	string32 game_version : 0x5C06480, 0x284;
	string256 log_message : 0x5C06C98, 0x0, 0x28;
	float node_x : 0x5B661B0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B661B0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B661B0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B7B240, 0x8, 0x120, 0x18, 0x0, 0x208, 0x578;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_20")
{
	byte is_playable : 0x5978A20, 0xA9;
	string64 level_name : 0x5978A20, 0x183;
	string64 level_descriptive_name : 0x5978A20, 0x1C4;
	string32 game_version : 0x5978A20, 0x284;
	string256 log_message : 0x59791E8, 0x0, 0x28;
	float node_x : 0x58D8ED0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58D8ED0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58D8ED0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x058EDF48, 0x8, 0x120, 0x18, 0x0, 0x208, 0x578;
}

//	vulkan
state("bg3", "gog_hotfix_21")
{
	byte is_playable : 0x5C034C8, 0xA9;
	string64 level_name : 0x5C034C8, 0x183;
	string64 level_descriptive_name : 0x5C034C8, 0x1C4;
	string32 game_version : 0x5C034C8, 0x284;
	string256 log_message : 0x5C03CC8, 0x0, 0x28;
	float node_x : 0x5B63070, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B63070, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B63070, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B780F8, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_21")
{
	byte is_playable : 0x5975BA8, 0xA9;
	string64 level_name : 0x5975BA8, 0x183;
	string64 level_descriptive_name : 0x5975BA8, 0x1C4;
	string32 game_version : 0x5975BA8, 0x284;
	string256 log_message : 0x5976358, 0x0, 0x28;
	float node_x : 0x58D5DF0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58D5DF0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58D5DF0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58EAE50, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	vulkan
state("bg3", "steam_hotfix_21")
{
	byte is_playable : 0x5C14840, 0xA9;
	string64 level_name : 0x5C14840, 0x183;
	string64 level_descriptive_name : 0x5C14840, 0x1C4;
	string32 game_version : 0x5C14840, 0x284;
	string256 log_message : 0x5C15040, 0x0, 0x28;
	float node_x : 0x5B741F0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B741F0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B741F0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B89280, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_21")
{
	byte is_playable : 0x5986E10, 0xA9;
	string64 level_name : 0x5986E10, 0x183;
	string64 level_descriptive_name : 0x5986E10, 0x1C4;
	string32 game_version : 0x5986E10, 0x284;
	string256 log_message : 0x59875D0, 0x0, 0x28;
	float node_x : 0x58E6F50, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58E6F50, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58E6F50, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58FBFB8, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	vulkan
state("bg3", "gog_hotfix_21_1")
{
	byte is_playable : 0x5C034F8, 0xA9;
	string64 level_name : 0x5C034F8, 0x183;
	string64 level_descriptive_name : 0x5C034F8, 0x1C4;
	string32 game_version : 0x5C034F8, 0x284;
	string256 log_message : 0x5C03CF8, 0x0, 0x28;
	float node_x : 0x5B63070, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B63070, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B63070, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B780F8, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_21_1")
{
	byte is_playable : 0x5975B98, 0xA9;
	string64 level_name : 0x5975B98, 0x183;
	string64 level_descriptive_name : 0x5975B98, 0x1C4;
	string32 game_version : 0x5975B98, 0x284;
	string256 log_message : 0x5976348, 0x0, 0x28;
	float node_x : 0x58D5DF0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58D5DF0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58D5DF0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58EAE50, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	vulkan
state("bg3", "steam_hotfix_21_1")
{
	byte is_playable : 0x5C14850, 0xA9;
	string64 level_name : 0x5C14850, 0x183;
	string64 level_descriptive_name : 0x5C14850, 0x1C4;
	string32 game_version : 0x5C14850, 0x284;
	string256 log_message : 0x5C15050, 0x0, 0x28;
	float node_x : 0x5B741F0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B741F0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B741F0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B89280, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_21_1")
{
	byte is_playable : 0x5987E20, 0xA9;
	string64 level_name : 0x5987E20, 0x183;
	string64 level_descriptive_name : 0x5987E20, 0x1C4;
	string32 game_version : 0x5987E20, 0x284;
	string256 log_message : 0x59885E0, 0x0, 0x28;
	float node_x : 0x58E7F50, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58E7F50, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58E7F50, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58FCFB8, 0x8, 0x120, 0x18, 0x0, 0x208, 0x588;
}

//	vulkan
state("bg3", "gog_hotfix_22")
{
	byte is_playable : 0x5C054C8, 0xA9;
	string64 level_name : 0x5C054C8, 0x183;
	string64 level_descriptive_name : 0x5C054C8, 0x1C4;
	string32 game_version : 0x5C054C8, 0x284;
	string256 log_message : 0x5C05CD0, 0x0, 0x28;
	float node_x : 0x5B65050, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B65050, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B65050, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B7A0D8, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_22")
{
	byte is_playable : 0x5978978, 0xA9;
	string64 level_name : 0x5978978, 0x183;
	string64 level_descriptive_name : 0x5978978, 0x1C4;
	string32 game_version : 0x5978978, 0x284;
	string256 log_message : 0x5979138, 0x0, 0x28;
	float node_x : 0x58D8DB0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58D8DB0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58D8DB0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58EDE10, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598;
}

//	vulkan
state("bg3", "steam_hotfix_22")
{
	byte is_playable : 0x5C16680, 0xA9;
	string64 level_name : 0x5C16680, 0x183;
	string64 level_descriptive_name : 0x5C16680, 0x1C4;
	string32 game_version : 0x5C16680, 0x284;
	string256 log_message : 0x5C16E98, 0x0, 0x28;
	float node_x : 0x5B761F0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B761F0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B761F0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B8B280, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_22")
{
	byte is_playable : 0x5988B70, 0xA9;
	string64 level_name : 0x5988B70, 0x183;
	string64 level_descriptive_name : 0x5988B70, 0x1C4;
	string32 game_version : 0x5988B70, 0x284;
	string256 log_message : 0x5989338, 0x0, 0x28;
	float node_x : 0x58E8F10, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58E8F10, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58E8F10, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58FDF78, 0x8, 0x120, 0x18, 0x0, 0x208, 0x598;
}

//	vulkan
state("bg3", "gog_hotfix_25")
{
	byte is_playable : 0x5C08548, 0xA9;
	string64 level_name : 0x5C08548, 0x183;
	string64 level_descriptive_name : 0x5C08548, 0x1C4;
	string32 game_version : 0x5C08548, 0x284;
	string256 log_message : 0x5C08D58, 0x0, 0x28;
	float node_x : 0x5B68030, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B68030, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B68030, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B7D0B8, 0x8, 0x120, 0x18, 0x0, 0x1F0, 0x208, 0x598;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_25")
{
	byte is_playable : 0x597ACA8, 0xA9;
	string64 level_name : 0x597ACA8, 0x183;
	string64 level_descriptive_name : 0x597ACA8, 0x1C4;
	string32 game_version : 0x597ACA8, 0x284;
	string256 log_message : 0x597B450, 0x0, 0x28;
	float node_x : 0x58DADD0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58DADD0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58DADD0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x58EFE30, 0x8, 0x120, 0x18, 0x0, 0x1F0, 0x208, 0x598;
}

//	vulkan
state("bg3", "steam_hotfix_25")
{
	byte is_playable : 0x5C1A7E0, 0xA9;
	string64 level_name : 0x5C1A7E0, 0x183;
	string64 level_descriptive_name : 0x5C1A7E0, 0x1C4;
	string32 game_version : 0x5C1A7E0, 0x284;
	string256 log_message : 0x5C1AFD8, 0x0, 0x28;
	float node_x : 0x5B7A170, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5B7A170, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5B7A170, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5B8F200, 0x8, 0x120, 0x18, 0x0, 0x1F0, 0x208, 0x598;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_25")
{
	byte is_playable : 0x598CD40, 0xA9;
	string64 level_name : 0x598CD40, 0x183;
	string64 level_descriptive_name : 0x598CD40, 0x1C4;
	string32 game_version : 0x598CD40, 0x284;
	string256 log_message : 0x598D4F8, 0x0, 0x28;
	float node_x : 0x58ECEF0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x58ECEF0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x58ECEF0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5901F58, 0x8, 0x120, 0x18, 0x0, 0x1F0, 0x208, 0x598;
}

//	vulkan
state("bg3", "gog_patch_7")
{
	byte is_playable : 0x5F93C98, 0xA9;
	string64 level_name : 0x5F93C98, 0x183;
	string64 level_descriptive_name : 0x5F93C98, 0x1C4;
	string32 game_version : 0x5F93C98, 0x284;
	string256 log_message : 0x5F944D8, 0x0, 0x28;
	float node_x : 0x5F94490, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5F94490, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5F94490, 0x260, 0x38, 0x38, 0x18;
// patch 7 has a large amount of changes to UI, gog vulkan version seems to have a different pointer path compared to other binaries
// signature scanner will fail to give you the correct pointer but the code offset seems correct
	string32 ui_state : 0x5F13918, 0x8, 0x770, 0xE8, 0x4C0;
}

//	directx 11
state("bg3_dx11", "gog_patch_7")
{
	byte is_playable : 0x5D040F8, 0xA9;
	string64 level_name : 0x5D040F8, 0x183;
	string64 level_descriptive_name : 0x5D040F8, 0x1C4;
	string32 game_version : 0x5D040F8, 0x284;
	string256 log_message : 0x5D048E0, 0x0, 0x28;
	float node_x : 0x5D048A0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5D048A0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5D048A0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5C845F8, 0x8, 0xE40, 0x58, 0x4C0;
}

//	vulkan
state("bg3", "steam_patch_7")
{
	byte is_playable : 0x5F9DE28, 0xA9;
	string64 level_name : 0x5F9DE28, 0x183;
	string64 level_descriptive_name : 0x5F9DE28, 0x1C4;
	string32 game_version : 0x5F9DE28, 0x284;
	string256 log_message : 0x5F9E668, 0x0, 0x28;
	float node_x : 0x5F9E620, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5F9E620, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5F9E620, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5F1D9D8, 0x8, 0xE40, 0x58, 0x4C0;
}

//	directx 11
state("bg3_dx11", "steam_patch_7")
{
	byte is_playable : 0x5D0F238, 0xA9;
	string64 level_name : 0x5D0F238, 0x183;
	string64 level_descriptive_name : 0x5D0F238, 0x1C4;
	string32 game_version : 0x5D0F238, 0x284;
	string256 log_message : 0x5D0FA20, 0x0, 0x28;
	float node_x : 0x5D0F9E0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5D0F9E0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5D0F9E0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5C8F718, 0x8, 0xE40, 0x58, 0x4C0;
}

//	vulkan
state("bg3", "gog_hotfix_28")
{
	byte is_playable : 0x5FA5CD8, 0xA9;
	string64 level_name : 0x5FA5CD8, 0x183;
	string64 level_descriptive_name : 0x5FA5CD8, 0x1C4;
	string32 game_version : 0x5FA5CD8, 0x284;
	string256 log_message : 0x5FA6508, 0x0, 0x28;
	float node_x : 0x5FA64C0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5FA64C0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5FA64C0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5F25918, 0x8, 0x770, 0xE8, 0x4C0;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_28")
{
	byte is_playable : 0x5D17238, 0xA9;
	string64 level_name : 0x5D17238, 0x183;
	string64 level_descriptive_name : 0x5D17238, 0x1C4;
	string32 game_version : 0x5D17238, 0x284;
	string256 log_message : 0x5D17A10, 0x0, 0x28;
	float node_x : 0x5D179D0, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5D179D0, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5D179D0, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5C975D8, 0x8, 0xE40, 0x58, 0x4C0;
}

//	vulkan
state("bg3", "steam_hotfix_28")
{
	byte is_playable : 0x5FB1F78, 0xA9;
	string64 level_name : 0x5FB1F78, 0x183;
	string64 level_descriptive_name : 0x5FB1F78, 0x1C4;
	string32 game_version : 0x5FB1F78, 0x284;
	string256 log_message : 0x5FB27A8, 0x0, 0x28;
	float node_x : 0x5FB2760, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5FB2760, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5FB2760, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5F31A18, 0x8, 0xE40, 0x58, 0x4C0;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_28")
{
	byte is_playable : 0x5D23588, 0xA9;
	string64 level_name : 0x5D23588, 0x183;
	string64 level_descriptive_name : 0x5D23588, 0x1C4;
	string32 game_version : 0x5D23588, 0x284;
	string256 log_message : 0x5D23D60, 0x0, 0x28;
	float node_x : 0x5D23D20, 0x260, 0x38, 0x38, 0x10;
	float node_y : 0x5D23D20, 0x260, 0x38, 0x38, 0x14;
	float node_z : 0x5D23D20, 0x260, 0x38, 0x38, 0x18;

	string32 ui_state : 0x5CA3738, 0x8, 0xE40, 0x58, 0x4C0;
}

//	vulkan
state("bg3", "gog_patch_8")
{
	byte is_playable : 0x62AAB48, 0xA9;
	string64 level_name : 0x62AAB48, 0x183;
	string64 level_descriptive_name : 0x62AAB48, 0x1C4;
	string32 game_version : 0x62AAB48, 0x284;
	string256 log_message : 0x62AB390, 0x0, 0x28;
	float node_x : 0x62AB348, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62AB348, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62AB348, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62A7D68, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "gog_patch_8")
{
	byte is_playable : 0x601AFF8, 0xA9;
	string64 level_name : 0x601AFF8, 0x183;
	string64 level_descriptive_name : 0x601AFF8, 0x1C4;
	string32 game_version : 0x601AFF8, 0x284;
	string256 log_message : 0x601B7E8, 0x0, 0x28;
	float node_x : 0x601B7A8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x601B7A8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x601B7A8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x6018230, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "steam_patch_8")
{
	byte is_playable : 0x62B6D08, 0xA9;
	string64 level_name : 0x62B6D08, 0x183;
	string64 level_descriptive_name : 0x62B6D08, 0x1C4;
	string32 game_version : 0x62B6D08, 0x284;
	string256 log_message : 0x62B7540, 0x0, 0x28;
	float node_x : 0x62B74F8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62B74F8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62B74F8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62B3F30, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "steam_patch_8")
{
	byte is_playable : 0x60280E8, 0xA9;
	string64 level_name : 0x60280E8, 0x183;
	string64 level_descriptive_name : 0x60280E8, 0x1C4;
	string32 game_version : 0x60280E8, 0x284;
	string256 log_message : 0x60288D8, 0x0, 0x28;
	float node_x : 0x6028898, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x6028898, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x6028898, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x6025360, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "gog_hotfix_30")
{
	byte is_playable : 0x62B5CB8, 0xA9;
	string64 level_name : 0x62B5CB8, 0x183;
	string64 level_descriptive_name : 0x62B5CB8, 0x1C4;
	string32 game_version : 0x62B5CB8, 0x284;
	string256 log_message : 0x62B64F0, 0x0, 0x28;
	float node_x : 0x62B64A8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62B64A8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62B64A8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62B2EB0, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_30")
{
	byte is_playable : 0x6027128, 0xA9;
	string64 level_name : 0x6027128, 0x183;
	string64 level_descriptive_name : 0x6027128, 0x1C4;
	string32 game_version : 0x6027128, 0x284;
	string256 log_message : 0x6027908, 0x0, 0x28;
	float node_x : 0x60278C8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x60278C8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x60278C8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x60243C8, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "steam_hotfix_30")
{
	byte is_playable : 0x62CBC28, 0xA9;
	string64 level_name : 0x62CBC28, 0x183;
	string64 level_descriptive_name : 0x62CBC28, 0x1C4;
	string32 game_version : 0x62CBC28, 0x284;
	string256 log_message : 0x62CC450, 0x0, 0x28;
	float node_x : 0x62CC408, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62CC408, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62CC408, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62C8E78, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_30")
{
	byte is_playable : 0x6033148, 0xA9;
	string64 level_name : 0x6033148, 0x183;
	string64 level_descriptive_name : 0x6033148, 0x1C4;
	string32 game_version : 0x6033148, 0x284;
	string256 log_message : 0x6033938, 0x0, 0x28;
	float node_x : 0x60338F8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x60338F8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x60338F8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x60303C8, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "gog_hotfix_31")
{
	byte is_playable : 0x62B7BD8, 0xA9;
	string64 level_name : 0x62B7BD8, 0x183;
	string64 level_descriptive_name : 0x62B7BD8, 0x1C4;
	string32 game_version : 0x62B7BD8, 0x284;
	string256 log_message : 0x62B8410, 0x0, 0x28;
	float node_x : 0x62B83C8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62B83C8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62B83C8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62B4E18, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_31")
{
	byte is_playable : 0x6029308, 0xA9;
	string64 level_name : 0x6029308, 0x183;
	string64 level_descriptive_name : 0x6029308, 0x1C4;
	string32 game_version : 0x6029308, 0x284;
	string256 log_message : 0x6029AF0, 0x0, 0x28;
	float node_x : 0x6029AB0, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x6029AB0, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x6029AB0, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x6026588, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "steam_hotfix_31")
{
	byte is_playable : 0x62C3F08, 0xA9;
	string64 level_name : 0x62C3F08, 0x183;
	string64 level_descriptive_name : 0x62C3F08, 0x1C4;
	string32 game_version : 0x62C3F08, 0x284;
	string256 log_message : 0x62C4750, 0x0, 0x28;
	float node_x : 0x62C4708, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62C4708, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62C4708, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62C1120, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_31")
{
	byte is_playable : 0x60353A8, 0xA9;
	string64 level_name : 0x60353A8, 0x183;
	string64 level_descriptive_name : 0x60353A8, 0x1C4;
	string32 game_version : 0x60353A8, 0x284;
	string256 log_message : 0x6035B98, 0x0, 0x28;
	float node_x : 0x6035B58, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x6035B58, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x6035B58, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x60325F8, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "gog_hotfix_32")
{
	byte is_playable : 0x62B9C88, 0xA9;
	string64 level_name : 0x62B9C88, 0x183;
	string64 level_descriptive_name : 0x62B9C88, 0x1C4;
	string32 game_version : 0x62B9C88, 0x284;
	string256 log_message : 0x62BA4C0, 0x0, 0x28;
	float node_x : 0x62BA478, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62BA478, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62BA478, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62B6EE0, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_32")
{
	byte is_playable : 0x602A328, 0xA9;
	string64 level_name : 0x602A328, 0x183;
	string64 level_descriptive_name : 0x602A328, 0x1C4;
	string32 game_version : 0x602A328, 0x284;
	string256 log_message : 0x602AB08, 0x0, 0x28;
	float node_x : 0x602AAC8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x602AAC8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x602AAC8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x60275A8, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "steam_hotfix_32")
{
	byte is_playable : 0x62C5DE8, 0xA9;
	string64 level_name : 0x62C5DE8, 0x183;
	string64 level_descriptive_name : 0x62C5DE8, 0x1C4;
	string32 game_version : 0x62C5DE8, 0x284;
	string256 log_message : 0x62C6610, 0x0, 0x28;
	float node_x : 0x62C65C8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62C65C8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62C65C8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62C3018, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_32")
{
	byte is_playable : 0x6036528, 0xA9;
	string64 level_name : 0x6036528, 0x183;
	string64 level_descriptive_name : 0x6036528, 0x1C4;
	string32 game_version : 0x6036528, 0x284;
	string256 log_message : 0x6036D18, 0x0, 0x28;
	float node_x : 0x6036CD8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x6036CD8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x6036CD8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x6033788, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "gog_hotfix_33")
{
	byte is_playable : 0x6298E18, 0xA9;
	string64 level_name : 0x6298E18, 0x183;
	string64 level_descriptive_name : 0x6298E18, 0x1C4;
	string32 game_version : 0x6298E18, 0x284;
	string256 log_message : 0x6299650, 0x0, 0x28;
	float node_x : 0x6299608, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x6299608, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x6299608, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x6296050, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "gog_hotfix_33")
{
	byte is_playable : 0x600A1B8, 0xA9;
	string64 level_name : 0x600A1B8, 0x183;
	string64 level_descriptive_name : 0x600A1B8, 0x1C4;
	string32 game_version : 0x600A1B8, 0x284;
	string256 log_message : 0x600A9A8, 0x0, 0x28;
	float node_x : 0x600A968, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x600A968, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x600A968, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x6007408, 0x10, 0x20, 0x2D8, 0x688;
}

//	vulkan
state("bg3", "steam_hotfix_33")
{
	byte is_playable : 0x62A4EE8, 0xA9;
	string64 level_name : 0x62A4EE8, 0x183;
	string64 level_descriptive_name : 0x62A4EE8, 0x1C4;
	string32 game_version : 0x62A4EE8, 0x284;
	string256 log_message : 0x62A5730, 0x0, 0x28;
	float node_x : 0x62A56E8, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x62A56E8, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x62A56E8, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x62A2108, 0x10, 0x20, 0x2D8, 0x688;
}

//	directx 11
state("bg3_dx11", "steam_hotfix_33")
{
	byte is_playable : 0x60174A8, 0xA9;
	string64 level_name : 0x60174A8, 0x183;
	string64 level_descriptive_name : 0x60174A8, 0x1C4;
	string32 game_version : 0x60174A8, 0x284;
	string256 log_message : 0x6017C98, 0x0, 0x28;
	float node_x : 0x6017C58, 0x2C8, 0x38, 0x38, 0x10;
	float node_y : 0x6017C58, 0x2C8, 0x38, 0x38, 0x14;
	float node_z : 0x6017C58, 0x2C8, 0x38, 0x38, 0x18;

	string32 ui_state : 0x60146F8, 0x10, 0x20, 0x2D8, 0x688;
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
	vars.splits.Add("split_on_mountain_pass_to_shadow_cursed_lands", new Tuple<string, string, string>("Split on Mountain Pass to Shadow Cursed Lands", "CRE_Main_A", "SCL_Main_A"));
	vars.splits.Add("split_on_shadow_cursed_lands_to_intermission_gith", new Tuple<string, string, string>("Split on Shadow Cursed Lands to Intermission Gith", "SCL_Main_A", "INT_Main_A"));
	vars.splits.Add("split_on_intermission_gith_to_wyrms_crossing", new Tuple<string, string, string>("Split on Intermission Gith to Wyrm's Crossing", "INT_Main_A", "BGO_Main_A"));
	vars.splits.Add("split_on_wyrms_crossing_to_baldurs_gate", new Tuple<string, string, string>("Split on Wyrm's Crossing to Baldur's Gate", "BGO_Main_A", "CTY_Main_A"));
	vars.splits.Add("split_on_baldurs_gate_to_high_hall", new Tuple<string, string, string>("Split on Baldur's Gate to High Hall", "CTY_Main_A", "END_Main"));

	vars.split_mapping = new Dictionary<string, Tuple<string, string, string>>();

	foreach(KeyValuePair<string, Tuple<string, string, string>> split_pair in vars.splits)
	{
		settings.Add(split_pair.Key, false, split_pair.Value.Item1);
	}
	
	settings.Add("debug", false, "Debug");
	settings.Add("debug_node_fling", false, "Debug - Node Fling");
	settings.Add("debug_no_cached_addresses", false, "Debug - No Cached Addresses, Always scan (Splitter will slow whenever game starts up. Requires game or livesplit to restart)");
	settings.Add("load_remove_ui_state", false, "Load Remove use UI State (Not guaranteed to work prior to hotfix 17 4.1.1.4494476)"); 

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

	vars.scan_target_server_state = new SigScanTarget(3,
/*
7FF74701B1FB - 48 8B 35 66072B02  - mov rsi,[bg3_dx11.exe+596B968] <<
7FF74701B202 - 44 0F B6 71 08  - movzx r14d,byte ptr [rcx+08]
*/
		"48 8B 35 ????????",
		"44 0F B6 71 08"
	);

	//	world object position x, y = x + 4, z = x + 8
	//	<x,y,z> => <x,z> maps to what you see on the minimap
	//	y is height of the position in world space
	//	0x260, 38, 38, 10
	vars.scan_target_node_fling = new SigScanTarget(3,
/*
bg3_dx11.exe+27D2692 - 48 8B 0D F7960F03     - mov rcx,[bg3_dx11.exe+58CBD90] { (28BE4D60400) }
bg3_dx11.exe+27D2699 - 4C 8D 44 24 40        - lea r8,[rsp+40]
bg3_dx11.exe+27D269E - 48 8D 54 24 20        - lea rdx,[rsp+20]
*/
	"48 8B 0D ????????",
	"4C 8D 44 24 40",
	"48 8D 54 24 20"
	);

	//	try to use hardcoded pointers so it's a bit faster
	//	if version is not supported then take the slow "unsupported" path
	//	slow path does require livesplit to be running before the game does, otherwise it'll take too long
	//	trying to comb through memory pages for logging and server pointers

	//	main menu -> go to options -> hit escape to return to main menu
	//	it'll be a lookup for some sounds, there are other ones that will do lookup from Wwise but those 
	//	signatures are all varied by images of the same game versions..
	vars.scan_target_ui_state = new SigScanTarget(3,
/*
bg3_dx11.exe+3BEA4C1 - 48 8B 05 68DD4202     - mov rax,[bg3_dx11.exe+6018230] { (1D0001065C0) }
bg3_dx11.exe+3BEA4C8 - 0F57 C0               - xorps xmm0,xmm0
bg3_dx11.exe+3BEA4CB - 0F11 85 B0050000      - movups [rbp+000005B0],xmm0
*/
		"48 8B 05 ????????",
		"0F57 C0",
		"0F11 85 B0050000"
	);

	vars.game_version = modules.First().FileVersionInfo.ProductVersion;
	// getting ProductMajorPart, ProductMinorPart, ProductBuildPart, ProductPrivatePart returns 1,0,0,0 isntead
	// of the actual product version string we get above.. so splitting it off the string intead
	var split_version_parts = vars.game_version.Split('.');
	bool is_gog_version = false;
	foreach (var module in modules)
	{
		if (module.ModuleName == "Galaxy64.dll")
		{
			is_gog_version = true;
			break;
		}
	}

	Dictionary<String, String> gog_version_map = new Dictionary<String, String>()
	{
//		{ "4.1.1.370362", "gog_hotfix_6" },
		{ "4.1.1.3732833", "gog_patch_3" },
		{ "4.1.1.3735951", "gog_hotfix_7" },
		{ "4.1.1.3767641", "gog_hotfix_9" },
		{ "4.1.1.3882084", "gog_patch_4" },
		{ "4.1.1.3905231", "gog_patch_4_1" },
		{ "4.1.1.3911062", "gog_hotfix_10" },
		{ "4.1.1.3956130", "gog_hotfix_11" },
//		{ "4.1.1.4061076", "gog_patch_5" },
		{ "4.1.1.4079877", "gog_hotfix_12" },
		{ "4.1.1.4145012", "gog_hotfix_13" },
		{ "4.1.1.4216792", "gog_hotfix_14" },
		{ "4.1.1.4251417", "gog_hotfix_15" },
		{ "4.1.1.4425968", "gog_hotfix_16" },
		{ "4.1.1.4494476", "gog_hotfix_17" },
		{ "4.1.1.4763283", "gog_patch_6" },
		{ "4.1.1.4788723", "gog_hotfix_18" },
		{ "4.1.1.4811634", "gog_hotfix_19" },
		{ "4.1.1.4854838", "gog_hotfix_20" },
		{ "4.1.1.4890942", "gog_hotfix_21" },
		{ "4.1.1.4900808", "gog_hotfix_21_1" },
		{ "4.1.1.4905117", "gog_hotfix_22" },
		{ "4.1.1.5022896", "gog_hotfix_25" },
		{ "4.1.1.5849914", "gog_patch_7" },
		{ "4.1.1.6072089", "gog_hotfix_28" },
		{ "4.1.1.6758295", "gog_patch_8" },
		{ "4.1.1.6805605", "gog_hotfix_30" },
		{ "4.1.1.6839938", "gog_hotfix_31" },
		{ "4.1.1.6848561", "gog_hotfix_32" },
		{ "4.1.1.6897358", "gog_hotfix_33" },
	};

	Dictionary<String, String> steam_version_map = new Dictionary<String, String>()
	{
		{ "4.1.1.3700362", "steam_hotfix_6" },
		{ "4.1.1.3732833", "steam_patch_3" },
		{ "4.1.1.3735951", "steam_hotfix_7" },
		{ "4.1.1.3767641", "steam_hotfix_9" },
		{ "4.1.1.3882084", "steam_patch_4" },
		{ "4.1.1.3905231", "steam_patch_4_1" },
		{ "4.1.1.3911062", "steam_hotfix_10" },
		{ "4.1.1.3956130", "steam_hotfix_11" },
		{ "4.1.1.4061076", "steam_patch_5" },
		{ "4.1.1.4079877", "steam_hotfix_12" },
		{ "4.1.1.4145012", "steam_hotfix_13" },
		{ "4.1.1.4216792", "steam_hotfix_14" },
		{ "4.1.1.4251417", "steam_hotfix_15" },
		{ "4.1.1.4425968", "steam_hotfix_16" },
		{ "4.1.1.4494476", "steam_hotfix_17" },
		{ "4.1.1.4763283", "steam_patch_6" },
		{ "4.1.1.4788723", "steam_hotfix_18" },
		{ "4.1.1.4811634", "steam_hotfix_19" },
		{ "4.1.1.4854838", "steam_hotfix_20" },
		{ "4.1.1.4890942", "steam_hotfix_21" },
		{ "4.1.1.4900808", "steam_hotfix_21_1" },
		{ "4.1.1.4905117", "steam_hotfix_22" },
		{ "4.1.1.5022896", "steam_hotfix_25" },
		{ "4.1.1.5849914", "steam_patch_7" },
		{ "4.1.1.6072089", "steam_hotfix_28" },
		{ "4.1.1.6758295", "steam_patch_8" },
		{ "4.1.1.6805605", "steam_hotfix_30" },
		{ "4.1.1.6839938", "steam_hotfix_31" },
		{ "4.1.1.6848561", "steam_hotfix_32" },
		{ "4.1.1.6897358", "steam_hotfix_33" },
	};
	
	vars.is_using_ui_state = false;
	if (split_version_parts.Length == 4)
	{
		int product_major = Convert.ToInt32(split_version_parts[0]);
		int product_minor = Convert.ToInt32(split_version_parts[1]);
		int product_build = Convert.ToInt32(split_version_parts[2]);
		int product_private = Convert.ToInt32(split_version_parts[3]);
		bool is_hotfix_6 = product_major == 4 && product_minor == 1 && product_build == 1 && product_private == 3700362;
		bool is_hotfix_17_to_latest = product_major >= 4 && product_minor >= 1 && product_build >= 1 && product_private >= 4494476;

		if (is_hotfix_6 || is_hotfix_17_to_latest)
		{
			vars.is_using_ui_state = true;
		}
	}

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

	vars.ui_state_code_ptr = IntPtr.Zero;
	vars.ui_state_code_offset = 0;
	vars.ui_state_offset = 0;
	vars.ui_state_ptr = IntPtr.Zero;
	vars.ui_state = null;

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
		vars.server_state_level_name = new DeepPointer(vars.server_state_ptr, 0x183);
		vars.server_state_level_descriptive_name = new DeepPointer(vars.server_state_ptr, 0x1C4);

		if (settings["debug_node_fling"])
		{
			vars.node_fling_code_ptr = vars.Scanner(game, vars.scan_target_node_fling);
			if (vars.server_state_code_ptr != IntPtr.Zero)
			{
				vars.node_fling_code_offset = game.ReadValue<int>((IntPtr)vars.node_fling_code_ptr);
				vars.node_fling_offset = vars.node_fling_code_ptr.ToInt64() - modules.First().BaseAddress.ToInt64() + 4;
				vars.node_fling_offset = vars.node_fling_offset + vars.node_fling_code_offset;
				vars.node_fling_ptr = new IntPtr(modules.First().BaseAddress.ToInt64() + vars.node_fling_offset);
				vars.node_fling_x_ptr = new DeepPointer(vars.node_fling_ptr, 0x2C8, 0x38, 0x38, 0x10);
				vars.node_fling_y_ptr = new DeepPointer(vars.node_fling_ptr, 0x2C8, 0x38, 0x38, 0x14);
				vars.node_fling_z_ptr = new DeepPointer(vars.node_fling_ptr, 0x2C8, 0x38, 0x38, 0x18);
			}
		}
	}

	if (!vars.is_using_ui_state || vars.is_version_unsupported)
	{
		if (settings["load_remove_ui_state"])
		{
			vars.ui_state_code_ptr = vars.Scanner(game, vars.scan_target_ui_state);
			if (vars.ui_state_code_ptr == IntPtr.Zero)
			{
				throw new Exception("Couldn't find ui state pointer");
			}
			vars.ui_state_code_offset = game.ReadValue<int>((IntPtr)vars.ui_state_code_ptr);
			vars.ui_state_offset = vars.ui_state_code_ptr.ToInt64() - modules.First().BaseAddress.ToInt64() + 4;
			vars.ui_state_offset = vars.ui_state_offset + vars.ui_state_code_offset;
			vars.ui_state_ptr = new IntPtr(modules.First().BaseAddress.ToInt64() + vars.ui_state_offset);
			vars.ui_state = new DeepPointer(vars.ui_state_ptr, 0x10, 0x20, 0x2D8, 0x688);
		}
		else
		{
			vars.is_using_ui_state = false;
		}
	}

	vars.current_is_playable = 0;
	vars.current_level_name = String.Empty;
	vars.current_level_descriptive_name = String.Empty;
	vars.current_log_message = String.Empty;
	vars.current_node_x = 0;
	vars.current_node_y = 0;
	vars.current_node_z = 0;
	vars.current_ui_state = String.Empty;
	vars.old_is_playable = 0;
	vars.old_level_name = String.Empty;
	vars.old_level_descriptive_name = String.Empty;
	vars.old_log_message = String.Empty;
	vars.old_node_x = 0;
	vars.old_node_y = 0;
	vars.old_node_z = 0;
	vars.old_ui_state = String.Empty;
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
	vars.old_ui_state = vars.current_ui_state;

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
		if (vars.ui_state_ptr != null && vars.ui_state != null)
		{
			vars.current_ui_state = vars.ui_state.DerefString(game, 32, String.Empty);
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

		if (vars.is_using_ui_state)
		{
			vars.current_ui_state = current.ui_state;
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

		vars.SetText("Debug_UI_Ptr", String.Format("{0}", vars.ui_state_code_ptr.ToString("X")));
		vars.SetText("Debug_UI_code_offset", vars.ui_state_code_offset.ToString("X"));
		vars.SetText("*Debug_UI_offset*", vars.ui_state_offset.ToString("X"));
		vars.SetText("Debug_UI", vars.current_ui_state);
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
	bool is_running = false;
	if (vars.is_using_ui_state)
	{
		is_running = vars.current_ui_state.Contains("None") && vars.old_ui_state.Contains("Loading");
	}
	else
	{
		is_running = vars.current_log_message.Contains("to: Running") && !vars.old_log_message.Contains("to: Running");
	}
	return is_tutorial && vars.current_is_playable != 0 && is_running;
}

isLoading
{
	bool is_playing = vars.current_is_playable != 0;
	bool is_loading = false;
	if (vars.is_using_ui_state)
	{
		is_loading = vars.current_ui_state.Contains("Loading");
	}
	else
	{
		is_loading = !vars.current_log_message.Contains("to: Running") && !vars.current_log_message.Contains("to: Save");
	}
	return !is_playing || (is_playing && is_loading);
}

split
{
	bool has_level_changed = vars.current_level_name != vars.old_level_name;
	bool is_level_change_progressive = false;
	bool is_credits = false;
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
	if (vars.is_using_ui_state)
	{
		is_credits = vars.current_ui_state.Contains("Credits") && vars.current_is_playable != 0;
	}

	return (has_level_changed && is_level_change_progressive) || is_credits;
}

exit
{
    timer.IsGameTimePaused = true;
}
