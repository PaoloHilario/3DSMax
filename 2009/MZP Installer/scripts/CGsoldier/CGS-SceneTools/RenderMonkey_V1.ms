-------------------------------------------------------
-------------------------------------------------------
--- Render Monkey v1.1							---
--- By Paolo Hilario (paolo@cgsoldier.com)		---
--- Created 04.22.05								---
--- http://www.cgsoldier.com					---
--- CGsoldier "Miltitant CG Merc Tools"		---
-------------------------------------------------------
-------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variables
---------------------------------------------------------------------------------------------------------------------------------------------

	global RM_rollout
	global RMsubmit_floater
	global RMsubmit_rollout
	global RMpassload
	global RM_SubmitPercent
	global RM_SubmitText
	global RM_SubmitType
	global RMpassdata = (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3)) + "ini")
	global RMRenderPath = (getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "RenderPath")
	global RMpasslist

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	(

	--- Script Local Functions --- 
	
	local RM_BuildSelSets
	local RM_BuildGroups
	local RM_BuildObjID
	
	local RMListView
	local RMListUpdate
	
	local RMresetprops
	local RMSetObjects
	local RMSetCLR
	local RMSetMatteObj
	local RMSetRenderSettings
	local RMsetscene
	
	local RMSaveRenderFiles
	local RMDelRenFiles
	local RMnetsub_strip
	local RMnetsub_full

	--- Dialog Window Position --- 
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterY") as integer)
	local FLw = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterW") as integer)
	local FLh = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterH") as integer)
	
	--- External File Paths ---
	
	local CLR_Merge_STD = "$userscripts\\CGsoldier\\merge\\Render Monkey\\CLR-STANDARD.max"
	local CLR_Merge_HDRI_D = "$userscripts\\CGsoldier\\merge\\Render Monkey\\CLR-HDRI-DAY.max"
	local CLR_Merge_HDRI_N = "$userscripts\\CGsoldier\\merge\\Render Monkey\\CLR-HDRI-NIGHT.max"
	local INI_Merge_STD = "$userscripts\\CGsoldier\\merge\\Render Monkey\\WM-Project Template-STD.ini"
	local INI_Merge_HDRI_D = "$userscripts\\CGsoldier\\merge\\Render Monkey\\WM-Project Template-HDRI_D.ini"
	local INI_Merge_HDRI_N = "$userscripts\\CGsoldier\\merge\\Render Monkey\\WM-Project Template-HDRI_N.ini"
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	if RM_rollout != undefined then DestroyDialog RM_rollout

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Active X Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	
	
	--- Scene Builder Functions --- 
	
	fn RM_BuildSelSets =
		(
		---Base Selection Sets---
		selectionSets["CLR_PERS"] = $CLR_PERS*
		selectionSets["CLR_ELEV"] = $CLR_ELEV*
		selectionSets["BLDG_BASE"] = $BLDG*
		selectionSets["SITE_BASE"] = $SITE_BASE*
		selectionSets["SITE_ENT"] = $SITE_ENT*
		selectionSets["SITE_ASPHALT"] = $SITE_AUX*
		selectionSets["CARS_BASE"] = $CARS*
		selectionSets["LANDSCAPE"] = $LANDSCAPE*
		---BLDG SHDW Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_ASPHALT"]
		selectionSets["BLDG_SHDW"] = selection
		---PERSPECTIVE SITE Selection Set---
		clearselection()
		select selectionSets["SITE_BASE"]
		selectMore selectionSets["SITE_ENT"]
		selectMore selectionSets["SITE_ASPHALT"]
		selectionSets["SITE_PARKING"] = selection 
		---SITE_ENT SHDW Selection Set---
		clearselection()
		select selectionSets["SITE_PARKING"]
		selectionSets["SITE_MATTE"] = selection	
		---SITE ENTOURAGE MATTE Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_PARKING"]
		selectionSets["SITE_ENT_MATTE"] = selection
		---CARS MATTE Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_ASPHALT"]
		selectMore selectionSets["SITE_PARKING"]
		selectMore selectionSets["SITE_ENT"]
		selectionSets["CARS_MATTE"] = selection
		---PERSPECTIVE AO Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_PARKING"]
		selectionSets["AMBIENT_OCCLUSION"] = selection 	
		---PERSPECTIVE GREYSCALE Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_BASE"]
		selectionSets["PERS-GREYSCALE"] = selection 	
		---PERSPECTIVE PSD Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_BASE"]
		selectionSets["PERS-PSD_CHANNELS"] = selection 
		---ELEVATION PSD Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_ASPHALT"]
		selectionSets["ELEV-PSD_CHANNELS"] = selection 	
		---ELEVATION GREYSCALE Selection Set---
		clearselection()
		select selectionSets["BLDG_BASE"]
		selectMore selectionSets["SITE_ASPHALT"]
		selectionSets["ELEV-GREYSCALE"] = selection
		--- Clear All ---
		clearselection()	
		)
	
	fn RM_BuildObjID = 
		(
		$SITE_AUX*.gbufferchannel = 1
		$SITE_BASE*.gbufferchannel = 2
		$SITE_ENT*.gbufferchannel = 3
		)
		
	fn RM_BuildGroups = 
		(
		group $BLDG* name:"BUILDING"
		group $SITE_BASE* name:"SITE BASE"
		group $SITE_ENT* name:"SITE ENTOURAGE"
		group $CARS* name:"CARS"
		group $LANDSCAPE* name:"LANDSCAPE"
		)
		
	--- Active X List Builder ---
	
	fn RMListView lv =
		(
		lv.gridLines = true  
		lv.View = (dotNetClass "System.Windows.Forms.View").Details  
		lv.fullRowSelect = true 
		lv.AllowColumnReorder = true
		lv.Checkboxes = true
		
		layout_def = #("O", "Pass Name", "Matte Objects", "Matte Type", "Render Preset","Render Size", "Frames")
		layout_width = #(20,180,120,120,150,100,60)

		for i=1 to layout_def.count do
			lv.Columns.add layout_def[i] layout_width[i]	
		) 
		
	fn RMListUpdate lv =
	(
	theRange=#()
	INIdata = getINIsetting RMpassdata
	for i = 1 to INIdata.count do
		(
		li = dotNetObject "System.Windows.Forms.ListViewItem" ((getINISetting RMpassdata (INIdata[i] as string) "PassRender") as string)
		li.checked = (if getINISetting RMpassdata (INIdata[i] as string) "PassRender" == "true" then true else false)
		sub_li = li.SubItems.add ((INIdata[i]) as string)
		sub_li = li.SubItems.add ((getINISetting RMpassdata (INIdata[i] as string) "MTset") as string)
		sub_li = li.SubItems.add ((getINISetting RMpassdata (INIdata[i] as string) "MTtype") as string)
		sub_li = li.SubItems.add ((getINISetting RMpassdata (INIdata[i] as string) "RPS") as string)
		sub_li = li.SubItems.add (((getINISetting RMpassdata (INIdata[i] as string) "OutputWidth") + " x " + (getINISetting RMpassdata (INIdata[i] as string) "OuputHeight")) as string)
		sub_li = li.SubItems.add (((getINISetting RMpassdata (INIdata[i] as string) "RenderFrames")) as string)
		append theRange li		
		)
	lv.Items.AddRange theRange
	)
		
	--- Scene Setting Functions ---
	
	fn GetWMP = 
		(
		RMpasslist = #()
		junk = #()
		data = getINISetting RMpassdata
		for i = 1 to data.count do 
			(
			junk[i] = data[i]
			RMpasslist = junk
			)
		)
	
	fn RMresetprops = 
		(
		for obj in objects do
			(
			setUserProp obj "VRay_Matte_Enable" "False"
			setUserProp obj "VRay_Matte_Alpha" "1.0"
			setUserProp obj "VRay_Matte_Shadows" "False"
			setUserProp obj "VRay_Matte_ShadowAlpha" "False"
			setUserProp obj "VRay_GI_VisibleToGI" "True"
			setUserProp obj "VRay_Matte_ReflectionAmount" "1.000000"
			setUserProp obj "VRay_Matte_RefractionAmount" "1.000000"
			obj.primaryVisibility = true
			obj.castShadows = true		
			)	
		)
			
	fn RMSetObjects xxx =
		(
		RMresetprops()
		SSS = getINIsetting RMpassdata xxx "SELSet"
		for i = 1 to LayerManager.count do
			(
			x = layermanager.getlayer (i-1)
			x.ishidden = false
			)
		for obj in objects do obj.displayByLayer = false 
		max select all 	
		max hide selection
		selectionSets[(SSS)].isHidden = false
		select selectionSets[(SSS)]
		max select none
		)
		
	fn RMSetCLR xxx = 
		(
		CLR = getINIsetting RMpassdata xxx "CLRset"
		selectionSets[CLR].isHidden = false
		select selectionSets[CLR]	
		KillLights()
		SetLights()
		SetCams()
		max select none
		)
	
		
	fn RMSetMatteObj xxx =	
		(
		--- Get INI Data ---
		
		SSS = getINIsetting RMpassdata xxx "SELSet"
		MTSS = getINIsetting RMpassdata xxx "MTset"
		MTTP = getINISetting RMpassdata xxx "MTtype"
		PASS = xxx as string
		
		--- Unhide Selection Matte Set ---
		
		if MTSS != "NONE" do 
			(
			selectionSets[MTSS].isHidden = false
			)
			
		--- Set Object Properties ---
		
		if MTTP == "NONE" do
			(
			RMresetprops()	
			)
			
		if MTTP == "MATTE" do 
			(
			select selectionSets[MTSS]
			for obj in selection do
				(
				setUserProp obj "VRay_Matte_Enable" "True"
				setUserProp obj "VRay_Matte_Alpha" "-1.0"
				setUserProp obj "VRay_Matte_ReflectionAmount" "0.000000"
				setUserProp obj "VRay_Matte_RefractionAmount" "0.000000"		
				)
			)
			
		if MTTP == "OBJ SHDW" do 
			(
			select selectionSets[MTSS]
			for obj in selection do
				(
				setUserProp obj "VRay_Matte_Enable" "True"
				setUserProp obj "VRay_Matte_Alpha" "-1.0"
				setUserProp obj "VRay_Matte_Shadows" "True"
				setUserProp obj "VRay_Matte_ShadowAlpha" "True"	
				setUserProp obj "VRay_Matte_ReflectionAmount" "0.000000"
				setUserProp obj "VRay_Matte_RefractionAmount" "0.000000"
				obj.castShadows = false
				)
			select selectionSets[SSS]
			for obj in selection do
				(
				obj.primaryVisibility = false
				)
			)
			
		if MTTP == "SELF SHDW" do 
			(
			select selectionSets[MTSS]
			for obj in selection do
				(
				setUserProp obj "VRay_Matte_Enable" "True"
				setUserProp obj "VRay_Matte_Alpha" "-1.0"
				setUserProp obj "VRay_Matte_Shadows" "True"
				setUserProp obj "VRay_Matte_ShadowAlpha" "True"	
				setUserProp obj "VRay_Matte_ReflectionAmount" "0.000000"
				setUserProp obj "VRay_Matte_RefractionAmount" "0.000000"
				)
			select selectionSets[SSS]
			for obj in selection do
				(
				obj.castShadows = true
				)
			)
			
		if MTTP == "REFLECTION" do 
			(
			select selectionSets[MTSS]
			for obj in selection do
				(
				setUserProp obj "VRay_Matte_Enable" "True"
				setUserProp obj "VRay_Matte_Alpha" "-1.0"
				obj.secondaryVisibility = on
				)
			)
			
		if PASS == "PERS-SITE_PARKING" do
			(
			unhide $'SITE_AUX:ASPHALT'
			try setUserProp $'SITE_AUX:ASPHALT' "VRay_Matte_Alpha" "-1.0" catch()	
			)

		if PASS == "PERS-BUILDING_AMB" do
			(
			try setUserProp $'BLDG:GLASS' "VRay_Matte_Alpha" "-1.0" catch()
			try setUserProp $'SITE_AUX:ASPHALT' "VRay_GI_VisibleToGI" "True" catch()
			KillLights()
			)		

		if PASS == "PERS-BUILDING_BASE" do
			(
			try setUserProp $'BLDG:GLASS' "VRay_Matte_Alpha" "-1.0" catch()
			try setUserProp $'SITE_AUX:ASPHALT' "VRay_GI_VisibleToGI" "True" catch()
			)
			
		if PASS == "ELEV-BLDG_BASE" do
			(
			try setUserProp $'BLDG:GLASS' "VRay_Matte_Alpha" "1.0" catch()
			try setUserProp $'SITE_AUX:ASPHALT' "VRay_GI_VisibleToGI" "True" catch()		
			)	
		)
		
	fn RMSetRenderSettings xxx = 
		(
		CheckRenderDialog()
		
		---Get Pass Data---
		
		SS = getINISetting RMpassdata xxx "SELset"
		CL = getINISetting RMpassdata xxx "CLRset"
	
		---Load Render Presets---
		
		renderPresets.LoadAll 0 ((getINISetting RMpassdata xxx "RPSpath" as string) + "\\" + (getINISetting RMpassdata xxx "RPS" as string))
		
		---Create Directories---
		
		direxists = getDirectories (RMRenderPath + "\\PERSPECTIVES\\")
		if direxists.count == 0 then makeDir (RMRenderPath + "\\PERSPECTIVES\\")
		direxists = getDirectories (RMRenderPath + "\\ELEVATIONS\\")
		if direxists.count == 0 then makeDir (RMRenderPath + "\\ELEVATIONS\\")
		direxists = getDirectories (RMRenderPath + "\\PSD CHANNELS\\")
		if direxists.count == 0 then makeDir (RMRenderPath + "\\PSD CHANNELS\\")
		direxists = getDirectories (RMRenderPath + "\\TEST RENDERS\\")
		if direxists.count == 0 then makeDir (RMRenderPath + "\\TEST RENDERS\\")
		direxists = getDirectories (RMRenderPath + "\\ALIGNMENTS\\")
		if direxists.count == 0 then makeDir (RMRenderPath + "\\ALIGNMENTS\\")
		direxists = getDirectories (RMRenderPath + "\\DETAIL\\")
		if direxists.count == 0 then makeDir (RMRenderPath + "\\DETAIL\\")
		
		---Set Render Output Path---
		
		if substring CL 5 4 == "PERS" do
			(
			RP = RMRenderPath + "\\PERSPECTIVES\\"
			)
			
		if substring CL 5 4 == "ELEV" do
			(
			RP = RMRenderPath +	"\\ELEVATIONS\\"
			)
			
		if substring CL 5 3 == "LOS" do
			(
			RP = RMRenderPath +	"\\ALIGNMENTS\\"
			)
			
		if substring CL 5 3 == "DET" do
			(
			RP = RMRenderPath +	"\\DETAIL\\"
			)
			
		rendOutputFilename = ((RP as string) + (substring maxfilename 1 6) + "-" + (xxx as string) + ".tga")	
			
		---Set Render Dialog Settings---
		
		setrendertype #view
		renderWidth = getINISetting RMpassdata xxx "OutputWidth" as integer 
		renderHeight = getINISetting RMpassdata xxx "OuputHeight" as integer
		rendTimeType = 4
		rendPickupFrames = getINISetting RMpassdata xxx "RenderFrames" as string
		rendSaveFile = True
		rendUseNet = True
		rendShowVFB = False
		
		---Set PSD Manager Paths if Present---
		
		if (getINISetting RMpassdata xxx "RPS" as string) == "VR-PERSPECTIVES_PSD.rps" do
			(
			(getEffect 1).filename = ((RMRenderPath as string) + "\\PSD CHANNELS\\" + (substring maxfilename 1 6) + "-" + (substring CL 5 4 as string) + "_" + (substring SS 1 4) + "_PSD CHANNELS.psd")	
			rendOutputFilename = ""
			)
			
		if (getINISetting RMpassdata xxx "RPS" as string) == "VR-ELEVATIONS_PSD.rps" do
			(
			(getEffect 1).filename = ((RMRenderPath as string) + "\\PSD CHANNELS\\" + (substring maxfilename 1 6) + "-" + (substring CL 5 4 as string) + "_" + (substring SS 1 4) + "_PSD CHANNELS.psd")	
			rendOutputFilename = ""
			)
			
		if (getINISetting RMpassdata xxx "RPS" as string) == "VR-ELEVATIONS_AO.rps" do
			(
			KillLights()
			)
		
		if (getINISetting RMpassdata xxx "RPS" as string) == "VR-PERSPECTIVES_AO.rps" do
			(
			KillLights()
			)
			
		if (getINISetting RMpassdata xxx "RPS" as string) == "VR-HDRI_DAY.rps" do
			(
			KillLights()
			)
		
		if CRDstate == true then renderSceneDialog.open()
		)
		
	fn RMsetscene xxx = 
		(
		RMSetObjects xxx
		RMSetMatteObj xxx 
		RMSetCLR xxx
		RMSetRenderSettings xxx
		)
		
		--- Submit to Network --- 	
		
	fn RMSaveRenderFiles = 
		(
		--- Check and Create Temp Save Directory ---
		direxists = getdirectories "$max\\scenes\\RenderMonkey\\"
		if direxists.count == 0 do (makedir "$max\\scenes\\RenderMonkey\\")
		filexists = getFiles "$max\\scenes\\RenderMonkey\\3dsmaxcmd.exe"
		if filexists.count == 0 do (copyFile "$max\\3dsmaxcmd.exe" "$max\\scenes\\RenderMonkey\\3dsmaxcmd.exe")
		filexists = getFiles "$max\\scenes\\RenderMonkey\\libDLnrapi30.dll"
		if filexists.count == 0 do (copyFile "$max\\libDLnrapi30.dll" "$max\\scenes\\RenderMonkey\\libDLnrapi30.dll")
		filexists = getFiles "$max\\scenes\\RenderMonkey\\max64.task"
		if filexists.count == 0 do (copyFile "$max\\max64.task" "$max\\scenes\\RenderMonkey\\max64.task")
		
		--- Delete Old Submission Files ---
		
		RMDelRenFiles()
		
		--- Get Scene List --- 
		WMSP = getINISetting RMpassdata
		
		for i = 1 to WMSP.count do
			(
			RM_SubmitPercent = 100.*i/WMSP.count
			if (getINISetting RMpassdata WMSP[i] "PassRender") == "true" do
				(
				RM_SubmitText = "SAVING: " + (WMSP[i] as string)
				RMsetscene WMSP[i]
				saveMaxFile ("$max\\scenes\\RenderMonkey\\" + (substring maxfilename 1 6) + "-" + WMSP[i] + ".max") useNewFile:false quiet:true
				)
			RM_SubmitText = "SAVE COMPLETE"
			) 
		)
		
	fn RMDelRenFiles = 
		(
		SF = getfiles "$max\\scenes\\RenderMonkey\\*.max"
		
		for i = 1 to SF.count do
			(
			deleteFile SF[i]	
			)	
		)
		
	fn WM_LaunchSubmitter = 
		(
		if RMsubmit_floater != undefined then DestroyDialog RMsubmit_rollout
		RMsubmit_floater = CreateDialog RMsubmit_rollout 350 100
		)

	 
	fn RMnetsub_strip = 
		(
		RMSaveRenderFiles()
		RM_SubmitType = "strip"
		WM_LaunchSubmitter()
		
		)
	
	fn RMnetsub_full =
		(
		RMSaveRenderFiles()
		RM_SubmitType = "full"
		WM_LaunchSubmitter()
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------
--- Scene Submission Rollout --- 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout RMsubmit_rollout "Walmart Monkey Submitting to Manager" 
	(
	timer SubmitTimer interval:10000
	label ProgText align:#center width:300 offset:[0,10]
	progressBar submitprog align:#center width:300 Height:30 color:[255,175,75] offset:[0,10]
	local index = "0"
	local SF = getfiles "$max\\scenes\\RenderMonkey\\*.max"
	local MAXREN = "$max\\scenes\\RenderMonkey\\3dsmaxcmd.exe"

	on RMsubmit_rollout open do
		(
		ProgText.text = "CONNECTING TO MANAGER"
		submitprog.value = 0
		m = netrender.getmanager()
		m.connect #manual "ren-manager"
		if m.connected == true then 
			(
			ProgText.text = "CONNECTED TO MANAGER"
			) 
		else 
			(
			ProgText.text = "FAILED TO CONNECT"
			RM_SubmitText = "FAILED TO CONNECT"
			DestroyDialog RMsubmit_rollout
			RMsubmit_floater = undefined
			)
		)

	on SubmitTimer tick do
		(
		i = (index as integer)+1
		index = i as string
		RM_SubmitPercent = 100.*i/SF.count
		submitprog.value = RM_SubmitPercent as integer
		RM_SubmitText = "SUBMITTING: " + (getfilenamefile SF[i])	
		ProgText.text = RM_SubmitText as string
		if (substring (getfilenamefile SF[i]) 8 4) == "ELEV" then (SPLITPARAM = "-split:10,3") else (SPLITPARAM = "-split:50,3")
		if RM_SubmitType == "strip" then (PARAM = "-submit " + (SPLITPARAM as string)) else (PARAM = "-submit")
		ShellLaunch MAXREN (PARAM + " " + (getfilenamefile SF[i] + getfilenametype SF[i]))
		if i >= SF.count do 
			(
			DestroyDialog RMsubmit_rollout
			RMsubmit_floater = undefined
			RM_SubmitText = "PASSES SUBMITTED SUCESSFULLY"
			)
		)
	)
	
	

---------------------------------------------------------------------------------------------------------------------------------------------
--- Define Submenus for Main WalmartMonkey Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

RCMenu WMmain
	(
	submenu "Merge Items"
		(
		menuItem MergeCLR_STD "STANDARD RIG"
		menuItem MergeCLR_HDRI_D "HDRI DAY RIG"
		menuItem MergeCLR_HDRI_N "HDRI NIGHT RIG"
		)
	submenu "Build Passes"
		(
		menuItem BuiildSS "Build Selection Sets"
		separator Sep_A
		menuItem BuildPass_STD "Build Pass - STANDARD"
		menuItem BuildPass_HDRI_D "Build Pass - HDRI DAY"
		menuItem BuildPass_HDRI_N "Build Pass - HDRI NIGHT"
		)
	submenu "Scene Organization"
		(
		menuItem BuildGroups "Auto Group Objects"
		menuItem BuildObjID "Set Standard Object ID's"
		)
	submenu "Delete Passes"
		(
		menuItem Del_SelPass "Delete Selected Passes"
		menuItem Del_AllPass "Delete All Passes"
		menuItem Del_SelSets "Delete All Selection Sets"
		menuItem Del_Groups "Explode All Groups"	
		)
	submenu "Submit To Network"
		(
		menuItem SubmitStrips "Submit Strips"
		menuItem SubmitFullFrames "Submit Full Frames"
		)
	
	--- Merge Item Commands ---	
		
	on MergeCLR_STD picked do 
		(
		mergeMAXFile CLR_Merge_STD
		)
	
	on MergeCLR_HDRI_D picked do 
		(
		mergeMAXFile CLR_Merge_HDRI_D
		)

	on MergeCLR_HDRI_N picked do 
		(
		mergeMAXFile CLR_Merge_HDRI_N
		)
		
	--- Build Pass Commands ---	
	
	on BuiildSS picked do 
		(
		RM_BuildSelSets()
		)
		
	on BuildPass_STD picked do 
		(
		if doesFileExist (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini")) == true then
			(
			deleteFile (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini"))
			)
		copyfile INI_Merge_STD (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini"))
		DestroyDialog RM_rollout
		fileIn "$userscripts\\CGsoldier\\CGS-SceneTools\\CGS-RenderMonkey_V1.ms"
		)
		
	on BuildPass_HDRI_D picked do 
		(
		if doesFileExist (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini")) == true then
			(
			deleteFile (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini"))
			)
		copyfile INI_Merge_HDRI_D (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini"))
		DestroyDialog RM_rollout
		fileIn "$userscripts\\CGsoldier\\CGS-SceneTools\\CGS-RenderMonkey_V1.ms"
		)
		
	on BuildPass_HDRI_N picked do 
		(
		if doesFileExist (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini")) == true then
			(
			deleteFile (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini"))
			)
		copyfile INI_Merge_HDRI_N (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini"))
		DestroyDialog RM_rollout
		fileIn "$userscripts\\CGsoldier\\CGS-SceneTools\\CGS-RenderMonkey_V1.ms"
		)		
	
	--- Scene Organization Commands ---
		
	on BuildGroups picked do
		(
		RM_BuildGroups()
		)
		
	on BuildObjID picked do
		(
		RM_BuildObjID()
		)
		
	--- Delete Pass Commands ---
	
	on Del_SelSets picked do
		(
		for i = 1 to selectionsets.count do deleteitem selectionSets (getNamedSelSetName 1)	
		)
		
	on Del_AllPass picked do
		(
		deleteFile (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3) + "ini"))
		DestroyDialog RM_rollout
		fileIn "$userscripts\\CGsoldier\\CGS-SceneTools\\CGS-RenderMonkey_V1.ms"	
		)
		
	on Del_Groups picked do
		(
		for obj in objects do
			(
			obj.ishidden = false	
			)
			
		$Z*.ishidden=true
		max select all
		
		for obj in selection do
			(
			explodeGroup obj
			)
		clearselection()
		)
	
	--- Submit Pass Commands ---
	
	on SubmitStrips picked do
		(
		RMnetsub_strip()	
		)
		
	On SubmitFullFrames picked do
		(
		RMnetsub_full()	
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Main WalmartMonkey Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------

	rollout RM_rollout "Render Monkey v1.1" 
	(
	bitmap RMicon "RenderMonkey" filename:"$userscripts\\CGsoldier\\images\\rendermonkey.bmp" align:#right
	groupbox RPgroup "Render Output Path" align:#left pos:[10,10] width:585 height:50 across:3
	button RPB "Render Path" pos:[15,27] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", 11, 3, 3, 4, 4) tooltip:"Set Render Output Path"
	edittext RPT pos:[35,30] bold:true readonly:true width:550
	groupbox TestRender "Test Render Passes" align:#left pos:[10,70] width:300 height:90
	dropDownList WMloadscene pos:[20,110] height:18 width:175 items:#() selection:0 
	button WMSetpasses "Set Scene" pos:[210,90] width:90 height:20 
	button WMtestrender "Test Render" pos:[210,125] width:90 height:20
	groupbox SubProg "Submission Progress" pos:[320,70] width:275 height:90
	label ProgText pos:[335,95] width:240
	timer ProgUp interval:1000 
	progressBar submitprog pos:[335,125] width:240 Height:25 color:[255,175,75]
	dotNetControl lv "System.Windows.Forms.ListView" align:#left pos:[10,175]
	
	--- Dialog Actions --- 
	
	on RM_rollout open do
		(
		RMListView lv
		RMListUpdate lv
		PMpos = getDialogPos RM_rollout
		PMsize = getDialogSize RM_rollout	
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 20 as integer) (PMsize.y - 190 as integer)
		WMlist = lv	
		RPT.text = RMRenderPath
		GetWMP()
		WMloadscene.items = RMpasslist
		RM_SubmitPercent = 0
		RM_SubmitText = "READY TO SUBMIT"
		)
		
	on ProgUp tick do
		(
		submitprog.value = RM_SubmitPercent as integer	
		ProgText.text = RM_SubmitText as string
		)
	
	on RM_rollout close do
		(
		PMpos = getDialogPos RM_rollout
		PMsize = getDialogSize RM_rollout	
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterX"  (( PMpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterY"  (( PMpos.y ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterW"  (( PMsize.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterH"  (( PMsize.y ) as String) 
		RMDelRenFiles()
		RM_rollout = undefined 
		)
			
	on RM_rollout moved position do
		(
		PMpos = position
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterX"  (( PMpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterY"  (( PMpos.y ) as String) 
		)
	
	on RM_rollout resized size do
		(
		PMsize = size
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterW"  (( PMsize.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "FloaterH"  (( PMsize.y ) as String) 
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 20 as integer) (PMsize.y - 190 as integer)
		)
		
	--- DotNet Actions ---
	
	on lv itemcheck x do
		(
		try setINISetting RMpassdata (RMPassList [x.index+1] as string) "PassRender" (if x.currentvalue.value__ == 0 then "true" else "false") catch()
		)
	
	--- Button Actions ---	
	
	on RPB pressed do 
		(
		RenderOutput = getSavePath caption:"Select Render Output Folder:"
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "RenderPath" ((RenderOutput) as String)
		RMRenderPath = (getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RenderMonkey" "RenderPath") 
		RPT.text = RMRenderPath
		)
		
	on WMloadscene selected i do
		(
		if WMloadscene.selection != 0 do 
			(
			RMpassload = WMloadscene.items[i]
			)
		)
	
	on WMSetpasses pressed do
		(
		if RMpassload != undefined do 
			(
			disablesceneredraw()
			RMsetscene RMpassload
			enablesceneredraw()
			redrawviews() 
			)
		)
		
	on WMtestrender pressed do
		(
		--- Set Test Render Variables ---
		
		if substring (getINISetting RMpassdata RMpassload "CLRset") 5 4 == "PERS" then
			(
			rwidth = (getINISetting RMpassdata RMpassload "OutputWidth" as integer) / 7
			rheight = (getINISetting RMpassdata RMpassload "OuputHeight" as integer) / 7
			)
			
		if substring (getINISetting RMpassdata RMpassload "CLRset") 5 4 == "ELEV" then
			(
			rwidth = (getINISetting RMpassdata RMpassload "OutputWidth" as integer) / 7
			rheight = (getINISetting RMpassdata RMpassload "OuputHeight" as integer) / 7
			)
			
		if substring (getINISetting RMpassdata RMpassload "CLRset") 5 2 == "VA" then
			(
			rwidth = (getINISetting RMpassdata RMpassload "OutputWidth" as integer) / 7
			rheight = (getINISetting RMpassdata RMpassload "OuputHeight" as integer) / 7
			)
			
		if substring (getINISetting RMpassdata RMpassload "CLRset") 5 3 == "DET" then
			(
			rwidth = (getINISetting RMpassdata RMpassload "OutputWidth" as integer) / 7
			rheight = (getINISetting RMpassdata RMpassload "OuputHeight" as integer) / 7
			)
			
		savetest = ((RMRenderPath as string) + "\\TEST RENDERS\\" + (substring maxfilename 1 6) + "_" + (getINISetting RMpassdata RMpassload "SELSet") + ".tga")
		
		--- Test Render Pass ---	 
		render frame:#current vfb:true progressbar:true outputwidth:(rwidth as integer) outputheight:(rheight as integer) outputfile:savetest
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Check for Existing RenderMonkey Data & Create RenderMonkey Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
	(
	local direxists = getdirectories (maxfilepath + "RM-DATA")
	if direxists.count == 0 then 
		(
		if queryBox "Render Monkey requires a sub directory in the current file path to collect Render Monkey data.\nWould you like to create this directory and launch Render Monkey?" title:"Render Monkey" then
			(	
			makedir (maxfilepath + "RM-DATA")
			CreateDialog RM_rollout 775 600 menu:WMmain style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
			)
		else
			(
			messagebox "Sorry, I cannot continue without Render Monkey Data!"
			)
		)
		else
			(
			CreateDialog RM_rollout 775 600 FLx FLy menu:WMmain style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
			)
		)
	)
