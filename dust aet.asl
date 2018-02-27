state("DustAET") {
	//	Note(ogam):	Find load thread pointer - 5c to get array
	//				array + 54 = input stuff (PCManager)
	//				array + 5C = load thread (ManagedThread)
	//				array + 70 = map (mapclasses.map)
	//				array + 74 = navManager (NavManager)
	//				array + 7C = destructableManager
	//				array + 84 = challengeManager
	//				array + 8C = cutscene
	//				array + C4 = eventManager (EventManager)
	//				array + C8 = inventoryManager
	//				array + CC = questManager
	//				array + D0 = hud.Menu
	// 				array + D4 = hud.hud (all sorts of shit happens here)
	//				array + DC = stats (current run player stats)
}

startup {

	vars.scanLoadThreadTarget = new SigScanTarget(2,
		"8D 15 ????????",			// lea edx,[04793524] { [0379D5EC] }							<--	Address of LoadThread ManagedThread
		"E8 ????????",				// call clr.dll+24E0
		"B9 ????????",				// mov ecx,00768C64 { [01000200] }
		"E8 ????????",				// call 001330C8
		"8B F8",					// mov edi,eax
		"8B CF",					// mov ecx,edi
		"BA 03000000",				// mov edx,00000003 { 3 }
		"FF 15 ????????"			// call dword ptr [00768C1C] { ->Lotus.Threading.ManagedThread::.ctor }
	);
	
	vars.scanWorldMapFadeTarget = new SigScanTarget(2,
		"D9 1D ????????",			// fstp dword ptr [001456F4] { [0.00] }							<--	Address of Worldmap fade in
		"33 D2",					// xor edx,edx
		"89 15 ????????",			// mov [001456EC],edx { [0.01] }
		"D9EE",						// fldz 
		"D9 1D ????????",			// fstp dword ptr [001456FC] { [0.00] }
		"D9EE",						// fldz 
		"D9 1D ????????",			// fstp dword ptr [001456F8] { [0.00] }
		"B9 ????????"				// mov ecx,0354783C { [01000400] }
	);
	
	vars.UpdateWatchers = (Action<Process, MemoryWatcherList, List<int[]>, List<Type>>)((proc, watchers, offsetList, types) => {
		for(int i = 0; i < watchers.Count; ++i) {
			int[] offsets = offsetList[i];
			IntPtr pointer = new IntPtr(offsets[0]);
			for(int j = 1; j < offsets.Length - 1; ++j) {
				proc.ReadPointer(pointer + offsets[j], false, out pointer);
			}
			
			watchers[i].Old = watchers[i].Current;
			if(offsets.Length > 1) {
				pointer += offsets[offsets.Length - 1];
			}
			Type currentType = types[i];
			
			if(currentType == typeof(int)) {
				int value = 0;
				proc.ReadValue<int>(pointer, out value);
				watchers[i].Current = value;
			} else if(currentType == typeof(bool)) {
				bool value;
				proc.ReadValue<bool>(pointer, out value);
				watchers[i].Current = value;
			} else if(currentType == typeof(float)) {
				float value;
				proc.ReadValue<float>(pointer, out value);
				watchers[i].Current = value;
			} else if(currentType == typeof(string)) {
				string str;
				proc.ReadString(pointer, 18, out str);
				watchers[i].Current = str;
			} else if(currentType == typeof(byte)) {
				byte value;
				proc.ReadValue<byte>(pointer, out value);
				watchers[i].Current = value;
			}
		}
	});
	
	vars.textMap = new Dictionary<string, object>();
	
	vars.FindOrCreateTextComponentSettings = (Func<string, object>)((name) => {
		//	DefyGravity
		//	https://github.com/jkarkkainen/DefyGravityASL/blob/master/DefyGravity.asl
		
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
		
		vars.textMap[name].Text2 = text;
	});
	
	vars.loadQueueName 				= "Load Queue Count";
	vars.isUsingWorldMapName 		= "Is Using World Map";
	vars.eventTypeName 				= "Event Type";
	vars.currentEventName 			= "Current Event";
	vars.subEventName 				= "Sub Event";
	vars.eventTimerName 			= "Event Timer";
	vars.regionIntroStageName 		= "Region Intro Stage";
	vars.transInFrameName 			= "Transition In Frame";
	vars.transOutFrameName 			= "Transition Out Frame";
	vars.worldMapFadeTimerName 		= "World Map Fade Timer";
	vars.chapterTitleName			= "Chapter Title";
	vars.dialogueStateName			= "Dialogue State";
	vars.dashName					= "Dash";
	vars.dustStormName				= "Dust Storm";
	vars.raisingDustStormName		= "Aerial Dust Storm";
	vars.slideName					= "Slide";
	vars.climbName					= "Iron Grip";
	vars.doubleJumpName				= "Double Jump";
	vars.fidgetFireName				= "Fidget Fire";
	vars.fidgetLightningName		= "Fidget Lightning";
	vars.completionName				= "Completion";
	vars.exploredName				= "Explored";
	vars.treasureFoundName			= "Treasure Found";
	vars.friendsFoundName			= "Friends Found";
	vars.materialArrayName			= "Materials";
	vars.shopMaterialArrayName		= "Shop Materials";
	vars.maxMaterialsName			= "Max Materials";
	vars.challengeArenaArrayName	= "Challenge Arena";
	vars.questsAvailableName		= "Quests Available";
	vars.questsCompletedName		= "Quests Completed";
	vars.introGladeName				= "Glade Region Introduction";
	vars.introAuroraName			= "Aurora Region Introduction";
	vars.introAbadisName			= "Abadis Region Introduction";
	vars.introCirromonName			= "Cirromon Region Introduction";
	vars.introMudpotName			= "Mudpot Region Introduction";
	vars.introSorrowingName			= "Sorrowing Region Introduction";
	vars.introBlackmoorName			= "Blackmoor Region Introduction";
	vars.introEverdawm1Name			= "Bloodmoon Region Introduction";
	vars.introEverdawn2Name			= "Everdawn Battlefield Region Introduction";
	vars.introArcherName			= "Archer's Pass Region Introduction";
	
	vars.abilityNames				= new string[]{
		vars.dashName,
	    vars.dustStormName,
	    vars.raisingDustStormName,
	    vars.slideName,
		vars.climbName,
	    vars.doubleJumpName,
	    vars.fidgetFireName,
	    vars.fidgetLightningName
	};
	
	vars.introRegionNames			= new string[]{
		vars.introGladeName,
		vars.introAuroraName,
		vars.introAbadisName,
		vars.introCirromonName,
		vars.introMudpotName,
		vars.introSorrowingName,
		vars.introBlackmoorName,
		vars.introEverdawm1Name,
		vars.introEverdawn2Name,
		vars.introArcherName
	};
	
	settings.Add("debug",								false,			"Debug - show more stats"								);
	settings.Add("117",									false,			"117% show progression text on layout"					);
	settings.Add("Pause IGT On Room Transitions", 		false, 			"Pause IGT on when losing control on room transitions"	);
	settings.Add("Pause IGT Unskippable Dialogue", 		false, 			"Pause IGT on unskippable dialogue transition sections"	);
	settings.Add("Pause IGT Region Intro", 				false, 			"Pause IGT on panorama/region introduction scenes"		);
	
	for(int i = 0; i < vars.abilityNames.Length; ++i) {
		settings.Add(vars.abilityNames[i], 				false, 			"Split on " + vars.abilityNames[i]						);
	}
	
	settings.Add("Chapter 1", 							true, 			"Split on chapter 1 (enter aurora)"						);
	settings.Add("Chapter 2", 							true, 			"Split on chapter 2 (enter cirromon)"					);
	settings.Add("Chapter 3", 							true, 			"Split on chapter 3 (enter sorrowing)"					);
	settings.Add("Chapter 4", 							true, 			"Split on chapter 4 (enter blackmoor)"					);
	settings.Add("Chapter 5", 							true, 			"Split on chapter 5 (enter everdawn)"					);
	
	for(int i = 0; i < vars.introRegionNames.Length; ++i){
		settings.Add(vars.introRegionNames[i],			false,			"Split on " + vars.introRegionNames[i]					);
	}
	
	settings.Add("Post-Abadis - Gaius Cutscene",		false,			"Split on first gaius cutscene with soldier"			);	//	115
	settings.Add("Post-Cirromon - Gaius Cutscene",		false,			"Split on second gaius cutscene with soldier"			);	//	270
	settings.Add("Post-Blackmoor - Gaius Cutscene",		false,			"Split on third gaius cutscene with soldier"			);	//	505
	
	settings.Add("Kane", 								false, 			"Split on last hit on Kane"								);
}

shutdown {
	vars.totalLoadQueueTime = default(TimeSpan);
	vars.totalTransitionTime = default(TimeSpan);
	vars.stopThreads = true;
	vars.isGameInit = 0;
}

init {
	vars.isGameInit = 0;
	vars.stopThreads = false;
	vars.isWorldMapLoaded = false;
	
	TimeSpan clientAliveTime = DateTime.Now - game.StartTime;
	if(clientAliveTime.Seconds < 2.5f) {
		//	Note(ogam):	wait for initial unskippable splash
		Thread.Sleep(2500 - clientAliveTime.Milliseconds);
	}
	
	vars.isLoading = false;
	
	vars.GetStructAddress = (Func<Process, SigScanTarget, IntPtr>)((proc, sigScanTarget) => {
		IntPtr resultPtr = IntPtr.Zero;
		foreach (var page in proc.MemoryPages(true)) {
            var scanner = new SignatureScanner(proc, page.BaseAddress, (int)page.RegionSize);
            if (resultPtr == IntPtr.Zero) {
				resultPtr = scanner.Scan(sigScanTarget);
            } else {
                break;
            }
		}
		
		return resultPtr;
	});
	
	IntPtr ptr = vars.GetStructAddress(game, vars.scanLoadThreadTarget);
	int ptr32 = 0;
	if(ptr == IntPtr.Zero) {
		throw new Exception("Couldn't find address to LoadThread");
	} else {
		//	set pointer to start of array
		ptr32 = game.ReadValue<int>(ptr) - 0x5C;
		print("Array Ptr: " + ptr32.ToString("X"));
	}
	
	//	parallel
	vars.watchers 				= new MemoryWatcherList() {
		new MemoryWatcher<int>(IntPtr.Zero) 	{ Name = vars.loadQueueName 			},
		new MemoryWatcher<bool>(IntPtr.Zero) 	{ Name = vars.isUsingWorldMapName		},
		new MemoryWatcher<int>(IntPtr.Zero) 	{ Name = vars.eventTypeName 			},
		new MemoryWatcher<int>(IntPtr.Zero) 	{ Name = vars.currentEventName			},
		new MemoryWatcher<int>(IntPtr.Zero) 	{ Name = vars.subEventName 				},
		new MemoryWatcher<float>(IntPtr.Zero) 	{ Name = vars.eventTimerName			},
		new MemoryWatcher<int>(IntPtr.Zero) 	{ Name = vars.regionIntroStageName		},
		new MemoryWatcher<float>(IntPtr.Zero) 	{ Name = vars.transInFrameName			},
		new MemoryWatcher<float>(IntPtr.Zero) 	{ Name = vars.transOutFrameName			},
		new MemoryWatcher<float>(IntPtr.Zero) 	{ Name = vars.worldMapFadeTimerName 	},
		new StringWatcher(IntPtr.Zero, 18)		{ Name = vars.chapterTitleName			},
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.dialogueStateName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.dashName					},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.dustStormName				},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.raisingDustStormName		},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.slideName					},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.climbName					},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.doubleJumpName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.fidgetFireName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.fidgetLightningName		},
		new MemoryWatcher<float>(IntPtr.Zero)	{ Name = vars.completionName			},		//	in game menu truncates this
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.exploredName				},		//	values are truncated in memory, percentage of found
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.treasureFoundName			},      //	values are truncated in memory, percentage of found
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.friendsFoundName			},      //	values are truncated in memory, percentage of found
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.materialArrayName			},		//	array address
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.shopMaterialArrayName		},      //	array address
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.maxMaterialsName			},
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.challengeArenaArrayName	},		//	array address
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.questsAvailableName		},
		new MemoryWatcher<int>(IntPtr.Zero)		{ Name = vars.questsCompletedName		},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introGladeName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introAuroraName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introAbadisName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introCirromonName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introMudpotName			},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introSorrowingName		},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introBlackmoorName		},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introEverdawm1Name		},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introEverdawn2Name		},
		new MemoryWatcher<byte>(IntPtr.Zero)	{ Name = vars.introArcherName			}
	};
	
	vars.watcherOffsets			= new List<int[]>() {
		new int[]{ ptr32, 0x5C, 0x2C 			},						//	loadQueueName
		new int[]{ ptr32, 0x74, 0x10 			},     					//	isUsingWorldMapName
		new int[]{ ptr32, 0xC4, 0x24 			},     					//	eventTypeName
		new int[]{ ptr32, 0xC4, 0x28 			},     					//	currentEventName
		new int[]{ ptr32, 0xC4, 0x34 			},     					//	subEventName
		new int[]{ ptr32, 0xC4, 0x48 			},     					//	eventTimerName
		new int[]{ ptr32, 0xC4, 0x38 			},     					//	regionIntroStageName
		new int[]{ ptr32, 0x70, 0xA8 			},     					//	transInFrameName
		new int[]{ ptr32, 0x70, 0xAC 			},     					//	transOutFrameName
		new int[]{ 0 							},                 		//	worldMapFadeTimerName
		new int[]{ ptr32, 0xD0, 0x30, 0x4, 0x8 	},                 		//	chapterTitleName
		new int[]{ ptr32, 0xD4, 0x3C 			},                 		//	dialogueStateName
		new int[]{ ptr32, 0xDC, 0x8, 0x12		},						//	dashName
		new int[]{ ptr32, 0xDC, 0x8, 0x8		},						//	dustStormName
		new int[]{ ptr32, 0xDC, 0x8, 0x14		},						//	raisingDustStormName
		new int[]{ ptr32, 0xDC, 0x8, 0x16		},						//	slideName
		new int[]{ ptr32, 0xDC, 0x8, 0x18		},						//	climbName
		new int[]{ ptr32, 0xDC, 0x8, 0x15		},						//	doubleJumpName
		new int[]{ ptr32, 0xDC, 0x8, 0x9		},						//	fidgetFireName
		new int[]{ ptr32, 0xDC, 0x8, 0xA		},						//	fidgetLightningName
		new int[]{ ptr32, 0xDC, 0x54			},						//	completionName
		new int[]{ ptr32, 0xDC, 0x58			},						//	exploredName
		new int[]{ ptr32, 0xDC, 0x5C			},						//	treasureFoundName
		new int[]{ ptr32, 0xDC, 0x60			},						//	friendsFoundName
		new int[]{ ptr32, 0xDC, 0x24			},						//	materialArrayName		
		new int[]{ ptr32, 0xDC, 0x28			},						//	shopMaterialArrayName	
		new int[]{ ptr32, 0xDC, 0x108			},						//	maxMaterialsName		
		new int[]{ ptr32, 0x84, 0x8, 0x4		},						//	challengeArenaArrayName
		new int[]{ ptr32, 0xCC, 0x4, 0x1C		},						//	questsAvailableName
		new int[]{ ptr32, 0xCC, 0xC, 0xC		},						//	questsCompletedName
		new int[]{ ptr32, 0xC4, 0x14, 0x8		},						//	introGladeName
		new int[]{ ptr32, 0xC4, 0x14, 0x9		},						//	introAuroraName
		new int[]{ ptr32, 0xC4, 0x14, 0xB		},						//	introAbadisName
		new int[]{ ptr32, 0xC4, 0x14, 0xC		},						//	introCirromonName
		new int[]{ ptr32, 0xC4, 0x14, 0xD		},						//	introMudpotName
		new int[]{ ptr32, 0xC4, 0x14, 0xE		},						//	introSorrowingName
		new int[]{ ptr32, 0xC4, 0x14, 0xF		},						//	introBlackmoorName
		new int[]{ ptr32, 0xC4, 0x14, 0x10		},						//	introEverdawm1Name
		new int[]{ ptr32, 0xC4, 0x14, 0x11		},						//	introEverdawn2Name
		new int[]{ ptr32, 0xC4, 0x14, 0xA		}						//	introArcherName
	};
	
	vars.watcherTypes 			= new List<Type>(){
		typeof(int),													//	loadQueueName 		
		typeof(bool),                       							//	isUsingWorldMapName	
		typeof(int),                        							//	eventTypeName 		
		typeof(int),                        							//	currentEventName	
		typeof(int),                        							//	subEventName 		
		typeof(float),                      							//	eventTimerName		
		typeof(int),                        							//	regionIntroStageName
		typeof(float),                      							//	transInFrameName	
		typeof(float),                      							//	transOutFrameName	
		typeof(float),                      							//	worldMapFadeTimerName
		typeof(string),													//	chapterTitleName
		typeof(int),													//	dialogueStateName
		typeof(byte),													//	dashName
		typeof(byte),													//	dustStormName
		typeof(byte),													//	raisingDustStormName
		typeof(byte),													//	slideName
		typeof(byte),													//	climbName
		typeof(byte),													//	doubleJumpName
		typeof(byte),													//	fidgetFireName
		typeof(byte),													//	fidgetLightningName
		typeof(float),													//	completionName
		typeof(int),													//	exploredName
		typeof(int),													//	treasureFoundName
		typeof(int),													//	friendsFoundName
		typeof(int),													//	materialArrayName
		typeof(int),													//	shopMaterialArrayName
		typeof(int),													//	maxMaterialsName
		typeof(int),													//	challengeArenaArrayName
		typeof(int),													//	questsAvailableName
		typeof(int),													//	questsCompletedName
		typeof(byte),													//	introGladeName
		typeof(byte),													//	introAuroraName
		typeof(byte),													//	introAbadisName
		typeof(byte),													//	introCirromonName
		typeof(byte),													//	introMudpotName
		typeof(byte),													//	introSorrowingName
		typeof(byte),													//	introBlackmoorName
		typeof(byte),													//	introEverdawm1Name
		typeof(byte),													//	introEverdawn2Name
		typeof(byte)													//	introArcherName
	};
	
	vars.fadeTimerTempAddress 	= 0;
	vars.fadeTimerIndex = 0;
	
	for(int i = 0; i < vars.watchers.Count; ++i) {
		if(vars.watchers[i].Name == vars.worldMapFadeTimerName) {
			vars.fadeTimerIndex = i;
			break;
		}
	}
	
	vars.worldMapScannerThread = new Thread(() => {
		IntPtr fadeTimePtr = IntPtr.Zero;
		while(!vars.isWorldMapLoaded) {
			if(vars.stopThreads) {	
				break;
			}
			fadeTimePtr = vars.GetStructAddress(game, vars.scanWorldMapFadeTarget);
			if(fadeTimePtr == IntPtr.Zero) {
				continue;
			} else {
				fadeTimePtr = new IntPtr(game.ReadValue<int>(fadeTimePtr));
			}
			
			vars.fadeTimerTempAddress = fadeTimePtr.ToInt32();
			
			vars.isWorldMapLoaded = true;
		}
	});
	
	vars.totalLoadQueueTime = default(TimeSpan);
	vars.totalTransitionTime = default(TimeSpan);
	vars.loadTimeStamp = DateTime.Now;
	vars.transitionTimeStamp = DateTime.Now;
	
	vars.isGameInit = 1;
}

update {
	if(vars.isGameInit == 0) {
		return;
	}
	vars.UpdateWatchers(game, vars.watchers, vars.watcherOffsets, vars.watcherTypes);
	
	if(settings["debug"]) {
		vars.SetText("Events", string.Format("{0}, {1}, {2}", 	vars.watchers[vars.currentEventName].Current,
																vars.watchers[vars.eventTypeName].Current,
																vars.watchers[vars.subEventName].Current
											)
					);

		float fadeTime = Math.Max(vars.watchers[vars.transInFrameName].Current, vars.watchers[vars.transOutFrameName].Current);
		fadeTime = Math.Max(Math.Max(fadeTime, vars.watchers[vars.worldMapFadeTimerName].Current), 0);
		
		float oldFadeTime = Math.Max(vars.watchers[vars.transInFrameName].Old, vars.watchers[vars.transOutFrameName].Old);
		oldFadeTime = Math.Max(Math.Max(oldFadeTime, vars.watchers[vars.worldMapFadeTimerName].Old), 0);
		
		vars.SetText("Fade Timer", fadeTime.ToString("N3"));
		vars.SetText("Load Count", vars.watchers[vars.loadQueueName].Current.ToString());
		vars.SetText("Dialogue", vars.watchers[vars.dialogueStateName].Current.ToString());

		if(oldFadeTime == 0 && fadeTime > 0) {
			vars.transitionTimeStamp = DateTime.Now;
		}
		
		if(fadeTime > 0) {
			if(vars.watchers[vars.loadQueueName].Current > 0) {
				if(vars.watchers[vars.loadQueueName].Old == 0){
					vars.loadTimeStamp = DateTime.Now;
				}
				vars.totalLoadQueueTime = vars.totalLoadQueueTime.Add(DateTime.Now - vars.loadTimeStamp);
				vars.loadTimeStamp = DateTime.Now;
			}
			vars.totalTransitionTime = vars.totalTransitionTime.Add(DateTime.Now - vars.transitionTimeStamp);
			vars.transitionTimeStamp = DateTime.Now;
		}
		
		vars.SetText("Total Load Time", vars.totalLoadQueueTime.ToString(@"hh\:mm\:ss\.fff"));
		vars.SetText("Total Transition Time", vars.totalTransitionTime.ToString(@"hh\:mm\:ss\.fff"));
	}
	
	if(settings["117"]) {
		int currentMaterials = 0;
		int currentShopMaterials = 0;
		int maxMaterials = vars.watchers[vars.maxMaterialsName].Current;
		int value, address;
		
		for(int i = 0; i < maxMaterials; ++i) {
			address = vars.watchers[vars.materialArrayName].Current + 0x8 + i * 4;
			if(!memory.ReadValue<int>(new IntPtr(address), out value)){
				value = -1;
			}
			if(value > -1) {
				++currentMaterials;
			}
			
			address = vars.watchers[vars.shopMaterialArrayName].Current + 0x8 + i * 4;
			if(!memory.ReadValue<int>(new IntPtr(address), out value)){
				value = -1;
			}
			if(value > -1) {
				++currentShopMaterials;
			}
		}
		
		int currentChallenges = 0;
		int maxChallenges = 6;

		for(int i = 0; i < maxChallenges; ++i) {
			address = vars.watchers[vars.challengeArenaArrayName].Current + 0x8 + i * 4;
			memory.ReadValue<int>(new IntPtr(address), out address);
			if(!memory.ReadValue<int>(new IntPtr(address + 0xC), out value)){
				value = 0;
			}
			if(value > 0) {
				++currentChallenges;
			}
		}

		//	TODO(ogam):	find RevealMap find current / total of each category
		vars.SetText("Completion", (int)vars.watchers[vars.completionName].Current + "%");
		vars.SetText("Exploration", vars.watchers[vars.exploredName].Current + "%");
		vars.SetText("Treasures", vars.watchers[vars.treasureFoundName].Current + "%");
		vars.SetText("Friends", String.Format("{0:N0}/{1}", vars.watchers[vars.friendsFoundName].Current / 100f * 12, 12));
		vars.SetText("Materials", String.Format("{0}/{1}/{2}", currentMaterials, currentShopMaterials, maxMaterials));
		//	Note(ogam):	add in challenge star ranking? each star is added towards 117% calculation
		vars.SetText("Challenges", String.Format("{0}/{1}", currentChallenges, maxChallenges));
		vars.SetText("Quests", String.Format("{0}/{1}", vars.watchers[vars.questsCompletedName].Current, vars.watchers[vars.questsAvailableName].Current - 1));
	}
}

reset {
	return vars.watchers[vars.eventTypeName].Current > 0 && vars.watchers[vars.currentEventName].Current == 0;
}

start {
	//	pre-run flags 		- eventType = 1, currentEvent = 0
	//	start of run flags 	- eventType = 0, currentEvent = 0
	int eventTypeOld 		= vars.watchers[vars.eventTypeName].Old;
	int eventTypeCurrent 	= vars.watchers[vars.eventTypeName].Current;
	int currentEventCurrent = vars.watchers[vars.currentEventName].Current;
	
	vars.totalLoadQueueTime = default(TimeSpan);
	vars.totalTransitionTime = default(TimeSpan);
	return eventTypeOld > 0 && eventTypeCurrent == 0 && currentEventCurrent == 0;
}

split {
	int eventTypeOld 			= vars.watchers[vars.eventTypeName].Old;
	int eventTypeCurrent 		= vars.watchers[vars.eventTypeName].Current;
	int currentEventOld 		= vars.watchers[vars.currentEventName].Old;
	int currentEventCurrent 	= vars.watchers[vars.currentEventName].Current;
	string chapterTitleOld		= vars.watchers[vars.chapterTitleName].Old;
	string chapterTitleCurrent	= vars.watchers[vars.chapterTitleName].Current;
	
	bool isActiveEvent 			= eventTypeCurrent > 0;
	bool isEnteringEvent 		= eventTypeCurrent > 0 && eventTypeOld == 0;
	bool isEndingEvent 			= eventTypeOld > 0 && eventTypeCurrent == 0;
	bool isEnterChapterVideo	= string.IsNullOrEmpty(chapterTitleOld) && !string.IsNullOrEmpty(chapterTitleCurrent);
	bool doSplit 				= false;
	bool hasLoadedSavedGame		= currentEventOld == -1000 && currentEventCurrent > 0;
	
	string abilityName;
	int abilityOld, abilityCurrent;
	
	//	Note(ogam):	don't split on abilities and region intros while loading a saved game
	if(!hasLoadedSavedGame) {
		for(int i = 0; i < vars.abilityNames.Length; ++i) {
			abilityName = vars.watchers[vars.abilityNames[i]].Name;
			abilityOld = vars.watchers[abilityName].Old;
			abilityCurrent = vars.watchers[abilityName].Current;
			if(settings[abilityName]) {
				if(abilityCurrent > abilityOld) {
					doSplit = true;
					break;
				}
			}
		}
		
		for(int i = 0; i < vars.introRegionNames.Length; ++i) {
			if(settings[vars.introRegionNames[i]]) {
				if(vars.watchers[vars.introRegionNames[i]].Old == 0 && vars.watchers[vars.introRegionNames[i]].Current == 1) {
					doSplit = true;
					break;
				}
			}
		}
	}
	
	if(isEnterChapterVideo) {
		int chapterNumber = chapterTitleCurrent[chapterTitleCurrent.Length - 1] - '0';
		if(settings["Chapter " + chapterNumber]) {
			doSplit = true;
		}
	}
	
	//	Note(ogam):	Some events such as picking up quest items does not raise an event type so should check for just 'currentEventOld < value'
	switch(currentEventCurrent) {	
		//	TODO(ogam):	add more cases for important sections or something
		case 115:
		{
			if(settings["Post-Abadis - Gaius Cutscene"]) {
				if(isEnteringEvent && currentEventOld < 115){
					doSplit = true;
				}
			}
			break;
		}
		
		case 270:
		{
			if(settings["Post-Cirromon - Gaius Cutscene"]) {
				if(isEnteringEvent && currentEventOld < 270){
					doSplit = true;
				}
			}
			break;
		}
		
		case 390:
		{
			//	last hit on kane
			if(settings["Kane"]) {
				if(isEnteringEvent && currentEventOld < 390) {
					doSplit = true;
				}
			}
			break;
		}
		
		case 505:
		{
			if(settings["Post-Blackmoor - Gaius Cutscene"]) {
				if(isEnteringEvent && currentEventOld < 505){
					doSplit = true;
				}
			}
			break;
		}
		
		case 800:
		{
			//	reaching the ledge at crawl scene will set currentEvent at 800
			if(isEnteringEvent && currentEventOld < 800) {
				doSplit = true;
			}
			break;
		}
	}
	
	return doSplit;
}

exit {
	timer.IsGameTimePaused = true;
	vars.isGameInit = 0;
	vars.stopThreads = true;
	vars.isWorldMapLoaded = false;
}

isLoading {
	float transInFrameCurrent 			= vars.watchers[vars.transInFrameName].Current;
	float transOutFrameCurrent 			= vars.watchers[vars.transOutFrameName].Current;
	float eventTimerCurrent 			= vars.watchers[vars.eventTimerName].Current;
	int subEventCurrent 				= vars.watchers[vars.subEventName].Current;
	int dialogueStateCurrent			= vars.watchers[vars.dialogueStateName].Current;
	int regionIntroStageCurrent			= vars.watchers[vars.regionIntroStageName].Current;
	int loadQueueCount					= vars.watchers[vars.loadQueueName].Current;
	
	bool bWaitOnWorldMap 				= false;
	bool isWaitingOnDialogueSkip 		= false;
	bool isIntroCameraPanning 			= false;
	bool isTransitioning				= transInFrameCurrent > 0 || transOutFrameCurrent > 0;
	bool isLoadingBetweenTransitions 	= isTransitioning && loadQueueCount > 0;
	bool isLoading						= false;
	
	
	//	Note(ogam):	DialogueState		-	0 ->	nothing
	//									-	1 ->	loading
	//									-	2 ->	active
	//				haven't seen a dialogue state set at loading yet, can skip at active
	//				subevents are usually for complicated dialogue scenes to transfer and setup conversations for characters involved
	//				still needs a more testing if this is decided to keep in the run, helps determine when input is available
	//	Note(ogam):	ignoring skippable flag since that those text can be mashed through, not fast but still possible do have input
	if(settings["Pause IGT Unskippable Dialogue"]) {
		isWaitingOnDialogueSkip = subEventCurrent > 0 && dialogueStateCurrent == 0;
	}
	//	Note(ogam):	not sure if we care about this
	if(settings["Pause IGT Region Intro"]) {
		isIntroCameraPanning = regionIntroStageCurrent > 0;
	}
	
	
	//	Note(ogam):	black screen transition times
	if(settings["Pause IGT On Room Transitions"]) {
		//	Bug(ogam):	timing will pause->play->pause when switching from loading assets to checking the updated fade timer
		//				so you will lose a tiny bit of time until new value is found
		if(vars.watchers[vars.isUsingWorldMapName].Current) {
			if(vars.isWorldMapLoaded) {
				if(vars.fadeTimerTempAddress != 0) {
					vars.watcherOffsets[vars.fadeTimerIndex][0] = vars.fadeTimerTempAddress;
					vars.fadeTimerTempAddress = 0;
					bWaitOnWorldMap = loadQueueCount > 0;
					vars.UpdateWatchers(game, vars.watchers, vars.watcherOffsets, vars.watcherTypes);
				} else {
					bWaitOnWorldMap = vars.watchers[vars.worldMapFadeTimerName].Current > 0f;
				}
			} else {
				if(!vars.worldMapScannerThread.IsAlive) {
					vars.worldMapScannerThread.Start();
				}
				bWaitOnWorldMap = loadQueueCount > 0;
			}
		}
		
		isLoading = isTransitioning || bWaitOnWorldMap || isWaitingOnDialogueSkip || isIntroCameraPanning;
	} else {
		//	Note(ogam):	loading asset times
		bWaitOnWorldMap = vars.watchers[vars.isUsingWorldMapName].Current && loadQueueCount > 0;
		isLoading = isLoadingBetweenTransitions || bWaitOnWorldMap || isWaitingOnDialogueSkip || isIntroCameraPanning;
	}
	
	return isLoading;
}