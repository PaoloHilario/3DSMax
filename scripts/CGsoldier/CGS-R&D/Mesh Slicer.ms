-------------------------------------------------------------------------------
-- Elevation_Slicer.ms
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 1.02
-- Created On: 02/26/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Creates Spline sections of objects at specified increments
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Choose an object and specify the increments you need and it does the restw
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-------------------------------------------------------------------------------
-- v1.02: Now works with Poly and Mesh objects and a few new catches
-------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

	global ES_Rollout

(--Begin Script

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

--- Local Functions
	
	local SliceX
	local SliceY
	local SliceZ
	
--- Local Variables
	
	local sliceset
	local refobj
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	if ES_Rollout != undefined then DestroyDialog ES_Rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

fn SliceX obj delta detach=
	(
	select sliceset
	minX = refobj.min.x
	maxX = obj.max.x
		for obj in sliceset do
		(
			if detach == true then
			(
			for currentX = minX to maxX by delta do
				(
					cpy = copy obj
					meshop.slice cpy cpy.faces [-1,0,0] -currentX seperate:true delete:true 
					meshop.slice cpy cpy.faces [1,0,0] (currentX - delta) seperate:true delete:true 
				)
			)
			else
			(
			for currentX = minX to maxX by delta do
				(
					meshop.slice obj obj.faces [1,0,0] currentZ seperate:true  
				)
			)
		)
	)
	
fn SliceY obj delta detach =
	(
		select sliceset
		minY = refobj.min.y
		maxY = obj.max.y
		for obj in sliceset do
		(
			if detach == true then
			(
			for currentY = minY to maxY by delta do
				(
					cpy = copy obj
					meshop.slice cpy cpy.faces [0,-1,0] -currentY seperate:true delete:true 
					meshop.slice cpy cpy.faces [0,1,0] (currentY - delta) seperate:true delete:true 
				)
			)
			else
			(
			for currentY = minY to maxY by delta do
				(
					meshop.slice obj obj.faces [0,1,0] currentY seperate:true  
				)
			)
		)
	)
	
fn SliceZ obj delta detach = 
	(
		select sliceset
		minZ = refobj.min.z
		maxZ = obj.max.z
		for obj in sliceset do
		(
			if detach == true then
			(
			for currentZ = minZ to maxZ by delta do
				(
					cpy = copy obj
					meshop.slice cpy cpy.faces [0,0,-1] -currentZ seperate:true delete:true 
					meshop.slice cpy cpy.faces [0,0,1] (currentZ - delta) seperate:true delete:true 
				)
			)
			else
			(
			for currentZ = minZ to maxZ by delta do
				(
					meshop.slice obj obj.faces [0,0,1] currentZ seperate:true  
				)
			)
		)
	)
		
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout ES_Rollout "Elevation Slicer" width:280 height:150
		(
			label lbl1 "Label" pos:[11,12] width:280 height:17
			groupBox grp1 "Slice Axis" pos:[10,33] width:264 height:56
			checkButton ckbX "Along X" pos:[16,55] width:72 height:24 checked:false
			checkButton ckbY "Along Y" pos:[104,55] width:72 height:24 checked:false
			checkButton ckbZ "Along Z" pos:[192,55] width:72 height:24 checked:false
			groupBox grp2 "Options" pos:[10,90] width:264 height:80
			spinner spn1 "Slice Spacing: " pos:[55,110] width:100 height:25 type:#worldunits scale:1 labelontop:true range:[0,9999,0] 
			checkBox ckbD "Detach Meshes" pos:[20,140] width:100 height:20 checked:true
			button btn1 "Pick Ref Object" pos:[170,105] width:95 height:55
			button btn2 "Slice & Dice" pos:[10,180] width:264 height:35
			
		on ES_Rollout open do
			(
			lbl1.text = ("Current System Units: " + (units.SystemScale as string) + " = " + (units.SystemType as string))
			)
			
		on btn1 pressed do 
		(
			if selection.count == 1 then 
			(
				selset = getcurrentselection()
				refobj = selset[1]
				btn1.text = refobj.name as string
			)
			else messagebox "Please Select Only One Reference Object"
		)
		
		on btn2 pressed do
			(
			if selection.count >= 1 and refobj != null 
				then 
					sliceset = getcurrentselection() as array 
				else 
					messagebox "Please select one reference object and at least one mesh object"
			
			if classof $ == Editable_Mesh then 
				(
					if ckbX.checked do (SliceX $ spn1.value ckbD.checked) 
					if ckbY.checked do (SliceY $ spn1.value ckbD.checked) 
					if ckbZ.checked do (SliceZ $ spn1.value ckbD.checked) 
				) 
			else
				(
					messagebox "Object is not an Editable Mesh"
				)
			)
		)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
	
	(
	CreateDialog ES_Rollout 280 225
	)
		
) --End Script