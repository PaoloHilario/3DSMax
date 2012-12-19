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
	global namer_floater
	global namer_rollout
	global ren_options_rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjNamer" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjNamer" "FloaterY") as integer)
	
	local name_type_val = 1
	local scne_num_val = 1
	local scne_num_txt = "000"
	local elem_num_val = 1
	local elem_num_txt = "000"
	local cust_text_val = ""
	local desc_text_val = ""
	
	local Rename_Objects
	local Purge_Layers
	local Auto_Layers
	local check_tags
	local check_naming
	local objtool

	local group_members_val = false
	local auto_num_val = false
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"	
	if namer_floater != undefined then CloseRolloutFloater namer_floater

---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

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
--- Rollout Definition, Namer Rollout
---------------------------------------------------------------------------------------------------------------------------------------------

rollout namer_rollout "Object Namer"
	(
	group "Rename:" 
		(
		dropdownlist rename_type "" items:name_array height:30 
		edittext cust_text "Custom Prefix: " fieldWidth:160 text:cust_text_val align:#right enabled:false offset:[-2,5]
		spinner scne_num "Scene #: " range:[0,100,0] type:#integer scale:1 align:#left offset:[0,10] across:2 value:scne_num_val
		spinner elem_num "Element #: " range:[0,999,0] type:#integer scale:1 align:#right offset:[-2,10] value:elem_num_val
		edittext desc_text "Description: " fieldWidth:230 text:desc_text_val align:#right offset:[-2,5] labelontop:true
		button do_rename "Rename Selected Objects" width:230 height:30 align:#center toolTip:"Rename" offset:[0,10]
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

	group "Options"
		(
		checkbox group_members "Don't Rename Group Members" checked:false
		checkbox Auto_Num "Auto Number Elements" checked:false enabled:false
		)
		
	on group_members changed state do 
		(
		if group_members.checked == true then group_members_val = true 
		else group_members_val = false
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
	
	on namer_rollout open do
		(
		)
		
	on namer_rollout close do
		(
		PMpos = namer_floater.pos
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjNamer" "FloaterX"  (( PMpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjNamer" "FloaterY"  (( PMpos.y ) as String)
		namer_rollout = undefined 
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition, Namer Utilities
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout utilities_rollout "Scene Utilities:"
	(
	button check_scene "Check Scene for Bad Object Naming" width:250 height:30 align:#center toolTip:"Check Scene for Mis-Named Objects"
	button Apply_To_Layer "Apply Objects to Layers" width:250 height:30 align:#center toolTip:"Apply objects to the Proper Layers"
		
	group "Object Tools:"
		(
		radiobuttons obj_ops labels:#("Select", "Hide", "Unhide", "Isolate", "Freeze", "Unfreeze") default:1 Columns:3 offset:[0,5]
		button btn_type "Type" width:70 align:#left toolTip:"Select Objects by Type" across:3 offset:[0,10]
		button btn_scene "Scene" width:70 align:#center toolTip:"Select All Objects in a Scene" offset:[0,10] 
		button btn_elements "Elements" width:70 align:#right toolTip:"Select Elements within a Scene" offset:[0,10]
		)
		
	on check_scene pressed do
		(
		check_naming()
		)
	
	on Apply_To_Layer pressed do
		(
		Create_Layers()
		Auto_Layers()
--		Purge_Layers()
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
	)

namer_floater = newRolloutFloater "Object Namer v1.0 BETA" 275 505 FLx FLy
addRollout namer_rollout namer_floater
addRollout utilities_rollout namer_floater rolledup:false
)
-------------------------------------------------------------------------------