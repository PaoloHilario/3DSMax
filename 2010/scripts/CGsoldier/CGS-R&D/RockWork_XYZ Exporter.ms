-------------------------------------------------------------------------------
-- Rockwork_XYZ Exporter.ms 
-- By Paolo Hilario (cgsoldier@gmail.com)
-- v 1.01
-- Created On: 04/22/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Exports XYZ files from splines based on the object name.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Select a spline or multiple splines, specify a directory to save to and it will 
-- export and XYZ file with a filename based on the object name. 
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
	
	global rwk_xyz_export
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
	local savepath
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RWK_XYZ_Exporter" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RWK_XYZ_Exporter" "FloaterY") as integer)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	include "U:\\WireWorks3D\\3DS Max\\Library.ms" 
	if rwk_xyz_export != undefined then DestroyDialog rwk_xyz_export

---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------

	
	fn export_xyz =
		(
		objset = getcurrentselection()
		for obj in objset do (if classof obj != SplineShape then deleteitem objset (finditem objset obj))
		
		for obj in objset do --Create the XYZ Files
			(
			if savepath != undefined do (createFile (savepath + "\\" + obj.name + ".xyz"))
			print (savepath + "\\" + obj.name + ".xyz")
			)
		
		for obj in objset do --Write the XYZ Values to the file. 
			(
			
			ExportXYZ (savepath + "\\" + objset[i].name + ".xyz")
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout rwk_xyz_export "Rockwork XYZ Exporter 1.0"
		(
		bitmap Bm1 filename:"$userscripts\\CGsoldier\\images\\ScaleRef.bmp" width:150 height:150 pos:[10,10]
		button btn1_save "Save Pass" align:#right height:20 pos:[170,10] enabled:true images:#("$usericons\\CGsoldier_16i.bmp", "$usericons\\CGsoldier_16a.bmp", 11, 7, 7, 8, 8) tooltip:"XYZ Data Folder"
		edittext txt1_SP "" align:#left pos:[195,10] fieldwidth:240 text:"Specify Folder For XYZ Files"
		button btn2_export "Export XYZ Data for Selected Splines" width:270 height:30 pos:[170,40] align:#right enabled:false
			
		on rwk_xyz_export close do
			(
			PMpos = getDialogPos rwk_xyz_export
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RWK_XYZ_Exporter" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RWK_XYZ_Exporter" "FloaterY"  (( PMpos.y ) as String)
			AW_rollout = undefined 
			)
			
		on rwk_xyz_export moved position do
			(
			PMpos = position
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RWK_XYZ_Exporter" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RWK_XYZ_Exporter" "FloaterY"  (( PMpos.y ) as String) 
			)
			
		on btn1_save pressed do
			(
			savepath = getSavePath caption:"Choose Folder to Save XYZ Data" initialDir:maxfilepath
			txt1_SP.text = savepath
			btn2_export.enabled = true
			)
			
		on btn2_export pressed do
			(
			objset = getcurrentselection()
			for obj in objset do (if classof obj != SplineShape then deleteitem objset (finditem objset obj))
			plists = getplists objset
			for i = 1 to objset.count do (ExportXYZ (savepath + "\\" + objset[i].name + ".xyz") plists[i])
			)
		)
		
---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
		
		if rwk_xyz_export != undefined do DestroyDialog rwk_xyz_export
			(
			CreateDialog rwk_xyz_export 450 170 FLx FLy
			)
			
) -- End Script