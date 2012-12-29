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

fn SliceX delta keepOrig=
	(
		for obj in sliceset do
		(
			offset = obj.pivot.x
			minX = refobj.pivot.x
			maxX = obj.max.x + delta
			for i in minX to maxX by delta do
				(
					currentX = i - offset
					cpy = copy obj
					print ("Slicing X @ " + (-(currentX + delta)) as string + " N[-1,0,0]")
					meshop.slice cpy cpy.faces [-1,0,0] -(currentX + delta) seperate:false delete:true 
					print ("Slicing X @ " + (currentX) as string + " N[1,0,0]")
					meshop.slice cpy cpy.faces [1,0,0] (currentX) seperate:false delete:true 
				)
			if keepOrig == false do delete obj
		)
	)
	
fn SliceY delta keepOrig =
	(
		for obj in sliceset do
		(
			offset = obj.pivot.y
			minY = refobj.pivot.y
			maxY = obj.max.y + delta
			for i in minY to maxY by delta do
				(
					currentY = i - offset
					cpy = copy obj
					print ("Slicing Y @ " + (-(currentY + delta)) as string + " N[0,-1,0]")
					meshop.slice cpy cpy.faces [0,-1,0] -(currentY + delta)  seperate:false delete:true 
					print ("Slicing Y @ " + (currentY) as string + " N[0,1,0]")
					meshop.slice cpy cpy.faces [0,1,0] (currentY) seperate:false delete:true 
				)
			if keepOrig == false do delete obj
		)
	)
	
fn SliceZ delta keepOrig = 
	(
		for obj in sliceset do
		(
			offset = obj.pivot.z
			minZ = refobj.pivot.z
			maxZ = obj.max.z + delta
			for i in minZ to maxZ by delta do
				(
					currentZ = i - offset
					cpy = copy obj
					print ("Slicing Z @ " + (-(currentZ + delta)) as string + " N[0,0,-1]")
					meshop.slice cpy cpy.faces [0,0,-1] -(currentZ + delta) seperate:false delete:true 
					print ("Slicing Z @ " + (currentZ) as string + " N[0,0,1]")
					meshop.slice cpy cpy.faces [0,0,1] (currentZ)  seperate:false delete:true 
				)
			if keepOrig == false do delete obj
		)
	)
		
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout ES_Rollout "Mesh Slicer" width:280 height:150
		(
			label lbl1 "Label" pos:[11,12] width:280 height:17
			groupBox grp1 "Slice Axis" pos:[10,33] width:264 height:56
			checkButton ckbX "Along X" pos:[16,55] width:72 height:24 checked:false
			checkButton ckbY "Along Y" pos:[104,55] width:72 height:24 checked:false
			checkButton ckbZ "Along Z" pos:[192,55] width:72 height:24 checked:false
			groupBox grp2 "Options" pos:[10,90] width:264 height:80
			spinner spn1 "Slice Spacing: " pos:[55,110] width:100 height:25 type:#worldunits scale:1 labelontop:true range:[0,9999,0] 
			checkBox ckbD "Keep Original Mesh" pos:[20,140] width:125 height:20 checked:true 
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
				then (sliceset = getcurrentselection() as array)
				else (messagebox "Please select one reference object and at least one mesh object")
					
			if ckbX.checked do (SliceX spn1.value ckbD.checked) 
			if ckbY.checked do (SliceY spn1.value ckbD.checked)
			if ckbZ.checked do (SliceZ spn1.value ckbD.checked)
			)
		)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
	
	(
	CreateDialog ES_Rollout 280 225
	)
		
) --End Script