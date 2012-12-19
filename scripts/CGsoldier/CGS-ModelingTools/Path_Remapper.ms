-------------------------------------------------------------------------------
-- Path_Remapper.ms
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 1.00
-- Created On: 11/20/06
-- Modified On: N/A
-- tested using Max 8
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Required Files:
-- BSLib.ms, http://www.blur.com/blurmaxscripts
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-- v 1.1 Added Material Library Path Editing Function
-- Fixed small bugs and changed the way it searches for Vray Mesh Objects
-- by searching the object properties rather than the prefix of the objects. 

-------------------------------------------------------------------------------

(
-- Globals

global SPC_rollout
global get_all_matlib_maps
global get_scene_bitmaps
global get_scene_meshpaths
global get_matlib_paths


-- Local Variables

local txtfind
local txtreplace
local pathtype
global bitmap_paths
global mesh_paths
global matlib_paths
local theRange

-- Includes

fileIn "$userscripts\\BlurScripts\\BSLib.mse"

-- Close Old Dialogs

if SPC_rollout != undefined then destroydialog SPC_rollout

-- Functions

fn get_all_matlib_maps = 
	(
	b = #()
	for i = 1 to currentMaterialLibrary.count do
		(
		a = #()
		get_maps_from_mat currentMaterialLibrary[i] a
		join b a
		)
	trim_dups b
	qsort b name_compare_case_insensitive
	return b
	)

fn get_scene_bitmaps =
	(
	a = #()
	b = #()
	c = #()
	d = #()
	all_maps = #()
	all_bm = #()
	total_files_copied = 0
	
	a = get_all_scene_maps()
	b = get_all_medit_maps()
	c = get_misc_scene_maps true true true true true
	d = get_all_maps_in_selected_objs()
	
	all_maps = a + b + c + d
	bitmap_paths = get_bitmaps_from_maps all_maps
	
	trim_dups bitmap_paths
	)
	
fn get_scene_meshpaths = 
	(
	mesh_paths = #()
	for obj in geometry do 
		(
		if isProperty obj #filename == true then append mesh_paths obj
		)
	)
	
fn get_matlib_paths = 
	(
	matlib_mats=#()
	matlib_maps=#()
	matlib_mats = for i=1 to currentmateriallibrary.count collect currentmateriallibrary[i]	
	matlib_maps = get_all_matlib_maps()
	matlib_paths = get_bitmaps_from_maps matlib_maps
	trim_dups matlib_paths
	)
	
fn AXListView lv =
	(
	lv.gridLines = true  
	lv.View = (dotNetClass "System.Windows.Forms.View").Details  
	lv.fullRowSelect = true 
	lv.AllowColumnReorder = true
	lv.Checkboxes = false
	lv.sorting = Ascending
	lv.labeledit = true
	
	layout_def = #("Filepath")
	
	for i in layout_def do
		(
		column = lv.Columns.add i 575
		) 
	) 
	
fn AXListUpdate lv x=
	(
	lv.Items.clear()
	theRange = #()
	for i = 1 to x.count do
		(
		li = dotNetObject "System.Windows.Forms.ListViewItem" (x[i].filename as string)
		append theRange li
		)
	lv.Items.AddRange theRange 
	)
	
-- The Script


	rollout SPC_rollout "Scene Path Converter v1.1" 
		(
		dropdownlist pathtype "Object Type" items:#("Scene Bitmap Paths", "Scene Vray Mesh Paths", "Material Library") selection:0 width:200 offset:[0,10] across:2
		button find_replace "Find & Replace" align:#right offset:[0,25] width:125 height:25 color:[255,255,255]
		edittext path_find "Find:" text:"Enter Character String to Find" labelOnTop:true offset:[0,10]
		edittext path_replace "Replace With:" text:"Enter Character String to Replace" labelOnTop:true offset:[0,10]
		label pftxt "" pos:[40,70] align:#left
		label prtxt "" pos:[85,120] align:#left
		dotNetControl lv "System.Windows.Forms.ListView" align:#left pos:[10,180]
		 
		
		on SPC_rollout open do
			(
			SPCsize = getDialogSize SPC_rollout	
			lv.size = dotNetObject "System.Drawing.Size" (SPCsize.x - 20 as integer) (SPCsize.y - 190 as integer)
			AXListView lv
			)
			
		on pathtype selected i do 
			(
			if pathtype.selection == 1 do
				(
				get_scene_bitmaps()
				AXListUpdate lv	bitmap_paths 
				)
			if pathtype.selection == 2 do
				(
				get_scene_meshpaths()
				AXListUpdate lv mesh_paths 
				)
			if pathtype.selection == 3 do
				(
				fileOpenMatLib()
				get_matlib_paths()
				AXListUpdate lv matlib_paths 
				)		
			)
			
		on path_find changed txt do 
			(
			txtfind = txt as string
			pftxt.text = txtfind	
			)
			
		on path_replace changed txt do 
			(
			txtreplace = txt as string
			prtxt.text = txtreplace
			)
			
		on find_replace pressed do
			(
			if pathtype.selection == 1 do
				(
				for i = 1 to bitmap_paths.count do
					(
					if findstring bitmap_paths[i].filename txtfind != undefined then
						(
						bitmap_paths[i].filename = replace bitmap_paths[i].filename (findstring bitmap_paths[i].filename txtfind) (txtfind.count) (txtreplace as string)
						)
					)
				get_scene_bitmaps()
				AXListUpdate lv	bitmap_paths
				)
			if pathtype.selection == 2 do
				(
				for i = 1 to mesh_paths.count do
					(
					if findstring mesh_paths[i].filename txtfind != undefined then
						(
						mesh_paths[i].filename = replace mesh_paths[i].filename (findstring mesh_paths[i].filename txtfind) (txtfind.count) (txtreplace as string)
						)
					)
				get_scene_meshpaths()
				AXListUpdate lv	mesh_paths
				)
			if pathtype.selection == 3 do
				(
				for i = 1 to matlib_paths.count do
					(
					if findstring matlib_paths[i].filename txtfind != undefined then
						(
						matlib_paths[i].filename = replace matlib_paths[i].filename (findstring matlib_paths[i].filename txtfind) (txtfind.count) (txtreplace as string)
						)
					)
				fileSaveMatLib()				
				get_matlib_paths()
				AXListUpdate lv	matlib_paths
				)
			)
		)
	
	(
	CreateDialog SPC_rollout 600 600 style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
	)
)