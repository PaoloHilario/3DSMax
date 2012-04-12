-------------------------------------------------------------------------------
-- CGS-SceneTools Run
-- By Paolo Hilario (paolo@cgsoldier.com)
-- Based on Neil Blevins' BSRun script (soulburn@blur.com)
-- v 1.0
-- Created On: 04/19/2005
-- tested using Max 8
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Required Files:
-- CGSLib.ms
-------------------------------------------------------------------------------

(
-- Globals

global bsrun_update
global bsr_io

global bsr_rollout
global bsr_floater

global script_names
global script_files

global CGS_Floater

-- Includes

include "$userscripts\\CGsoldier\\functions\\CGS_func.mse"

-- Variables

last_script_index = 1
the_script = 1

-- Functions

fn bsrun_update = 
	(
	script_names = #()
	script_files = get_all_files_in_dir ((getdir #userscripts) + "\\CGsoldier\\CGS-SceneTools\\") false "mse"
	if script_files.count != 0 then
		(
		for i = 1 to script_files.count do
			(
			the_name = (filenameFromPath script_files[i])
			append script_names (strip_file_extension the_name)
			)			
		)
	)

fn bsr_io = 
	(
	bsr_ini_name = ((getdir #maxdata) + "\\CGS-STrun.ini")
	if openFile bsr_ini_name != undefined then
		(
		bsr_ini = openFile bsr_ini_name
		inputdata = readLine bsr_ini
		my_index = findItem script_names inputdata
		if my_index == 0 then my_index = 1
		last_script_index = my_index
		close bsr_ini
		)
	else
		(
		bsr_ini = createFile bsr_ini_name
		format (strip_file_extension (filenameFromPath (script_files[the_script] as string))) to:bsr_ini
		close bsr_ini
		)
	)

-- Script

rollout CGS_rollout "CGsoldier Tools"
	(
	on CGS_rollout open do
		(
		the_script = last_script_index
		)
	bitmap CGSlogo "CGsoldier" pos:[10,10] fileName:"$userscripts/CGsoldier/images/CGsoldier.bmp"
	dropdownlist the_scripts "" items:script_names selection:last_script_index height:40 width: 200 pos:[70,15]
	button the_scripts_run "Run The Script" width:200 pos:[70,45] toolTip:"Run The Script"

	on the_scripts selected i do 
		(
		the_script = i
		)
	on the_scripts_run pressed do 
		(
		CloseRolloutFloater CGS_floater

		bsr_ini_name = ((getdir #maxdata) + "\\CGS-STrun.ini")
		if openFile bsr_ini_name != undefined then deletefile bsr_ini_name
		bsr_ini = createFile bsr_ini_name
		format (strip_file_extension (filenameFromPath (script_files[the_script] as string))) to:bsr_ini
		close bsr_ini
		
		FileIn (script_files[the_script] as string)
		)
		
	on CGS_rollout close do
		(
		CGS = CGS_Floater.pos	
	 	setINISetting "$maxdata\\CGsoldier.ini" "CGS-STrun_pos" "FloaterX"  (( CGS.x ) as String)
		setINISetting "$maxdata\\CGsoldier.ini" "CGS-STrun_pos" "FloaterY"  (( CGS.y ) as String)  
		)
	)

FLx= ((getINISetting "$maxdata\\CGsoldier.ini" "CGS-STrun_pos" "FloaterX") as integer)
FLy= ((getINISetting "$maxdata\\CGsoldier.ini" "CGS-STrun_pos" "FloaterY") as integer)

bsrun_update()
bsr_io()

if CGS_floater != undefined then CloseRolloutFloater CGS_floater

if  (( FLy == 0 )) then
 	( 
	CGS_floater = newRolloutFloater "CGS-Scene Tools v1.05" 300 105	
	addRollout CGS_rollout CGS_floater
	) else
	(
	CGS_floater = newRolloutFloater "CGS-Scene Tools v1.05" 300 105 FLx FLy
	addRollout CGS_rollout CGS_floater
	)
)
-------------------------------------------------------------------------------
