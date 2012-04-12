-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--- WireWorks 3D v1.0 beta		
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

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	(
	--- Script Local Functions --- 
	
	local WW3D_Version = "Wire Works 3D v1.0 Beta"	

	--- Dialog Window Position --- 
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterY") as integer)
	local FLw = ((getINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterW") as integer)
	local FLh = ((getINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterH") as integer)
	local LastMenu = (getINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "LastMenu")
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
--	include "U:\\WireWorks3D\\3DS Max\\Library.ms"

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	
	
	--- Window Memory Function ---
	
	local ClearDialogs;
	fn ClearDialogs = 
		(
		if WW3D_Main_Rollout != undefined then destroyDialog WW3D_Main_Rollout
		if WW3D_CP_Rollout != undefined then destroyDialog WW3D_CP_Rollout
		if WW3D_PE_Rollout != undefined then destroyDialog WW3D_PE_Rollout
		if WW3D_WE_rollout != undefined then destroyDialog WW3D_WE_rollout
		if WW3D_Util_rollout != undefined then destroyDialog WW3D_Util_rollout
		)

	local SetDialog;
	fn SetDialog X =
		(
		PMpos = getDialogPos X
		PMsize = getDialogSize X	
		setINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterX"  (( PMpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterY"  (( PMpos.y ) as String)
		setINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterW"  (( PMsize.x ) as String)
		setINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "FloaterH"  (( PMsize.y ) as String)
		setINISetting "$UI\\Macroscripts\\WW3D.ini" "WireWorks" "LastMenu"  X.name 
		)
	
	--- Active X List Builder ---
	
	local WWListView;
	fn WWListView lv =
		(
		lv.gridLines = true  
		lv.View = (dotNetClass "System.Windows.Forms.View").Details  
		lv.fullRowSelect = true 
		lv.AllowColumnReorder = true
		lv.Checkboxes = true
	
		layout_def = #("Step","Length", "Angle", "Flags", "X", "Y","Z")
		layout_width = #(120,120,120,120,90,90,90)

		for i=1 to layout_def.count do
			lv.Columns.add layout_def[i] layout_width[i]	
		) 
		
	local WWListUpdate;
	fn WWListUpdate lv =
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
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- WireWorks3D Main Splash Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
global WW3D_Main_Rollout;
rollout WW3D_Main_Rollout (WW3D_Version + " - Main Menu") 
	(
	bitmap RMicon filename:"$userscripts\\WireWorks3D\\Splash.jpg" align:#center offset:[0,10]
	
		--- Dialog Actions --- 
	
	on WW3D_Main_Rollout open do
		(
		SetDialog WW3D_Main_Rollout
		)
		
	on WW3D_Main_Rollout moved position do
		(
		SetDialog WW3D_Main_Rollout
		)
	
	on WW3D_Main_Rollout close do
		(
		SetDialog WW3D_Main_Rollout
		)
			
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- WireWorks3D Create Panel Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
global WW3D_CP_Rollout;	
rollout WW3D_CP_Rollout (WW3D_Version + " - Create Panels") 
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
	
		
		
	on WW3D_CP_Rollout open do
		(
		SetDialog WW3D_PE_Rollout
		)
		
	on WW3D_CP_Rollout moved position do
		(
		SetDialog WW3D_CP_Rollout
		)
		
	on WW3D_CP_Rollout close do
		(
		SetDialog WW3D_CP_Rollout
		)
	)
	
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- WireWorks3D Panel Editor Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
global WW3D_PE_Rollout;	
rollout WW3D_PE_Rollout (WW3D_Version + " - Panel Editor") 
	(
		
		
	on WW3D_PE_Rollout open do
		(
		SetDialog WW3D_PE_Rollout
		)
	
	on WW3D_PE_Rollout moved position do
		(
		SetDialog WW3D_PE_Rollout
		)
		
	on WW3D_PE_Rollout close do
		(
		SetDialog WW3D_PE_Rollout
		)
		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- WireWorks3D Wire Editor Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
global WW3D_WE_rollout;	
rollout WW3D_WE_rollout (WW3D_Version + " - Wire Editor")  
	(
	button XYZ_Import "Import XYZ" align:#left offset:[0,10] width:180 height:30 across:4
	button DT6_Import "Import DT6" align:#left offset:[0,10] width:180  height:30
	button Read_Wire "Read Spline" align:#left offset:[0,10] width:180  height:30		
	button Pre_Viz "Preview Animation" align:#left offset:[0,10] width:180  height:30
	button XYZ_Export "Export XYZ" align:#left offset:[0,10] width:180  height:30 across:4
	button DT6_Export "Export DT6" align:#left offset:[0,10] width:180  height:30
	button Create_Wire "Draw Spline" align:#left offset:[0,10] width:180  height:30
	button Simplify "Simplify" align:#left offset:[0,10] width:180  height:30	
	
	dotNetControl lv "System.Windows.Forms.ListView" offset:[0,10]

	--- Dialog Actions --- 
	
	on WW3D_WE_rollout open do
		(
		PMsize = getDialogSize WW3D_WE_rollout
		WWListView lv
--		WWListUpdate lv
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 25 as integer) (PMsize.y - 120 as integer)
--		WMlist = lv	
		SetDialog WW3D_WE_rollout
		)
		
	on WW3D_WE_rollout close do
		(
		SetDialog WW3D_WE_rollout
		)
			
	on WW3D_WE_rollout moved position do
		(
		SetDialog WW3D_WE_rollout
		)
	
	on WW3D_WE_rollout resized size do
		(
		PMsize = size
		SetDialog WW3D_WE_rollout
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 25 as integer) (PMsize.y - 120 as integer)
		)
		
	--- Button Actions ---	
	
	on XYZ_Import pressed do ()
	on DT6_Import pressed do ()
	on Read_Wire pressed do () 	
	on Pre_Viz pressed do () 
	on XYZ_Export pressed do ()
	on DT6_Export pressed do () 
	on Create_Wire pressed do ()
	on Simplify pressed do ()
		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- WireWorks3D Panel Editor Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
global WW3D_Util_rollout;	
rollout WW3D_Util_rollout (WW3D_Version + " - Utilities") 
	(
		
		
	on WW3D_Util_rollout open do
		(
		SetDialog WW3D_Util_rollout
		)
		
	on WW3D_Util_rollout moved position do
		(
		SetDialog WW3D_Util_rollout
		)
		
	on WW3D_Util_rollout close do
		(
		SetDialog WW3D_Util_rollout
		)
	
	--- Button Actions ---	
		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Define Submenus for Main RenderMonkey Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

RCMenu WW3D_RCmenu
	(
	menuItem MainMenu "Main"
	menuItem CreatePanels "Create Panels"
	menuItem PanelEditor "Panel Editor"
	menuItem WireEditor "Wire Editor"
	menuItem Utilities "Utilities"
	Submenu "Help"
		(
		menuItem About_WW "About WireWorks3D"
		menuItem Help_WW "Help Manual"
		menuItem WebHelp_WW "Help on Web"
		)
		
	on MainMenu picked do 
		(
		ClearDialogs()
		createDialog WW3D_Main_Rollout 350 350 FLx FLy menu:WW3D_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on CreatePanels picked do 
		(
		ClearDialogs()
		createDialog WW3D_CP_Rollout 775 515 FLx FLy menu:WW3D_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on PanelEditor picked do 
		(
		ClearDialogs()
		createDialog WW3D_PE_Rollout 775 600 FLx FLy menu:WW3D_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on WireEditor picked do 
		(
		ClearDialogs()
		createDialog WW3D_WE_rollout 775 600 FLx FLy menu:WW3D_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
		)
		
	on Utilities picked do 
		(
		ClearDialogs()
		createDialog WW3D_Util_rollout 775 600 FLx FLy menu:WW3D_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
	
	on About_WW picked do ()
	on Help_WW picked do ()
	on WebHelp_WW picked do ()
	)
---------------------------------------------------------------------------------------------------------------------------------------------
--- Create Initial WireWorks Dialog
---------------------------------------------------------------------------------------------------------------------------------------------
		(
		if LastMenu != "" then 
			(
			createDialog (execute LastMenu) FLw FLh FLx FLy menu:WW3D_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
			)
		else
			(
			createDialog WW3D_Main_Rollout 350 315 FLx FLy menu:WW3D_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
			)
		)
	)


