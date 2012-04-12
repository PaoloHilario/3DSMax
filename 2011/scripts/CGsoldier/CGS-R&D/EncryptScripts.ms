-------------------------------------------------------------------------------
-- Encrypt Script
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 1.0 Beta
-- Created On: 06/07/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Encrypts Scripts Within a Directory
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Select a Directory at the prompt and it will encrypt all scripts within
-- that selected directory. 
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

	global EncryptScript_rollout

( -- Begin Script
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

--- Local Functions
	

--- Local Variables
	
	local FLx = ((getINISetting "$maxdata\\CGsoldier.ini" "EncryptScript" "FloaterX") as integer)
	local FLy = ((getINISetting "$maxdata\\CGsoldier.ini" "EncryptScript" "FloaterY") as integer)
	local Last_Dir = undefined
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
-- 	fileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse" 
	if EncryptScript_rollout != undefined then DestroyDialog EncryptScript_rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout EncryptScript_rollout "Encrypt Script Beta"
		(
		radiobuttons rd1 "" labels:#("Single Script","Multiple Scripts") offset:[0,5]
		button btn1 "Encrypt Scripts" offset:[0,5] width:175 height:25
			
		on EncryptScript_rollout open do
			(
			)
			
		on EncryptScript_rollout close do
			(
			PMpos = getDialogPos EncryptScript_rollout	
			setINISetting "$maxdata\\CGsoldier.ini" "EncryptScript" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$maxdata\\CGsoldier.ini" "EncryptScript" "FloaterY"  (( PMpos.y ) as String)
			EncryptScript_rollout = undefined 
			)
				
		on btn1 pressed do 
			(
			case rd1.state of
				(	
				1:	(
					script = getOpenFileName()
					if script != undefined do encryptScript script
					)
					
				2: (
					initialdir = "$userscripts"
					if Last_Dir != undefined then (initialdir = Last_Dir)
					script_dir = (getSavePath caption:"Encrypt Scripts in Directory" initialDir:initialdir)
					if script_dir != undefined then (Last_Dir = script_dir)
					script_files = if script_dir != undefined do (get_all_files_in_dir script_dir true "ms")
					if script_files != undefined do (for i in script_files do (encryptScript i))
					)
				)
			)
		)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
		if EncryptScript_rollout != undefined do DestroyDialog EncryptScript_rollout
			(
			CreateDialog EncryptScript_rollout 225 75 FLx FLy
			)

	
) --End Script