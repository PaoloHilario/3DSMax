--------------------------------------------------------------
--------------------------------------------------------------
------ Pass Monkey v1.9 								------
------ By Paolo Hilario (CGsoldier@gmail.com)		------
------ Created 04.22.05								------
------ http://www.cgsoldier.com						------
------ CGsoldier "Miltitant CG Merc Tools"		------
--------------------------------------------------------------
--------------------------------------------------------------

--- Revision History ---
---
--- Version 1.5: 
--- Added renderer preset option
--- Fixed No Camera in Scene Crash
---
---------------------------------------------------------------------------------------------------------------------------------------------
--- Globals ---
---------------------------------------------------------------------------------------------------------------------------------------------

--- Floater Definitions --- 
global PM_Floater
global AB_Floater
global LM_Floater
--- Path Definitions ---
global RPS_home
global MAT_home
--- Layer Globals ---
global CurrentLayerRoll
global LSM1_rollout 
global LSM2_rollout
global LSM_sub
global LSM_ops
global LSMsavename
global LShide
global LSunhide
global LSfreeze
global LSunfreeze
global applyAM 	
global applyAP 
global revertAM 
global revertAP 
--- Layer Data --- 
global LSMops
global LSMname
global LSMhidden
global LSMfrozen
global LSMaltmatcheck
global LSMaltmat
global LSMaltpropcheck
global LSMaltprop

---------------------------------------------------------------------------------------------------------------------------------------------
--- Script Includes --- 
---------------------------------------------------------------------------------------------------------------------------------------------

fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local UI Specific Variables ---
---------------------------------------------------------------------------------------------------------------------------------------------
(
--- local functions ---	
local SetINI
local GetINI
local LSMsave
local ALTsave
local ALTload
local refresh
local FloaterSizer
--- floater definitions ---
local PM_rollout
local Pass_rollout
local Render_rollout
local MSR_rollout
local ALTprop_rollout
local PMabout_rollout
local PickAltMat_rollout
local PickAltProp_rollout
--- Icons Settings ---
local CGi_cnt = 11
local CGi_PM = 1
local CGi_RM = 2
local CGi_edt1 = 3
local CGi_edt2 = 4
local CGi_del1 = 5
local CGi_del2 = 6
local CGi_sv1 = 7
local CGi_sv2 = 8
local CGi_mat1 = 9
local CGi_mat2 = 10
local CGi_frz1 = 11
--- Data Holding Vars ---
local ALTname
--local layer functions ---
local LSM_menu
local LSM_pickmat
local LSM_pickprop
--- Floater Window & Direcotry Settings ---
local RMexists = getdirectories (maxfilepath + "RM-DATA")
local FLx = ((getINISetting "$maxdata\\CGsoldier.ini" "PassMonkey" "FloaterX") as integer)
local FLy = ((getINISetting "$maxdata\\CGsoldier.ini" "PassMonkey" "FloaterY") as integer)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Variables Saved to PassMonkey Data ---
---------------------------------------------------------------------------------------------------------------------------------------------

--- Main Pass Monkey --- 
global PMload
local PMname
--- Layer & Selection --- 
local PassMode
local SS1 
local SSselect
local LS1 
local LSselect
local LSCLselect
--- MSR Settings ---
local MT1
local MTselect
local MT2
local MORpath
local MORselect
local MT3
local ALTselect
--- Render Settings ---
local RPS1
local RPSpath
local RPSselect
local RPO1
local RPO2
local RPO3

---------------------------------------------------------------------------------------------------------------------------------------------
--- PassMonkey Specific Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------
	
function SetINI = 
	(
	--- Pass Rollout INI settings ---
	if PassMode != undefined then setINISetting RMdata PMname "PassMode" (PassMode as string) else setINISetting RMdata PMname "PassMode" "false"
	if SS1 != undefined then setINISetting RMdata PMname "SS1" (SS1 as string) else setINISetting RMdata PMname "SS1" "false"
	if SSselect != undefined then setINISetting RMdata PMname "SSselect" (SSselect as string) else setINISetting RMdata PMname "SSselect" "undefined"
	if LS1 != undefined then setINISetting RMdata PMname "LS1" (LS1 as string) else setINISetting RMdata PMname "LS1" "false"
	if LSselect != undefined then setINISetting RMdata PMname "LSselect" (LSselect as string) else setINISetting RMdata PMname "LSselect" "undefined"
	if LSCLselect != undefined then setINISetting RMdata PMname "LSCLselect" (LSCLselect as string) else setINISetting RMdata PMname "LSCLselect" "undefined"
	--- MSR Rollout INI Settings --- 
	if MT1 != undefined then setINISetting RMdata PMname "MT1" (MT1 as string) else setINISetting RMdata PMname "MT1" "false"
	if MTselect != undefined then setINISetting RMdata PMname "MTselect" (MTselect as string) else setINISetting RMdata PMname "MTselect" "undefined"
	if MT2 != undefined then setINISetting RMdata PMname "MT2" (MT2 as string) else setINISetting RMdata PMname "MT2" "false"
	if MORpath != undefined then setINISetting RMdata PMname "MORpath" MORpath else setINISetting RMdata PMname "MORpath" (getINIsetting (getMAXIniFile() as string) "Directories" "Materials")
	if MORselect != undefined then setINISetting RMdata PMname "MORselect" (MORselect as string) else setINISetting RMdata PMname "MORselect" "undefined"
	if MT3 != undefined then setINISetting RMdata PMname "MT3" (MT3 as string) else setINISetting RMdata PMname "MT3" "false"
	if ALTselect != undefined then setINISetting RMdata PMname "ALTselect" (ALTselect as string) else setINISetting RMdata PMname "ALTselect" "undefined"
	--- Render Rollout INI Settings ---
	if RPS1 != undefined then setINISetting RMdata PMname "RPS1" (RPS1 as string) else setINISetting RMdata PMname "RPS1" "false"
	if RPSpath != undefined then setINISetting RMdata PMname "RPSpath" RPS_home else setINISetting RMdata PMname "RPSpath" (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 4)) + "_PRESETS")
	if RPSselect != undefined then setINISetting RMdata PMname "RPSselect" (RPSselect as string) else setINISetting RMdata PMname "RPSselect" "undefined"
	if RPO1 != undefined then setINISetting RMdata PMname "RPO1" (RPO1 as string) else setINISetting RMdata PMname "RPO1" "true"
	if RPO2 != undefined then setINISetting RMdata PMname "RPO2" (RPO2 as string) else setINISetting RMdata PMname "RPO2" "true"
	if RPO3 != undefined then setINISetting RMdata PMname "RPO3" (RPO3 as string) else setINISetting RMdata PMname "RPO3" "true"
	)
		
function GetINI = 
	(
	--- Pass Rollout INI settings ---
	PassMode = getINISetting RMdata PMload "PassMode" as integer
	SS1 = getINISetting RMdata PMload "SS1" as BooleanClass
	SSselect = getINISetting RMdata PMload "SSselect" as string
	LS1 = getINISetting RMdata PMload "LS1" as BooleanClass
	LSselect = getINISetting RMdata PMload "LSselect" as string
	LSCLselect = getINISetting RMdata PMload "LSCLselect" as string
	--- MSR Rollout INI Settings --- 
	MT1 = getINISetting RMdata PMload "MT1" as BooleanClass
	MTselect = getINISetting RMdata PMload "MTselect" as string
	MT2 = getINISetting RMdata PMload "MT2" as BooleanClass
	MORpath = getINISetting RMdata PMload "MORpath" as string
	MORselect = getINISetting RMdata PMload "MORselect" as string
	MT3 = getINISetting RMdata PMload "MT3" as BooleanClass
	ALTselect = getINISetting RMdata PMload "ALTselect" as string
	--- Render Rollout INI Settings ---
	RPS1 = getINISetting RMdata PMload "RPS1" as BooleanClass
	RPS_home = getINISetting RMdata PMload "RPSpath" as string
	GetRPS()
	RPSselect = getINISetting RMdata PMload "RPSselect" as string
	RPO1 = getINISetting RMdata PMload "RPO1" as BooleanClass
	RPO2 = getINISetting RMdata PMload "RPO2" as BooleanClass
	RPO3 = getINISetting RMdata PMload "RPO3" as BooleanClass
	)
	
fn refresh = 
	(
	AA = Pass_rollout.open
	BB = MSR_rollout.open
	CC = Render_rollout.open
	DD = PMabout_rollout.open
	removerollout Pass_rollout PM_Floater 
	removerollout MSR_rollout PM_Floater 
	removerollout Render_rollout PM_Floater 
	removerollout PMabout_rollout PM_Floater 
	if AA == false then addRollout Pass_rollout PM_Floater rolledup:true else addRollout Pass_rollout PM_Floater
	if BB == false then addRollout MSR_rollout PM_Floater rolledup:true else addRollout MSR_rollout PM_Floater
	if CC == false then addRollout Render_rollout PM_Floater rolledup:true else addRollout Render_rollout PM_Floater
	if DD == false then addRollout PMabout_rollout PM_Floater rolledup:true else addRollout PMabout_rollout PM_Floater
	FloaterSizer()
	)
	
fn FloaterSizer = 
	(
	a = (if PM_rollout.open == true then (PM_rollout.height + 25) else 22)
	b = (if Pass_rollout.open == true then (Pass_rollout.height + 25) else 22)
	c = (if MSR_rollout.open == true then (MSR_rollout.height + 25) else 22)
	d = (if Render_rollout.open == true then (Render_rollout.height + 25) else 22)
	e = (if PMabout_rollout.open == true then (PMabout_rollout.height + 25) else 22)
	width = (a+b+c+d+e)
	PM_floater.size = [250,width]
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Layer & Selection Set Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

rollout Pass_rollout "Layer and Selection Controls" category:2
	(
	radiobuttons SetMode labels:#("Selection Sets   ","Layer States")	
		
	group "Selection Sets" 
		(
		label SStext "Load Selection Set:" align:#left offset:[0,5] across:3
		button SSedit align:#right offset:[45,0] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_edt1, CGi_edt1, CGi_edt2, CGi_edt2) tooltip:"Edit Selection Sets"
		button SSdelete align:#right images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_del1, CGi_del1, CGi_del2, CGi_del2) tooltip:"Delete Current Selection Set"
		dropDownList SSscene align:#center height:20 items:#() selection:0 offset:[0,0] 
		)
		
	group "Layer State Controls" 
		(
		label LStext1 "Load Layer State:" align:#left offset:[0,5] across:3
		button LSedit align:#right offset:[45,0] enabled:false images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_edt1, CGi_edt1, CGi_edt2, CGi_edt2) tooltip:"Edit Layer Sets"
		button LSdelete align:#right enabled:false images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_del1, CGi_del1, CGi_del2, CGi_del2) tooltip:"Delete Current Layer Set"	
		dropDownList LSscene align:#center height:20 items:#() selection:0 offset:[0,0] enabled:false
		label LStext2 "Camera and Light Selection Set:" align:#left offset:[0,5]
		dropDownList LScamlights align:#center height:20 items:#() selection:0 offset:[0,0] enabled:false
		)
		
--- Rollout Variable Loaders --- 

on Pass_rollout open do
	(
	GetSS()
	GetLSM()
	--- Pass Set Mode ---
	if PassMode == undefined then 
		(
		SetMode.state = 1
		PassMode = 1
		SS1 = true
		LS1 = false
		)
	else 
		(
		Setmode.state = PassMode
		if PassMode == 1 then
			( 
			SS1 = true
			LS1 = false
			)
		if PassMode == 2 then
			(
			SS1 = false
			LS1 = true
			)
		)
	--- Selection Sets ---
	SSedit.enabled = if SS1 != undefined then SS1 else false
	SSdelete.enabled = if SS1 != undefined then SS1 else false
	SSscene.items = SS
	SSscene.enabled = if SS1 != undefined then SS1 else false
	if SSselect != undefined then SSindex = finditem SS SSselect
	SSscene.selection = if SSindex != undefined and PassMode == 1 then SSindex else 0
	--- Layer States --- 
	LSedit.enabled = if LS1 != undefined then LS1 else false
	LSdelete.enabled = if LS1 != undefined then LS1 else false
	LSscene.items = LSM
	LSscene.enabled = if LS1 != undefined then LS1 else false
	if LSselect != undefined then LSindex = finditem LSM LSselect
	LSscene.selection = if LSindex != undefined and PassMode == 2 then LSindex else 0
	LScamlights.items = SS
	LScamlights.enabled = if LS1 != undefined then LS1 else false
	if LSCLselect != undefined then LSCLindex = finditem SS LSCLselect
	LScamlights.selection = if LSCLindex != undefined and PassMode == 2 then LSCLindex else 0
	)
	
--- DropDownList Actions --- 

on SSscene selected i do
	(
	if SSscene.selection != 0 then
		(
		SSselect = SSscene.selected
		SSdelete.enabled = true
		)
	else
		(
		SSselect = undefined
		SSdelete.enabled = false
		)
	)
	
on LSscene selected i do
	(
	if LSscene.selection != 0 then  
		(
		LSselect = LSscene.selected
		LSMsavename = LSscene.selected
		LSdelete.enabled = true
		)
	else
		(
		LSselect = undefined
		LSMsavename = undefined
		LSdelete.enabled = false
		)
	)

on LScamlights selected i do
	(
	if LScamlights.selection != 0 then  
		(
		LSCLselect = LScamlights.selected
		)
	else
		(
		LSCLselect = undefined
		)
	)
	
--- Checkbox Actions --- 

on SetMode changed theState do 
	(
	if theState == 1 then
		(
		PassMode = 1
		SS1 = true
		LS1 = false
		LSselect = undefined
		refresh()
		)
	if theState == 2 then
		(
		PassMode = 2
		SS1 = false
		LS1 = true
		SSselect = undefined
		refresh()
		)
	)
		
on SSenable changed theState do
	(
	if theState == true then
		(
		SS1 = true
		SSedit.enabled = SS1
		SSdelete.enabled = SS1
		SSscene.enabled = SS1
		SSscene.selection = 1
		SSselect = SSscene.selected
		) else (
		SS1 = false
		SSedit.enabled = SS1
		SSdelete.enabled = SS1
		SSscene.enabled = SS1
		SSscene.selection = 0
		SSselect = undefined
		)
	)

on LSenable changed theState do
	(
	if theState == true then
		(
		LS1 = true
		LSedit.enabled = LS1
		LSdelete.enabled = LS1
		LSscene.enabled = LS1
		LSscene.selection = 1
		LSselect = LSscene.selected
		) else (
		LS1 = false
		LSedit.enabled = LS1
		LSdelete.enabled = LS1
		LSscene.enabled = LS1
		LSscene.selection = 0
		LSselect = undefined
		)
	)

--- Button Actions --- 

on SSedit pressed do
	(
	macros.run "Edit" "namedSelSets"
	)

on SSdelete pressed do
	(
	if querybox "Are you sure you want to do this?" title:"Please Confirm" then
		(
		if SSselect != undefined then (deleteItem selectionSets SSselect) else (messagebox "Nothing Selected" title:"Cannot Comply" beep:true)
		GetSS()
		SSscene.items = SS
		SSscene.enabled = true
		SSscene.selection = 0
		)
	)
	
on LSedit pressed do 
	(
	if LM_Floater != undefined then CloseRolloutFloater LM_Floater
	LM_Floater = newRolloutFloater "Layer Monkey" 280 500
	addRollout LSM1_rollout LM_Floater
	)
	
on LSdelete pressed do 
	(
	if LSselect == undefined then (messagebox "Nothing Selected" title:"Cannot Comply" beep:true) else
		(
		if querybox "Are you sure you wnt to do this?" then
			(
			(delIniSetting LSdata LSscene.selected)
			GetLSM()
			LSscene.items = LSM
			LSscene.selection = 0
			)
		)
	)
)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Layer Management Functions --- 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout PickAltMat_rollout "Alternate Layer Material" 
	(
	materialbutton choosemat "Pick Material" width:165 height:30 offset:[0,5]
	
	on pickaltmat_rollout open do
		(
		i = finditem LSMops LSM_ops
		if LSMaltmat[i] != "undefined" then 
			(
			x = getMatLibFileName()
			AltMat = LSMaltmat[i]
			loadMaterialLibrary MATdata
			choosemat.material = currentMaterialLibrary[AltMat]
			loadMaterialLibrary x
			)
		else 
			(
			choosemat.material = none
			)
		)
	
	on choosemat picked mtl do
		(
		choosemat.material = mtl
		--- Data Handling --- 
		i = finditem LSMops LSM_ops
		LSMaltmat[i] = mtl.name
		LSMselobj LSM_ops
		UDtext "LSMaltmat" mtl.name
		if $ != undefined then deselect $
		--- Save Materials --- 
		x = getMatLibFileName()
		loadMaterialLibrary MATdata
		currentMaterialLibrary[mtl.name] = mtl
		saveMaterialLibrary MATdata
		loadMaterialLibrary x
		SaveLayers LSMsavename
		removerollout LSM2_rollout LM_floater
		CurrentLayerRoll()
		DestroyDialog PickAltMat_rollout
		)
	)

rollout PickAltProp_rollout "Alternate Layer Property"
	(
--	dropDownList ALTprop align:#left height:20 width:185 items:APL selection:0 offset:[0,10] across:2
	button ALTbuild "Build States" align:#right offset:[5,8] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_edt1, CGi_edt1, CGi_edt2, CGi_edt2) tooltip:"Edit Alternate States"
	
	on pickaltprop_rollout open do
		(
		i = finditem LSMops LSM_ops
		x = findItem APL LSMaltprop[i]
		ALTprop.selection = if x != 0 then x else 0 
		)
	
	on ALTprop selected i do
		(
		i = finditem LSMops LSM_ops
		deleteItem LSMaltprop i
		insertItem (ALTprop.selected as string) LSMaltprop i
		LSMselobj LSM_ops
		UDtext "LSMaltprop" ALTprop.selected
		if $ != undefined then deselect $
		SaveLayers LSMsavename
		removerollout LSM2_rollout LM_floater
		CurrentLayerRoll()
		DestroyDialog PickAltProp_rollout		
		)
	
	on ALTbuild pressed do 
		(
		if AB_floater != undefined then CloseRolloutFloater AB_Floater
		AB_floater = newRolloutFloater "Alternate Properties Manager" 300 345
		addrollout ALTprop_rollout AB_floater
		)
	)

rcmenu LSM_menu
	(
	MenuItem pickaltmat "Pick Alternate Material"
	Menuitem pickaltprop "Pick Alternate Property"
	seperator sep0 
	MenuItem addtolayer "Add Selected to Layer"
	MenuItem selectobj "Select Objects on Layer"
	separator sep1
	MenuItem deletelayer "Delete Layer"
	Menuitem deletelayobj "Delete Layer and Objects"
	seperator sep2
	MenuItem layerprops "Layer Properties"
	
	on pickaltmat picked do LSM_pickmat()
	on pickaltprop picked do LSM_pickprop()
	on addtolayer picked do LSMaddobj LSM_ops 
	on selectobj picked do LSMselobj LSM_ops
	on deletelayer picked do LSMdeleteLayer LSM_ops 
	on deletelayobj picked do LSMdeleteLayerObj LSM_ops
	on layerprops picked do (layermanager.editlayerbyname LSM_ops)
	)	

fn LSM_sub ops = 
	(
	LSM_ops = ops
	print LSM_ops
	popupmenu LSM_menu rollout:LSM2_rollout
	)
	
fn LSM_pickmat = 
	(
	if LSselect != undefined then 
	createdialog PickAltMat_rollout 175 50 else 
	messagebox "You must load a Layer State before doing this" title:"LayerMonkey Error"
	)

fn LSM_pickprop = 
	(
	if LSselect != undefined then 
	createdialog PickAltProp_rollout 235 50 else 
	messagebox "You must load a Layer State before doing this" title:"LayerMonkey Error"
	)
	
fn LShide ops =
	(
	(layermanager.getLayerFromName ops).ishidden = true	
	LSMselobj ops
	for obj in selection do obj.ishidden = true
	if $ != undefined then deselect $
	)

fn LSunhide ops =
	(
	(layermanager.getLayerFromName ops).ishidden = false
	LSMselobj ops
	for obj in selection do obj.ishidden = false
	if $ != undefined then deselect $
	)

fn LSfreeze ops =
	(
	(layermanager.getLayerFromName ops).isfrozen = true
	LSMselobj ops
	for obj in selection do obj.isfrozen = true
	if $ != undefined then deselect $	
	)

fn LSunfreeze ops =
	(
	(layermanager.getLayerFromName ops).isfrozen = false
	LSMselobj ops
	for obj in selection do obj.isfrozen = false
	if $ != undefined then deselect $	
	)
	
fn applyAM ops = 
	(	
	LSM_ops = ops
	i = finditem LSMops LSM_ops
	deleteItem LSMaltmatcheck i
	insertItem true LSMaltmatcheck i	
	LSMselobj LSM_ops
	SetAltMat LSMaltmat[i]
	if $ != undefined then deselect $	
	)
	
fn revertAM ops =
	(	
	LSM_ops = ops
	i = finditem LSMops LSM_ops
	deleteItem LSMaltmatcheck i
	insertItem false LSMaltmatcheck i
	LSMselobj LSM_ops
	RevertAltMat()
	if $ != undefined then deselect $	
	)
	
fn applyAP ops =
	(	
	LSM_ops = ops
	i = finditem LSMops LSM_ops
	deleteItem LSMaltpropcheck i
	insertItem true LSMaltpropcheck i
	LSMselobj LSM_ops
	SetAltProp LSMaltprop[i]
	if $ != undefined then deselect $	
	)


fn revertAP ops =
	(	
	LSM_ops = ops
	i = finditem LSMops LSM_ops
	deleteItem LSMaltpropcheck i
	insertItem false LSMaltpropcheck i	
	LSMselobj LSM_ops
	RevertAltProp()
	if $ != undefined then deselect $
	)
 
---------------------------------------------------------------------------------------------------------------------------------------------
--- Layer Management Rollout - Load / Save ---
---------------------------------------------------------------------------------------------------------------------------------------------

rollout LSM1_rollout "Load/Save Layer States" category:1
(
	dropDownList LSM_load "Load Layer States:" align:#left height:18 width:220 items:#() selection:0 offset:[0,0] across:2
	button LSM_delete "Delete" align:#right enabled:false offset:[5,17] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_del1, CGi_del1, CGi_del2, CGi_del2) tooltip:"Delete Saved Layer State"	
	Label lbl_SaveNew "Save New Layer State:" align:#left offset:[0,0]
	edittext LSM_name height:20 width:223 align:#left text:"" offset:[-5,3] across:2
	button LSM_save "Save" align:#right enabled:false offset:[5,2] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_sv1, CGi_sv1, CGi_sv2, CGi_sv2) tooltip:"Save Layer State"
	
--- Rollout Variable Loaders --- 
	
on LSM1_rollout open do 
	(
	getLSM()
	LSM_load.items = if LSM != undefined then LSM else #()
	if LSselect != undefined then 
		(
		LSM_delete.enabled = true
		LSM_save.enabled = true
		LSM_name.text = LSselect
		LSindex = finditem LSM LSselect
		LSM_load.selection = LSindex
		DisableSceneRedraw()
		getlayer_current()
		CurrentLayerRoll()
		SetLayer LSselect
		EnableSceneRedraw()
		RedrawViews()
		)
	else 
		(
		for o in objects do o.layer.ishidden = o.ishidden
		for o in objects do o.layer.isfrozen = o.isfrozen
		for o in objects do o.displayByLayer = true
		getlayer_current()
		CurrentLayerRoll()
		for i = 1 to LSMhidden.count do 
			(
			if LSMhidden[i] == false then 
				(
				LSMselobj LSMops[i]
				for obj in selection do obj.ishidden = false
				)	
			)
		if $ != undefined then deselect $		
		)	
	)
	
on LSM1_rollout close do
	(
	if PickAltMat_rollout != undefined then DestroyDialog PickAltMat_rollout
	if PickAltProp_rollout != undefined then DestroyDialog PickAltProp_rollout
	refresh()
	)
	
--- DropDownList Actions ---

on LSM_load selected i do
	(
	if LSM_load.selection != 0 then
		(
		LSselect = LSM_load.selected
		LSM_delete.enabled = true
		LSM_name.text = LSM_load.selected
		LSMsavename = LSM_load.selected
		LSM_save.enabled = true
		DisableSceneRedraw()
		SetLayer LSselect
		EnableSceneRedraw()
		RedrawViews()
		)
	)

--- Textbox Actions ---

on LSM_name changed txt do
	(
	if LSM_name.text != "" then
		(
		LSM_save.enabled = true
		LSMsavename = LSM_name.text
		) 
	else
		(
		LSM_save.enabled = false	
		)
	)
	
--- Button Actions ---
	
on LSM_delete pressed do
	(
	if querybox "Are you sure you want to do this?" title:"Please Confirm" then
		(
		delIniSetting LSdata LSM_load.selected
		GetLSM()
		LSM_load.items = LSM		
		)
	)
	
on LSM_save pressed do 
	(
	if findItem (getINIsetting LSdata) LSMsavename != 0 then
		(
		if querybox "Do you want to overwrite the previous saved Layer State?" title:"Please Confirm" then
			(
			delIniSetting LSdata LSMsavename
			SaveLayers LSMsavename
			GetLSM()
			LSM_load.items = LSM
			LSindex = finditem LSM LSMsavename
			LSM_load.selection = if LSindex != undefined then LSindex else 0			
			)
		) 
	else
		(
		saveLayers LSMsavename
		GetLSM()
		LSM_load.items = LSM
		LSindex = finditem LSM LSMsavename
		LSM_load.selection = if LSindex != undefined then LSindex else 0
		)
	)
)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Layer Management Rollout - Layers ---
---------------------------------------------------------------------------------------------------------------------------------------------

function CurrentLayerRoll = 
	(
	--- Begin Rollout Creator --- 	
	LSM2 = rolloutCreator "LSM2_rollout" "Layer States Settings"
	LSM2.begin()
	--- Button Image Definitions --- 
	LSM2.addLocal "btnfreeze" init:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_frz1, CGi_frz1, CGi_frz1, CGi_frz1)	
	LSM2.addLocal "btnmat" init:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_mat1, CGi_mat1, CGi_mat2, CGi_mat2)	
	LSM2.addLocal "btnedit" init:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_edt1, CGi_edt1, CGi_edt2, CGi_edt2)
	--- User Defined Layer Buttons --- 
	for i = 1 to LayerManager.count do
		(
		--- Layer Toggles ---
		LSM2.addLocal "hidestate" init:(LSMhidden[i] as booleanClass)
		LSM2.addControl #checkbutton (("layer" + ((i) as string))as name) (LSMname[i] as string) paramStr:"align:#left width:155 across:5 checked:(not hidestate)"
		LSM2.addHandler (("layer" + ((i) as string))as name) #changed paramStr:"theState" codeStr:("if theState == true then " + "LSunhide " + "@" + (LSMops[i]) + "@" + " else " + "LShide " + "@" + (LSMops[i]) + "@") filter:on
		--- Layer Freeze ---
		LSM2.addLocal "freezestate" init:(LSMfrozen[i] as booleanClass) 
		LSM2.addControl #checkbutton (("layer" + ((i) as string) + "_freeze") as name) "" paramStr:" offset:[100,0] images:btnfreeze checked:freezestate" 
		LSM2.addHandler (("layer" + ((i) as string) + "_freeze") as name) #changed paramStr:"theState" codeStr:("if theState == true then " + "LSfreeze " + "@" + (LSMops[i]) + "@" + " else " + "LSunfreeze " + "@" + (LSMops[i]) + "@") filter:on
		--- Layer Alternate Material ---
		LSM2.addLocal "altmatcheck" init:(if LSMaltmatcheck[i] == undefined then false else LSMaltmatcheck[i] as booleanClass)
		LSM2.addLocal "enabled" init:(if LSMsavename != "" then (if LSMaltmat[i] != "undefined" then true else false) else false)
		LSM2.addControl #checkbutton (("layer" + ((i) as string) + "_altmat") as name) "" paramStr:" offset:[75,0] images:btnmat enabled:enabled checked:altmatcheck" 
		LSM2.addHandler (("layer" + ((i) as string) + "_altmat") as name) #changed paramStr:"theState" codeStr:("if theState == true then " + "applyAM " + "((layermanager.getLayerFromName " + "@" + (LSMops[i]) + "@" + ").name) " + "else " + "if theState == false then " + "revertAM " + "((layermanager.getLayerFromName " + "@" + (LSMops[i]) + "@" + ").name)") filter:on
		--- Layer Alternate Property ---
		LSM2.addLocal "altpropcheck" init:(if LSMaltpropcheck[i] == undefined then false else LSMaltpropcheck[i] as booleanClass)
		LSM2.addLocal "enabled" init:(if LSMsavename != "" then (if LSMaltprop[i] != "undefined" then true else false) else false)
		LSM2.addControl #checkbutton (("layer" + ((i) as string) + "_altprop") as name) "" paramStr:" offset:[50,0] images:btnedit enabled:enabled checked:altpropcheck" 
		LSM2.addHandler (("layer" + ((i) as string) + "_altprop") as name) #changed paramStr:"theState" codeStr:("if theState == true then " + "applyAP " + "((layermanager.getLayerFromName " + "@" + (LSMops[i]) + "@" + ").name) " + "else " + "if theState == false then " + "revertAP " + "((layermanager.getLayerFromName " + "@" + (LSMops[i]) + "@" + ").name)") filter:on
		--- Layer Additional Options --- 
		LSM2.addControl #button (("layer" + ((i) as string) + "_popup") as name) ">" paramStr:" offset:[25,0] width:15" 
		LSM2.addHandler (("layer" + ((i) as string) + "_popup") as name) #pressed codeStr:("LSM_sub " + "((layermanager.getLayerFromName " + "@" + (LSMops[i]) + "@" + ").name)") filter:on
		)
	LSM2.end()
	addRollout LSM2.def LM_Floater
	LM_floater.size = [280,(LSM1_rollout.height + LSM2_rollout.height + 55)]
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Matte/Shadow/Reflection Controls Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

rollout MSR_rollout "Secondary Matte/Shadow/Reflection" category:3
	(
	checkbox MTenable "Select Objects to Affect:" align:#left offset:[0,5]
	dropDownList MTscene align:#left width:185 height:20 items:#() selection:0 across:2
	button MTdelete align:#right enabled:false images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_del1, CGi_del1, CGi_del2, CGi_del2) tooltip:"Delete Current Layer Set"	
	checkbox MORenable "Material Override:" align:#left across:2
	label MORcurrent align:#left enabled:false
	dropDownList MORload align:#left width:185 height:20 items:#() selection:0 across:2
	button MORget "Load Materials" align:#right offset:[0,-2] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_mat1, CGi_mat1, CGi_mat2, CGi_mat2) tooltip:"Load Materials"
	checkbox ALTenable "Alternate Properties:" align:#left 
	dropDownList ALTprop align:#left height:20 width:185 items:#() selection:0 across:2
	button ALTbuild "Build States" align:#right offset:[0,-2] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_edt1, CGi_edt1, CGi_edt2, CGi_edt2) tooltip:"Edit Alternate States"

	--- Rollout Variable Loaders --- 

on MSR_rollout open do
	(
	--- Matte Objects ---
	MTenable.checked = if MT1 != undefined then MT1 else false
	MTdelete.enabled = if MT1 != undefined then MT1 else false
	GetSS()
	MTscene.items = SS
	MTscene.enabled = if MT1 != undefined then MT1 else false
	if MTselect != undefined then MTindex = finditem SS MTselect
	MTscene.selection = if MTindex != undefined and MTscene.enabled == true then MTindex else 0
	--- Material Override ---
	MORenable.enabled = if MT1 != undefined then MT1 else false
	MORcurrent.enabled = if MT1 != undefined then MT1 else false
	MORenable.checked = if MT2 != undefined then MT2 else false
	MORget.enabled = if MT2 != undefined then MT2 else false
	MAT_home = MORpath
	GetML()
	MORcurrent.text = (filterString MAT_home "\\")[(filterString MAT_home "\\").count]
	MORload.items = ML
	MORload.enabled = if MT2 != undefined then MT2 else false
	if MORselect != undefined then MORindex = finditem ML MORselect
	MORload.selection = if MORindex != undefined and MORload.enabled == true then MORindex else 0
	--- Alternate Properties ---
	ALTenable.enabled = if MT1 != undefined then MT1 else false
	ALTenable.checked = if MT3 != undefined then MT3 else false
	ALTbuild.enabled = if MT3 != undefined then MT3 else false
	GetAPL()
	ALTprop.items = APL
	ALTprop.enabled = if MT3 != undefined then MT3 else false
	if ALTselect != undefined then ALTindex = finditem APL ALTselect
	ALTprop.selection = if ALTindex != undefined and ALTprop.enabled == true then ALTindex else 0
	)

--- Checkbox Actions --- 
	
on MTenable changed theState do
	(
	if theState == true then
		(
		MT1 = true
		refresh()
		) else (
		MT1 = false
		MT2 = false
		MT3 = false
		refresh()
		)
	) 	

on MORenable changed theState do
	(
	if theState == true then
		(
		MT2 = true
		refresh()
		) else (
		MT2 = false
		refresh()
		)
	)
	
on ALTenable changed theState do
	(
	if theState == true then
		(
		MT3 = true
		refresh()
		) else (
		MT3 = false
		refresh()
		)
	)	

--- DropDownList Actions --- 

on MORload selected i do
	(
	MORselect = ML[i]
	)

on MTscene selected i do
	(
	MTselect = MTscene.selected
	)

on ALTprop selected i do
	(
	ALTselect = ALTprop.selected
	)

--- Button Actions --- 

on MTdelete pressed do
	(
	if querybox "Are you sure you want to do this?" title:"Please Confirm" then
		(
		if MTselect != undefined then (deleteItem selectionSets MTselect) else (messagebox "Nothing Selected" title:"Cannot Comply" beep:true)
		GetSS()
		MTscene.items = SS
		MTscene.enabled = true
		MTscene.selection = 0
		)
	)
	
on MORget pressed do 
	(
	fileOpenMatLib()
	MAT_home = getMatLibFileName()
	MORpath = getMatLibFileName()
	GetML()
	MORcurrent.text = (filterString MAT_home "\\")[(filterString MAT_home "\\").count]
	MORload.items = ML
	)

on ALTbuild pressed do 
	(
	if AB_floater != undefined then CloseRolloutFloater AB_Floater
	AB_floater = newRolloutFloater "Alternate Properties Manager" 300 345
	addrollout ALTprop_rollout AB_floater
	)
)



---------------------------------------------------------------------------------------------------------------------------------------------
--- Build Alternate States Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

rollout ALTprop_rollout "Build Alternate States"
	(
	group "Load / Save Alternate States:" 
		(
		dropDownList ALTprop "Load Alternate Properties:" align:#left height:18 width:235 items:#() selection:0 offset:[0,3] across:2
		button ALTprop_delete "Delete" align:#right enabled:false offset:[0,20] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_del1, CGi_del1, CGi_del2, CGi_del2) tooltip:"Delete Alternate Property"	
		Label Label_SaveNew "Save New Alternate Property State:" align:#left offset:[0,3]
		edittext ALTprop_name fieldwidth:235 height:20 align:#left text:"" offset:[-5,3] across:2
		button ALTprop_save "Save" align:#right enabled:false offset:[0,3] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_sv1, CGi_sv1, CGi_sv2, CGi_sv2) tooltip:"Save Alternate Property"
		)
		
	group "Set Alternate Properties"
		(
		checkbox ALT_renderable "Renderable" align:#left 
		checkbox ALT_inheritVisibility "Inherit Visibility" align:#left 
		checkbox ALT_primaryVisibility "Visible to Camera" align:#left 
		checkbox ALT_secondaryVisibility "Visible to Relection/Refraction" align:#left 
		checkbox ALT_receiveshadows "Recieve Shadows" align:#left 
		checkbox ALT_castShadows "Cast Shadows" align:#left 
		checkbox ALT_applyAtmospherics "Apply Atmospherics" align:#left 
		checkbox ALT_renderOccluded "Render Occluded" align:#left 
		)
	
--- Rollout Variable Loaders --- 

on ALTprop_rollout open do
	(
	GetAPL()
	ALTprop.items = APL
	APLindex = finditem APL ALTselect
	ALTprop.selection = if APLindex != undefined then APLindex else 0
	ALTname = ALTprop.selected
	if ALTselect != undefined then
		(
		ALT_renderable.checked = if (getINISetting APdata ALTname "renderable") == "true" then true else false
		ALT_inheritVisibility.checked = if (getINISetting APdata ALTname "inheritVisibility") == "true" then true else false
		ALT_primaryVisibility.checked = if (getINISetting APdata ALTname "primaryVisibility") == "true" then true else false
		ALT_secondaryVisibility.checked = if (getINISetting APdata ALTname "secondaryVisibility") == "true" then true else false
		ALT_receiveshadows.checked = if (getINISetting APdata ALTname "receiveshadows") == "true" then true else false
		ALT_castShadows.checked = if (getINISetting APdata ALTname "castShadows") == "true" then true else false
		ALT_applyAtmospherics.checked = if (getINISetting APdata ALTname "applyAtmospherics") == "true" then true else false
		ALT_renderOccluded.checked = if (getINISetting APdata ALTname "renderOccluded") == "true" then true else false	
		ALTprop_delete.enabled = true
		ALTprop_save.enabled = true
		ALTprop_name.text = ALTname
		)
	)

on ALTprop_rollout close do
	(
	GetAPL()
	refresh()
	)

--- DropDownList Actions --- 

on ALTprop selected i do
	(
	ALTselect = i
	ALTname = ALTprop.selected
	ALTprop_name.text = ALTprop.selected
	ALTprop_delete.enabled = true
	ALTprop_save.enabled = true
	
	ALT_renderable.checked = if (getINISetting APdata ALTname "renderable") == "true" then true else false
	ALT_inheritVisibility.checked = if (getINISetting APdata ALTname "inheritVisibility") == "true" then true else false
	ALT_primaryVisibility.checked = if (getINISetting APdata ALTname "primaryVisibility") == "true" then true else false
	ALT_secondaryVisibility.checked = if (getINISetting APdata ALTname "secondaryVisibility") == "true" then true else false
	ALT_receiveshadows.checked = if (getINISetting APdata ALTname "receiveshadows") == "true" then true else false
	ALT_castShadows.checked = if (getINISetting APdata ALTname "castShadows") == "true" then true else false
	ALT_applyAtmospherics.checked = if (getINISetting APdata ALTname "applyAtmospherics") == "true" then true else false
	ALT_renderOccluded.checked = if (getINISetting APdata ALTname "renderOccluded") == "true" then true else false	
	)

	
--- Text Actions --- 

on ALTprop_name changed txt do
	(
	if ALTprop_name.text != "" then
		(
		ALTprop_save.enabled = true
		ALTname = ALTprop_name.text
		)
	)
	
--- Button Actions --- 

on ALTprop_delete pressed do 
	(
	delIniSetting APdata ALTname
	GetAPL()
	ALTprop.items = APL
	)
	
on ALTprop_save pressed do 
	(
	setINISetting APdata ALTname "renderable" (ALT_renderable.checked as string)
	setINISetting APdata ALTname "inheritVisibility" (ALT_inheritVisibility.checked as string)
	setINISetting APdata ALTname "primaryVisibility" (ALT_primaryVisibility.checked as string)
	setINISetting APdata ALTname "secondaryVisibility" (ALT_secondaryVisibility.checked as string)
	setINISetting APdata ALTname "receiveshadows" (ALT_receiveshadows.checked as string)
	setINISetting APdata ALTname "castShadows" (ALT_castShadows.checked as string)
	setINISetting APdata ALTname "applyAtmospherics" (ALT_applyAtmospherics.checked as string)
	setINISetting APdata ALTname "renderOccluded" (ALT_renderOccluded.checked as string)
	GetAPL()
	ALTprop.items = APL
	)
)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Renderer Settings Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

rollout Render_rollout "Render Setting Controls" category:4
	(
	group "Render Presets"
		(
		checkbox RPSenable "Load Render Preset:" align:#left offset:[0,5] across:2
		button RPSfile align:#right offset:[0,-2] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_edt1, CGi_edt1, CGi_edt2, CGi_edt2) tooltip:"Get Render Preset Path"
		dropDownList RPSload align:#center height:20 items:#() selection:0  
		)
	group "Render Options"
		(
		checkbox envEnable "Load Environment Map" align:#left checked:true
		checkbox atmosEnable "Render Atmospherics" align:#left checked:true
		checkbox effEnable "Render Effects" align:#left checked:true
		)

--- Rollout Variable Loaders --- 

on Render_rollout open do
	(
	GetRPS()
	--- Render Presets ---
	RPSenable.checked = if RPS1 != undefined then RPS1 else false
	RPSfile.enabled = if RPS1 != undefined then RPS1 else false
	RPSload.items = RPS 
	RPSload.enabled = if RPS1 != undefined then RPS1 else false
	if RPSselect != undefined then RPSindex = finditem RPS RPSselect
	RPSload.selection = if RPSindex != undefined then RPSindex else 0
	--- Render Options --- 
	envEnable.checked = if RPO1 != undefined then RPO1 else true
	atmosEnable.checked = if RPO2 != undefined then RPO2 else true
	effEnable.checked = if RPO3 != undefined then RPO3 else true
	)

		
--- DropDownList Actions --- 
		
on RPSload selected i do
	(
	if RPSload.selection != 0 then 
		(
		RPSselect = RPSload.selected
		RPSfile.enabled = true
		RPSload.enabled = true
		) else (
		RPSselect = undefined
		RPSfile.enabled = false
		RPSload.enabled = false
		)
	)

--- Checkbox Actions --- 	
		
on RPSenable changed theState do
	(
	if theState == true then
		(
		RPS1 = true
		RPSload.enabled = true
		RPSfile.enabled = true
		RPSload.selection = 1
		RPSindex = 1
		) else (
		RPS1 = false
		RPSload.enabled = false
		RPSfile.enabled = false
		RPSload.selection = 0
		RPSindex = 0
		)
	)
	
on envEnable changed theState do
	(
	if theState == true then (RPO1 = true) else (RPO1 = false)
	)

on atmosEnable changed theState do
	(
	if theState == true then (RPO2 = true) else (RPO2 = false)
	)
	
on effEnable changed theState do
	(
	if theState == true then (RPO3 = true) else (RPO3 = false)
	)
	
--- Button Actions --- 	

on RPSfile pressed do 
	(
	RPS_home = getSavePath caption:"Select Render Presets Folder:"
	GetRPS()
	RPSload.items = RPS 
	)
)

---------------------------------------------------------------------------------------------------------------------------------------------
--- About PassMonkey Rollout --- 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout PMabout_rollout "About PassMonkey" category:5
(
group "About..."
	(
	label labelss01 "Pass Monkey"
	label labelss02 "Version 1.8 - 06.13.05"
	label labelss03 "by Paolo Hilario"
	hyperLink cgsoldier_link "CGsoldier Website" color:(color 255 180 75) hoverColor:(color 255 75 75) address:"http://www.cgsoldier.com" align:#center
	)
)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Main PassMonkey Rollout --- 
---------------------------------------------------------------------------------------------------------------------------------------------


rollout PM_rollout "Pass Monkey v2.0" category:1
	(
	bitmap PMicon "Bitmap" align:#center fileName:"$userscripts/CGsoldier/images/passmonkey.bmp"
	button PMsetscene "Set Scene" align:#center width:90 height:20	offset:[-5,5] across:2
	button PMtestrender "Test Render" align:#center width:90 height:20 offset:[5,5]
		
	group ""
		(
		dropDownList PMloadscene "Load Saved Passes:" align:#left height:18 width:190 items:#() selection:0 offset:[-3,0] across:2
		button PMscene_delete "Delete" align:#right enabled:false offset:[3,17] images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_del1, CGi_del1, CGi_del2, CGi_del2) tooltip:"Delete Saved Pass"	
		edittext PMsave_name "Save New Pass:" width:190 height:20 align:#left offset:[-3,0] across:2 labelontop:true
		button PMsavescene "Save Pass" align:#right height:20 offset:[3,18] enabled:false images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", CGi_cnt, CGi_sv1, CGi_sv1, CGi_sv2, CGi_sv2) tooltip:"Save Render Pass"
		)

		
--- Rollout Actions --- 

on PM_rollout open do
	(
	GetSP()
	PMloadscene.items = SP
	DisableSceneRedraw()
	RevertAll()
	BackupScene()
	EnableSceneRedraw()
	RedrawViews()	
	)


on PM_rollout close do
	(
	disablesceneredraw()
	RevertAll()
	BackupScene()
	if LM_Floater != undefined then closeRolloutFloater LM_Floater
	RPS_home = undefined
	enablesceneredraw()
	RedrawViews()
	)
	
on PM_rollout moved position do
	(
	PMpos = position
	setINISetting "$maxdata\\CGsoldier.ini" "PassMonkey" "FloaterX"  (( PMpos.x ) as String)
	setINISetting "$maxdata\\CGsoldier.ini" "PassMonkey" "FloaterY"  (( PMpos.y ) as String) 
	)
	
--- DropDownList Actions --- 
		
on PMloadscene selected i do
	(
	if PMloadscene.selection != 0 then 
		(
		PMload = PMloadscene.items[i]
		PMscene_delete.enabled = true
		PMsave_name.text = PMloadscene.items[i]
		PMname = PMloadscene.items[i]
		PMsavescene.enabled = true
		GetINI()
		refresh()
		)
	else
		(
		PMload = undefined
		PMscene_delete.enabled = false
		)
	)		

--- Text Actions --- 

on PMsave_name changed txt do
	(
	if PMsave_name.text != "" then
		(
		PMname = PMsave_name.text 
		PMsavescene.enabled = true
		) 
	else 
		(
		PMname = undefined 
		PMsavescene.enabled = false
		)
	)

--- Button Actions --- 

on PMsetscene pressed do
	(
	if passmode == 1 and SSselect != undefined then 
		(
		disablesceneredraw()
		CheckRenderDialog() 
		SetScene PMload
		SetMatteObj PMload
		SetRenderSettings PMload
		if CRDstate == true then renderSceneDialog.open()
		refresh()
		enablesceneredraw()
		redrawviews() 
		)
	else if passmode == 1 and SSselect == undefined then messagebox "Select a Selection Set to Load"
	
	
	if passmode == 2 and LSselect != undefined then 
		(
		disablesceneredraw()
		CheckRenderDialog()
		SetLayer LSselect
		SetCL LSCLselect
		SetMatteObj PMload 
		SetRenderSettings PMload
		if CRDstate == true then renderSceneDialog.open()
		enablesceneredraw() 
		redrawviews()
		)
	else if passmode == 2 and LSselect == undefined then messagebox "Select a Layer State to Load"
	
	)


on PMscene_delete pressed do
	(
	if querybox "Are you sure you want to do this?" title:"Please Confirm" then
		(
		delIniSetting RMdata PMloadscene.selected
		GetSP()
		PMloadscene.items = SP
		)
	)	

on PMsavescene pressed do
	(
	if (PassMode == 1 and SSselect == undefined) then messagebox "Please Choose Selection Set" 
	
	if (PassMode == 2 and LSselect == undefined) then messagebox "Please Choose Layer State" 

	if (PassMode == 1 and SSselect != undefined) or (PassMode == 2 and LSselect != undefined) then 
		(
		if findItem (getINIsetting RMdata) PMname != 0 then
			(
			if querybox "Do you want to overwrite the previous saved pass?" title:"Please Confirm" then
				(
				delIniSetting RMdata PMname
				SetINI()
				GetSP()
				PMloadscene.items = SP
				PMindex = finditem SP PMname
				PMloadscene.selection = if PMindex != undefined then PMindex else 0	
				)
			) 
		else
			(
			SetINI()
			GetSP()
			PMloadscene.items = SP
			PMindex = finditem SP PMname
			PMloadscene.selection = if PMindex != undefined then PMindex else 0	
			)
		)
	)
	
on PMtestrender pressed do
	(
	render frame:#current vfb:true progressbar:true	
	)

)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Build PassMonkey Rollout --- 
---------------------------------------------------------------------------------------------------------------------------------------------

(
if PM_Floater != undefined then CloseRolloutFloater PM_Floater

if RMexists.count == 0 then 
	(
	if queryBox "Pass Monkey requires a sub directory in the current file path to collect Render Monkey data.\nWould you like to create this directory and launch Pass Monkey?" title:"Pass Monkey Error" then
		(
		makedir (maxfilepath + "RM-DATA")
		
		if  (( FLy == 0 )) then
			 	( 
				PM_Floater = newRolloutFloater "Pass Monkey v1.9" 250 425
				addRollout PM_rollout PM_Floater
				addRollout Pass_rollout PM_Floater rolledup:true
				addRollout Render_rollout PM_Floater rolledup:true
				addRollout MSR_rollout PM_floater rolledup:true
				addRollout PMabout_rollout PM_floater rolledup:true
				) 
			else
				(
				PM_Floater = newRolloutFloater "Pass Monkey v1.9" 250 425 FLx FLy
				addRollout PM_rollout PM_Floater
				addRollout Pass_rollout PM_Floater rolledup:true
				addRollout Render_rollout PM_Floater rolledup:true
				addRollout MSR_rollout PM_floater rolledup:true
				addRollout PMabout_rollout PM_floater rolledup:true
				)
			)	
		) 
	else
		(
		if  (( FLy == 0 )) then
		 	( 
			PM_Floater = newRolloutFloater "Pass Monkey v1.9" 250 425
			addRollout PM_rollout PM_Floater
			addRollout Pass_rollout PM_Floater rolledup:true
			addRollout Render_rollout PM_Floater rolledup:true
			addRollout MSR_rollout PM_floater rolledup:true
			addRollout PMabout_rollout PM_floater rolledup:true
			) 
		else
			(
			PM_Floater = newRolloutFloater "Pass Monkey v1.9" 250 425 FLx FLy
			addRollout PM_rollout PM_Floater
			addRollout Pass_rollout PM_Floater rolledup:true
			addRollout Render_rollout PM_Floater rolledup:true
			addRollout MSR_rollout PM_floater rolledup:true
			addRollout PMabout_rollout PM_floater rolledup:true
			)
		)
	)
)