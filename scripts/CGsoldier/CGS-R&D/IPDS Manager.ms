-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--- BIM Monkey 3D v1.0 beta
--- Written for Scenario Design, Inc. 
--- By Paolo Hilario				
--- http://www.cgsoldier.com	
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
--
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-------------------------------------------------------------------------------

(	--Begin Script
---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
	global SDBIM_MM_Rollout
	global SDBIM_PA_Rollout
	global SDBIM_BA_Rollout
	global SDBIM_RPT_Rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
	local SDBIM_Version = "IPDS Manager v1.0 Beta"	

	--- Script Local Functions --- 
	
	local ClearDialogs	
	local SetDialog
	local GetDialogSet

	--- Dialog Window Position --- 
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterY") as integer)
	local FLw = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterW") as integer)
	local FLh = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterH") as integer)
	local LastMenu = (getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "LastMenu")
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	FileIn "$userscripts\CGsoldier\functions\CGS_func.mse"
	
	if SDBIM_MM_Rollout != undefined then destroyDialog SDBIM_MM_Rollout
	if SDBIM_PA_Rollout != undefined then destroyDialog SDBIM_PA_Rollout
	if SDBIM_BA_Rollout != undefined then destroyDialog SDBIM_BA_Rollout
	if SDBIM_RPT_Rollout != undefined then destroyDialog SDBIM_RPT_Rollout
	if SDBIM_UTL_Rollout != undefined then destroyDialog SDBIM_UTL_Rollout

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	
	
	--- Window Memory Function ---
	
	fn ClearDialogs = 
		(
		if SDBIM_MM_Rollout != undefined then destroyDialog SDBIM_MM_Rollout
		if SDBIM_PA_Rollout != undefined then destroyDialog SDBIM_PA_Rollout
		if SDBIM_BA_Rollout != undefined then destroyDialog SDBIM_BA_Rollout
		if SDBIM_RPT_Rollout != undefined then destroyDialog SDBIM_RPT_Rollout
		if SDBIM_UTL_Rollout != undefined then destroyDialog SDBIM_UTL_Rollout
		)

	fn SetDialog X =
		(
		Dpos = GetDialogPos X
		Dsize = getDialogSize X	
		setINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterX"  (( Dpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterY"  (( Dpos.y ) as String)
		setINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterW"  (( Dsize.x ) as String)
		setINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterH"  (( Dsize.y ) as String)
		setINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "LastMenu"  X.name 
		)
		
		fn GetDialogSet =
		(
		FLx = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterX") as integer)
		FLy = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterY") as integer)
		FLw = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterW") as integer)
		FLh = ((getINISetting "$UI\\Macroscripts\\SDBIM.ini" "BIM Monkey" "FloaterH") as integer)
		)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- BIM Monkey Main Splash Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout SDBIM_MM_Rollout (SDBIM_Version + " - Main Menu") 
	(
	bitmap RMicon filename:"$userscripts\\CGsoldier\\images\\BIMmonkey.bmp" align:#center offset:[0,10]
	
	--- Dialog Actions --- 
	
	on SDBIM_MM_Rollout open do
		(
		SetDialog SDBIM_MM_Rollout
		)
		
	on SDBIM_MM_Rollout moved position do
		(
		SetDialog SDBIM_MM_Rollout
		)
	
	on SDBIM_MM_Rollout close do
		(
		SetDialog SDBIM_MM_Rollout
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- BIM Monkey Create Panel Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout SDBIM_PA_Rollout (SDBIM_Version + " - Project Assumptions") 
	(
	groupBox grp1 "Type Of Surfaces" pos:[10,11] width:375 height:50
	checkbox chk1 "Closed Surfaces" pos:[20,33] width:106 height:16
	checkbox chk2 "Swap U,V Parametrization" pos:[133,33] width:145 height:16
		
	groupBox grp2 "Panelization" pos:[10,65] width:375 height:205
	checkbox chk3 "Divide Surface Into Panels" pos:[20,90] width:186 height:16		
	checkbox chk4 "Automatically Determine Number of Panels in X-Direction:" pos:[20,115] width:322 height:16
	label lbl2 "Number of Panels in X-Direction:" pos:[20,140] width:181 height:16	
	spinner spn3 "" pos:[295,140] width:80 height:16 range:[0,100,0] type:#integer scale:1
	label lbl5 "Optimal Panel Width (in):" pos:[20,240] width:181 height:16
	spinner spn4 "" pos:[295,165] width:80 height:16 range:[0,100,0] type:#float scale:1
	checkbox chk5 "Automatically Determine Number of Panels in Z-Direction:" pos:[20,190] width:322 height:16
	label lbl4 "Number of Panels in Y-Direction:" pos:[20,215] width:181 height:16
	spinner spn5 "" pos:[295,215] width:80 height:16 range:[0,100,0] type:#integer scale:1
	label lbl3 "Optimal Panel Width (in):" pos:[20,165] width:181 height:16
	spinner spn6 "" pos:[295,240] width:80 height:16 range:[0,100,0] type:#float scale:1
		
	groupBox grp3 "Wire Dimensions" pos:[10,275] width:375 height:225
	radioButtons rdo1 "" pos:[20,300] width:184 height:16 labels:#("Single Bar", "Multi Bar Quadrants") columns:2
	label lbl11 "Offset (in):" pos:[20,330] width:181 height:16	
	spinner spn7 "" pos:[295,330] width:80 height:16 range:[0,100,0] type:#float scale:1
	label lbl7 "Optimal Wire Spacing (in):" pos:[20,355] width:181 height:16
	spinner spn9 "" pos:[294,355] width:80 height:16 range:[0,100,0] type:#float scale:1
	label lbl8 "Optimal Minimum Bend Spacing (in):" pos:[20,380] width:181 height:16
	spinner spn10 "" pos:[294,380] width:80 height:16 range:[0,100,0] type:#float scale:1
	label lbl9 "Edge Gap (in):" pos:[20,405] width:181 height:16
	spinner spn11 "" pos:[294,405] width:80 height:16 range:[0,100,0] type:#float scale:1
	checkbox chk6 "Simplify Wires (Remove Unncessary Bends)" pos:[20,441] width:233 height:16
	label lbl6 "Simplification Tolerance (in):" pos:[20,470] width:181 height:16
	spinner spn8 "" pos:[295,470] width:80 height:16 range:[0,100,0] type:#float scale:1
	
	groupBox grp4 "Draw Wire Web" pos:[393,11] width:375 height:50
	checkbox chk7 "Draw Wire Web" pos:[402,33] width:110 height:16	
	checkbox chk8 "Draw Panel Boundaries" pos:[510,33] width:133 height:16

	groupBox grp5 "XYZ File Export" pos:[393,65] width:375 height:80
	checkbox chk9 "Export XYZ Files" pos:[402,87] width:101 height:16
	editText edt1 "Folder: " pos:[402,113] width:335 height:16
	button btn1 "Button" pos:[742,111] width:20 height:20 images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", 11, 7, 7, 8, 8) tooltip:"Browse Folder"

	groupBox grp6 "DT6 File Export" pos:[393,150] width:375 height:130
	checkbox chk10 "Export DT6 Files" pos:[402,172] width:101 height:16
	editText edt5 "Folder: " pos:[402,198] width:335 height:16
	button btn5 "Button" pos:[742,196] width:20 height:20 images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", 11, 7, 7, 8, 8) tooltip:"Browse Folder"
	label lbl10 "DT6 Reference File:" pos:[402,226] width:181 height:16
	editText edt6 "Folder: " pos:[402,250] width:335 height:16
	button btn6 "Button" pos:[742,248] width:20 height:20 images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", 11, 7, 7, 8, 8) tooltip:"Browse Folder"
	
	groupBox grp7 "Excel Spreadsheet Inventory" pos:[393,285] width:375 height:80
	checkbox chk11 "Export Inventory Data" pos:[403,307] width:136 height:16
	editText edt3 "Folder: " pos:[403,333] width:335 height:16
	button btn3 "Button" pos:[743,331] width:20 height:20 images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", 11, 7, 7, 8, 8) tooltip:"Browse Folder"
	
	groupBox grp8 "POV-Ray Include Files" pos:[393,370] width:375 height:80
	checkbox chk12 "Export POV-Ray Include Files" pos:[402,392] width:177 height:16
	editText edt4 "Folder: " pos:[402,418] width:335 height:16
	button btn4 "Button" pos:[742,416] width:20 height:20 images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", 11, 7, 7, 8, 8) tooltip:"Browse Folder"
	
	button btn16 "Create Panels" pos:[393,460] width:375 height:40 
	
		
		
	on SDBIM_PA_Rollout open do
		(
		SetDialog SDBIM_PA_Rollout
		)
		
	on SDBIM_PA_Rollout moved position do
		(
		SetDialog SDBIM_PA_Rollout
		)
		
	on SDBIM_PA_Rollout close do
		(
		SetDialog SDBIM_PA_Rollout
		)
	)
	
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- BIM Monkey Panel Editor Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout SDBIM_BA_Rollout (SDBIM_Version + " - Budget Analysis") 
	(
-- 	dotNetControl eSheet "Excel.sheet" height:470 width:740 align:#center offset:[0,10]
	dotNetControl eSheet "Webbrowser" height:470 width:740 align:#center offset:[0,10]
-- 	activeXControl ax "I:\PROGRAMMING\MAXnet\MAX 2008\scripts\CGsoldier\Script R&D\excel_table-test\Book1.xls" height:470 width:740 align:#center offset:[0,10]
--	xl = createOLEObject "Excel.Chart"
-- 	dotNetControl eSheet "Microsoft.Office.Tools" height:470 width:740 offset:[0,10]
-- 	dotNetControl eChart "Microsoft.Office.Tools.Excel.ListObject" 
	
	--- General Rollout Actions ---		
		
	on SDBIM_BA_Rollout open do
		(
		showproperties eSheet
		showmethods esheet
		esheet.navigate "G:\PROGRAMMING\MAXnet\MAX 2008\scripts\CGsoldier\Script R&D\excel_table-test\Book1.htm"
		PMsize = getDialogSize SDBIM_BA_Rollout
		SetDialog SDBIM_BA_Rollout
		)
	
	on SDBIM_BA_Rollout moved position do
		(
		SetDialog SDBIM_BA_Rollout
		)
		
	on SDBIM_BA_Rollout close do
		(
		SetDialog SDBIM_BA_Rollout
		)
		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- BIM Monkey Wire Editor Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout SDBIM_RPT_rollout (SDBIM_Version + " - Reports")  
	(
	groupbox gb1 "Data Filters" pos:[15,15] width:260 height:220
	radiobuttons rb1 "Condense By:" labels:#("None", "Vendor Parts","Instances") pos:[30,35] default:2
	checkbox cb1 "Exclude Group Sub-Objects" checked:true pos:[30,70]
	
-- 	checkbox cb2 "Condense Instanced Objects" checked:true pos:[30,55]
-- 	checkbox cb4 "Condense By Vendor Part No." checked:true pos:[30,75]
	checkbox cb3 "Filter By Object Type" checked:false pos:[30,90]
	MultiListBox mlb1 "Object Types: (CTRL + Left Click)" pos:[30,110]  width:230 height:7 labelontop:true items:name_array enabled:false
		
	groupbox gb2 "Report Presets:" pos:[295,15] width:260 height:220
	ListBox lb1 "" pos:[310,40] width:230 height:9 labelontop:true items:#("Comprehensive", "Budget Report","Schedule Report","E.M.S. Report")
	button btn1 "REFRESH DATA" width:230 height:40 pos:[310,180] 
	
	groupbox gb3 "Export Reports" pos:[575,15] width:210 height:220
	dropdownlist dd1 "Data Format:" pos:[590,50] width: 180 height:30 labelontop:true items:#("SDBIM Server", "Excel Spreadsheet", "Primavera", "Microsoft Project", "CSV File", "Text File")
	dropdownlist dd2 "Data Set:" pos:[590,100] width: 180 height:30 labelontop:true items:#("Complete BIM", "Schedule", "Budget", "EMS") enabled:false
	checkbox cb5 "Use Current Data Table Layout" checked:true pos:[590,155] 
	button btn2 "EXPORT DATA" pos:[590,190] width:180  height:30
	
	dotNetControl lv "System.Windows.Forms.ListView" pos:[10,250]
		
	--- Initial Object Set --- 
		
	local objset = #()
		
	--- Interface Actions ---
	
	on cb3 changed state do 
		(
		if cb3.checked == true then mlb1.enabled = true else mlb1.enabled = false
		)
	
	on btn1 pressed do 
		(
		types = (BitToString mlb1.selection prefix_array)
		objset = object_filter rb1.state cb1.checked cb3.checked types
 		lv.clear()
		BIMListView lv lb1.selection
 		BIMListUpdate lv rb1.state lb1.selection objset 
		)
		
	on btn2 pressed do 
		(
		case dd1.selection of 
			(
			1:()
			2:(xl_export false lv lb1.selected)
			3:()
			4:()
			5:()
			6:()
			)
		)
	
	--- Dotnet Table Actions ---
		
	on lv ColumnClick x do
		(
		print x.column
		lv.sort()
		)

	--- General Rollout Actions ---
	
	on SDBIM_RPT_Rollout open do
		(
		types = (BitToString mlb1.selection prefix_array)
		objset = object_filter rb1.state cb1.checked cb3.checked types
		BIMListView lv lb1.selection
 		BIMListUpdate lv rb1.state lb1.selection objset
		PMsize = getDialogSize SDBIM_RPT_Rollout
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 25 as integer) (PMsize.y - 270 as integer)
		SetDialog SDBIM_RPT_Rollout
		print mlb1.selection
		)
		
	on SDBIM_RPT_Rollout close do
		(
		SetDialog SDBIM_RPT_Rollout
		)
			
	on SDBIM_RPT_Rollout moved position do
		(
		SetDialog SDBIM_RPT_Rollout
		)
	
	on SDBIM_RPT_Rollout resized size do
		(
		PMsize = size
		SetDialog SDBIM_RPT_Rollout
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 25 as integer) (PMsize.y - 270 as integer)
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- BIM Monkey Panel Editor Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout SDBIM_UTL_rollout (SDBIM_Version + " - Utilities") 
	(
		
		
	on SDBIM_UTL_Rollout open do
		(
		SetDialog SDBIM_UTL_Rollout
		)
		
	on SDBIM_UTL_Rollout moved position do
		(
		SetDialog SDBIM_UTL_Rollout
		)
		
	on SDBIM_UTL_Rollout close do
		(
		SetDialog SDBIM_UTL_Rollout
		)
	
	--- Button Actions ---	
		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Define Submenus for Main RenderMonkey Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

RCMenu SDBIM_RCmenu
	(
	menuItem MM "Main"
	menuItem PA "Project Assumptions"
	menuItem BA "Budget Analysis"
	menuItem RPT "Reports"

	Submenu "Utilities"
		(
		menuItem OBJ_BIM "Object BIM Tool"
		)	
	Submenu "Help"
		(
		menuItem About_BIM "About BIM Monkey3D"
		menuItem Help_BIM "Help Manual"
		menuItem WebHelp_BIM "Help on Web"
		)
		
	on MM picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog SDBIM_MM_Rollout 450 350 FLx FLy menu:SDBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on PA picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog SDBIM_PA_Rollout 775 515 FLx FLy menu:SDBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on BA picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog SDBIM_BA_Rollout 775 500 FLx FLy menu:SDBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on RPT picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog SDBIM_RPT_Rollout 800 900 FLx FLy menu:SDBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
		)
			
	on OBJ_BIM picked do (FileIn "$userscripts\\CGsoldier\\CGS-SceneTools\\IPDS Object.mse")
	on About_BIM picked do ()
	on Help_BIM picked do ()
	on WebHelp_BIM picked do ()
	)
---------------------------------------------------------------------------------------------------------------------------------------------
--- Create Initial BIM Monkey Dialog
---------------------------------------------------------------------------------------------------------------------------------------------
	(
	if LastMenu != "" then 
		(
		ClearDialogs()
		createDialog (execute LastMenu) FLw FLh FLx FLy menu:SDBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
		)
	else
		(
		ClearDialogs()
		createDialog SDBIM_MM_Rollout 440 320 FLx FLy menu:SDBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
		)
	)
)	-- End Script


