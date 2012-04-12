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
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	if ES_Rollout != undefined then DestroyDialog ES_Rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
fn detach_elev delta =
	(
	local plist = #()
	for i = 1 to (polyop.getnumverts $) do
		(
		p = polyop.getVert $ i 
		if p.Z <= (delta-1) then append plist i 
		)
	polyop.detachFaces $ (polyop.getFacesUsingVert $ plist) asNode:True delete:true
	)

fn Slicer delta = 
	(
	obj = $
	minZ = obj.min.z
	maxZ = obj.max.z
	obj.split = on
	disablesceneredraw()
	for currentZ = minZ to maxZ by delta do
		(
		obj.split = on
		obj.slice [0,0,1] [0,0,currentZ]
		detach_elev currentZ
		)
	enablesceneredraw()
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout ES_Rollout "Elevation Slicer" width:280 height:150
		(
			label lbl1 "Label" pos:[11,12] width:280 height:17
			groupBox grp1 "Slice Axis" pos:[10,33] width:264 height:56
			checkButton ckbX "Along X" pos:[16,55] width:72 height:24 enabled:false
			checkButton ckbY "Along Y" pos:[104,55] width:72 height:24 enabled:false
			checkButton ckbZ "Along Z" pos:[192,55] width:72 height:24 checked:true
			spinner spn1 "Slice Spacing: " pos:[55,110] width:100 height:35 type:#worldunits scale:1 labelontop:true range:[0,9999,0] 
			button btn1 "Slice & Dice" pos:[164,100] width:110 height:35
			
		on ES_Rollout open do
			(
			lbl1.text = ("Current System Units: " + (units.SystemScale as string) + " = " + (units.SystemType as string))
			)
			
		on btn1 pressed do
			(
			if selection.count == 1 then sliceset = getcurrentselection() else messagebox "No Objects or Too Many Selected"
			if classof $ == Editable_Poly then 
				(
				if ckbX.checked do (Slicer spn1.value)
				if ckbY.checked do (Slicer spn1.value)
				if ckbZ.checked do (Slicer spn1.value)
				) else
				(
				messagebox "Object is not an Editable Poly"
				)
			)
		)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
	
	(
	CreateDialog ES_Rollout 280 150
	)
		
) --End Script