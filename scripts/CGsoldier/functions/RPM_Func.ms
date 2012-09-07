----------------------------------------------------------
----------------------------------------------------------
------ Render & Pass Monkey Functions v1.0 beta		------
------ By Paolo Hilario (CGsoldier@gmail.com)		------
------ Created 04.22.05								------
------ Headrick & Associates						------
----------------------------------------------------------
----------------------------------------------------------

--- Global Variables ---

global KillLights 
global SetLights
global SetCameraView
global SelectZEM
global SetZEM

global SS
global SSMT
global RPS
global RPS_home

global AXListView
global AXListUpdate
global INIFILEpath
global INIFILE

--- Set Scene Functions ---

fn KillLights =
	(
	for obj in lights do
		(
		if iskindof obj light do
		obj.on = false
		)
	)

fn SetLights =
	(
	for obj in selection do
		(
		if iskindof obj light then 
		obj.on = true
		)
	)

fn SetCameraView =
	(
	setselectfilter 5
	max select all
		(
		for obj in selection do
		if iskindof obj camera then
		select obj
		viewport.SetCamera$
		)
	setselectfilter 1
	)
	
fn SelectZEM = 
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
			
			
fn SetZEM = 
	(
	SelectZEM()
		(	
		if selection.count > 1 then
			(
			if queryBox "Too Many ZEM objects in Scene!\nDo you want to fix that?" title:"Pass Monkey Error" beep:true then
			macros.run "Edit" "namedSelSets"
			)
		else
		if selection.count == 0 or $ == undefined then
			(
			if environmentMap != undefined then
			environmentMap = undefined
			)
		else
		if selection.count == 1 then
			(
			environmentMap = $.material.diffuseMap
			)	
		)
	)
	
--- Scene Functions ---

fn GetSelSets = 
	(
	SS = #()
	for i = 1 to selectionsets.count do
		 (
		 if (substring (getnamedSelSetname i) 1 2 != "MT") and (substring (getnamedSelSetname i) 1 2 != "LT") then
		 SS[i] = (getnamedSelSetname i)
		 )
	)
	
fn GetSelSetsMT = 
	(
	SSMT = #()
	for i = 1 to selectionsets.count do
		(
		if substring (getnamedSelSetname i) 1 2 == "MT" then
		SSMT[i] = getnamedSelSetname i
		for i = 1 to SSMT.count do 
		if findItem SSMT undefined == 1 then 
		deleteItem SSMT 1
		)
		insertItem "NONE" SSMT 1
	)
	

fn GetRenderPresets =
	(
	RPS = #()
	RPS_home = ((getDir #maxroot) + "\\renderpresets\\")
	RPS_files = getFiles (RPS_home + "*.rps")
	(
	if RPS_files.count != 0 then
		(
		for i = 1 to RPS_files.count do
			(
			RPS[i] = (filenameFromPath RPS_files[i])
			)
		)
	)
)

--- Active X Functions ---

fn AXListView lv =
	(
	lv.gridLines = true  
	lv.View = #lvwReport  
	lv.fullRowSelect = true 
	lv.AllowColumnReorder = true
	lv.Checkboxes = true
	lv.Backcolor = color 225 215 210
	lv.sorted = true
	
	layout_def = #("Pass Name","Scene","Output","Render Size","Frames","Render Preset","Matte Objects","Other States")
	
	for i in layout_def do
		(
		column = lv.ColumnHeaders.add() 
		column.text = I
		) 
	) 
	
fn AXListUpdate lv =
	(
	lv.ListItems.clear()
	INIFILE=#()
	INIFILEpath = (maxfilepath + "RM-DATA\\" + "RMdata.ini")
	INIFILE = getINIsetting INIFILEpath
	
	for i = 1 to INIFILE.count do
		(
		li = lv.ListItems.add()
		li.text = (INIFILE[i]) as string
		li.ToolTipText = (getINISetting INIFILEpath (INIFILE[i] as string) "RMpassnotes") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting INIFILEpath (INIFILE[i] as string) "RMscene") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting INIFILEpath (INIFILE[i] as string) "RMoutput") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = ((getINISetting INIFILEpath (INIFILE[i] as string) "RMrenderWidth") + " x " + (getINISetting INIFILEpath (INIFILE[i] as string) "RMrenderHeight")) as string
		sub_li = li.ListSubItems.add()
		sub_li.text = ((getINISetting INIFILEpath (INIFILE[i] as string) "RMrendStart") + " - " + (getINISetting INIFILEpath (INIFILE[i] as string) "RMrendEnd")) as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting INIFILEpath (INIFILE[i] as string) "RMrenderpreset") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting INIFILEpath (INIFILE[i] as string) "RMmatte") as string
		sub_li = li.ListSubItems.add()
		sub_li.text = (getINISetting INIFILEpath (INIFILE[i] as string) "RMmatte_aa") as string
		)
	) 

	
--- Initialization End ---

Print "RPM Functions Loaded"

