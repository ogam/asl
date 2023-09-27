//	currently supported versions
//		Patch 3
//		hotfix 7

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
*/

//	vulkan
state("bg3", "gog_patch_3")
{
	byte is_playable : 0x52A8A70, 0xA9;
	string64 level_name : 0x52A8A70, 0x142;
	string64 level_descriptive_name : 0x52A8A70, 0x183;
	string32 game_version : 0x52A8A70, 0x284;
	string256 log_message : 0x52ACD70, 0x0, 0x28;
}


//	directx 11
state("bg3_dx11", "gog_patch_3")
{
	byte is_playable : 0x4FF5370, 0xA9;
	string64 level_name : 0x4FF5370, 0x142;
	string64 level_descriptive_name : 0x4FF5370, 0x183;
	string32 game_version : 0x4FF5370, 0x284;
	string256 log_message : 0x4FF85C0, 0x0, 0x28;
}

//	vulkan
state("bg3", "steam_patch_3")
{
	byte is_playable : 0x52B2E90, 0xA9;
	string64 level_name : 0x52B2E90, 0x142;
	string64 level_descriptive_name : 0x52B2E90, 0x183;
	string32 game_version : 0x52B2E90, 0x284;
	string256 log_message : 0x52B7190, 0x0, 0x28;
}


//	directx 11
state("bg3_dx11", "steam_patch_3")
{
	byte is_playable : 0x5020A70, 0xA9;
	string64 level_name : 0x5020A70, 0x142;
	string64 level_descriptive_name : 0x5020A70, 0x183;
	string32 game_version : 0x5020A70, 0x284;
	string256 log_message : 0x5023CC0, 0x0, 0x28;
}

//	vulkan
state("bg3", "gog_hotfix_7")
{
	byte is_playable : 0x528DB50, 0xA9;
	string64 level_name : 0x528DB50, 0x142;
	string64 level_descriptive_name : 0x528DB50, 0x183;
	string32 game_version : 0x528DB50, 0x284;
	string256 log_message : 0x5291E50, 0x0, 0x28;
}


//	directx 11
state("bg3_dx11", "gog_hotfix_7")
{
	byte is_playable : 0x501E920, 0xA9;
	string64 level_name : 0x501E920, 0x142;
	string64 level_descriptive_name : 0x501E920, 0x183;
	string32 game_version : 0x501E920, 0x284;
	string256 log_message : 0x5021B70, 0x0, 0x28;
}

//	vulkan
state("bg3", "steam_hotfix_7")
{
	byte is_playable : 0x52BA1A0, 0xA9;
	string64 level_name : 0x52BA1A0, 0x142;
	string64 level_descriptive_name : 0x52BA1A0, 0x183;
	string32 game_version : 0x52BA1A0, 0x284;
	string256 log_message : 0x52BE4A0, 0x0, 0x28;
}


//	directx 11
state("bg3_dx11", "steam_hotfix_7")
{
	byte is_playable : 0x5027D90, 0xA9;
	string64 level_name : 0x5027D90, 0x142;
	string64 level_descriptive_name : 0x5027D90, 0x183;
	string32 game_version : 0x5027D90, 0x284;
	string256 log_message : 0x502AFE0, 0x0, 0x28;
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

	vars.Scanner = (Func<Process, SigScanTarget, IntPtr>)((proc, scan_target) => {
		IntPtr result_ptr = IntPtr.Zero;
		foreach (var page in proc.MemoryPages(true))
		{
			var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);
			if (result_ptr == IntPtr.Zero)
			{
				result_ptr = scanner.Scan(scan_target);
			}
			else
			{
				break;
			}
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

	vars.scan_target_server_state = new SigScanTarget(12,
/*
		bg3_dx11.exe+30485C0 - 0FB6 51 08            - movzx edx,byte ptr [rcx+08]
		bg3_dx11.exe+30485C4 - 48 8B 0D A584FD01     - mov rcx,[bg3_dx11.exe+5020A70] { (1E806274800) }
		
		"0FB6 51 08",
		"48 8B 0D ????????"
*/
/*
		bg3_dx11.exe+30485E0 - 44 0FB6 41 09         - movzx r8d,byte ptr [rcx+09]
		bg3_dx11.exe+30485E5 - 0FB6 51 08            - movzx edx,byte ptr [rcx+08]
		bg3_dx11.exe+30485E9 - 48 8B 0D 8084FD01     - mov rcx,[bg3_dx11.exe+5020A70] { (1E806274800) }		
*/
		"44 0F B6 41 09",
		"0F B6 51 08",
		"48 8B 0D ????????"
	);

	//	try to use hardcoded pointers so it's a bit faster
	//	if version is not supported then take the slow "unsupported" path
	//	slow path does require livesplit to be running before the game does, otherwise it'll take too long
	//	trying to comb through memory pages for logging and server pointers
	vars.module_size = modules.First().ModuleMemorySize;
	Dictionary<int, String> module_version_map = new Dictionary<int, String>()
	{
		//	gog vulkan
		{ 91283456, "gog_patch_3" },
		//	gog dx11
		{ 88444928, "gog_patch_3" },
		//	steam vulkan
		{ 91324416, "steam_patch_3" },
		//	steam dx11
		{ 88621056, "steam_patch_3" },
		
		//	gog vulkan
		{ 91176960, "gog_hotfix_7" },
		//	gog dx11
		{ 88608768, "gog_hotfix_7" },

		//	steam vulkan
		{ 91357184, "steam_hotfix_7" },
		//	steam dx11 
		{ 88649728, "steam_hotfix_7" },
	};
	
	String mapped_version;
	if (module_version_map.TryGetValue(vars.module_size, out mapped_version))
	{
		version = mapped_version;
	}
	else
	{
		version = "unsupported";
	}

	vars.is_version_unsupported = version == "unsupported";

	print(String.Format("[BG3_ASL]: {0} - {1}", game.ProcessName, version));
	print(String.Format("[BG3_ASL]: Module Size - {0}", vars.module_size));

	vars.logging_message_code_ptr = IntPtr.Zero;
	vars.logging_message_code_offset = 0;	
	vars.logging_message_offset = 0;
	vars.logging_message_ptr = IntPtr.Zero;
	vars.server_state_code_ptr = IntPtr.Zero;
	vars.server_state_code_offset = 0;
	vars.server_state_offset = 0;
	vars.server_state_ptr = IntPtr.Zero;
	
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
	}

	vars.current_is_playable = 0;
	vars.current_level_name = String.Empty;
	vars.current_level_descriptive_name = String.Empty;
	vars.current_log_message = String.Empty;
	vars.old_is_playable = 0;
	vars.old_level_name = String.Empty;
	vars.old_level_descriptive_name = String.Empty;
	vars.old_log_message = String.Empty;
}

update
{
	vars.old_is_playable = vars.current_is_playable;
	vars.old_level_name = vars.current_level_name;
	vars.old_level_descriptive_name = vars.current_level_descriptive_name;
	vars.old_log_message = vars.current_log_message;

	if (vars.is_version_unsupported)
	{
		vars.current_is_playable = vars.server_state_is_playable.Deref<byte>(game);
		vars.current_level_name = vars.server_state_level_name.DerefString(game, 32, "Failed");
		vars.current_level_descriptive_name = vars.server_state_level_descriptive_name.DerefString(game, 64, "Failed");
		vars.current_log_message = vars.logging_message.DerefString(game, 256, "Failed");
	}
	else
	{
		vars.current_is_playable = current.is_playable;
		vars.current_level_name = current.level_name;
		vars.current_level_descriptive_name = current.level_descriptive_name;
		vars.current_log_message = current.log_message;
	}

	if (settings["debug"])
	{
		vars.SetText("Debug_Module_Size", String.Format("{0}", vars.module_size));
		vars.SetText("Debug_Log_Ptr", String.Format("{0}", vars.logging_message_code_ptr.ToString("X")));
		vars.SetText("Debug_Log_code_offset", vars.logging_message_code_offset.ToString("X"));
		vars.SetText("Debug_Log_offset", vars.logging_message_offset.ToString("X"));
		vars.SetText("Debug_Log", vars.current_log_message);

		vars.SetText("Debug_Server_Ptr", String.Format("{0}", vars.server_state_code_ptr.ToString("X")));
		vars.SetText("Debug_Server_code_offset", vars.server_state_code_offset.ToString("X"));
		vars.SetText("Debug_Server_offset", vars.server_state_offset.ToString("X"));
		vars.SetText("Debug_Server_is_playable", String.Format("{0}", vars.current_is_playable));
		vars.SetText("Debug_Server_level_name", vars.current_level_name);
		vars.SetText("Debug_Server_level_descriptive_name", vars.current_level_descriptive_name);
	}
}

start
{
	return vars.current_level_name.Contains("TUT_Avernus_C") && (vars.current_is_playable != 0 && vars.current_log_message.Contains("from: PrepareRunning, to: Running") && !vars.old_log_message.Contains("from: PrepareRunning, to: Running"));
}

isLoading
{
	return !(vars.current_is_playable != 0 && vars.current_log_message.Contains("from: PrepareRunning, to: Running"));
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