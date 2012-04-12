macroScript RemoveKr
category: "PolyBoost"
tooltip: "GrowRing"
icon:#("PB_Icons1", 5)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBGrowShrinkRing $ keyboard.altpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)
derpresets) + "\\backup_pre_krakatoa_assignment.rps")
		if doesFileExist lastRendererPresetFilename then
		(
			local theLastRendererName = renderpresets.MapIndexToCategory  lastRendererPresetFilename  32
			local theQuery = querybox ("Are you sure you want to remove Krakatoa from the Production Renderer slot\nand switch to the last known settings of ["+theLastRendererName+"]?\n\nA backup of your current Krakatoa settings will be saved as 'backup_last_krakatoa_settings.rps'") title:"Krakatoa: Switch To Previous Renderer"
			if theQuery then
			(
				RenderPresets.Save 0 ((getdir #renderpresets) + "\\backup_last_krakatoa_settings.rps") #{1,4..64} 
				renderpresets.LoadAll 0 lastRendererPresetFilename 
				messagebox ("Switched to last known renderer ["+ (classof renderers.current) as string +"]") title:"Krakatoa: Switch To Previous Renderer"
			)	
		)	
		else
		(
			local theQuery = querybox "No previously saved Render Preset found.\n\nSwitch to Default Scanline Renderer?" title:"Krakatoa: Switch To Previous Renderer"
			if theQuery do 
				renderers.current = Default_Scanline_Renderer()	
		)	
	)	
	else
		messagebox ("The current renderer is already set to  ["+ (classof renderers.current) as string + "].") title:"Krakatoa: Switch To Previous Renderer"
)
