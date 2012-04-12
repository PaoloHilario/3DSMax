-------------------------------------------------------------------------------
-- Object_Namer.ms
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 1.0
-- Created On: 04/21/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Semi-Automated Naming Script for The Scenario Design Production Pipeline
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Works on single or groups of objects
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
(
	global OBJBIM_NM_Rollout
	global OBJBIM_UTL_Rollout
	global OBJBIM_MTL_Rollout
	global OBJBIM_SCH_Rollout
	global OBJBIM_CALC_Rollout
	global OBJBIM_VEN_Rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
	local name_type_val = 1
	local scne_num_val = 1
	local scne_num_txt = "000"
	local elem_num_val = 1
	local elem_num_txt = "000"
	local cust_text_val = ""
	local desc_text_val = ""
	
	local Rename_Objects
	local Create_Layers
	local Purge_Layers
	local Auto_Layers
	local check_tags
	local check_naming
	local objtool

	local group_members_val = false
	local layerpurge_val = true
	local auto_num_val = false
	
	local phase_type_val
	
	local ClearDialogs	
	local SetDialog
	local GetDialogSet
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterY") as integer)
	local FLw = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterW") as integer)
	local FLh = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterH") as integer)
	local LastMenu = (getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "LastMenu")
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	FileIn "$userscripts\CGsoldier\functions\CGS_func.mse"
	
	if OBJBIM_NM_Rollout != undefined then destroyDialog OBJBIM_NM_Rollout
	if OBJBIM_UTL_Rollout != undefined then destroyDialog OBJBIM_UTL_Rollout
	if OBJBIM_MTL_Rollout != undefined then destroyDialog OBJBIM_MTL_Rollout
	if OBJBIM_SCH_Rollout != undefined then destroyDialog OBJBIM_SCH_Rollout
	if OBJBIM_VEN_Rollout != undefined then destroyDialog OBJBIM_VEN_Rollout
	if OBJBIM_CALC_Rollout != undefined then destroyDialog OBJBIM_CALC_Rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

	--- Window Memory Function ---
	
	fn ClearDialogs = 
		(
		if OBJBIM_NM_Rollout != undefined then destroyDialog OBJBIM_NM_Rollout
		if OBJBIM_UTL_Rollout != undefined then destroyDialog OBJBIM_UTL_Rollout
		if OBJBIM_MTL_Rollout != undefined then destroyDialog OBJBIM_MTL_Rollout
		if OBJBIM_SCH_Rollout != undefined then destroyDialog OBJBIM_SCH_Rollout
		if OBJBIM_VEN_Rollout != undefined then destroyDialog OBJBIM_VEN_Rollout
		if OBJBIM_CALC_Rollout != undefined then destroyDialog OBJBIM_CALC_Rollout			
		)

	fn SetDialog X =
		(
		Dpos = GetDialogPos X
		Dsize = getDialogSize X	
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterX"  (( Dpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterY"  (( Dpos.y ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterW"  (( Dsize.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterH"  (( Dsize.y ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "LastMenu"  X.name 
		)
		
	fn GetDialogSet =
		(
		FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterX") as integer)
		FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterY") as integer)
		FLw = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterW") as integer)
		FLh = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjectBIM" "FloaterH") as integer)
		)

	fn Rename_Objects =
		(
		undo "Object Namer" on
			(
			if group_members_val == false then 
				(
				objset = getcurrentselection() 
				)
			else
				(
				objset = #()
				temp = getcurrentselection()
				for obj in temp do (if isgroupmember obj == false do append objset obj)
				)

			if getCommandPanelTaskMode() == #modify then max create mode

			for obj in objset do --Start Renaming
				(
				case name_array[name_type_val] of
					(
					"Custom":
						(
						obj.name = (cust_text_val + "_" + scne_num_txt + "_" + elem_num_txt + "_" + toUpper desc_text_val)
						setUserProp obj "Type" cust_text_val
						setUserProp obj "Scene" scne_num_txt
						setUserProp obj "Element" elem_num_txt
						setUserProp obj "Description" (toUpper desc_text_val)
						)
						
					default:
						(
						obj.name = ((prefix_array[name_type_val] as string) + "_" + scne_num_txt + "_" + elem_num_txt + "_" + toUpper desc_text_val)
						setUserProp obj "Type" (prefix_array[name_type_val] as string)
						setUserProp obj "Scene" scne_num_txt as string
						setUserProp obj "Element" elem_num_txt as string
						setUserProp obj "Description" (toUpper desc_text_val)
						)
					)
				)
			)
		)
	
	fn check_tags obj = 
		(
		txt = filterstring obj.name "_,:,-"
		getUserProp obj "Type" == txt[1] and getUserProp obj "Scene" == txt[2] as integer and getUserProp obj "Element" == txt[3] as integer and getUserProp obj "Description" == txt[4]
		)
	
	fn scene_count = 
		(
		ScneCnt = #()
		for obj in objects do 
			(			
			txt = filterstring obj.name "_,:,-"
			if txt[2] != undefined do appendIfUnique ScneCnt txt[2]
			)
		return ScneCnt
		)	

	fn check_naming =
		(
		clearselection()
			
		for obj in objects do 
			(
			if check_tags obj == false then 
				(
				obj.isHidden = false
				selectmore obj
				)
			)
		if selection.count !=0 then macros.run "Tools" "Isolate_Selection" else messagebox "All The Objects Are Correctly Named!"
		)
		
	fn objtools xxx = 
		(
		case xxx of
			(
			1: objset = getcurrentselection()
			2: $.ishidden = true
			3: $.ishidden = false
			4: macros.run "Tools" "Isolate_Selection"
			5: $.isfrozen = true
			6: $.isfrozen = false
			)
		)
		
	fn Create_Layers = 
		(
		scenes = scene_count()
		for i = 1 to scenes.count do -- Make New layers based on Layer Prefixes + Number of Scenes + Object Types
			(
			for j = 1 to prefix_array.count do
				(
				if LayerManager.getLayerFromName ("SDI-" + scenes[i] + "-" + prefix_array[j]) == undefined then (LayerManager.newLayerFromName ("SDI-" + scenes[i] + "-" + prefix_array[j]))
				)
			)
		)
		
	fn Purge_Layers = 
		(
		lnames = #()
		for i = 1 to LayerManager.count do
			(
			layer = LayerManager.getLayer (i-1)
			append lnames layer.name
			)
		for i = 1 to lnames.count do
			(
			LayerManager.deleteLayerByName lnames[i]
			)
		)
		
	fn Auto_Layers =
		(
		for i = 1 to LayerManager.count do
			(
			layer = LayerManager.getLayer (i-1)
			lname = filterstring layer.name "-"
			if lname.count > 0 then
				(
				for obj in objects do
					(
					oname = filterstring obj.name "_,:,-"
					if lname[3] == oname[1] and lname[2] == oname[2] do layer.addnode obj 
					)
				)
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition, Namer Module
---------------------------------------------------------------------------------------------------------------------------------------------

rollout OBJBIM_NM_Rollout "Element Naming"
	(
	group "Element Name:"
		(
		dropdownlist rename_type "" items:name_array height:30 
		edittext cust_text "Custom Prefix: " fieldWidth:270 text:cust_text_val align:#right enabled:false offset:[-5,10]
		spinner scne_num "Scene #: " range:[0,100,0] type:#integer scale:1 align:#left offset:[0,15] across:2 value:scne_num_val
		spinner elem_num "Element #: " range:[0,999,0] type:#integer scale:1 align:#right offset:[-2,15] value:elem_num_val
		edittext desc_text "Description: " fieldWidth:280 text:desc_text_val align:#left offset:[0,10]
		button do_rename "RENAME SELECTED OBJECTS" width:340 height:30 align:#center toolTip:"Rename" offset:[0,10]
		)

	on rename_type selected i do 
		(
		if rename_type.selected == "Custom" then 
			(
			cust_text.enabled = true
			)
		else
			(
			cust_text.enabled = false
			)
		name_type_val = i
		)
		
	on cust_text changed text do 
		(	
		cust_text_val = cust_text.text
		)
		
	on desc_text changed text do 
		(	
		desc_text_val = desc_text.text
		)
		
	on scne_num changed val do
		(
		scne_num_val = val
		case of
			(
				(scne_num_val<10): scne_num_txt = ("00" + (scne_num_val as string))
				((scne_num_val>=10) and (scne_num_val<100)): scne_num_txt = ("0" + (scne_num_val as string))
				(scne_num_val>=100): scne_num_txt = (scne_num_val as string)
			)
		)
		
	on elem_num changed val do
		(
		elem_num_val = val
		case of
			(
				(elem_num_val<10): elem_num_txt = ("00" + (elem_num_val as string))
				((elem_num_val>=10) and (elem_num_val<100)): elem_num_txt = ("0" + (elem_num_val as string))
				(elem_num_val>=100): elem_num_txt = (elem_num_val as string)
			)
		)
		
	on do_rename pressed do 
		(
		if selection.count != 0 then Rename_Objects() else messagebox "No Objects Selected Sucka!"
		)
		
	group "Naming Utilities"
		(
		button check_scene "CHECK FOR BAD OBJECT NAMING" width:340 height:30 align:#center toolTip:"Check Scene for Mis-Named Objects" offset:[0,5]
		button Apply_To_Layer "APPLY OBJECTS TO LAYERS" width:340 height:30 align:#center toolTip:"Apply objects to the Proper Layers" offset:[0,10]
		)
		
	on check_scene pressed do
		(
		check_naming()
		)
	
	on Apply_To_Layer pressed do
		(
		Create_Layers()
		Auto_Layers()
		if layerpurge_val == true do Purge_Layers()
		)
		
	group "Options"
		(
		checkbox group_members "Don't Rename Group Members" checked:group_members_val
		checkbox layerpurge "Auto Purge Layers" checked:layerpurge_val
		checkbox Auto_Num "Auto Number Sub Elements" checked:false enabled:false
		)
		
	on group_members changed state do 
		(
		if group_members.checked == true then group_members_val = true 
		else group_members_val = false
		)
		
	on layerpurge changed state do 
		(
		if layerpurge.checked == true then layerpurge_val = true 
		else layerpurge_val = false
		)
		
	on Auto_Num changed state do 
		(
		if Auto_Num.checked == true then 
			(
			auto_num_val = true
			elem_num.enabled = false
			)
		else
			(
			auto_num_val = false
			elem_num.enabled = true	
			)
		)
		
	--- General Rollout Actions ---
	
	on OBJBIM_NM_Rollout open do
		(
		SetDialog OBJBIM_NM_Rollout
		)
		
	on OBJBIM_NM_Rollout moved position do
		(
		SetDialog OBJBIM_NM_Rollout
		)
		
	on OBJBIM_NM_Rollout close do
		(
		SetDialog OBJBIM_NM_Rollout
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition, Material Specifications Module
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout OBJBIM_MTL_Rollout "Material Specifications"
	(
	local Mat_List = #("Architectural_Roofing", "Architectural_Walls", "Architectural_Details","Steel", "Iron","Aluminum Alloys","Other Alloys","Copper Alloys", "Plastics", "Other Metals", "Generic Glass Fibers", "Carbon Fibers", "Silicons", "Wood", "Composite Wood", "Other Non-Metals" )	
	local Mat_Lists = #(#("Standing Seam","S Tile", "Flat Tile", "Asphalt"),#("Foundation-12in. Concrete","Exterior-CMU","Exterior-CMU/Mtl Stud","Generic-6in.", "Generic-8in." ),#("Concrete-Rockwork","Concrete-Lightweight Pre Cast","EIFS","FRP","GFRC"),#("AISI 304", "AISI 1020", "Alloy Steel", "Cast Alloy Steel", "Cast Carbon Steel", "Cast Stainless Steel", "Chrome Stainless", "SteelGalvanized", "Steel Plain", "Carbon Steel", "Wrought Stainless Steel"), #("Ductile Iron", "Gray Cast Iron", "Malleable Cast Iron"),#("1060 Alloy","1345 Alloy","1350 Alloy","2014 Alloy","2018 Alloy","2024 Alloy","3003 Alloy","6061 Alloy","7079 Alloy"),#("Duranickel(R) 301","Magnesium Alloy","Monel(R) 400"),#("Aluminum Bronze","Brass","Copper","Leaded Commercial Bronze","Manganese Bronze","Tin Bearing Bronze","Wrought Copper"),#("ABS","ABS PC","Acrylic (Medium-high impact)","Nylon 6/10","PA Type 6","PBT General Purpose","PC High Viscosity","PE High Density","PE Low/Medium Density","POM Acetal Copolymer","PP Copolymer","PS Medium/High Flow","PVC 0.007 Plasticized","PVC Rigid","Perspex (TM) GS Acrylic Cast Sheet","PTFE (general)"),#("Cobalt","Molybdenum","Nickel","Pure Gold","Pure Lead","Pure Silver","Titanium","Tungsten","Vanadium","Zirconium"),#("A-Glass Fiber","C-Glass Fiber","E-Glass Fiber","S-Glass Fiber"),#("Zoltek Panex 33","Hexcel AS4C (3000 Filaments)","Thornel Mat VMA","Thornel VCB-20 Carbon Cloth"),#("Silicon","Silicon Dioxide"),#("Beech","Cedar","Maple","Oak","Pine","Teak","Mahogany","Balsa"),#("Plywood", "MDF", "MDO","Parallam", "Particle Board" ),#("Air","Ceramic Porcelain","Glass","Rubber","Water"))
	local Mat_Dens = #(#("","2.456","",""),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#("","","","","","","",""),#(),#())
	local Mat_Units = #(#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#(),#()) 
		
	dropdownlist dd1 "Category:" items:Mat_List offset:[0,10] width:350 labelontop:true
	listbox lb1 "Construction Material:" items:Mat_Lists[1] width:350 height:10 align:#center toolTip:"Choose Element Material" offset:[0,10]
	checkbox cb1 "Use Applied MAX Material" checked:true offset:[0,10]
	listbox lb2 "Element Finish:" items:Finish_List width:350 height:1 align:#center toolTip:"Choose Element Material" offset:[0,5] enabled:false
	button bt1 "APPLY MATERIAL INFORMATION" width:350 height:40 align:#center toolTip:"Apply Material to Selection" offset:[0,5]
	
	
	on dd1 selected i do
		(
		lb1.items = Mat_Lists[i]
		)
		
	on cb1 changed state do 
		(
		if cb1.checked == false then
			(
			lb2.enabled = true	
			lb2.height = 80
			bt1.pos = [12,375]
			OBJBIM_MTL_Rollout.height = 425
			) 
		else
			(
			lb2.enabled = false
			lb2.height = 18
			bt1.pos = [12,310]
			OBJBIM_MTL_Rollout.height = 360
			)
		)
		
	on bt1 pressed do 
		(
		sel_obj = getcurrentselection()	
		for obj in sel_obj do
			(
			setUserProp obj "Material" (Mat_Lists [dd1.selection] [lb1.selection] as string)
			setUserProp obj "Mat_Density" (Mat_Dens [dd1.selection] [lb1.selection] as string)
			setUserProp obj "Mat_Units" (Mat_Units [dd1.selection] [lb1.selection] as string)
			setUserProp obj "Mat_Finish" "undefined"
			)
		)
	
	--- General Rollout Actions ---
		
	on OBJBIM_MTL_Rollout open do
		(
		SetDialog OBJBIM_MTL_Rollout
		)
		
	on OBJBIM_MTL_Rollout moved position do
		(
		SetDialog OBJBIM_MTL_Rollout
		)
		
	on OBJBIM_MTL_Rollout close do
		(
		SetDialog OBJBIM_MTL_Rollout
		)		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition, Scheduling Specifications
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout OBJBIM_SCH_Rollout "Scheduling"
	(
	local phase = "Design"
	local duration = "1"
	local objset = #()
		
	group "Task Durations"
		(
		spinner sp1 "Design Duration (Days): " range:[0,365,0] type:#integer align:#right fieldWidth:50 offset:[0,10]
		spinner sp2 "Engineering Duration (Days): " range:[0,365,0] type:#integer align:#right fieldWidth:50 offset:[0,10]
		spinner sp3 "Fabrication Duration (Days): " range:[0,365,0] type:#integer align:#right fieldWidth:50 offset:[0,10]
		spinner sp4 "Shipping Duration (Days): " range:[0,365,0] type:#integer align:#right fieldWidth:50 offset:[0,10]
		spinner sp5 "Installation Duration (Days): " range:[0,365,0] type:#integer align:#right fieldWidth:50 offset:[0,10]
		bitmap RMicon filename:"$userscripts\\CGsoldier\\images\\BIMtime.bmp" height:150 width:150 align:#left offset:[0,10] pos:[20,30]
		)
	dropdownlist dd2 "Apply to The Following:" items:#("Selected Items", "Scene") width:370 labelontop:true offset:[0,10]
	dropdownlist dd3 "Scene \ Zone Selection:" items:#() width:370 labelontop:true enabled:false
	button bt1 "APPLY SCHEDULE INFORMATION" align:#left offset:[0,10] width:370 height:35
		
	on sp1 changed val do
		(
		duration = val
		)
		
	on dd1 selected i do 
		(
		phase = dd1.selected
		)
		
	on dd2 selected i do 
		(
		case dd2.selection of
			(
			1:	( -- Selected Items --	
				dd3.enabled = false
			    objset = getcurrentselection()
				)	
			2:	( -- Scene --	
				dd3.enabled = true
				dd3.text = "Scene Selection:"
				scenes = scene_count()
				dd3.items = scenes
				)
			)
		)
		
	on dd3 selected i do 
		(
		objset =#()
 		for obj in objects do 
			(
			txt = filterstring obj.name "_,:,-"
			if txt[2] == dd3.selected do (append objset obj)
			)
		)
		
		
	on bt1 pressed do 
		(
		if dd2.selection == 1 then objset = getcurrentselection()
		for obj in objset do
			(
			setUserProp obj "Design_Duration(Days)" (sp1.value as string)
			setUserProp obj "Engineering_Duration(Days)" (sp2.value as string)
			setUserProp obj "Fabrication_Duration(Days)" (sp3.value as string)
			setUserProp obj "Shipping_Duration(Days)" (sp4.value as string)
			setUserProp obj "Installation_Duration(Days)" (sp5.value as string)
			setUserProp obj "Total_Duration(Days)" (sp1.value+sp2.value+sp3.value+sp4.value+sp5.value)
			)
		)
	
	--- General Rollout Actions ---
		
	on OBJBIM_SCH_Rollout open do
		(
		SetDialog OBJBIM_SCH_Rollout
		)
		
	on OBJBIM_SCH_Rollout moved position do
		(
		SetDialog OBJBIM_SCH_Rollout
		)
		
	on OBJBIM_SCH_Rollout close do
		(
		SetDialog OBJBIM_SCH_Rollout
		)		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition, Budget Module
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout OBJBIM_VEN_Rollout "Estimated Pricing"
	(
	local imagepath = "$userscripts\\CGsoldier\\images\\sdvendor\\"
	local vendor = #("KHS&S","Scenario","Pacific Supply","Cal-Ply", "A-Star Glass & Metal", "Garner Holt Productions","HAFFEMA")
	local ven_part = #(#("W-Type F/1-4 16'","W-Type B/A-4 16'","W-Type KA/0-4 16'","W-O King Stud","W-O Kong Stud","W-O Box Header","W-O Pro X Header"),#("Flats_1/2in Sentra","Murals_Printed","RWK_Monokote","RWK_Concrete","RWK_Shotcrete","RWK_Parabeam","FRP_FRP Mold", "FRP_Sil Mold", "FRP_Plaster Mold"),#("CL-0765", "SYN-9876"),#("STUCCO", "EIFS"),#("ALUM-Storefront", "ALUM-Door"),#("ATR_1 Func", "ATR_2 Func","ATR_3 Func"),#("Water System_Gravity Feed","Track System_S.P. Vehicle"))
	local ven_image = #(#("003.jpg","003.jpg","003.jpg","undefined","undefined","006.jpg","undefined"),#(),#("002.jpg","005.jpg"),#("003.jpg"),#("001.jpg","004.jpg"),#(),#())
	local ven_unit = #(#("LinearMeasure","LinearMeasure","LinearMeasure", "Per Unit", "Per Unit", "LinearMeasure", "LinearMeasure"),#("SurfaceArea","SurfaceArea","SurfaceArea","SurfaceArea","SurfaceArea","SurfaceArea","SurfaceArea","SurfaceArea","SurfaceArea"),#("SurfaceArea", "SurfaceArea"),#("SurfaceArea", "SurfaceArea"),#("SurfaceArea", "Per Unit"),#("Per Unit","Per Unit","Per Unit"),#("LinearMeasure","LinearMeasure"))
	local ven_price = #(#("371.46","248.50","148.98","117.83","57.78","23.72","8.60"),#("20.00","5.50","30.23","32.88","25.38","29.18","40.14","46.14","38.14"),#("5.08", "6.64"),#("6.17", "10"),#("20", "1000"),#("25000","30000","35000"),#("3500","1895"))		
	
	group "Vendor Database:"
		(
		bitmap bitmap1 "" filename:"$userscripts\\CGsoldier\\images\\BIMvendor.bmp" height:200 width:300 offset:[0,10] align:#center
		dropdownlist vd1 "Vendor:" items:vendor offset:[0,0] width:350 labelontop:true
		dropdownlist vd2 "Vendor Part #:" items:ven_part[vd1.selection] width:350 offset:[0,5] labelontop:true
		edittext vd3 "Unit Type:" fieldWidth:130 text:"" offset:[0,5] labelontop:true readonly:true
		edittext vd4 "Unit Price (USD):" fieldWidth:130 text:"" offset:[0,10] labelontop:true readonly:true
		edittext vd5 "Price Comparison:" pos:[160,340] height:72 labelontop:true fieldWidth:200 readOnly:true
		button btn1 "APPLY STANDARD VENDOR INFORMATION" align:#left offset:[0,10] width:350 height:35
		)
		
	group "Custom:"
		(
		edittext cst1 "Vendor:" text:""  fieldWidth:350 offset:[0,5] labelontop:true
		edittext cst2 "Vendor Part #:" text:"" fieldWidth:350 offset:[0,5] labelontop:true
		dropdownlist cst3 "Unit Type:" items:#("Per Unit", "LinearMeasure", "SurfaceArea", "Weight", "Volume") width:350 offset:[0,5] labelontop:true
		edittext cst4 "Unit Price (USD):" fieldWidth:150 text:"" offset:[0,5] labelontop:true
		button btn2 "APPLY CUSTOM VENDOR INFORMATION" align:#left offset:[0,15] width:350 height:35
		)
		
	--- local Functions ---
		
	local olditem
	local oldprice

	fn PriceCompare = 
		(
		desc1 = if olditem != undefined then olditem else (vd2.selected as string)
		price1 = if oldprice != undefined then oldprice else vd4.text
		desc2 = (vd2.selected as string)
		price2 = vd4.text
		olditem = desc2
		oldprice = price2 as string
		difference = ((price2 as float) - (price1 as float)) as string
		return (desc1 + ": $" + price1 + "\n" + desc2 + ": $" + price2 + "\n" + "Price Difference: $" + difference)
		)
		
	--- Interface Actions ---

	on vd1 selected index do 
		(
		vd2.items = ven_part[index]
		vd3.text = (ven_unit [index] [vd2.selection]) as string
		vd4.text = (ven_price [index] [vd2.selection]) as string
		image = ((ven_image [index] [vd2.selection]) as string)
 		bitmap1.filename = if image != "undefined" then (bitmap1.filename = (imagepath + image as string)) else (bitmap1.filename = "$userscripts\\CGsoldier\\images\\BIMvendor.bmp")
		)
		
	on vd2 selected index do 
		(
		vd3.text = (ven_unit [vd1.selection] [index]) as string
		vd4.text = (ven_price [vd1.selection] [index]) as string
		image = ((ven_image [vd1.selection] [index]) as string)
		bitmap1.filename = if image != "undefined" then (bitmap1.filename = (imagepath + image as string)) else (bitmap1.filename = "$userscripts\\CGsoldier\\images\\BIMvendor.bmp")
		vd5.text = PriceCompare()
		)
		
	on btn1 pressed do 
		(
		objset = getcurrentselection()
		for obj in objset do
			(
			setUserProp obj "Vendor" vd1.selected
			setUserProp obj "Vendor_Part" vd2.selected
			setUserProp obj "Vendor_Unit" vd3.text
			setUserProp obj "Vendor_Price" vd4.text
			)
		)

	on btn2 pressed do 
		(
		objset = getcurrentselection()
		for obj in objset do
			(
			setUserProp obj "Vendor" cst1.text
			setUserProp obj "Vendor_Part" cst2.text
			setUserProp obj "Vendor_Unit" cst3.selected
			setUserProp obj "Vendor_Price" cst4.text
			)
		)	
		
	--- General Rollout Actions ---
		
	on OBJBIM_VEN_Rollout open do
		(
		SetDialog OBJBIM_VEN_Rollout
		)
		
	on OBJBIM_VEN_Rollout moved position do
		(
		SetDialog OBJBIM_VEN_Rollout
		)
		
	on OBJBIM_VEN_Rollout close do
		(
		SetDialog OBJBIM_VEN_Rollout
		)		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition, Element Calculations Module
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout OBJBIM_CALC_Rollout "Element Calculations"
	(
	local objset = #()
	local oplist = #()
	local index
	
	dropdownlist dd1 "Operate On:" items:#("Selected Objects", "Object Type", "Scenes") offset:[0,10] width:350 labelontop:true
	MultiListBox mlb1 "Object Groups: (CTRL + Left Click for Multiple Selections)" items:#() offset:[0,5] width:350 height:10 labelontop:true enabled:false
	MultiListBox mlb2 "Calculation Type: (CTRL + Left Click for Multiple Selections)" items:#("Calculate All","Linear Measurement","Surface Area","Weight","Volume","Overall Dimensions") offset:[0,5] width:350 height:6 labelontop:true
	button bt1 "CALCULATE OBJECT DATA" width:350 height:40 align:#center toolTip:"Apply Material to Selection" offset:[0,10]

	on dd1 selected i do 
		(
		case i of
			(
			1:	( -- Selected Items --	
				mlb1.enabled = false
				mlb1.items = #()
				)
			2:	( -- Type --	
				mlb1.enabled = true
				mlb1.text = "Element Type: (CTRL + Left Click for Multiple Selections)"
				names = name_array
				mlb1.items = names
				index = 1
				)					
			3:	( -- Scene --	
				mlb1.enabled = true
				mlb1.text = "Scene Selection: (CTRL + Left Click for Multiple Selections)"
				scenes = scene_count()
				mlb1.items = scenes
				index = 2
				)
			)
		)
	
	on mlb1 selectionEnd do
		(
		prefixes = (BitToString mlb1.selection prefix_array)
		objset = #()
 		for obj in objects do 
			(
			txt = filterstring obj.name "_,:,-"
			if (finditem prefixes txt[index]) != 0 do (append objset obj)
			)
		)
		
	on mlb2 selectionEnd do
		(
		if (mlb2.selection as string) == "#{2..6}" do mlb2.selection = 1
		oplist = #()
		oplist = (BitToString mlb2.selection mlb2.items)
		print (oplist as string)
		)
		
	on bt1 pressed do 
		(
		if dd1.selection == 1 do (objset = getcurrentselection())
		for obj in objset do
			(
			if (findItem oplist "Calculate All") != 0 then 
				(
				Calc_Linear obj
				Calc_SurfaceArea obj
				Calc_Weight obj
				Calc_Volume obj
				Calc_OverallDims obj
				)
			else 
				(
				if (findItem oplist "Linear Measurement") != 0 do (Calc_Linear obj)
				if (findItem oplist "Surface Area") != 0 do (Calc_SurfaceArea obj)
				if (findItem oplist "Weight") != 0 do (Calc_Weight obj)
				if (findItem oplist "Volume") != 0 do (Calc_Volume obj)
				if (findItem oplist "Overall Dimensions") != 0 do (Calc_OverallDims obj)
				)
			)
		)	

	--- General Rollout Actions ---
		
	on OBJBIM_CALC_Rollout open do
		(
		SetDialog OBJBIM_CALC_Rollout
		)
		
	on OBJBIM_CALC_Rollout moved position do
		(
		SetDialog OBJBIM_CALC_Rollout
		)
		
	on OBJBIM_CALC_Rollout close do
		(
		SetDialog OBJBIM_CALC_Rollout
		)		
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition, Utilities
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout OBJBIM_UTL_Rollout "Scene Utilities"
	(
	group "Scene Selection Tools:"
		(
		dropdownlist rename_type "" items:name_array height:30 
		spinner scne_num "Scene #: " range:[0,100,0] type:#integer scale:1 align:#left offset:[0,10] across:2 value:scne_num_val
		spinner elem_num "Element #: " range:[0,999,0] type:#integer scale:1 align:#right offset:[-2,10] value:elem_num_val
		edittext desc_text "Search For: " fieldWidth:283 text:desc_text_val align:#left offset:[0,10]
			
		radiobuttons obj_ops labels:#("Select", "Hide", "Unhide", "Isolate", "Freeze", "Unfreeze") default:1 Columns:3 offset:[0,15]
		button btn_type "Type" width:70 align:#center toolTip:"Select Objects by Type" offset:[0,15] across:4
		button btn_scene "Scene" width:70 align:#center toolTip:"Select All Objects in a Scene" offset:[0,15] 
		button btn_elements "Elements" width:70 align:#center toolTip:"Select Elements within a Scene" offset:[0,15]
		button btn_desc "Description" width:70 align:#center toolTip:"Select Elements based on Description Search" offset:[0,15]
		)
	group "Purge BIM Data"
		(
		radiobuttons rb1 "" labels:#("Selected Objects","All Objects") offset:[0,10]
		button bt1 "PURGE ALL OBJECT BIM DATA" width:350 height:40 align:#center toolTip:"Purge All BIM Data" offset:[0,10]
		)
		
		on rename_type selected i do 
		(
		name_type_val = i
		)

	on desc_text changed text do 
		(	
		desc_text_val = desc_text.text
		)
		
	on scne_num changed val do
		(
		scne_num_val = val
		case of
			(
				(scne_num_val<10): scne_num_txt = ("00" + (scne_num_val as string))
				((scne_num_val>=10) and (scne_num_val<100)): scne_num_txt = ("0" + (scne_num_val as string))
				(scne_num_val>=100): scne_num_txt = (scne_num_val as string)
			)
		)
		
	on elem_num changed val do
		(
		elem_num_val = val
		case of
			(
				(elem_num_val<10): elem_num_txt = ("00" + (elem_num_val as string))
				((elem_num_val>=10) and (elem_num_val<100)): elem_num_txt = ("0" + (elem_num_val as string))
				(elem_num_val>=100): elem_num_txt = (elem_num_val as string)
			)
		)
		
	on btn_type pressed do
		(
		clearselection()
		for obj in objects do 
			(
			txt = filterstring obj.name "_,:,-"
			if txt[1] != undefined do
				(
				if matchPattern (txt[1]) pattern:(prefix_array[name_type_val] as string) == true then selectmore obj
				)
			)
		if $ != undefined do objtools obj_ops.state 
		)
	
	on btn_scene pressed do
		(
		clearselection()
		for obj in objects do 
			(
			txt = filterstring obj.name "_,:,-"
			if txt[2] != undefined do
				(
				if matchPattern (txt[2]) pattern:(scne_num_txt) == true then selectmore obj
				)
			)
		if $ != undefined do objtools obj_ops.state 	
		)
		
	on btn_elements pressed do
		(
		clearselection()
		for obj in objects do 
			(
			txt = filterstring obj.name "_,:,-"
			if txt[3] != undefined do
				(
				if matchPattern (txt[2]) pattern:(scne_num_txt) == true and matchPattern (txt[3]) pattern:(elem_num_txt) == true then selectmore obj
				)
			)
		if $ != undefined do objtools obj_ops.state 	
		)
		
	on btn_desc pressed do
		(
		clearselection()
		if desc_text.text != "" do
			(
			for obj in objects do 
				(
				txt = obj.name
				if findstring obj.name desc_text.text  != undefined then selectmore obj
				)
			)
		if $ != undefined do objtools obj_ops.state
		)
		
	on bt1 pressed do
		(
		qb = queryBox "Are You Sure You want to purge BIM Data?\nYou cannot undo this action!!!" title:"DATA PURGE"
		if qb == true do
			(
			case rb1.state of 	
				(
				1:	(--Selected Objects--
					objsel = getcurrentselection()
					for obj in objsel do (setuserpropbuffer obj "")
					)
			
				2:	(--All Objects-- 
					for obj in objects do (setuserpropbuffer obj "")
					)
				)
			)
		)
	
	on OBJBIM_UTL_Rollout open do
		(
		SetDialog OBJBIM_UTL_Rollout
		)
		
	on OBJBIM_UTL_Rollout moved position do
		(
		SetDialog OBJBIM_UTL_Rollout
		)
		
	on OBJBIM_UTL_Rollout close do
		(
		SetDialog OBJBIM_UTL_Rollout
		)	
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Define Submenus for Main RenderMonkey Rollout ---
---------------------------------------------------------------------------------------------------------------------------------------------

RCMenu OBJBIM_RCmenu
	(
	menuItem EN "Namer"
	menuItem EM "Materials"
	menuItem ES "Schedule"
	menuItem EV "Vendor"
	menuItem EC "Calculations"
	submenu "Utilities"
		(
		menuItem UTL "Object Utilities"
		menuItem OBJ_BIM "Open BIM Manager"
		)
	Submenu "Help"
		(
		menuItem About_BIM "About Object BIM"
		menuItem Help_BIM "Help Manual"
		menuItem WebHelp_BIM "Help on Web"
		)
		
	on EN picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog OBJBIM_NM_Rollout 375 400 FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on EM picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog OBJBIM_MTL_Rollout 375 360 FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on ES picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog OBJBIM_SCH_Rollout 400 350 FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
	
	on EV picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog OBJBIM_VEN_Rollout 375 760 FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on EC picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog OBJBIM_CALC_Rollout 375 395 FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on UTL picked do 
		(
		ClearDialogs()
		GetDialogSet()
		createDialog OBJBIM_UTL_Rollout 375 325 FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
		
	on OBJ_BIM picked do 
		(
		FileIn "$userscripts\\CGsoldier\\CGS-SceneTools\\VPD Manager_v1.mse"
		)
	
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
		createDialog (execute LastMenu) FLw FLh FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
	else
		(
		ClearDialogs()
		createDialog OBJBIM_NM_Rollout 275 275 FLx FLy menu:OBJBIM_RCmenu style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Script End
---------------------------------------------------------------------------------------------------------------------------------------------
)