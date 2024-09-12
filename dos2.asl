//	isInputAvailable :		0 - whenever game is loading and when ingame main menu is up
//							1 - when you can interact with the game one way or another

state("EoCApp") {}

startup {
	vars.textMap = new Dictionary<string, object>(10);

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
	
	//	https://raw.githubusercontent.com/drtchops/asl/master/dxmd.asl
	//	props to chops, forgot about using bytes[] for c#. easier to check in c since you can check directly 
	// 	ptr: address of the offset (not the start of the instruction!)
    // 	offsetSize: the number of bytes of the offset
    // 	remainingBytes: the number of bytes until the end of the instruction (not including the offset bytes)
	vars.ReadOffset = (Func<Process, IntPtr, int, int, IntPtr>)((proc, ptr, offsetSize, remainingBytes) =>
    {
        byte[] offsetBytes;
        if (ptr == IntPtr.Zero || !proc.ReadBytes(ptr, offsetSize, out offsetBytes))
            return IntPtr.Zero;

        int offset;
        switch (offsetSize)
        {
            case 1:
                offset = offsetBytes[0];
                break;
            case 2:
                offset = BitConverter.ToInt16(offsetBytes, 0);
                break;
            case 4:
                offset = BitConverter.ToInt32(offsetBytes, 0);
                break;
            default:
                throw new Exception("Unsupported offset size");
        }
        return ptr + offsetSize + remainingBytes + offset;
    });
	
	settings.Add("Debug_ShowInfoText", false, "Show Debug Info");
	settings.Add("InputCheck", true, "Input Check");
}

init {
	//	go to line and scroll up a bit
	//	C6 47 10 01 - mov byte ptr [rdi+10],01
	vars.loadPattern = new SigScanTarget(3,
		"48 8B 3D ?? ?? ?? ??",			//mov rdi,[EoCApp.exe+2931FD8] { [7FFDFFD4500] }	
		"48 89 47 48"					//mov [rdi+48],rax
	);
	
	//	this is called whenever reentering game play state after closing menu
	//	break at this line and backtrack through to find the following instructions that points to rsi
	//	80 4E 14 01 - or byte ptr[rsi+14], 01
	
	//	look for the following line, and when pressing escape to get to menu you'll get the second line when checking for value being read
	//	patch 2
	//	80 BB F4000000 00 		- cmp byte ptr [rbx+000000F4],00
	//	88 88 F4000000        	- mov [rax+000000F4],cl
	//	for version as of 02/03/2019, the one above works so leaving it alone for now
	//	80 BB 04010000 00 		- cmp byte ptr [rbx+00000104],00
	//	48 8B 05 6C112401     	- mov rax,[EoCApp.exe+290B7E8] { [025C8510] }
	//	88 88 04010000        	- mov [rax+00000104],cl
	vars.inputPattern = new SigScanTarget(3,
		"48 8B 05 ?? ?? ?? ??",     	//	mov rax,[EoCApp.AK::IAkStreamMgr::m_pStreamMgr+C740] { [1DB18910] }
		"88 88 ?? ?? ?? ??"        		//	mov [rax+000000F4],cl
	);
	
	var module = modules.First();
	var scanner = new SignatureScanner(game, module.BaseAddress, module.ModuleMemorySize);
	IntPtr loadPtr = scanner.Scan(vars.loadPattern);
	loadPtr = vars.ReadOffset(game, loadPtr, 4, 0);
	loadPtr = new IntPtr(memory.ReadValue<long>(loadPtr));
	loadPtr += 0x10;
	
	IntPtr inputPtr = IntPtr.Zero;
	print(string.Format("Module Size: {0}", module.ModuleMemorySize));
	
	inputPtr = scanner.Scan(vars.inputPattern);
	inputPtr = vars.ReadOffset(game, inputPtr, 4, 0);
	
	inputPtr = new IntPtr(memory.ReadValue<long>(inputPtr));
	if(module.ModuleMemorySize == 0x2226000){
		print("Patch 2 version");		
		inputPtr += 0xF4;
	} else {
		print("Current version, if doesn't work poke ogam");
		inputPtr += 0x104;
	}
	
	vars.watchers = new MemoryWatcherList() {
		new MemoryWatcher<bool>(loadPtr) 	{ Name = "Load"},
		new MemoryWatcher<bool>(inputPtr) 	{ Name = "Input"},
	};
	
	vars.isInLoadingPhase = false;
}

update {
	vars.watchers.UpdateAll(game);
	bool isInputAvailable = vars.watchers["Input"].Current;
	bool isLoading = vars.watchers["Load"].Current;
	if (settings["InputCheck"]) {
		if (vars.isInLoadingPhase) {
			vars.isInLoadingPhase = !isInputAvailable;
		} else {
			vars.isInLoadingPhase = isLoading;
		}
	} else {
		vars.isInLoadingPhase = isLoading;
	}
	
	if (settings["Debug_ShowInfoText"]) {
		vars.SetText("Loading|Input", string.Format("{0}|{1}", isLoading, isInputAvailable));
	}
}

isLoading {
	return vars.isInLoadingPhase;
}