-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--- IPDS Manager v1.0 beta
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
	
	global VPD_CS_MM_Rollout
	global VPD_CS_SIM_rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
	local SDBIM_Version = "VPD Construction Simulator v1.0 Beta"	

	--- Script Local Functions --- 
	
	local ClearDialogs	
	local SetDialog
	local GetDialogSet

	--- Dialog Window Position --- 
	
	local FLx = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterX") as integer)
	local FLy = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterY") as integer)
	local FLw = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterW") as integer)
	local FLh = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterH") as integer)
	local LastMenu = (getINISetting "$maxdata\\VPD.ini" "ConSim" "LastMenu")
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	include "$userscripts\\CGsoldier\\functions\\F360Lib_Functions.mse"	
	
	if VPD_CS_MM_Rollout != undefined then destroyDialog VPD_CS_MM_Rollout
	if VPD_CS_SIM_rollout != undefined then destroyDialog VPD_CS_SIM_rollout

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------	
	
	--- Window Memory Function ---
	
	fn ClearDialogs = 
		(
		if VPD_CS_MM_Rollout != undefined then destroyDialog VPD_CS_MM_Rollout
		if VPD_CS_SIM_rollout != undefined then destroyDialog VPD_CS_SIM_rollout
		)

	fn SetDialog X =
		(
		Dpos = GetDialogPos X
		Dsize = getDialogSize X	
		setINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterX"  (( Dpos.x ) as String)
		setINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterY"  (( Dpos.y ) as String)
		setINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterW"  (( Dsize.x ) as String)
		setINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterH"  (( Dsize.y ) as String)
		setINISetting "$maxdata\\VPD.ini" "ConSim" "LastMenu"  X.name 
		)
		
		fn GetDialogSet =
		(
		FLx = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterX") as integer)
		FLy = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterY") as integer)
		FLw = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterW") as integer)
		FLh = ((getINISetting "$maxdata\\VPD.ini" "ConSim" "FloaterH") as integer)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------	
--- dotNet System Date Time Functions ---
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
--- Excel Data Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------
	
global xl_write;
fn xl_write row col data =
	(
	xlo = xlObject.application.cells row col
	xlo.value = (data)
	)

global xl_read;
fn xl_read row col =
	(
	xlo = xlObject.application.cells row col
	if (col == 4 or col == 5) then
		(
		xlo.NumberFormat = "General"
		return (xlo.value)
		)
	else
		(
		xlo.NumberFormat = "General"
		return (xlo.value)
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Schedule Importers ---
---------------------------------------------------------------------------------------------------------------------------------------------
		
	global xl_sched_import;
	fn xl_sched_import visible = 
		(
		try (file = getOpenFileName()) catch (messagebox "No File Selected")
			
		if file != undefined do 
			(
			xlObject = createOLEObject "Excel.Application"
			xlObject.Visible = visible
			xlObject.DisplayAlerts = false
			xlObject.workbooks.open file
				
			try
				(			
				global sched_data = #()
				col_count = 7 --(while (xl_read 1 (j)) != undefined do (j = j+1)) - 1
				i = 2
				j = 1
				while (xl_read (i) (j)) != undefined do 
					(
					temp = #()
					for j = 1 to col_count do
						(
						if (xl_read (i) (j)) == undefined then append temp "" else
							(
							append temp ((xl_read (i) (j)) as string)
							)
						)
					append sched_data temp
					i = i +1
					)
				)
			catch
				(
				messagebox "Could Not Import Schedule Data"
				)
			
			if visible == false do
				(
				xlObject.activeworkbook.close
				xlObject.Application.Quit()
				releaseAllOLEObjects()
				)
				
			return sched_data
			)
		)
		
	global get_msp_cell;
	fn get_msp_cell row col=
	(
		cell = mspObject.SelectCell row col false
		val = mspObject.ActiveCell.Text
		return val
	)
		
	global msp_sched_import;
	fn msp_sched_import visible = 
		(
		try (file = getOpenFileName()) catch (messagebox "No File Selected")

		if file != undefined do 
			(
			mspObject = createOLEObject "msproject.Application"
			mspObject.Visible = visible
			mspObject.DisplayAlerts = false
			mspObject.DefaultDateFormat = 8
			mspObject.FileOpenEx file

			try
				(			
				global sched_data = #()
				task_count = mspObject.ActiveProject.Tasks.Count
					
				for i = 1 to task_count do
					(
						temp = #()
						task = mspObject.ActiveProject.Tasks i
						append temp (task.ID as string)
						append temp (task.Name as string)
						append temp ((task.Duration/60 as float) as string)
						append temp (dnet_String_toOAD (get_msp_cell i 5))
						append temp (dnet_String_toOAD (get_msp_cell i 6))
						append temp (task.Predecessors as string)
						append temp (task.Notes as string)
						
						append sched_data temp
					)
				)
			catch
				(
				messagebox "Could Not Import Schedule Data"
				)
			
			if visible == false do
				(				
				mspObject.FileCloseEx
				mspObject.FileExit
				releaseAllOLEObjects()
				)
				
			return sched_data
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Schedule Exporters ---
---------------------------------------------------------------------------------------------------------------------------------------------
		
	global xl_sched_export;
	fn xl_sched_export visible lv rpt = 
		(
		headers = #("ID", "Task Name", "Duration", "Start", "Finish", "Predecessors", "Notes")
		savepath = getSavePath caption:"Save Excel File"
		xlObject = createOLEObject "Excel.Sheet"
		xlObject.application.visible = visible
		col_count = 2
		item_count = lv.items.count
			
		for i = 1 to headers.count do 
			(
			xl_write (1) (i) (headers[i])
			)
			
		for i = 1 to item_count do 
			(
			for j = 1 to col_count do
				(
				xl_write (i+1) (j) (lv.items.item[i-1].subitems.item[j-1].text)
				)
			)
		activeXL = xlobject.application.activeworkbook
		activeXL.SaveAs ((savepath) + "\\" + rpt + ".xlsx")
		releaseAllOLEObjects()
		)
		
	global msp_sched_export;
	fn msp_sched_export visible lv rpt = 
		(
		savepath = getSavePath caption:"Save MS Project File"
		global mspObject = createOLEObject "msproject.Application"
		mspObject.visible = visible
		mspObject.FileNew()
			
		item_count = lv.items.count
		for i = 1 to item_count do 
			(
			mspObject.ActiveProject.Tasks.Add (lv.items.item[i-1].subitems.item[1].text)
			)
			
		mspObject.FileSaveAs ((savepath) + "\\" + rpt + ".mpp")
		releaseAllOLEObjects()
		)

---------------------------------------------------------------------------------------------------------------------------------------------	
--- Schedule Range Calculators ---
---------------------------------------------------------------------------------------------------------------------------------------------
		
	global get_sched_range;
	fn get_sched_range = 
		(
		if (sched_data != undefined) and (sched_data.count != 0) then
			(
			rangeMin = #()
			rangeMax = #()
			for i=1 to sched_data.count do
				(
				append rangeMin sched_data[i][4]
				append rangeMax sched_data[i][5]
				)
			global MinVal = ((amin rangeMin) as double)
			global MaxVal = ((amax rangeMax) as double)
			return ((filterstring (dnet_OAD_toString MinVal) " ")[1] + " - " + (filterstring (dnet_OAD_toString MaxVal) " ")[1])
			)
		else 
			(
			"No Schedule Data Loaded"
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------	
--- List View Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------
		
	global VPD_CS_ListView;
	fn VPD_CS_ListView lv rptstyle =
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
		lv.labeledit = false
		lv.HotTracking = false
					
		layout_def = case rptstyle of 
			(
			1:	layout_def = #("ID", "Object/Task", "Duration (Hours)", "Start", "Finish", "Predecessors", "Notes")
			2:	layout_def = #("ID", "Object/Task", "Duration (Hours)", "Start", "Finish", "Predecessors", "Notes")
			3:	layout_def = #("ID", "Object/Task", "Duration (Hours)", "Start", "Finish", "Predecessors", "Notes")
			4:	layout_def = #("ID", "Object/Task", "Duration (Hours)", "Start", "Finish", "Predecessors", "Notes")
			5:	layout_def = #("ID", "Object/Task", "Duration (Hours)", "Start", "Finish", "Predecessors", "Notes")
			6: layout_def = #("ID", "Object/Task", "Duration (Hours)", "Start", "Finish", "Predecessors", "Notes")
			)
			
		layout_width = case rptstyle of 
			(
			1:	layout_width = #(60,220,120,140,140,90,405)
			2:	layout_width = #(60,220,120,140,140,90,405)
			3:	layout_width = #(60,220,120,140,140,90,405)
			4:	layout_width = #(60,220,120,140,140,90,405)
			5:	layout_width = #(60,220,120,140,140,90,405)
			6: layout_width = #(60,220,120,140,140,90,405)
			)
		
		for i=1 to layout_def.count do
		lv.Columns.add layout_def[i] layout_width[i]	
		) 
	
	global VPD_CS_ListUpdate;
	fn VPD_CS_ListUpdate lv condensed rptstyle objset =
	(
	ObjPropKey = case rptstyle of 
		(
		1:	ObjPropKey = #()
		2:	ObjPropKey = #()
		3:	ObjPropKey = #()
		4:	ObjPropKey = #()
		5:	ObjPropKey = #()
		)
	theRange=#()
		
	for i = 1 to objset.count do --for obj in objset do
		(
		x=0
		li = dotNetObject "System.Windows.Forms.ListViewItem" (i as string)
		sub_li = li.SubItems.add objset[i].name 
		append theRange li
		)
	lv.Items.AddRange theRange
	)
	
	global VPD_CS_SchedImport;
	fn VPD_CS_SchedImport lv rptstyle =
	(
	ColumnKey = case rptstyle of 
		(
		1:	ColumnKey = #()
		2:	ColumnKey = #() 
		3:	ColumnKey = #()
		4:	ColumnKey = #()
		5:	ColumnKey = #()
		6:	ColumnKey = #()
		)
	theRange=#()
		
	for i = 1 to sched_data.count do
		(
		li = dotNetObject "System.Windows.Forms.ListViewItem" (sched_data[i][1])
		sub_li = li.SubItems.add sched_data[i][2]
		sub_li = li.SubItems.add sched_data[i][3]
		sub_li = li.SubItems.add (dnet_OAD_toString (sched_data[i][4] as double))
		sub_li = li.SubItems.add (dnet_OAD_toString (sched_data[i][5] as double))
		sub_li = li.SubItems.add sched_data[i][6]
		sub_li = li.SubItems.add sched_data[i][7]
		append theRange li
		)
	lv.Items.AddRange theRange
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Animation Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------
	
	global OA_to_Key;
	fn OA_to_Key val = 
		(
		frame = ((val-MinVal)/(maxval - minval)*(animationRange.end as integer)/160)
		return ((frame + 0.5) as integer)
		)
	
	global get_obj_sched;
	fn get_obj_sched lv = 
		(
		item_count = lv.items.count
		global AnimObjSet = #()
		for i = 1 to item_count do 
			(
			TempArray = #()
			append TempArray (lv.items.item[i-1].subitems.item[1].text)
			append TempArray (dnet_String_toOAD (lv.items.item[i-1].subitems.item[3].text))
			append TempArray (dnet_String_toOAD (lv.items.item[i-1].subitems.item[4].text))
			append AnimObjSet TempArray
			)
		return AnimObjSet
		)
		
	global ClearAnimation;
	fn ClearAnimation = 
		(
		slidertime = AnimationRange.end
		select $objects
		macros.run "Animation Tools" "DeleteSelectedAnimation"
		deselect $objects
		)
	
	global Set_Anim_Range;
	fn Set_Anim_Range sec rate =		
		(
		case rate of 
			(
			1: FR = 30
			2: FR = 24
			3: FR = 12
			)
		EndFrame = (sec*FR) as integer
		framerate = FR
		animationRange = interval 0 EndFrame
		)
		
	global Set_Vis_Key;
	fn Set_Vis_Key obj StartFrame EndFrame =
		(
		obj.Visibility = true
		nkey = addnewkey obj.Visibility.controller StartFrame 
		nkey.value = 0
		tkey = addnewkey obj.Visibility.controller EndFrame        
		tkey.value = 1
		)
		
	global Set_Grow_Key;
	fn Set_Grow_Key obj StartFrame EndFrame =
		(
		obj.Visibility = true
		nkey = addnewkey obj.Scale.controller StartFrame 
		nkey.value = [0,0,0]
		tkey = addnewkey obj.Scale.controller EndFrame        
		tkey.value = [1,1,1]
		)
		
	global Set_Drop_Key;
	fn Set_Drop_Key obj StartFrame EndFrame =
		(
		obj.Visibility = true
		origin = obj.Position
		offset = [0,0,1000]
		
		set animate on
		sliderTime = 0f
		obj.Position = ((origin + offset) as point3)
		sliderTime = StartFrame
		obj.Position = ((origin + offset) as point3)
		sliderTime = EndFrame
		obj.Position = origin
		set animate off
		)

	global Set_Color_Key;
	fn Set_Color_Key obj StartFrame EndFrame =
		(
		obj.Visibility = true
			
-- 		set animate on
-- 		sliderTime = 0f
-- 		obj.wirecolor = color 86 86 86
-- 		sliderTime = StartFrame
-- 		obj.wirecolor = color 176 26 26
-- 		sliderTime = EndFrame
-- 		obj.wirecolor = color 88 177 27
-- 		set animate off
			
-- 		ikey = addnewkey obj.WireColor.controller 0f
-- 		nkey.value = color 86 86 86
-- 		nkey = addnewkey obj.WireColor.controller StartFrame 
-- 		nkey.value = color 176 26 26
-- 		tkey = addnewkey obj.WireColor.controller EndFrame        
-- 		tkey.value = color 88 177 27
		)		
				
---------------------------------------------------------------------------------------------------------------------------------------------
--- Main Rollout
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout VPD_CS_MM_Rollout (SDBIM_Version + " - Main Menu") 
	(
	bitmap RMicon filename:"$userscripts\\CGsoldier\\images\\Const-Sim.bmp" align:#left offset:[0,10]
	
	--- Dialog Actions --- 
	
	on VPD_CS_MM_Rollout open do
		(
		SetDialog VPD_CS_MM_Rollout
		)
		
	on VPD_CS_MM_Rollout moved position do
		(
		SetDialog VPD_CS_MM_Rollout
		)
	
	on VPD_CS_MM_Rollout close do
		(
		SetDialog VPD_CS_MM_Rollout
		)
	)
	

---------------------------------------------------------------------------------------------------------------------------------------------
--- Simluator Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------

rollout VPD_CS_SIM_rollout (SDBIM_Version + " - Simulator")  
	(
	bitmap RMicon filename:"$userscripts\\CGsoldier\\images\\Const-Sim.bmp" align:#left offset:[0,5]
	
	groupbox gb1 "Data Filters" pos:[330,15] width:230 height:295
	radiobuttons rb1 "Condense By:" labels:#("None", "Discipline","Instances") pos:[340,35] default:1
	checkbox cb1 "Exclude Group Sub-Objects" checked:true pos:[340,70]
	checkbox cb3 "Filter By Object Type" checked:false pos:[340,90]
	MultiListBox mdd1 "Object Types: (CTRL + Left Click)" pos:[340,110]  width:210 height:10 labelontop:true items:name_array enabled:false
	button btn1 "REFRESH OBJECT LIST" width:210 height:30 pos:[340,270] 
		
	groupbox gb2 "Import Schedule:" pos:[575,15] width:210 height:140
	dropdownlist dd1 "Import Format" pos:[585,35] width:190 height:30 labelontop:true items:#("VPD Server", "Excel Spreadsheet", "Microsoft Project")
	checkbutton chkbtn1 "KEEP OPEN ON IMPORT" width:190 height:30 pos:[585,80] checked:true
	button btn2 "IMPORT SCHEDULE" width:190 height:30 pos:[585,115] 
	
	groupbox gb3 "Export Schedule" pos:[575,170] width:210 height:140
	dropdownlist dd2 "Export Format:" pos:[585,190] width: 190 height:30 labelontop:true items:#("VPD Server", "Excel Spreadsheet", "Microsoft Project")
	checkbutton chkbtn2 "KEEP OPEN ON EXPORT" width:190 height:30 pos:[585,235] checked:true
	button btn3 "EXPORT SCHEDULE" pos:[585,270] width:190  height:30
	
	groupbox gb4 "Simulation Options" pos:[800,15] width:390 height:295
	dropdownlist dd3 "Simulation Type:" pos:[810,40] width: 180 height:30 labelontop:true items:#("Visibility", "Grow", "Drop")
	slider sl1 "Simulation Duration (seconds)" pos:[810,100] width: 380 height:30 labelontop:true type:#integer range:[1,600,0] ticks:10
	edittext et1 "Simulation Scale (Days/Seconds)" pos:[1000,170] labelontop:true fieldwidth:180 bold:true readonly:true
	edittext et2 "Current Timeline Range (Days)" pos:[810,170] labelontop:true fieldwidth:180 bold:true readonly:true
	radiobuttons rb2 "Frame Rate:" pos:[810,220] labels:#("NTSC 30 fps","FILM 24 fps","WEB 12 fps") columns:3
	button btn4 "APPLY SIMULATION" pos:[810,275] width:160  height:25
	progressbar pbar1 color:red pos:[980,275] width:200  height:25 value:0
	label lbl "" pos:[985,281]
	
	dotNetControl lv "System.Windows.Forms.ListView" pos:[10,325]
		
	--- Initial Object Set --- 
		
	global objset = #()
	
	--- Interface Actions ---
	
	on cb3 changed state do 
		(
		if cb3.checked == true then mdd1.enabled = true else mdd1.enabled = false
		)
	
	on btn1 pressed do 
		(
		types = (BitToString mdd1.selection prefix_array)
		objset = object_filter rb1.state cb1.checked cb3.checked types
 		lv.clear()
		VPD_CS_ListView lv dd1.selection
 		VPD_CS_ListUpdate lv rb1.state dd1.selection objset 
		)
		
	on btn2 pressed do 
		(
		case dd1.selection of 
			(
			1:()
			2:	(
				xl_sched_import chkbtn1.checked
				et2.text = get_sched_range()
				et2.caption = "Range (Days) = " + ((MaxVal - MinVal) as float) as string
				lv.clear()
				VPD_CS_ListView lv dd1.selection
				VPD_CS_SchedImport lv dd1.selection
				)
			3: (
				msp_sched_import chkbtn1.checked
				et2.text = get_sched_range()
				et2.caption = "Range (Days) = " + ((MaxVal - MinVal) as float) as string
				lv.clear()
				VPD_CS_ListView lv dd1.selection
				VPD_CS_SchedImport lv dd1.selection
				)
			) 
		)
		
	on btn3 pressed do 
		(
		if maxFilename == "" then 
			(
				messagebox "Please Save Max File First"
				max file saveas
			)
		else
			(
			case dd2.selection of 
				(
				1:()
				2:(xl_sched_export chkbtn2.checked lv (strip_file_extension maxFileName))
				3:(msp_sched_export chkbtn2.checked lv (strip_file_extension maxFileName))
				)
			)
		)
		
	on sl1 changed val do
		(
		et1.text = "1 Day = " + (val/((MaxVal - MinVal) as float)) as string
		sl1.text = "Duration (seconds) = " + (val as string)
		)
		
	on btn4 pressed do
		(
		ClearAnimation()
		Set_Anim_Range (sl1.value) (rb2.state)
		get_obj_sched lv
		case  dd3.selection of	
				(
				1: AnimType = Set_Vis_Key
				2: AnimType = Set_Grow_Key
				3: AnimType = Set_Drop_Key
				4: AnimType = Set_Color_Key
				default: AnimType = Set_Vis_Key
				)
		
		for i = 1 to AnimObjSet.count do
			(
			pbar1.value = 100.*i/AnimObjSet.count
			objset = #()
			for obj in objects do (if obj.name == AnimObjSet[i][1] do (append objset obj))
			for obj in objset do (AnimType obj (OA_to_Key AnimObjSet[i][2]) (OA_to_Key AnimObjSet[i][3]))
			)
		)

	--- Dotnet Table Actions ---
		
	on lv ColumnClick x do
		(
		print x.column
		lv.sort()
		)

	--- General Rollout Actions ---
	
	on VPD_CS_SIM_rollout open do
		(
		types = (BitToString mdd1.selection prefix_array)
		objset = object_filter rb1.state cb1.checked cb3.checked types
		VPD_CS_ListView lv dd1.selection
		VPD_CS_ListUpdate lv rb1.state dd1.selection objset
		PMsize = getDialogSize VPD_CS_SIM_rollout
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 20 as integer) (PMsize.y - 335 as integer)
		SetDialog VPD_CS_SIM_rollout
		)
		
	on VPD_CS_SIM_rollout close do
		(
		SetDialog VPD_CS_SIM_rollout
		)
			
	on VPD_CS_SIM_rollout moved position do
		(
		SetDialog VPD_CS_SIM_rollout
		)
	
	on VPD_CS_SIM_rollout resized size do
		(
		PMsize = size
		SetDialog VPD_CS_SIM_rollout
		lv.size = dotNetObject "System.Drawing.Size" (PMsize.x - 20 as integer) (PMsize.y - 335 as integer)
		)
	)
	
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Define Submenus for Main RenderMonkey Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

RCMenu VPD_CS_RCmenu
	(
	menuItem MM "Main"
	menuItem SIM "Simulator"

	Submenu "Help"
		(
		menuItem About_VPD_CS "About Construction Simulator"
		menuItem Help_VPD_CS "Construction Simulator Help Manual"
		menuItem WebHelp_VPD_CS "Construction Simulator Web"
		)
		
	on MM picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog VPD_CS_MM_Rollout 330 330 FLx FLy menu:VPD_CS_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on SIM picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog VPD_CS_SIM_rollout 1200 800 FLx FLy menu:VPD_CS_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
		)
			
	on About_VPDCS picked do ()
	on Help_VPDCS picked do ()
	on WebHelp_VPDCS picked do ()
	)
---------------------------------------------------------------------------------------------------------------------------------------------
--- Create Initial BIM Monkey Dialog
---------------------------------------------------------------------------------------------------------------------------------------------
	(
	if LastMenu != "" then 
		(
		ClearDialogs()
		createDialog (execute LastMenu) FLw FLh FLx FLy menu:VPD_CS_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
		)
	else
		(
		ClearDialogs()
		createDialog VPD_CS_MM_Rollout 330 330 FLx FLy menu:VPD_CS_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
		)
	)
)	-- End Script


