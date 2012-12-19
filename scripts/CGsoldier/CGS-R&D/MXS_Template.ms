-------------------------------------------------------------------------------
-- Script Name
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 1.0
-- Created On: 04/21/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
--
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

global XXX_Rollout

( -- Begin Script
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

--- Local Functions
	
local SetDialog
local GetDialogSet	

--- Local Variables

local ScriptName = "MXS Template"
local ScriptVersion = "v1.0.0.1"
local ScriptHeader = ScriptName + " " + ScriptVersion
local IniPath = "$maxdata\\MonoUtilities.ini"	
local FLx 
local FLy
local FLw
local FLh
local LastMenu
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Includes
---------------------------------------------------------------------------------------------------------------------------------------------
	
if XXX_Rollout != undefined then DestroyDialog XXX_Rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

fn SetDialog X =
	(
	Dpos = GetDialogPos X
	Dsize = getDialogSize X	
	setINISetting IniPath ScriptName "FloaterX"  (( Dpos.x ) as String)
	setINISetting IniPath ScriptName "FloaterY"  (( Dpos.y ) as String)
	setINISetting IniPath ScriptName "FloaterW"  (( Dsize.x ) as String)
	setINISetting IniPath ScriptName "FloaterH"  (( Dsize.y ) as String)
	setINISetting IniPath ScriptName "LastMenu"  X.name 
	)
	
fn GetDialogSet =
	(
	FLx = ((getINISetting IniPath ScriptName "FloaterX") as integer)
	FLy = ((getINISetting IniPath ScriptName "FloaterY") as integer)
	FLw = ((getINISetting IniPath ScriptName "FloaterW") as integer)
	FLh = ((getINISetting IniPath ScriptName "FloaterH") as integer)
	LastMenu = (getINISetting IniPath ScriptName "LastMenu")
	)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
rollout XXX_Rollout ScriptHeader
	(
			
	on XXX_Rollout open do
		(
		)
		
	on XXX_Rollout moved position do
		(
		SetDialog XXX_Rollout
		)

	on XXX_Rollout close do
		(
		SetDialog XXX_Rollout
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
	
GetDialogSet()
	
if FLw + FLh != 0 
	then
		CreateDialog XXX_Rollout FLw FLh FLx FLy
	else
		CreateDialog XXX_Rollout 300 200 FLx FLy
	
) --End Script