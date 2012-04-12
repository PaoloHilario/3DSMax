-------------------------------------------------------------------------------
-- Reference_Scale.ms
-- By Paolo Hilario (cgsoldier@gmail.com)
-- v 1.01
-- Created On: 04/22/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Allows you to scale objects based on a reference and target length
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Press the reference length key and click on two points (The size you want to scale from)
-- Press the target length button and click on two points (The size you want to scale to)
-- Select the objects you want to scale and hit the scale selected objects button
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------

(--Begin Script
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
	global refscale_rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

	local ref_a = [0,0,0]
	local ref_b = [0,0,0]
	local ref_dist = 0
	local tar_a = [0,0,0]
	local tar_b = [0,0,0]
	local tar_dist = 0
	local scale_perc
	local scale_axis = "XYZ"
	local scale_sel
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Scale_Reference" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Scale_Reference" "FloaterY") as integer)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	FileIn "$userscripts\\CGsoldier\\functions\\F360Lib_Functions.mse"	
	if refscale_rollout != undefined then DestroyDialog refscale_rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

	tool reference_scale 
		(
		on mousePoint clickno do 
			(
			if clickno == 2 then ref_a = worldPoint
			else if clickno == 3 then
				(
				ref_b = worldPoint
				ref_dist = (distance ref_a ref_b)
				#stop
				)
			)
		)

	tool target_scale 
		(
		on mousePoint clickno do 
			(
			if clickno == 2 then tar_a = worldPoint
			else if clickno == 3 then
				(
				tar_b = worldPoint
				tar_dist = (distance tar_a tar_b)
				#stop
				)
			)
		)
		
	fn scale_sel axis =
		(
		objset = getcurrentselection()
		undo "Reference Scale" on 
			(
			for obj in objset do
				(
				case axis of
					(
					"XYZ": obj.scale = [scale_perc,scale_perc,scale_perc]
					"X": obj.scale = [scale_perc,1,1]
					"Y": obj.scale = [1,scale_perc,1]
					"Z": obj.scale = [1,1,scale_perc]
					"XY": obj.scale = [scale_perc,scale_perc,1]
					"XZ": obj.scale = [scale_perc,1,scale_perc]
					"YZ": obj.scale = [1,scale_perc,scale_perc]
					)
				)
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout refscale_rollout "Scale Reference 1.0"
		(
		bitmap Bm1 filename:"$userscripts\\CGsoldier\\images\\ScaleRef.bmp" width:150 height:150 pos:[10,10]
		button btn1_GRL "Get Reference Length" width:140 height:20 pos:[170,10] 
		button btn2_GTL "Get Target Length" width:140 height:20 pos:[170,35] 
		label lbl1_STL "Specify Target Length:" pos:[170,60] 
		spinner sp1_STL fieldwidth:130 pos:[167,80] type:#worldunits range:[0,9999999,0]
		dropdownlist dd1_axis items:#("XYZ", "X", "Y", "Z", "XY", "XZ", "YZ") width:140 pos:[170,105]
		button btn3_Scale "Scale Selected Objects" width:140 height:25 pos:[170,135] 
			
		on refscale_rollout close do
			(
			PMpos = getDialogPos refscale_rollout
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Scale_Reference" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Scale_Reference" "FloaterY"  (( PMpos.y ) as String)
			AW_rollout = undefined 
			)
			
		on refscale_rollout moved position do
			(
			PMpos = position
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Scale_Reference" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Scale_Reference" "FloaterY"  (( PMpos.y ) as String) 
			)
			
		on btn1_GRL pressed do
			(
			startTool reference_scale prompt:"Get Reference Length"
			btn1_GRL.text = (units.formatvalue ref_dist) as string
			)
			
		on btn2_GTL pressed do
			(
			startTool target_scale prompt:"Get Target Length"
			btn2_GTL.text = (units.formatvalue tar_dist) as string
			sp1_STL.value = tar_dist
			scale_perc = (tar_dist/ref_dist)
			btn3_Scale.text = ("Scale: " + (scale_perc*100) as string +"%") 
			)
			
		on sp1_STL changed val do 
			(
			tar_dist = val
			scale_perc = (tar_dist/ref_dist) as double
			btn3_Scale.text = ("Scale: " + (scale_perc*100) as string +"%") 
			)
			
		on dd1_axis selected i do 
			(
			scale_axis = dd1_axis.selected
			)
			
		on btn3_Scale pressed do
			(
			if selection.count != 0 then 
				(
				reset_X_form()
				scale_sel scale_axis
				reset_X_form()
				) 
			else 
				(
				messagebox "No Objects Selected"
				)
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
		
		if refscale_rollout != undefined do DestroyDialog refscale_rollout
			(
			CreateDialog refscale_rollout 320 170 FLx FLy
			)
			
) -- End Script