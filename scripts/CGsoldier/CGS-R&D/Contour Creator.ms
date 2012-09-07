-------------------------------------------------------------------------------
-- Contour_Slicer.ms
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
	local AWspline
	
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
	
	fn SliceX XXX =
		(
		select sliceset
		meshSelected = $
		center = meshSelected.center
		minX = meshSelected.min.x
		maxX = meshSelected.max.x
		minY = meshSelected.min.y
		maxY = meshSelected.max.y
		minZ = meshSelected.min.z
		maxZ = meshSelected.max.z
		delta = XXX
		for currentX = minX to maxX by delta do
			(
			s = section pos:[currentX,center.y,center.z] transform:(matrix3 [0,1,0] [0,0,1] [1,0,0] [0,0,0])
			max views redraw 
			convertToSplineShape s
			if numSplines s != 0 do AWspline s
			if numSplines s == 0 do delete s
			)
		)
		
	fn SliceY XXX =
		(
		select sliceset
		meshSelected = $
		center = meshSelected.center
		minX = meshSelected.min.x
		maxX = meshSelected.max.x
		minY = meshSelected.min.y
		maxY = meshSelected.max.y
		minZ = meshSelected.min.z
		maxZ = meshSelected.max.z
		delta = XXX
		for currentY = minY to maxY by delta do
			(
			s = section pos:[center.x,currentY,center.z] transform:(matrix3 [1,0,0] [0,0,1] [0,-1,0] [0,0,0]) 
			max views redraw 
			convertToSplineShape s
			if numSplines s != 0 do AWspline s
			if numSplines s == 0 do delete s
			)
		)
	
	fn SliceZ XXX = 
		(
		select sliceset
		meshSelected = $
		center = meshSelected.center
		minX = meshSelected.min.x
		maxX = meshSelected.max.x
		minY = meshSelected.min.y
		maxY = meshSelected.max.y
		minZ = meshSelected.min.z
		maxZ = meshSelected.max.z
		delta = XXX
		for currentZ = minZ to maxZ by delta do
			(
			s = section pos:[center.x,center.y,currentZ]
			max views redraw 
			convertToSplineShape s
			if numSplines s != 0 do AWspline s
			if numSplines s == 0 do delete s
			)
		)
		
	fn AWspline XXX =
		(
		select XXX
		max modify mode
		modPanel.setCurrentObject XXX.baseObject
		subobjectLevel = 1
		max select all
		weldSpline XXX 0.001
		modPanel.setCurrentObject XXX.baseObject
		subobjectLevel = 0
		)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout ES_Rollout "Elevation Slicer" width:280 height:150
		(
			label lbl1 "Label" pos:[11,12] width:280 height:17
			groupBox grp1 "Slice Axis" pos:[10,33] width:264 height:56
			checkButton ckbX "Along X" pos:[16,55] width:72 height:24 enabled:true
			checkButton ckbY "Along Y" pos:[104,55] width:72 height:24 enabled:true
			checkButton ckbZ "Along Z" pos:[192,55] width:72 height:24 checked:true
			spinner spn1 "Contour Spacing: " pos:[55,110] width:100 height:35 type:#worldunits scale:1 labelontop:true range:[0,9999,0] 
			button btn1 "Create Contours" pos:[164,100] width:110 height:35
			
		on ES_Rollout open do
			(
			lbl1.text = ("Current System Units: " + (units.SystemScale as string) + " = " + (units.SystemType as string))
			)
			
		on btn1 pressed do
			(
			macros.run "Tools" "Isolate_Selection"
			if selection.count != 0 then sliceset = getcurrentselection() else messagebox "No Objects Selected"
			if ckbX.checked do (SliceX spn1.value)
			if ckbY.checked do (SliceY spn1.value)
			if ckbZ.checked do (SliceZ spn1.value)
			)
		)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
	
	(
	CreateDialog ES_Rollout 280 150
	)
		
) --End Script