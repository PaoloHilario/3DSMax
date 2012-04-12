-------------------------------------------------------------------------------
-- Reference_Rotate.ms
-- By Paolo Hilario (cgsoldier@gmail.com)
-- v 1.01
-- Created On: 04/29/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Allows you to rotate objects based on a reference and target angle
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Press the reference length key and click on two points (The original angle)
-- Press the target length button and click on two points (The desired angle)
-- Select the objects you want to rotate and hit the rotate selected objects button
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-------------------------------------------------------------------------------

(--Begin Script
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
	global refrotate_rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

	local ref_a = [0,0,0]
	local ref_b = [0,0,0]
	local ref_ang = 0
	local tar_a = [0,0,0]
	local tar_b = [0,0,0]
	local tar_ang = 0
	local rot_ang
	local rot_axis = "Z"
	local rot_sel
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Rotate_Reference" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Rotate_Reference" "FloaterY") as integer)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	if refrotate_rollout != undefined then DestroyDialog refrotate_rollout

---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

	tool reference_rotation 
		(
		on mousePoint clickno do 
			(
			if clickno == 2 then ref_a = worldPoint
			else if clickno == 3 then
				(
				ref_b = worldPoint
				ref_ang = acos(dot (normalize ref_a) (normalize ref_b))
				#stop
				)
			)
		)

	tool target_rotation 
		(
		on mousePoint clickno do 
			(
			if clickno == 2 then tar_a = worldPoint
			else if clickno == 3 then
				(
				tar_b = worldPoint
				tar_ang = acos(dot (normalize tar_a) (normalize tar_b))
				#stop
				)
			)
		)
		
	fn rot_sel axis =
		(
		objset = getcurrentselection()
		undo "Reference Scale" on 
			(
			for obj in objset do
				(
				case axis of
					(
					"XYZ": rotate obj eulerangles rot_ang rot_ang rot_ang
					"X": rotate obj (angleaxis rot_ang [1,0,0])
					"Y": rotate obj (angleaxis rot_ang [0,1,0])
					"Z": rotate obj (eulerangles 0 0 rot_ang)
					"XY": rotate obj (angleaxis rot_ang [1,1,0])
					"XZ": rotate obj (angleaxis rot_ang [1,0,1])
					"YZ": rotate obj (angleaxis rot_ang [0,1,1])
					)
				)
			)
		)
		
	fn reset_X_form =
		(
		objset = getcurrentselection()
		for obj in objset do 
			(
			ResetXForm obj
			collapseStack obj	
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout refrotate_rollout "Rotate Reference 1.0"
		(
		bitmap Bm1 filename:"$userscripts\\CGsoldier\\images\\RotateRef.bmp" width:150 height:150 pos:[10,10]
		button btn1_GRA "Get Reference Angle" width:140 height:20 pos:[170,10] 
		button btn2_GTA "Get Target Angle" width:140 height:20 pos:[170,35] 
		label lbl1_STL "Specify Target Angle:" pos:[170,60] 
		spinner sp1_STL fieldwidth:130 pos:[167,80] type:#float
		dropdownlist dd1_axis items:#("XYZ", "X", "Y", "Z", "XY", "XZ", "YZ") width:140 pos:[170,105] selection:4
		button btn3_Scale "Rotate Selected Objects" width:140 height:25 pos:[170,135] 
			
		on refrotate_rollout close do
			(
			PMpos = getDialogPos refrotate_rollout
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Rotate_Reference" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Rotate_Reference" "FloaterY"  (( PMpos.y ) as String)
			AW_rollout = undefined 
			)
			
		on refrotate_rollout moved position do
			(
			PMpos = position
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Rotate_Reference" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Rotate_Reference" "FloaterY"  (( PMpos.y ) as String) 
			)
			
		on btn1_GRA pressed do
			(
			startTool reference_rotation prompt:"Get Reference Angle"
			btn1_GRA.text = (ref_ang) as string
			)
			
		on btn2_GTA pressed do
			(
			startTool target_rotation prompt:"Get Target Angle"
			btn2_GTA.text = (tar_ang) as string
			sp1_STL.value = tar_ang
			rot_ang = (ref_ang-tar_ang)
			btn3_Scale.text = ("Rotation: " + (rot_ang) as string) 
			)
			
		on sp1_STL changed val do 
			(
			tar_ang = val
			rot_ang = (ref_ang-tar_ang)
			btn3_Scale.text = ("Rotation: " + (rot_ang) as string) 
			)
			
		on dd1_axis selected i do 
			(
			rot_axis = dd1_axis.selected
			)
			
		on btn3_Scale pressed do
			(
			if selection.count != 0 then 
				(
				rot_sel rot_axis
			--	reset_X_form()
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
		
		if refrotate_rollout != undefined do DestroyDialog refrotate_rollout
			(
			CreateDialog refrotate_rollout 320 170 FLx FLy
			)
			
) -- End Script