-------------------------------------------------------------------------------
-- AutoWeld.ms
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 1.0
-- Created On: 02/26/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Cycles through selected lines and welds at currently set thresholds
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Choose multiple editable splines and run the script
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

	global AW_rollout

( -- Begin Script
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

--- Local Functions
	
	local AWspline
	local AWpoly
	local AWmesh
	local ObjSort
	local ProgText
	local ProgPerc
	
--- Local Variables
	
	local SplineSet
	local PolySet
	local MeshSet
	local FLx = ((getINISetting "$maxdata\\CGsoldier.ini" "AutoWelder" "FloaterX") as integer)
	local FLy = ((getINISetting "$maxdata\\CGsoldier.ini" "AutoWelder" "FloaterY") as integer)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	if AW_rollout != undefined then DestroyDialog AW_rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

fn ObjSort =
	(
	SplineSet = #()
	PolySet = #()
	MeshSet = #()
		
	for obj in selection do
		(
		case classof obj of
			(
			SplineShape: (append SplineSet obj)
			Line: (append SplineSet obj)
			Editable_Poly: (append PolySet obj)
			Editable_Mesh: (append MeshSet obj)
			)
		)
	)
	
fn AWspline XXX =
	(
	disableSceneRedraw()
	for obj in SplineSet do
		(
--		ProgPerc = (100.0*(findItem SplineSet obj)/(SplineSet.count) as integer)
		select obj
		max modify mode
		modPanel.setCurrentObject obj.baseObject
		subobjectLevel = 1
		max select all
		allknots = getknotselection $ 1
		deleteitem allknots 1
		deleteitem allknots (allknots.count)
		setknotselection $ 1 allknots
		weldSpline $ XXX
		max select all
		k = getknotselection $ 1
		for i = 1 to k.count do setKnotType $ 1 (k[i]) #corner
		modPanel.setCurrentObject obj.baseObject
		subobjectLevel = 0
		)
	enableSceneRedraw()
	)

fn AWpoly XXX =
	(
	disableSceneRedraw()
	for obj in PolySet do
		(
--		ProgPerc = (100.0*(findItem PolySet obj)/(PolySet.count) as integer)
		select obj
		obj.weldthreshold = XXX
		max modify mode
		modPanel.setCurrentObject obj.baseObject
		subobjectLevel = 1
		max select all
		polyop.weldVertsByThreshold obj (polyop.getVertSelection obj)
		modPanel.setCurrentObject obj.baseObject
		subobjectLevel = 0
		)
	enableSceneRedraw()
	)

fn AWmesh XXX =
	(
	disableSceneRedraw()
	for obj in MeshSet do
		(
--		ProgPerc = (100.0*(findItem MeshSet obj)/(MeshSet.count) as integer)
		select obj
		max modify mode
		modPanel.setCurrentObject obj.baseObject
		subobjectLevel = 1
		max select all
		meshop.weldVertsByThreshold obj (getVertSelection obj) XXX
		modPanel.setCurrentObject obj.baseObject
		subobjectLevel = 0
		)
	enableSceneRedraw()
	)

	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout AW_rollout "Auto Welder 1.0"
		(
		spinner spn1 "Weld Threshold:" pos:[15,10] width:176 height:16 range:[0,100,0] type:#worldunits
		button btn1 "Auto Weld Selected Objects" pos:[5,35] width:190 height:30
		label lbl1 "" align:#center width:200 pos:[5,75]
		timer clock "Selection Test" interval:250 active:true			
			
		on AW_rollout open do
			(
			if selection.count != 0 then
				(
				ObjSort()
				ProgText = ((SplineSet.count as string) + " Spline(s) - " + (PolySet.count as string) + " Poly(s) - " + (MeshSet.count as string) + " Mesh(s)")
				lbl1.text = ProgText
				)
			else
				(
				ProgText = "No Objects Selected"
				lbl1.text = ProgText
				)
			)
		
		on clock tick do
			(
			if selection.count != 0 then
				(
				ObjSort()
				ProgText = ((SplineSet.count as string) + " Spline(s) - " + (PolySet.count as string) + " Poly(s) - " + (MeshSet.count as string) + " Mesh(s)")
				lbl1.text = ProgText
				)
			else
				(
				ProgText = "No Objects Selected"
				lbl1.text = ProgText
				)
			)
		
		on AW_rollout close do
			(
			PMpos = getDialogPos AW_rollout
			setINISetting "$maxdata\\CGsoldier.ini" "AutoWelder" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$maxdata\\CGsoldier.ini" "AutoWelder" "FloaterY"  (( PMpos.y ) as String)
			AW_rollout = undefined 
			)
			
		on AW_rollout moved position do
			(
			PMpos = position
			setINISetting "$maxdata\\CGsoldier.ini" "AutoWelder" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$maxdata\\CGsoldier.ini" "AutoWelder" "FloaterY"  (( PMpos.y ) as String) 
			)
	
		on btn1 pressed do
			(
			ObjSort()
			if SplineSet.count !=0 do (AWspline spn1.value)
			if PolySet.count !=0 do (AWpoly spn1.value)
			if MeshSet.count !=0 do (AWmesh spn1.value)				
			)
		)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
		if AW_rollout != undefined do DestroyDialog AW_rollout
			(
			CreateDialog AW_rollout 200 100 FLx FLy
			)

	
) --End Script