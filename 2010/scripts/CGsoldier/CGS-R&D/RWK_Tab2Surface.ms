-------------------------------------------------------------------------------
-- RWK_Tab 2 Surface
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 0.1 Alpha
-- Created On: 04/21/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Allows you to trim and extend Lines to a surface
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Select the Mesh
-- Select the line(s) to trim and extend
-- Checkboxes to trim/extend
-- Hit Tab 2 Surface
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
-- 09-17-2009 Alpha Build 
-------------------------------------------------------------------------------
-- 
-------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
--- Global Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

	global Tab2Surface_rollout

( -- Begin Script
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

--- Local Variables
	
	local Surf = #()
	local Tabs = #()
	
	local FLx = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Tab2Surface" "FloaterX") as integer)
	local FLy = ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Tab2Surface" "FloaterY") as integer)
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------
	
	include "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	if Tab2Surface_rollout != undefined then DestroyDialog Tab2Surface_rollout
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Function Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	local SurfaceFilter;
	fn SurfaceFilter OA = 
		(
		temp = #()
		for obj in OA do
			(
			if superclassof obj == GeometryClass do append temp obj
			)
		Surf = temp
		print Surf
		)
	
	local TabFilter;
	fn TabFilter OA = 
		(
		temp = #()
		for obj in OA do
			(
			if superclassof obj == Shape do append temp obj
			)
		Tabs = temp
		print Tabs
		)
		
	local D2P3; -- Distance to Point 3 --
	fn D2P3 D V OP = -- Distance * Normalized Vector + OriginPoint --
		(
		P3 = D*V+OP
		return P3
		) 
	
	local MoveVert;
	fn MoveVert obj vo tp = -- Args: Shape Object : vert index [Integer] to move : Target Point [Point 3 Value]  --
		(
		if superclassof obj == shape do
			(
			setKnotPoint obj 1 vo tp
			Updateshape obj
			)
		)
		
	local Marker;
	fn Marker P3 Style = 
		(
		case Style of 
			(
			1: ()
			2: Point pos:P3 isSelected:on centermarker:on axistripod:off cross:off size:20
			3: Point pos:P3 isSelected:on centermarker:off axistripod:off cross:on size:5
			)
		) 
		
---- I make a unit vector by diving the original ray direction (p2-p1) by the total length of the ray (distance p1 p2) (distance between the start and end positions of the ray).I then use rayMeshGridIntersect.getHitDist to figure out how far from the start position of the ray it intersected the mesh and multiplied that by the unit vector and then added that to the startpoint of the ray to get the actual worldspace of the hitpoint. It's actually less code than going down the bary path.

		
-- 	local T2M_IntersectRay; -- Method is Non-Voxel Based (slower) and ignores backfaces, but returns point 3 values --
-- 	fn T2M_IntersectRay = 
-- 		(
-- 		clearselection()
-- 		for obj in Tabs do
-- 			(
-- 			if numknots obj == 2 do
-- 				(
-- 				p1 = getKnotPoint obj 1 1; p2 = getKnotPoint obj 1 2
-- 				Hit = IntersectRay Surf[1] (ray p1 (p2 - p1))
-- 				MoveVert obj Hit.pos
-- 				)
-- 			)
-- 		)		

	local T2M_IntersectVox; -- Method is voxel based and allows intersection test regardless of normal direction; only returns distance --
	fn T2M_IntersectVox GridSize VertOp MarkNode = -- Arg: Voxel Grid Size --
		(
		RM = RayMeshGridIntersect()
		RM.Initialize GridSize
		RM.addNode Surf
		RM.buildGrid()
		for obj in Tabs do
			(
			if numknots obj == 2 do
				(
				local Intersect
				local Origin
				p1 = getKnotPoint obj 1 1; p2 = getKnotPoint obj 1 2
				if ((RM.IntersectRay p1 (p2-p1) true) > 0) do (Intersect = D2P3 (rm.gethitdist 1) (Normalize (p2-p1)) p1) -- Hit Test, Set Intersect P3 --
				if ((RM.IntersectRay p1 (p1-p2) true) > 0) do (Intersect = D2P3 (rm.gethitdist 1) (Normalize (p1-p2)) p1) -- Hit Test, Set Intersect P3 : Opposite Direction --
				if classof intersect == Point3 do
					(
					case VertOp of
						(
						1: Origin = (if ((distance p1 Intersect) < (distance p2 Intersect)) then 1 else 2)
						2: Origin = 1
						3: Origin = 2
						)
					Marker Intersect MarkNode
					MoveVert obj Origin Intersect
					)
				)
			)
		)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------
	
	rollout Tab2Surface_rollout "Tab 2 Surface"
		(
		bitmap Bm1 filename:"$userscripts\\CGsoldier\\images\\Tab2Surf.bmp" width:200 height:200 pos:[10,10]
		button btn1 "Choose Mesh" width:180 height:20 pos:[220,10] 
		button btn2 "Choose Tab(s)" width:180 height:20 pos:[220,35] 
		radiobuttons rb1 "Move Which Vert:" pos:[220,65] labels:#("Near      ","1st","2nd" ) Default:1 Columns:3
		radiobuttons rb2 "Node Marker:" pos:[220,110] labels:#("None    ","Center","Cross" ) Default:1 Columns:3
		spinner sp1 "Voxel Grid Size:  " pos:[220,155] fieldwidth:50 range:[10,1000,100] type:#integer
		button btn3 "Tab --> Surface" width:180 height:30 pos:[220,180] 
		
		-- Rollout Actions --
			
		on Tab2Surface_rollout close do
			(
			PMpos = getDialogPos Tab2Surface_rollout
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Tab2Surface" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Tab2Surface" "FloaterY"  (( PMpos.y ) as String)
			Tab2Surface_rollout = undefined 
			)
			
		on Tab2Surface_rollout moved position do
			(
			PMpos = getDialogPos Tab2Surface_rollout
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Tab2Surface" "FloaterX"  (( PMpos.x ) as String)
			setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "Tab2Surface" "FloaterY"  (( PMpos.y ) as String) 
			)	
			
		-- 	Interface Actions --
			
		on btn1 pressed do -- Get Surf --
			(
			case of
				(
					($selection.count == 1): (Surf = $; btn1.text = $.name )
					($selection.count == 0): messagebox "No Objects Selected"
					($selection.count > 1): messagebox "Only One Surface Allowed"
				)
			)
			
		on btn2 pressed do -- Get Tabs --
			(
			case of
				(
					($selection.count >= 1): (Tabs = ($selection as array); btn2.text = ($selection.count as string) + " Tabs")
					($selection.count == 0): messagebox "No Objects Selected"
				)
			)
			
		on btn3 pressed do -- Do Tab 2 Mesh --
			(
			VertOp = rb1.state
			MarkNode = rb2.state
			GridSize = sp1.value
			T2M_IntersectVox GridSize VertOp MarkNode
			)
			
		)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Launcher
---------------------------------------------------------------------------------------------------------------------------------------------
		if Tab2Surface_rollout != undefined do DestroyDialog Tab2Surface_rollout
			(
			CreateDialog Tab2Surface_rollout 410 220 FLx FLy
			)

	
) --End Script