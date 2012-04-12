-------------------------------------------------------------------------------
-- CGS-R&D Tools Run
-- By Paolo Hilario (cgsoldier@gmail.com)
-- Based on Neil Blevins' BSRun script (soulburn@blur.com)
-- v 1.0
-- Created On: 04/19/2005
-- tested using Max 2011
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Required Files:
-- CGS_func.mse
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Release Notes:
/*
03.19.2011: Modified for General Release, Updated tools for Max 2011
*/
-------------------------------------------------------------------------------

(
-------------------------------------------------------------------------------
-- Includes
-------------------------------------------------------------------------------

include "$userscripts\\CGsoldier\\library\\CGS_func.mse"

-------------------------------------------------------------------------------
-- Global Variables
-------------------------------------------------------------------------------

global CGS_RD
global CGS_RD_Floater

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------

global get_scripts
fn get_scripts = 
	(
	script_files = get_all_files_in_dir ((getdir #userscripts) + "\\CGsoldier\\CGS-R&D\\") false "mse"
	sort script_files
	return script_files
	)
	
global get_script_names
fn get_script_names script_files =
	(
	script_names = #()
	if script_files.count != 0 then
		(
		for i = 1 to script_files.count do
			(
			the_name = (filenameFromPath script_files[i])
			append script_names (strip_file_extension the_name)
			)			
		)
		return script_names
	)

global floater_last
fn floater_last script_names = 
	(
	last_script = getINISetting ((getdir #maxdata) + "\\CGsoldier.ini") "CGS_RDrun" "LastScript"
	if last_script != undefined then
		(
		my_index = findItem script_names last_script
		if my_index == 0 then my_index = 1
		return my_index
		)
		else
		(
		setINISetting ((getdir #maxdata) + "\\CGsoldier.ini") "CGS_RDrun" "LastScript"  (strip_file_extension (filenameFromPath (script_files[the_script] as string)))	
		return 1
		)
	)

global floater_ko	
fn floater_ko = 
	(
		ko = (getINISetting ((getdir #maxdata) + "\\CGsoldier.ini") "CGS_RDrun" "KeepOpen")
		if ko != "" then
		(
			return (ko as booleanClass)
		)
		else 
		(
			return true
		)
	)
	
-------------------------------------------------------------------------------
-- Script
-------------------------------------------------------------------------------

local script_files = get_scripts()
local script_names = get_script_names script_files
local the_script = floater_last script_names
local keep_open = floater_ko()

rollout CGS_RD "CGsoldier R&D Tools"
	(
	bitmap CGSlogo "CGsoldier" pos:[10,10] fileName:"$userscripts/CGsoldier/images/CGsoldier.bmp"
	dropdownlist the_scripts "" items:script_names selection:the_script height:40 width: 200 pos:[70,15]
	button the_scripts_run "Run The Script" width:125 pos:[70,45] toolTip:"Run The Script"
	checkbutton btn_keep_open "Keep Open" checked:keep_open pos:[195, 45] width:75 

	on the_scripts selected i do 
		(
		the_script = i
		)
		
	on the_scripts_run pressed do 
		(
		if keep_open == false do CloseRolloutFloater CGS_RD_Floater
	 	setINISetting ((getdir #maxdata) + "\\CGsoldier.ini") "CGS_RDrun" "LastScript"  (strip_file_extension (filenameFromPath (script_files[the_script] as string)))	
		FileIn (script_files[the_script] as string)
		)
		
	on btn_keep_open changed state do
	(
		keep_open = state
		setINISetting ((getdir #maxdata) + "\\CGsoldier.ini") "CGS_RDrun" "KeepOpen"  (state as string)
	)
		
	on CGS_RD close do
		(
		CGS = CGS_RD_Floater.pos	
	 	setINISetting ((getdir #maxdata) + "\\CGsoldier.ini") "CGS_RDrun" "FloaterX"  (( CGS.x ) as String)
		setINISetting ((getdir #maxdata) + "\\CGsoldier.ini") "CGS_RDrun" "FloaterY"  (( CGS.y ) as String)  
		)
	)

FLx= ((getINISetting ((getdir #maxdata) + "\\CGsoldier.ini")  "CGS_RDrun" "FloaterX") as integer)
FLy= ((getINISetting ((getdir #maxdata) + "\\CGsoldier.ini")  "CGS_RDrun" "FloaterY") as integer)

if CGS_RD_Floater != undefined then CloseRolloutFloater CGS_RD_Floater

if  (( FLy == 0 )) then
 	( 
	CGS_RD_Floater = newRolloutFloater "CGS-R&D Tools v1.1" 300 105	
	addRollout CGS_RD CGS_RD_Floater
	) else
	(
	CGS_RD_Floater = newRolloutFloater "CGS-R&D Tools v1.1" 300 105 FLx FLy
	addRollout CGS_RD CGS_RD_Floater
	)
)
-------------------------------------------------------------------------------
