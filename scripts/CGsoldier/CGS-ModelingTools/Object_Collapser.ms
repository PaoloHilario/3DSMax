-----------------------------------------------
-----------------------------------------------
--- Collapse Monkey v0.1					---
--- By Paolo Hilario (paolo@cgsoldier.com)	---
--- Created 09.14.07						---
--- http://www.cgsoldier.com				---
--- CGsoldier "Miltitant CG Merc Tools"		---
-----------------------------------------------
-----------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variables
---------------------------------------------------------------------------------------------------------------------------------------------

	global ObjCollapser_rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	(

	--- session data holding ---
	
	local MSname
	local OBJname 
	
	--- Dialog Window Position --- 
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjCollapser" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjCollapser" "FloaterY") as integer)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	if ObjCollapser_rollout != undefined then DestroyDialog ObjCollapser_rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Main Object Collapser Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------

	rollout ObjCollapser_rollout "Object Collapser v0.1" 
	(
	bitmap RMicon "ObjectCollapser" filename:"$userscripts\\CGsoldier\\images\\ObjCollapse.bmp" align:#center
	button KDMsel "Kill Duplicate Materials on Selection" width:230 offset:[0,15]
	button KDMscene "Kill Duplicate Materials in Scene" width:230 offset:[0,5]
	edittext MStextbx "New Material Name" labelontop:true width:225 offset:[0,40]
	button CMSM "Create Multi-Sub Material" width:230 offset:[0,10]
	button ColObj "Collapse to Single Mesh" width:230 offset:[0,40]
	button ColMat "Collapse By Material" width:230 offset:[0,5] enabled:false
	groupBox group1 "Kill Duplicate Materials" pos:[5,255] width:240 height:85
	groupBox group2 "Create Multi-Sub Material from Selection" pos:[5,345] width:240 height:110
	groupBox group3 "Collapse Objects" pos:[5,460] width:240 height:90

	--- Dialog Actions --- 
	
	
	on ObjCollapser_rollout close do
		(
		OCpos = getDialogPos ObjCollapser_rollout	
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjCollapser" "FloaterX"  (( OCpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjCollapser" "FloaterY"  (( OCpos.y ) as String)
		RM_rollout = undefined 
		)
			
	on ObjCollapser_rollout moved position do
		(
		OCpos = position
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjCollapser" "FloaterX"  (( OCpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "ObjCollapser" "FloaterY"  (( OCpos.y ) as String) 
		)
		
	--- Button Actions ---	
	
	on KDMsel pressed do
		(
		if $ == undefined then messagebox "No Objects are Selected" else
			(
			if querybox "This will remove all duplicate materials on your selected objects. Make sure you do not have different materials with the same name or this will destroy them. Do You want to proceed?" then
				(	
				KillDupMatSel()
				)	
			)
		)
		
	on KDMscene pressed do
		(
		if querybox "This will remove all duplicate materials in your entire scene. Make sure you do not have completely materials with the same name or this will destroy them. Do You want to proceed?" then
			(
			KillDupMatScene()
			)
		)
		
	on MStextbx entered txt do
		(
		if txt != "" do
			(
			MSname = txt
			)
		)
		
	on CMSM pressed do 
		(
		if MSname == undefined or $ == undefined then
			(		
			if MSname == undefined then messagebox "Please enter a name for the Multi-Sub Material above"
			if $ == undefined then messagebox "No Objects are Selected"
			)
			else		
			(
			if querybox "This will create a new Multi-Sub Material in the Active Material Slot. Is this ok?" then 
				(
				MultiSubMatSel MSname
				)
			)	
		)
		
	on ColMat pressed do
		(
		if $ == undefined then messagebox "No Objects are Selected" else
			(
			if querybox "THIS WILL COLLAPSE SELECTED OBJECTS BASED ON THEIR MATERIALS.\nYOU WILL NOT BE ABLE TO UNDO THIS IF YOU CONTINUE. DO YOU WISH TO PROCEED?" then
				(
				objset = getcurrentselection()
				for obj in objset do (if obj.material == undefined then deselect obj)
				KillDupMatSel()
				mats = GetSelMats()
				matnames = for i in mats collect i.name
				MatOps = ArrayDelDups matnames
				for i = 1 to MatOps.count do
					(
					CollapseByMat MatOps[i]
					)
				)
			)
		)
		
	on ColObj pressed do
		(
		if $ == undefined or $.count == 1 then messagebox "No Objects or Not Enough Objects are Selected" else
			(
			if querybox "THIS WILL COLLAPSE ALL SELECTED OBJECTS TO A SINGLE MESH WITH A MULTI-SUB MATERIAL.\nYOU WILL NOT BE ABLE TO UNDO THIS IF YOU CONTINUE. DO YOU WISH TO PROCEED?" then
				(
				selobj = getcurrentselection()
				temp = #()
				for i = 1 to selobj.count do 
					(
					if superClassOf selobj[i] == GeometryClass then append temp selobj[i]
					)
				selobj = temp
				KillDupMatSel selobj
				CollapseAllSel selobj
--				meditMaterials[medit.GetActiveMtlSlot()] = $.material
				)
			)
		)
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Check for Existing RenderMonkey Data & Create RenderMonkey Rollout 
---------------------------------------------------------------------------------------------------------------------------------------------
		(
		if FLx == 0 then
			(
			CreateDialog ObjCollapser_rollout 250 560 style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
			) 
			else
			(
			CreateDialog ObjCollapser_rollout 250 560 FLx FLy style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox)
			)
		)
	)
