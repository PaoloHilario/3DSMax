---------------------------------------------------------------
---------------------------------------------------------------
------ General Script Functions Functions v2.0		-------
------ By Paolo Hilario (CGsoldier@gmail.com)		-------
------ Created 04.22.05								-------
------ http://www.cgsoldier.com						-------
---------------------------------------------------------------
---------------------------------------------------------------

--- Initialization ---

(
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Global Variables --- 
---------------------------------------------------------------------------------------------------------------------------------------------	
-- Path Definitions --
global RMdata
RMdata = (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 3)) + "ini")
global LSdata
LSdata = (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 4)) + "_layerdata" + ".ini")
global APdata
APdata = "$scripts\\CGsoldier\\functions\\CGsoldier_altprops.ini"
global MATdata
MATdata = (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 4)) + "_backupMTL" + ".mat")
global RPSdata
RPSdata = (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 4)) + "_PRESETS")
-- Scene Data --
global SP
global SS
global LSM
global RPS
global RPS_home
-- Alt Mat and Props --
global ML
global MAT_home
global APL
-- Layer Data Arrays --
global LSMops
global LSMname
global LSMhidden
global LSMfrozen
global LSMaltmatcheck
global LSMaltmat
global LSMaltpropcheck
global LSMaltprop
-- Object Type Arrays --
global matlib_dir = "V:\\3D Library\\GAS-3D\\MATLIBS"
-- Object Type Names --	
global name_array = #("Cameras", "Lights", "Helpers/Rigs", "Linework/Reference", "Environment", "People", "Architectural", "Facade", "Catwalks", "Utilities", "Furniture/Fixtures/Equipment", "Facility Lighting Fixtures", "Show Set Lighting", "Audio/Visual", "Ride Vehicles", "Ride Track", "Ride Mechanism", "Flats/Graphics", "Murals/Cycs", "3D Props", "3D Characters", "Rockwork", "Vendor Typical", "Foliage", "Animatronics", "Show Action Equipment", "Special Effects", "Junk", "Custom")
global prefix_array = #("CAM", "LTG", "RIG", "LWK", "ENV", "PPL", "ARC", "FAC", "CTW","UTL", "FFE", "LTF", "LTS", "ADV", "RDV", "RDT", "RDM", "FLT", "MUR", "PRP", "CHR", "RWK", "VEN", "FOL", "ANI", "SAE", "EFF", "ZZZ", "CST")
global path_array = #($*CAM*, $*LTG*, $*RIG*, $*LWK*, $*ENV*, $*PPL*, $*ARE*, $*FAC*, $*CTW*, $*UTL*, $*FFE*, $*LTF*, $*LTS*, $*ADV*, $*RDV*, $*RDT*, $*RDM*, $*FLT*, $*MUR*, $*PRP*, $*CHR*, $*RWK*, $*VEN*, $*FOL*, $*ANI*, $*SAE*, $*EFF*, $*ZZZ*, $*CST*)
-- BIM Functions --
global Mat_List = #()
global Mat_Lists = #()
global Mat_Dens = #()
global Mat_Pricing = #()
global Finish_List = #()
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Geometry Building Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global BuildSpline;		
fn BuildSpline plist = 
	(
	sp = splineshape()
	addnewspline sp
	for i = 1 to plist.count do
		(
		addKnot sp 1 #corner #line plist[I]
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Scene Data Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global GetSS;
fn GetSS = 
	(
	SS = #()
	junk = #()
	for i = 1 to selectionsets.count do
		 (
		 junk[i] = (getnamedSelSetname i)
		 SS = sort junk
		 )
	)	

global GetRPS;
fn GetRPS =
	(
	RPS = #()
	junk = #()
	PresetExist = getdirectories RPSdata
	if PresetExist.count == 0 then makedir RPSdata
	RPS_dir = if RPS_home != undefined then RPS_home else RPSdata
	RPS_home = RPS_dir
	RPS_files = getFiles (RPS_dir + "\\" + "*.rps")
	
	if RPS_files.count != 0 then
		(
		for i = 1 to RPS_files.count do
			(
			junk[i] = (filenameFromPath RPS_files[i])
			RPS = sort junk
			)
		)
			
	if RPS_files.count == 0 then
		(
		RPS_dir = ((getDir #maxroot) + "renderpresets")
		RPS_home = RPS_dir
		RPS_files = getFiles (RPS_dir + "\\" + "*.rps")
		
		for i = 1 to RPS_files.count do
			(
			junk[i] = (filenameFromPath RPS_files[i])
			RPS = sort junk
			)
		)
	)

global GetAPL;
fn GetAPL = 
	(
	APL = #()
	junk = #()
	data = getINISetting APdata
	for i = 1 to data.count do 
		(
		junk[i] = data[i] 
		for i = 1 to junk.count do
		APL = sort junk
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Set Scene Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	

global KillLights;
fn KillLights =
	(
	for obj in lights do
		(
		if iskindof obj light do
		obj.on = false
		)
	)

global SetLights;
fn SetLights =
	(
	for obj in selection do
		(
		if iskindof obj light then 
		obj.on = true
		)
	)

global SelCams;
fn SelCams =
	(
	setselectfilter 5
	max select all
	setselectfilter 1
	for obj in selection do (if iskindof obj Targetobject then (deselect obj))
	)
	
global SetCams;
fn SetCams =
	(
	SelCams()
		(
		if selection.count < 1 then
			(
			if queryBox "No cameras in this scene!\nDo you want to fix that?" title:"Pass Monkey Error" beep:true then
			macros.run "Edit" "namedSelSets"
			) else
			
		if selection.count > 1 then
			(
			if queryBox "Too many cameras in this scene!\nDo you want to fix that?" title:"Pass Monkey Error" beep:true then
			macros.run "Edit" "namedSelSets"
			) else
			
		if selection.count == 1 then
			(
			viewport.SetCamera$
			)
		)
	)

global SelZEM;
fn SelZEM = 
	(
	select $'ZEM*'
		(
		for obj in selection do
			(
			if obj.isHidden == false then
			select obj
			)
			
		if selection.count > 1 then
			(
			clearNodeSelection()
			)
		)
	)
			
global SetZEM;			
fn SetZEM = 
	(
	SelZEM()
		(	
		if selection.count > 1 then
			(
			if queryBox "Too Many ZEM objects in Scene!\nDo you want to fix that?" title:"Pass Monkey Error" beep:true then
			macros.run "Edit" "namedSelSets"
			) else
			
		if selection.count == 0 or $ == undefined then
			(
			if environmentMap != undefined then
			environmentMap = undefined
			) else
			
		if selection.count == 1 then
			(
			environmentMap = $.material.diffuseMap
			)	
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Layer Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global getlayer_current;	
fn getlayer_current = 
	(
	LSMops = #()
	LSMname = #()
	LSMhidden = #()
	LSMfrozen = #()
	LSMaltmatcheck = #()
	LSMaltmat = #()
	LSMaltpropcheck = #()
	LSMaltprop = #()
	
	--- Gets Current Hidden & Frozen States ---
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		LSMops[i] = x.name
		LSMname[i] = if (x.name as string) == "0" then "DEFAULT_LAYER" else x.name
		LSMhidden[i] = x.ishidden
		LSMfrozen[i] = x.isfrozen
		)
	
	--- Gets Alternate State Data ---		
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		LSMselobj x.name
		LSMaltmatcheck[i] = if (getUserProp selection[1] "LSMaltmatcheck") == undefined then false else (getUserProp selection[1] "LSMaltmatcheck")
		LSMaltmat[i] = if (getUserProp selection[1] "LSMaltmat") == undefined then "undefined" else (getUserProp selection[1] "LSMaltmat")
		LSMaltpropcheck[i] = if (getUserProp selection[1] "LSMaltpropcheck") == undefined then false else (getUserProp selection[1] "LSMaltpropcheck")
		LSMaltprop[i] = if (getUserProp selection[1] "LSMaltprop") == undefined then "undefined" else (getUserProp selection[1] "LSMaltprop")
		)
	if $ != undefined then deselect $
	)

global getlayer;
fn getlayer_ini xxx = 
	(
	LSMops = #()
	LSMname = #()
	LSMhidden = #()
	LSMfrozen = #()
	LSMaltmatcheck = #()
	LSMaltmat = #()
	LSMaltpropcheck = #()
	LSMaltprop = #()
	
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		LSMops[i] = (getINISetting LSdata xxx (x.name as string + "_name") as string)
		LSMname[i] = if (getINISetting LSdata xxx (x.name as string + "_name") as string) == "0" then "DEFAULT_LAYER" else (getINISetting LSdata xxx (x.name as string + "_name") as string)
		LSMhidden[i] = getINIsetting LSdata xxx (x.name as string + "_hidden") as booleanClass
		LSMfrozen[i] = getINIsetting LSdata xxx (x.name as string + "_frozen") as booleanClass
		LSMaltmatcheck[i] = getINISetting LSdata xxx (x.name as string + "_AMchecked") as booleanClass
		LSMaltmat[i] = getINISetting LSdata xxx (x.name as string + "_AltMat") as string
		LSMaltpropcheck[i] = getINISetting LSdata xxx (x.name as string + "_APchecked") as booleanClass
		LSMaltprop[i] = getINISetting LSdata xxx (x.name as string + "_AltProp") as string	
		)
	)
	
global SaveLayers;
fn SaveLayers xxx = 
	(
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		setINISetting LSdata xxx (x.name as string + "_name") (x.name as string)
		setINISetting LSdata xxx (x.name as string + "_hidden") (x.ishidden as string)
		setINISetting LSdata xxx (x.name as string + "_frozen") (x.isfrozen as string)
		if LSMaltmatcheck[i] != undefined then setINISetting LSdata xxx (x.name as string + "_AMchecked") (LSMaltmatcheck[i] as string) else setINISetting LSdata xxx (x.name as string + "_AMchecked") false
		if LSMaltmat[i] != undefined then setINISetting LSdata xxx (x.name as string + "_AltMat") (LSMaltmat[i] as string) else setINISetting LSdata xxx (x.name as string + "_AltMat") undefined
		if LSMaltpropcheck[i] != undefined then setINISetting LSdata xxx (x.name as string + "_APchecked") (LSMaltpropcheck[i] as string) else setINISetting LSdata xxx (x.name as string + "_APchecked") false
		if LSMaltprop[i] != undefined then setINISetting LSdata xxx (x.name as string + "_AltProp") (LSMaltprop[i] as string) else setINISetting LSdata xxx (x.name as string + "_AltProp") undefined
		)
	)
	
global LSMselobj;
fn LSMselobj xxx = 
	(
	if $ != undefined then deselect $
	(layermanager.getlayerfromname xxx).select true
	)

global LSMaddobj;
fn LSMaddobj xxx = 
	(
	for obj in selection do 
		(	
		(layermanager.getlayerfromname xxx).addnode obj
		)
	)
	
global LSMdeleteLayer;
fn LSMdeleteLayer xxx = 
	(
	if querybox "This will delete the layer and move all objects into the Default Layer" then
		(
		(layermanager.getLayer 0).current = true
		LSMselobj xxx
		LSMaddobj "0" 
		layermanager.deleteLayerByName xxx
		if $ != undefined then deselect $
		getlayer_current()
		completeRedraw()
		)
		
	if LSM2_rollout != undefined then
		(
		removerollout LSM2_rollout LM_floater
		CurrentLayerRoll()
		)		
	)

global LSMdeleteLayerObj;
fn LSMdeleteLayerObj xxx =
	(
	if querybox "This will delete the layer and all its objects" then
		(
		(layermanager.getLayer 0).current = true
		LSMselobj xxx
		for obj in selection do delete obj
		layermanager.deleteLayerByName xxx
		getlayer_current()
		completeRedraw()
		)
		
	if LSM2_rollout != undefined then
		(
		removerollout LSM2_rollout LM_floater
		CurrentLayerRoll()
		)		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- File Functions  ---
---------------------------------------------------------------------------------------------------------------------------------------------	

global get_all_files_in_dir;
fn get_all_files_in_dir start_dir rec type = 
	(
	all_files = #()
	get_all_files_in_dir_rec start_dir rec type all_files
	all_files
	)
	
-- required by get_all_files_in_dir ---
global get_all_files_in_dir_rec;
fn get_all_files_in_dir_rec start_dir rec type all_files =  
	(
	cur_files = getFiles (start_dir + "*." + (type as string))
	for i in cur_files do
		(
		append all_files i
		)
	if rec == true then
		(
		sub_dirs = getDirectories (start_dir + "*.*")
		for i in sub_dirs do
			(
			get_all_files_in_dir_rec i rec type all_files
			)
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- String Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------
	
global strip_file_extension;	
fn strip_file_extension s = 
	(
	the_filename = reverse_string s
	where_to_cut = findString the_filename "."
	backwards_name = substring the_filename (where_to_cut + 1) the_filename.count
	return reverse_string backwards_name
	)

global reverse_string;
fn reverse_string s =
	(
	new_string = ""
	if s.count != 0 then
		(
		for i = s.count to 1 by -1 do
			(
			new_string += s[i]
			)
		)
	return new_string
	)
	
global currency;
fn currency num =
	(
	s1 = num as string
	s2 = substring s1 1 (s1.count - 3)
	s3 = "." + substring s1 (s1.count - 1) 2
	s4 = "$" + s2 + s3
	return s4
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Set Selection Set and Layer State Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global SetLayer;
fn SetLayer xxx = 
	(
	--- Revert and get State to Load ---
	RevertAll()
	getlayer_ini xxx
	--- Set Objects to Display by Layer ---	
	for o in objects do o.ishidden = false	
	for o in objects do o.displayByLayer = true
	--- Set Hidden and Frozen States ---	
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		x.ishidden = getINIsetting LSdata xxx (x.name as string + "_hidden") as booleanClass
		x.isfrozen = getINIsetting LSdata xxx (x.name as string + "_frozen") as booleanClass
		)
	--- Set Alternate Material States --- 
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		LSMselobj x.name
		if (LSMaltmatcheck[i] == true and LSMaltmat[i] != undefined) then SetAltMat LSMaltmat[i]
		)
	--- Set Alternate Property States --- 
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		LSMselobj x.name
		if (LSMaltpropcheck[i] == true and LSMaltprop[i] != undefined) then SetAltProp LSMaltprop[i]
		)
	--- Refresh Layer Views ---
	if LSM2_rollout != undefined then
		(
		removerollout LSM2_rollout LM_floater
		CurrentLayerRoll()
		)
	if $ != undefined then deselect $	
	)
	
global SetScene;
fn SetScene xxx =
	(
	RevertAll()
	SSselect = getINIsetting RMdata xxx "SSselect"
	for i = 1 to LayerManager.count do
		(
		x = layermanager.getlayer (i-1)
		x.ishidden = false
		)
	for o in objects do o.displayByLayer = false 
	max select all 	
	max hide selection
	selectionSets[SSselect].isHidden = false
	select selectionSets[SSselect]
	KillLights()
	SetLights()
	SetCams()
	max select none
	)

global SetCL;
fn SetCL xxx = 
	(
	selectionSets[xxx].isHidden = false
	select selectionSets[xxx]	
	LSMselobj $[1].layer.name
	for obj in selection do (obj.displayByLayer = false)
	deselect selectionSets[xxx]
	$.ishidden = true
	select selectionSets[xxx]
	KillLights()
	SetLights()
	SetCams()
	max select none
	)

global SetMatteObj;
fn SetMatteObj xxx =	
	(
	--- Get INI Data ---
	MT1 = (getINISetting RMdata xxx "MT1" as BooleanClass)
	MTselect = (getINIsetting RMdata xxx "MTselect" as string)
	MT2 = (getINISetting RMdata xxx "MT2" as BooleanClass)
	MORpath = (getINISetting RMdata xxx "MORpath" as string)
	MORselect = (getINISetting RMdata xxx "MORselect" as string)
	MT3 = (getINISetting RMdata xxx "MT3" as BooleanClass)
	ALTselect = (getINISetting RMdata xxx "ALTselect" as string)
	--- Unhide Selection Matte Set ---
	if MT1 == true then 
		(
		selectionSets[MTselect].isHidden = false
		)
	--- Set Alternate Material ---
	if MT2 == true then 
		(
		if $ != undefined then deselect $
		OGmatlib = getMatLibFileName()
		loadMaterialLibrary MORpath
		meditMaterials[24] = currentMaterialLibrary[MORselect]
		loadMaterialLibrary MATdata
		currentMaterialLibrary[meditMaterials[24].name] = meditMaterials[24]
		saveMaterialLibrary MATdata
		loadMaterialLibrary OGmatlib
		select selectionSets[MTselect]
		RevertAltMat()
		SetAltMat MORselect
		)
	--- Set Alternate Property ---	
	if MT3 == true then 
		(
		if $ != undefined then deselect $
		select selectionSets[MTselect]
		RevertAltProp()
		SetAltProp (ALTselect as string)
		)
	)
	
global SetRenderSettings; 
fn SetRenderSettings xxx = 
	(
	if (getINISetting RMdata xxx "RPS1" as BooleanClass) == true then
		(
		renderPresets.LoadAll 0 ((getINISetting RMdata xxx "RPSpath" as string) + "\\" + (getINISetting RMdata xxx "RPSselect" as string))
		)

	if getINISetting RMdata xxx "RPO1" as BooleanClass == true then SetZEM()
	rendatmosphere = getINISetting RMdata xxx "RPO2" as BooleanClass
	renderEffects = getINISetting RMdata xxx "RPO3" as BooleanClass
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Alternate Material and Property Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global SetAltMat;
fn SetAltMat xxx =
	(
	--- Save Loaded MatLib ---
	SavedMatlib = getMatLibFileName()	
	--- Check/Load/Create a Material Backup File ---
	if doesFileExist MATdata == false then 
		(
		loadMaterialLibrary "$scripts\\CGsoldier\\functions\\backup.mat"
		saveMaterialLibrary (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 4)) + "_backupMTL" + ".mat")
		loadMaterialLibrary	MATdata
		) 
	else
		(
		loadMaterialLibrary	MATdata
		)
	--- Backup Scene Materials to Library ---	
	for i = 1 to sceneMaterials.count do 
		(
		x = sceneMaterials[i].name
		currentMaterialLibrary[x] = sceneMaterials[i]
		)
		saveMaterialLibrary MATdata
		loadMaterialLibrary MATdata
	--- Apply Alternate Materials to Objects ---	
	for obj in selection do 
		(
		if (superclassof obj == GeometryClass or superclassof obj == shape) then obj.material = currentMaterialLibrary[xxx]
		)
	--- Deselect All & Reload Previous MatLib ---
	UDtext "LSMaltmatcheck" true
	if $ != undefined then deselect $
	loadMaterialLibrary	SavedMatlib
	)

global RevertAltMat;	
fn RevertAltMat =
	(
	SavedMatlib = getMatLibFileName()
	loadMaterialLibrary MATdata
	
	for obj in selection do 
		(
		OGmat = (getUserProp obj "OGmaterial" as string)
		if (superclassof obj == GeometryClass or superclassof obj == shape) then obj.material = currentMaterialLibrary[OGmat]
		)
		
	UDtext "LSMaltmatcheck" false	
	loadMaterialLibrary SavedMatlib
	)

global SetAltProp;	
fn SetAltProp xxx =
	(
	--- Apply Alternate Properties ---
	$.renderable = ((getINISetting APdata xxx "renderable") as booleanClass)
	$.inheritVisibility = ((getINISetting APdata xxx "inheritVisibility") as booleanClass)
	$.primaryVisibility = ((getINISetting APdata xxx "primaryVisibility") as booleanClass)
	$.secondaryVisibility = ((getINISetting APdata xxx "secondaryVisibility") as booleanClass)
	$.receiveshadows = ((getINISetting APdata xxx "receiveshadows") as booleanClass)
	$.castShadows = ((getINISetting APdata xxx "castShadows") as booleanClass)
	$.applyAtmospherics = ((getINISetting APdata xxx "applyAtmospherics") as booleanClass)
	$.renderOccluded = ((getINISetting APdata xxx "renderOccluded") as booleanClass)
	UDtext "LSMaltpropcheck" true
	)

global RevertAltProp;
fn RevertAltProp =
	(
	for obj in selection do
		(
		setProperty obj "renderable" (getUserProp obj "OGrenderable" as booleanClass)
		setProperty obj "inheritVisibility" (getUserProp obj "OGinheritVisibility" as BooleanClass)
		setProperty obj "primaryVisibility" (getUserProp obj "OGprimaryVisibility" as BooleanClass)
		setProperty obj "secondaryVisibility" (getUserProp obj "OGsecondaryVisibility" as BooleanClass)
		setProperty obj "receiveshadows" (getUserProp obj "OGreceiveshadows" as BooleanClass)
		setProperty obj "castShadows" (getUserProp obj "OGcastShadows" as BooleanClass)
		setProperty obj "applyAtmospherics" (getUserProp obj "OGapplyAtmospherics" as BooleanClass)
		setProperty obj "renderOccluded" (getUserProp obj "OGrenderOccluded" as BooleanClass)
		)
	UDtext "LSMaltpropcheck" false
	)

global RevertAll;
fn RevertAll = 
	(
	progressStart "Reverting Original State"
	max select all 
	if $ != undefined then selectionSets["ZZZ"] = $
	if $ != undefined then hide $ 
	SavedMatlib = getMatLibFileName()
	loadMaterialLibrary MATdata
	i = 1
	for obj in objects do 
		(
		i = i + 1
		progressUpdate (100.0*i/objects.count)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "renderable" (getUserProp obj "OGrenderable" as booleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "inheritVisibility" (getUserProp obj "OGinheritVisibility" as BooleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "primaryVisibility" (getUserProp obj "OGprimaryVisibility" as BooleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "secondaryVisibility" (getUserProp obj "OGsecondaryVisibility" as BooleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "receiveshadows" (getUserProp obj "OGreceiveshadows" as BooleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "castShadows" (getUserProp obj "OGcastShadows" as BooleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "applyAtmospherics" (getUserProp obj "OGapplyAtmospherics" as BooleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setProperty obj "renderOccluded" (getUserProp obj "OGrenderOccluded" as BooleanClass)
		if (getUserProp obj "LSMaltpropcheck") == true then setUserProp obj "LSMaltpropcheck" "false"
		if (getUserProp obj "LSMaltmatcheck") == true then 
			(
			OGmat = (getUserProp obj "OGmaterial" as string)
			if (superclassof obj == GeometryClass or superclassof obj == shape) then obj.material = currentMaterialLibrary[OGmat]
			)
		if (getUserProp obj "LSMaltmatcheck") == true then setUserProp obj "LSMaltmatcheck" "false"
		)
		i = 0
	loadMaterialLibrary SavedMatlib
	if selectionSets["ZZZ"] != undefined then selectionSets["ZZZ"].isHidden = false
	if selectionSets["ZZZ"] != undefined then deleteitem selectionsets "ZZZ"	
	if $ != undefined then deselect $
	ProgressEnd()
	)

global BackupScene;	
fn BackupScene = 
	(
	progressStart "Saving Scene's Original State"
	max select all 
	if $ != undefined then selectionSets["ZZZ"] = $
	--- Save all OG Properties ---
	select objects
	UDprop "OGrenderable" "renderable" 
	UDprop "OGinheritVisibility" "inheritVisibility"
	UDprop "OGprimaryVisibility" "primaryVisibility"
	UDprop "OGsecondaryVisibility" "secondaryVisibility"
	UDprop "OGreceiveshadows" "receiveshadows"
	UDprop "OGcastShadows" "castShadows"
	UDprop "OGapplyAtmospherics" "applyAtmospherics"
	UDprop "OGrenderOccluded" "renderOccluded"
	deselect objects
	--- Save Alternate State Data ---
	for obj in objects do 
		(
		if (getUserProp obj "LSMaltpropcheck") == undefined then setUserProp obj "LSMaltpropcheck" "false"
		if (getUserProp obj "LSMaltmatcheck") == undefined then setUserProp obj "LSMaltmatcheck" "false"	
		)
	--- Save all OG Materials ---
	i = 1
	for obj in objects do 
		(
		i = i + 1
		progressUpdate (100.0*i/objects.count)		
		if superclassof obj == GeometryClass and obj.material != undefined then (setUserProp obj "OGmaterial" (obj.material.name as String))
		if superclassof obj == Shape and obj.material != undefined then (setUserProp obj "OGmaterial" (obj.material.name as String))
		)
	i = 0
	hide selection
	if selectionSets["ZZZ"] != undefined then selectionSets["ZZZ"].isHidden = false
	if selectionSets["ZZZ"] != undefined then deleteitem selectionsets "ZZZ"
	if $ != undefined then deselect $
	ProgressEnd()
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- INI Data Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	

global GetSP;
fn GetSP = 
	(
	SP = #()
	junk = #()
	data = getINISetting RMdata
	for i = 1 to data.count do 
		(
		junk[i] = data[i]
		SP = sort junk
		)
	)
	
global GetLSM;	
fn GetLSM = 
	(
	LSM = #()
	junk = #()
	data = getINIsetting LSdata
	for i = 1 to data.count do 
		(
		junk[i] = data[i]
		LSM = sort junk
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Material Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global GetML;
fn GetML =
	(
	if MAT_home == undefined then MAT_home = (getFiles (matlib_dir + "\\" + "*.mat"))[1]
	loadMaterialLibrary MAT_home 
	ML = #()
	for i = 1 to currentMaterialLibrary.count do
		(
		ML[i] = currentMaterialLibrary[i].name
		)
	)
	
global GetSceneMats;
fn GetSceneMats = 
	(
	SM = for i = 1 to scenematerials.count collect scenematerials[i]
	)
	
global GetSelMats;
fn GetSelMats XXX = 
	(
	selobj = XXX
	SM = #()
	for obj in selobj do 
		(
		if obj.material != undefined do (append SM obj.material)
		)
	return SM
	)
	
global KillDupMatSel;
fn KillDupMatSel XXX = 
	(
	sel_mats = GetSelMats XXX
	sel_mats_names = for i in sel_mats collect i.name
	
		for obj in XXX do
		(
		if obj.material != undefined then
			(
			x = finditem sel_mats_names obj.material.name
			obj.material = sel_mats[x]
			)
		)
	)
	
global KillDupMatScene;	
fn KillDupMatScene = 
	(
	sel_mats = GetSceneMats()
	sel_mats_names = for i in sel_mats collect i.name
		
	for obj in objects do
		(
		if obj.material != undefined then
			(
			x = finditem sel_mats_names obj.material.name
			obj.material = sel_mats[x]
			)
		)
	)
	
global MultiSubMatSel;
fn MultiSubMatSel XXX = 
	(
	MapSlot = medit.GetActiveMtlSlot()
	MapName = XXX
	SavedSel = $selection as array
	SelMats = GetSelMats()
	SelMatIndex = for i in SelMats collect i.name
	SelMatsName = ArrayDelDups SelMatIndex
	ClearSelection()
	meditMaterials[MapSlot] = multimaterial numsubs:(SelMatsName.count)
	meditMaterials[MapSlot].name = MapName
	
	for i = 1 to meditMaterials[MapSlot].materiallist.count do 
		(
		mat = SelMats[finditem SelMatIndex selmatsname[i]]
		meditMaterials[MapSlot].materiallist[i] = mat	
		)
	)	
		
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Object Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global CollapseByMat;
fn CollapseByMat XXX = 
	(
	MatOp = XXX
	clearSelection()
	for obj in objects do 
		(
		if obj.material != undefined and obj.material.name == MatOp and superclassof obj == GeometryClass then selectmore obj
		)
	opset = getcurrentselection()
	for obj in opset do 
		(
		ConvertToMesh obj
		)
	for i = 1 to opset.count do
		(
		if i > 1 then meshop.attach opset[1] opset[i] attachMat:#IDtoMat condenseMat:true  
		)
	)
	
global CollapseAllSel;
fn CollapseAllSel XXX = 
	(	
	opset = XXX
	for obj in opset do 
		(
		ConvertToMesh obj
		)
	for i = 1 to opset.count do
		(
		if i > 1 then meshop.attach opset[1] opset[i] attachMat:#IDtoMat condenseMat:true 
		)
	clearselection()
	select opset[1]
	opset[1].material.name = opset[1].name
	)

global reset_X_form;	
fn reset_X_form =
	(
	objset = getcurrentselection()
	for obj in objset do 
		(
		ResetXForm obj
		collapseStack obj	
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Object Calculation Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global Calc_Linear; 
fn Calc_Linear obj =
	(
 	if superclassof obj.baseobject == shape then 
 		(
		max modify mode
		modPanel.setCurrentObject obj.baseObject
 		total_length = (curvelength obj) as float
		if obj.modifiers.count > 0 do (modPanel.setCurrentObject obj.modifiers[obj.modifiers.count])
		case (units.SystemType) of
			(
			#Inches: (setuserprop obj "LinearMeasure" ((total_length/12) as string +"-ft"))
			#Feet: (setuserprop obj "LinearMeasure" (total_length as string +"-ft"))
			#Miles: (setuserprop obj "LinearMeasure" (total_length as string +"-mi"))
			#Millimeters: (setuserprop obj "LinearMeasure" (total_length as string +"-mm"))
			#Centimeters: (setuserprop obj "LinearMeasure" (total_length as string +"-cm"))
			#Meters: (setuserprop obj "LinearMeasure" (total_length as string +"-m"))
			#Kilometers: (setuserprop obj "LinearMeasure" (total_length as string +"-km"))
			)
		)
	else
		(
		setuserprop obj "LinearMeasure" "undefined"
		)
	)
	
global Calc_SurfaceArea; 
fn Calc_SurfaceArea obj =
	(
	reset_X_form()
		
	local op
	local unit = units.SystemType
	local facecount
	local facearea
	local areatotal = 0
	
	case (classof obj) of
		(
		Editable_Mesh: op = meshop 
		Editable_Poly: op = polyop
		default: op = undefined
		)
		
	-- Get Surface Area -- 
	
	if op != undefined then 
		(
		facecount = op.getnumfaces obj	
		facearea = #()
		for i = 1 to facecount do
			(
			append facearea (op.getfacearea obj i)
			)
			
		for i = 1 to facearea.count do
			(
			areatotal = areatotal + facearea [i] 
			)
		
		-- Write Data Tag to Object -- 
		
		case (units.SystemType) of
			(
			#Inches: (setuserprop obj "SurfaceArea" ((areatotal/12^2) as string +"-ft^2"))
			#Feet: (setuserprop obj "SurfaceArea" ((areatotal) as string +"-ft^2"))
			#Miles: (setuserprop obj "SurfaceArea" ((areatotal) as string +"-Miles^2"))
			#Millimeters: (setuserprop obj "SurfaceArea" ((areatotal/1000^2) as string +"-m^2"))
			#Centimeters: (setuserprop obj "SurfaceArea" ((areatotal/100^2) as string +"-m^2"))
			#Meters: (setuserprop obj "SurfaceArea" ((areatotal) as string +"-m^2"))
			#Kilometers: (setuserprop obj "SurfaceArea" ((areatotal) as string +"-km^2"))
			)
		)
	else
		(
		setuserprop obj "SurfaceArea" "undefined"
		)
	)
	
global Calc_Weight; 
fn Calc_Weight obj =
	(
	setuserprop obj "Weight" "undefined"
	)
	
global Calc_Volume; 
fn Calc_Volume obj =
	(
	setuserprop obj "Volume" "undefined"
	)
	
global Calc_OverallDims; 
fn Calc_OverallDims obj =
	(
	bbox = #(obj.min,obj.max)
	dims = bbox[2]-bbox[1]
	udpkey = #("Length","Width","Height")	
	case (units.SystemType) of
		(
		#Inches: for i = 1 to 3 do (setuserprop obj udpkey[i] (dims[i] as string +"-in"))
		#Feet: for i = 1 to 3 do (setuserprop obj udpkey[i] (dims[i] as string +"-ft"))
		#Miles: for i = 1 to 3 do (setuserprop obj udpkey[i] (dims[i] as string +"-mi"))
		#Millimeters: for i = 1 to 3 do (setuserprop obj udpkey[i] (dims[i] as string +"-mm"))
		#Centimeters: for i = 1 to 3 do (setuserprop obj udpkey[i] (dims[i] as string +"-cm"))
		#Meters: for i = 1 to 3 do (setuserprop obj udpkey[i] (dims[i] as string +"-m"))
		#Kilometers: for i = 1 to 3 do (setuserprop obj udpkey[i] (dims[i] as string +"-km"))
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Array Dataset Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

	-- Deletes Duplicates inside an Array --
	
global ArrayDelDups;	
fn ArrayDelDups og_array =
	(
	clean_data = #()
	for i = 1 to og_array.count do 
		(
		if finditem clean_data og_array[i] == 0 then append clean_data og_array[i]
		)
	sort clean_data
	return clean_data
	)
	
global BitToString;
fn BitToString ba sa =
	(
	bits = ba as array
	dataset = #()
	for i = 1 to bits.count do
		(
		append dataset sa[bits[i]]
		)
	return dataset
	)

global Array_Sum;
fn Array_Sum og_array = 
	(
	total = 0
	for i = 1 to og_array.count do
		(
		if ((og_array[i] as string) != "undefined") do (total = total + (og_array[i] as float))
		)
	return (total as float)
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Object Data Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global UDprop;	
fn UDprop upn upv = 
	(
	for obj in selection do
		(
		setUserProp obj (upn as string) ((getProperty obj upv) as String)
		)
	)
	
global UDtext;
fn UDtext upn upv = 
	(
	for obj in selection do
		(
		setUserProp obj (upn as string) (upv as String) 
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Dialog & Window Controls ---
---------------------------------------------------------------------------------------------------------------------------------------------	

global CheckRenderDialog;	
fn CheckRenderDialog = 
	(
	if renderSceneDialog.isopen() == true then
		(
		renderSceneDialog.close()
		CRDstate = true
		) 
		else
		(
		CRDstate = false
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Active X Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	

global AXListView;
fn AXListView lv =
	(
	lv.gridLines = true  
	lv.View = #lvwReport  
	lv.fullRowSelect = true 
	lv.AllowColumnReorder = true
	lv.Checkboxes = true
	lv.Backcolor = color 225 215 210
	lv.sorted = true
	
	layout_def = #("Pass Name","Output","Render Size","Frames","Pass Mode","Render Preset","Matte Objects","Other States")
	
	for i in layout_def do
		(
		column = lv.ColumnHeaders.add() 
		column.text = I
		) 
	)
	
global AXListUpdate;	
fn AXListUpdate lv =
	(
	lv.ListItems.clear()
	INIdata=#()
	INIdata = getINIsetting RMdata
	
	for i = 1 to INIdata.count do
		(
		li = lv.ListItems.add()
		li.text = (INIdata[i]) as string
		li.ToolTipText = (getINISetting RMdata (INIdata[i] as string) "RMpassnotes") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting RMdata (INIdata[i] as string) "RMoutput") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = ((getINISetting RMdata (INIdata[i] as string) "RMrenderWidth") + " x " + (getINISetting RMdata (INIdata[i] as string) "RMrenderHeight")) as string
		sub_li = li.ListSubItems.add()
		sub_li.text = ((getINISetting RMdata (INIdata[i] as string) "RMrendStart") + " - " + (getINISetting RMdata (INIdata[i] as string) "RMrendEnd")) as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (if (getINISetting RMdata (INIdata[i] as string) "PassMode" == "1") then "Selection Set" else "Layer State") as string		
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting RMdata (INIdata[i] as string) "RPSselect") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (if (getINISetting RMdata (INIdata[i] as string) "MT1" == "true") then (getINISetting RMdata (INIdata[i] as string) "MTselect") else "NONE") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting RMdata (INIdata[i] as string) "RMmatte_aa") as string
		)
	) 
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Scene BIM Data Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	

global get_instance_list;
fn get_instance_list obj = 
(
InstanceMgr.GetInstances obj &numInstances
InstanceArray = for n in numInstances where  
(areNodesInstances obj n) collect n
return InstanceArray
)	
	
global get_instance_count;
fn get_instance_count obj = 
	(
	InstanceMgr.GetInstances obj &numInstances
	)
	
global get_ven_qty; 
fn get_ven_qty refobj =
	(
	temp = #()
	qtys = #()
	unit = (getuserprop refobj "Vendor_Unit")
		
	for obj in objects do
		(
		if (getuserprop obj "Vendor_Part") == (getuserprop refobj "Vendor_Part") do (append temp obj)
		)

	for obj in temp do
		(
		val = case of
			(
			(unit == "Per Unit"): 1
			(unit == undefined): 0
			(unit == "undefined"): 0
			default: (((filterstring (getuserprop obj unit) "-")[1]) as float)
			) 
		append qtys val 
		)
	return (array_sum qtys)
	)
	
global get_calc_total; 
fn get_calc_total refobj udpstring =
	(
	temp = #()
	calcs = #()
	for obj in objects do
		(
		if (getuserprop obj "Vendor_Part") == (getuserprop refobj "Vendor_Part") do (append temp obj)
		)
	for obj in temp do --extracts user defined calc data--- 
		(
		if ((getuserprop obj udpstring) as string) != "undefined" do
			(
			obj_udp = (filterString (getuserprop obj udpstring) "-")[1] 
			append calcs (obj_udp as float)
			)
		)
	return (Array_Sum calcs)
	)
	
global get_obj_price obj;
fn get_obj_price obj =	
	(
	venunit = (if (getuserprop obj "Vendor_Unit") != undefined then (getuserprop obj "Vendor_Unit") else "Per Unit")
	venprice = (if (getuserprop obj "Vendor_Price") != undefined then (getuserprop obj "Vendor_Price") else 0)
	qty =
		(
		case venunit of
			(
			"Per Unit": 1
			"LinearMeasure": if ((getuserprop obj "LinearMeasure") as string) != "undefined" then (((filterstring (getuserprop obj "LinearMeasure") "-")[1]) as float) else 0
			"SurfaceArea": if ((getuserprop obj "SurfaceArea") as string) != "undefined" then (((filterstring (getuserprop obj "SurfaceArea") "-")[1]) as float) else 0
			"Weight": if ((getuserprop obj "Weight") as string) != "undefined" then (getuserprop obj "Weight" as float) else 0
			"Volume": if ((getuserprop obj "Volume") as string) != "undefined" then (getuserprop obj "Volume" as float) else 0
			default: 1
			)
		)
	price = if venprice == undefined or venprice == "" then 0 else venprice
	setuserprop obj "Ven_Obj_Price" ((qty * price) as float) 
	)
	
global get_price_totals; 
fn get_price_totals refobj =
	(
	for obj in objects do (get_obj_price obj)
	temp = #()
	temptotal = 0
	PriceTotal = 0
	for obj in objects do
		(
		if (getuserprop obj "Vendor_Part") == (getuserprop refobj "Vendor_Part") do (append temp obj)
		)
	for i=1 to temp.count do
		(
		PriceTotal = PriceTotal + (getuserprop Temp[i] "Ven_Obj_Price")
		)
	return PriceTotal
	)

global scene_count;
fn scene_count = 
	(
	ScneCnt = #()
	for obj in objects do 
		(			
		txt = filterstring obj.name "_,:,-"
		if txt[2] != undefined do appendIfUnique ScneCnt txt[2]
		sort ScneCnt
		)
	return ScneCnt
	)
	
global object_filter;	
fn object_filter condense grp names types = --- Types (array) prefix strings : grp (boolean) option is to exclude group sub objects : inst (boolean) is to condense instanced objects
	(
	objset = (objects as array)
	
	case condense of 
		(
		1:	()
		2:	(
			temp = #()
			venprt = #()
			for obj in objset do 
				(
				if finditem venprt (getuserprop obj "Vendor_Part") == 0 and ((getuserprop obj "Vendor_Part") as string) != "undefined" do 
					(
					appendifunique venprt (getuserprop obj "Vendor_Part")
					appendifunique temp obj
					)
				)
			objset = temp		
			)
		3:	(
			temp = #()
			for obj in objset do 
				(
				if get_instance_count obj == 1 do append temp obj
				if get_instance_count obj > 1 do appendifUnique temp ((get_instance_list obj)[(get_instance_list obj).count])
				)
			objset = temp			
			)
		)	
	
	if names == true do
		(
		temp = #()
		for obj in objset do 
			(
			txt = filterstring obj.name "_,:,-"
			if (finditem types txt[1]) != 0 do (append temp obj)
			)
		objset = temp
		)
		
	if grp == true then 
		(
		temp = #()
		for obj in objset do 
			(
			if isGroupMember obj == false do append temp obj
			)
		objset = temp
		)
		else
		(
		temp = #()
		for obj in objset do 
			(
			if isGroupHead obj == false do append temp obj
			)
		objset = temp
		)
	return objset
	)	

global BIMListView;
fn BIMListView lv rptstyle =
	(
	local layout_def = #()
	local layout_width = #()
	
	lv.gridLines = true  
	lv.View = (dotNetClass "System.Windows.Forms.View").Details  
	lv.fullRowSelect = true 
	lv.AllowColumnReorder = true
	lv.Checkboxes = false
	lv.Sorting = (dotNetClass "System.Windows.Forms.SortOrder").Ascending
	lv.ListViewItemSorter = (dotNetClass "System.Windows.Forms.ListViewItemSorter") 
	lv.labeledit = true
				
	layout_def = case rptstyle of 
		(
		1:	layout_def = #("Object","Type", "Scene", "Element", "Description", "Material", "Finish", "Material Density", "Material Units", "Design (Days)", "Engineering (Days)", "Fabrication (Days)", "Shipping (Days)", "Installation (Days)", "Vendor", "Vendor Part", "Vendor Units", "Vendor Price", "Linear Measurement", "Surface Area", "Weight", "Volume", "Overall Dimensions")
		2:	layout_def = #("Object", "Vendor", "Vendor Part", "Vendor Units", "Vendor Price","Quantity", "Total Price")
		3:	layout_def = #("Object", "Design (Days)", "Eng (Days)", "Fab (Days)", "Shipping (Days)", "Install (Days)", "Total (Days)")
		4:	layout_def = #("Object", "Scene", "Equip. Type", "Vendor", "Vendor Part","Quantity")
		5:	layout_def = #("Object", "Vendor", "Vendor Part","Linear Measurement", "Surface Area", "Weight", "Volume", "Length","Width","Height","Quantity")
		)
		
	layout_width = case rptstyle of 
		(
		1:	layout_width = #(180,90,90,90,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120,120)
		2:	layout_width = #(180,150,110,90,90,60,90)
		3:	layout_width = #(180,90,90,90,90,90,140)
		4:	layout_width = #(180,90,80,165,165,90)
		5:	layout_width = #(180,165,165,90,90,90,90,90,90,90,90)
		)
	
	for i=1 to layout_def.count do
	lv.Columns.add layout_def[i] layout_width[i]	
	) 
	
global BIMListUpdate;
fn BIMListUpdate lv condensed rptstyle objset =
(
ObjPropKey = case rptstyle of 
	(
	1:	ObjPropKey = #("Type", "Scene", "Element", "Description", "Material", "Finish", "Mat_Density", "Mat_Units", "Design_Duration(Days)", "Engineering_Duration(Days)", "Fabrication_Duration(Days)", "Shipping_Duration(Days)", "Installation_Duration(Days)", "Vendor", "Vendor_Part", "Vendor_Unit", "Vendor_Price", "LinearMeasurement", "SurfaceArea", "Weight", "Volume", "OverallDimensions")
	2:	ObjPropKey = #("Vendor", "Vendor_Part", "Vendor_Unit", "Vendor_Price")
	3:	ObjPropKey = #("Design_Duration(Days)", "Engineering_Duration(Days)", "Fabrication_Duration(Days)", "Shipping_Duration(Days)", "Installation_Duration(Days)")
	4:	ObjPropKey = #("Scene", "Type", "Vendor", "Vendor_Part")
	5:	ObjPropKey = #("Vendor", "Vendor_Part")
	)
theRange=#()
for obj in objset do
	(
	li = dotNetObject "System.Windows.Forms.ListViewItem" obj.name
		
	for i = 1 to (ObjPropKey.count) do
		(
		sub_li = li.SubItems.add (getuserprop obj ObjPropKey[i] as string)
		)
		
	Count = 
		(
		case condensed of 
			(
			1: 1  
			2: get_ven_qty obj
			3: get_instance_count obj
			)
		)
		
	if condensed == 2 do 
		(
		LM = get_calc_total obj "LinearMeasure"
		SF = get_calc_total obj "SurfaceArea"
		WT = get_calc_total obj "Weight"
		VL = get_calc_total obj "Volume"
		LT = get_calc_total obj "Length"
		WD = get_calc_total obj "Width"
		HT = get_calc_total obj "Height"
		)
		
	case rptstyle of 
		(
		1: ()
		2: (
 			totalprice = get_price_totals obj
			sub_li = li.SubItems.add (Count as string)
			sub_li = li.SubItems.add (totalprice as string)
			)
		3: (
			TotalDays = (if (getuserprop obj "Design_Duration(Days)") != undefined then (getuserprop obj "Design_Duration(Days)") as integer else 0) + (if (getuserprop obj "Engineering_Duration(Days)") != undefined then (getuserprop obj "Engineering_Duration(Days)") as integer else 0) + (if (getuserprop obj "Fabrication_Duration(Days)") != undefined then (getuserprop obj "Fabrication_Duration(Days)") as integer else 0) + (if (getuserprop obj "Shipping_Duration(Days)") != undefined then (getuserprop obj "Shipping_Duration(Days)") as integer else 0) + (if (getuserprop obj "Installation_Duration(Days)") != undefined then (getuserprop obj "Installation_Duration(Days)") as integer else 0)
			sub_li = li.SubItems.add (TotalDays as string)
			)
		4: (
			sub_li = li.SubItems.add (count as string)
			)
		5: (
			sub_li = li.SubItems.add (LM as string)
			sub_li = li.SubItems.add (SF as string)
			sub_li = li.SubItems.add (WT as string)
			sub_li = li.SubItems.add (VL as string)
			sub_li = li.SubItems.add (LT as string)
			sub_li = li.SubItems.add (WD as string)
			sub_li = li.SubItems.add (HT as string)
			sub_li = li.SubItems.add (count as string)
			)
		)
	append theRange li
	)
lv.Items.AddRange theRange
)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- dotNet Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------
		
global dnet_OAD_toString;
fn dnet_OAD_toString val = 
	(
	OA = dotnetclass "System.DateTime"
	DateTime = OA.fromOAdate val
	return DateTime.ToString()
	)
		
global dnet_String_toOAD;
fn dnet_String_toOAD str = 
	(
	OA = dotnetclass "System.DateTime"
	datetime = oa.parse(str)
	return datetime.toOAdate()
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- BIM Excel Data Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

global xl_sheet;
fn xl_sheet visible = 
	(
	global xlObject = createOLEObject "Excel.Sheet"
	xlObject.application.visible = visible
	)
	
global xl_open;
fn xl_open visible = 
	(
	try (file = getOpenFileName()) catch (messagebox "No File Selected")
	global xlObject = createOLEObject "Excel.Application"
	xlObject.application.visible = visible
	if file != undefined do (xlObject.workbooks.open file)
	)
	
global xl_write;
fn xl_write row col data =
	(
	xlo = xlObject.application.cells row col
	xlo.value = (data as string)
	)

global xl_read;
fn xl_read row col =
	(
	global xlo = xlObject.application.cells row col
	return (xlo.value as string)
	)
	
global xl_save;	
fn xl_save rpt =
	(
	xlObject.saveAs ((getSavePath caption:"Save Excel File") + "\\" + rpt + ".xlsx")
	releaseAllOLEObjects()
	)

global xl_export;
fn xl_export visible lv rpt = 
	(
	savepath = getSavePath caption:"Save Excel File"
	xlObject = createOLEObject "Excel.Sheet"
	xlObject.application.visible = visible
	col_count = lv.columns.count
	item_count = lv.items.count
	for i = 1 to item_count do 
		(
		for j = 1 to col_count do
			(
			xl_write (i) (j) (lv.items.item[i-1].subitems.item[j-1].text)
			)
		)
	activeXL = xlobject.application.activeworkbook
	activeXL.SaveCopyAs ((savepath) + "\\" + rpt + ".xlsx")
	releaseAllOLEObjects()
	)
	
global xl_khssdemo;
fn xl_khssdemo visible lv =
	(
	savepath = (getSavePath caption:"Save Excel File")
	rptpath = "V:\\MAXnet\\MAX 2008\\scripts\\CGsoldier\\Script R&D\\khssdocs\\"
	rptfiles = #("W-Type B.xls","W-Type F.xls","W-Type KA.xls")
	xlo = createOLEObject "Excel.Application"
	xlo.visible = visible
	item_count = lv.items.count
	for i = 1 to item_count do 
		(
		xlo.workbooks.open (rptpath+rptfiles[i])
		(xlo.cells 6 3).value = (lv.items.item[i-1].subitems.item[3].text)
		xlo.ActiveWorkbook.SaveAs (savepath + "\\" + (filterstring rptfiles[i] ".")[1] + ".xls")
		xlo.ActiveWorkbook.Close
		)
	xlo.quit()
	releaseAllOLEObjects()
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- SQL Data Functions OLE Methods---
---------------------------------------------------------------------------------------------------------------------------------------------

global SQLconn; 
fn SQLconn =
	(
	global DBconn = createOLEObject "ADODB.Connection" 
	DBConn.Open "Provider=SQLoleDB; server=SDI-SAN; database=PDMWE_ScenarioFileVault; UID=sa; PWD=q7w8e9r"
	)
	
global SQLclose; 
fn SQLclose =
	(
	DBConn.close()
	)
	
global SQLcmd;
fn SQLcmd cmdstring =
	(
	SQLconn()
	DBconn.Execute (cmdstring)
	SQLclose()
	)
	
global SQLread;
fn SQLread QueryStr =
	(
	SQLconn()
	global RecordSet = createOLEObject "ADODB.Recordset"
	RecordSet.locktype = 1
	RecordSet.Open (QueryStr) DBconn
	data = RecordSet.getrows()
	RecordSet.close()
	return data.dataArray
	SQLclose()
	)

global SQLaddnew;
fn SQLaddnew table column val =
	(
	global RecordSet = createOLEObject "ADODB.Recordset"
	RecordSet.locktype = 4
	RecordSet.Open (table as string) DBconn
	RecordSet.addnew (column as string) val
	RecordSet.updatebatch()
	RecordSet.close()
	RecordSet.locktype = 1
	)
	
global SQLparse;
fn SQLparse sqldata index = 
	(
	a = #()
	for i = 1 to sqldata.count do
		(
		append a (sqldata [i] [index])
		)
	return a
	)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- SQL Data Functions DotNet Methods---
---------------------------------------------------------------------------------------------------------------------------------------------
		
-- 	"Driver={SQL Native Client};Server=VPD-Skunkwerks\VPD;Trusted_Connection=No;Database=VPD;UID=sa;PWD=q7w8e9r"  
-- 	"Driver={SQL Native Client}; server=SDI-SAN; Trusted_Connection=No; database=PDMWE_ScenarioFileVault; UID=sa; PWD=q7w8e9r"
-- 	"Driver={SQL Native Client};Server=.\SQLExpress;AttachDbFilename=Z:\PROGRAMMING\Scenario VPD\Scenario VPD Manager\Scenario VPD Manager\VPD_DB.mdf; Database=dbname; Trusted_Connection=Yes;"
	
global SQL_CSskunk = "Driver={SQL Native Client};Server=VPD-Skunkwerks\VPD;Trusted_Connection=No;Database=VPD;UID=sa;PWD=q7w8e9r"
global SQL_CSlocal = "Driver={SQL Native Client};Server=.\SQLExpress;AttachDbFilename=Z:\PROGRAMMING\Scenario VPD\Scenario VPD Manager\Scenario VPD Manager\VPD_DB.mdf; Database=VPD; Trusted_Connection=Yes;"	
	
global SQLconn2; 
fn SQLconn2 = 
	(
	global SQLconnect = dotNetObject "System.Data.odbc.OdbcConnection"
	SQLconnect.ConnectionString = SQL_CSlocal 
	try (SQLconnect.Open()) catch (messagebox "Unable to Establish Connection To Database")
	if SQLconnect.state.tostring() == "Open" then (messagebox ("SQL Connection Established:\n" + (SQLconnect.datasource))) else (messagebox "Unable to Establish Connection To Database")
	)

global SQLclose2; 
fn SQLclose2 = 
	(
	SQLconnect.Close()
	)
	
global SQLcmd2; 
fn SQLcmd2 = 
	(
	SQLconn2 ()
	global SQLcommand = dotNetObject "System.Data.odbc.OdbcCommand"
	)
	
global SQLread2;
fn SQLread2 =
	(
	try sqlreader.item(0) (continueloop = true) 
	catch (continueloop = false)
	BOMarray = #()
	while continueloop = true do 
		(
		temparray = #()
		for x = 0 to (sqlreader.fieldcount - 1) do 
			(
			append temparray (sqlreader.item(x))
			)
		append BOMarray temparray
		try (sqlreader.read()) (continueloop = true) 
		catch (continueloop = false)
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Initialization End ---
---------------------------------------------------------------------------------------------------------------------------------------------	
		
		
)