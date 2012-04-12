(
Global SourceObjectName = #($'Z-RB3-STILE-SOURCE',
						 $'Z-RB3-STRIM-SOURCE',$'Z-RB3-STRIM-SOURCE-L',$'Z-RB3-STRIM-SOURCE-R',
						 $'Z-RB3-STRIMSTOP-SOURCE',$'Z-RB3-STRIMSTOP-SOURCE-L',$'Z-RB3-STRIMSTOP-SOURCE-R',
						 $'Z-RB3-STILEBRDSTOP-SOURCE',
						 $'Z-RB3-ESTILE-SOURCE',
--						 $'Z-RB3-ESTRIM-SOURCE',$'Z-RB3-ESTRIM-SOURCE-R',$'Z-RB3-ESTRIM-SOURCE-L',     Hold of enhanced trim
						 $'Z-RB3-STRIM-SOURCE',$'Z-RB3-STRIM-SOURCE-R',$'Z-RB3-STRIM-SOURCE-L',
						 $'Z-RB3-SSEAM-SOURCE',
						 $'Z-RB3-SSTRIM-SOURCE',
						 $'Z-RB3-FLATTRIM-SOURCE',$'Z-RB3-FLATTRIM-SOURCE-R',$'Z-RB3-FLATTRIM-SOURCE-L'
						 )
Global 	RB3_Source_GeoFile = "$userscripts\\CGsoldier\\merge\\CGS-Roof Monkey\\roof_merge_M8.max"
Local   MatLibFilename="$userscripts\\CGsoldier\\merge\\CGS-Roof Monkey\\RM Materials\\CGS-Roof_Monkey.mat"

Global	RB3_Floater  -- Floater Position save

Global Error_Text = "Begin"
-- Text Locating area of error

Global EnhancedXMapWidth = 11.9  -- Width of one tile on Enhanced Tile Source
Global EnhancedYMapWidth = 20  	-- Length of one tile on Enhanced Tile Source

Global RefGrid 
--  RefGrid  : Reference grid space for 2d Computations
	
Global Roof_Height
--  Base heigth of roof eve from Rollout

Global Roof_Angle
--  Slope Angle of Roof

Global RoofWidth
--  Width of Roof

Global StdMapX=76	
Global StdMapY=60
Global StdGrimeMapX=120
Global StdGrimeMapY=120

-- Standard Flat tile Mapping coors.

Global RB3_STileTrimlen = 16  -- S-Tile Trim length
Global RB3_FTileTrimlen = 16  -- Flat Tile Trim length

Global SS
--  SS is the standard SelectionSet

Global Style_Tile = ( 1 as integer )
-- StyleTile Def Integer 
-- 1 - Standard Flat tile
-- 2 - Standard S-Tile
-- 4 - Enhanced Flat Tile
-- 8 - Enhanced S-Tile
-- 16 - Standing Seam

Global Rotation_Z_Angle
--  World Coord Z rotation of roof based on Point 1 and 2

Global Roof_fp, Roof_sp, Roof_tp
--  Three point DATA , First Three points of Spline

Global SelShape
--  Input spline of Roof

Global BaseShape
Global StartShape

--  Flattened 2D spline of Roof at .z=0
Global NamedAutoGroup = #( $'RF-STILE*',$'RF-ESTILE*',$'RF-STSSEAM*',$'RF-FLAT*',$'RF-EFLAT*', $'Z-S_ROOFLINE*', 'RF-BASE' )
Global NamedAutoName  = #( "Z-3DROOFLINE", "RF-STILE", "RF-ESTILE",  "RF-STSSEAM","RF-TILE", "RF-EFLAT" , "RF-BASE", "Z-2DROOFLINE", "RF-STILETRIM",   "RF-ESTILETRIM",  "RF-STSSEAMTRIM","RF-TILETRIM", "RF-EFLATTRIM")


-- PER TRIM TILE VARIATIONS IF DEGREES AND INCHES
Global RB3_ZRotVari=0
Global RB3_ZHeightVari=0
Global RB3_ZHeightAdd=0
Global RB3_YRotVari=0
Global RB3_TrimLength=0
Global TrimTileStop
Global TrimTileStyle
Global TrimTileWireColor

--  Geometry names the script builds from AND GROUPS TO

Global AutoGroupBase=#("RF-BASE")
Global AutoGroupStile =#("RF-STILE","RF-STRIMSTOP","RF-STRIM","RF-STILEBRDSTOP")	 
Global AutoGroupEStile =#("RF-ESTILE","RF-STRIMSTOP","RF-STRIM","RF-STILEBRDSTOP")	 
Global AutoGroupFtile =#("RF-TILE","RF-FLATTRIM")	 
Global AutoGroupSSeam =#("RF-SSEAM","RF-SSTRIM")	 
Global AutoGroupName=""
Global RB3_ToGroup =#()

Global MX,MY,MZ

FileIn "$userscripts\\CGsoldier\\functions\\F360Lib_Functions.mse" 
-- Multi X,Y,Z  Misc. Varible

-- Function to select item and if it does not exist
-- merge it from the RB3 source file
-- GEOMETRY TO BE MOVED AND BOOLEAN IS SELECTED BEFORE
-- THE FUNCTION CALL
-- BOOLEAN IS EXTRUDED FROM SPLINE IN baseshape
-- Function to select item and if it does not exist
-- merge it from the RB3 source file


 rollout F360_Auto_Group_Roll "Focus 360 Auto Group"
(
label LBG1 ""
label LBG2 "Enter / Edit Group Name"
label LBG3 ""
edittext GrpName ""
button Gname "Name Group" across:2
button Gexit	"Cancel"

on Gexit pressed do
(
destroyDialog F360_Auto_Group_Roll
)
on Gname pressed do
(
try
(
if RB3_ToGroup.count >1 then
	(
	Ngrp=group RB3_ToGroup name:GrpName.text
	select Ngrp 
	)
)catch(destroyDialog F360_Auto_Group_Roll)
destroyDialog F360_Auto_Group_Roll
)
on F360_Auto_Group_Roll open do
(
GrpName.text=AutoGroupName
)
)

fn Collect_Visible NameString CharMatch =
-- function to collect items with same name -- NameString		duh
-- CharMatch    		Number of characters from the beginning of the name to match
(
--try
(
--TA=undefined
FA=#()
ExecStr= ("\n\nTA = $'"+( subString NameString 1 Charmatch )+"*' as array \n" )
format "\n\nCollect_Visible : % \n" ExecStr

execute ExecStr

format "TA=%\n" TA
if ( TA != undefined ) then
	(
	for i=1 to TA.count do
		(
		if TA[i].ishidden == false then
			( append FA TA[i] )
		)
	TA=FA
	)
)
--catch(format "\nFail Execute\n")
TA
)


fn Collect_and_Group CollectNameArray SugName =
(
try
(
A=#()
format "Collect array : %" CollectNameArray
for i=1 to CollectNameArray.count do
	(
	B=( Collect_Visible CollectNameArray[i] (CollectNameArray[i].count-2) ) 
	format "-- %\n" B
	if (B != undefined) then A=A+B
	)
Format "\n\n A = % " A
if ( A.count > 0 ) then
	(
	RB3_ToGroup = A
	AutoGroupName = SugName
	createDialog F360_Auto_Group_Roll 200 200 modal:true
	)
)catch()

)


fn RB3_Name_From_Source SrcNode =
(
Rname=filterString SrcNode.name  "-_"
Xname = uniqueName ( "RF-" + Rname[3] )
Xname
)

fn RB3_Select2 SourceItem= 
(
local MergeItemString

MergeItemString = filterString (SourceItem as string ) "$'"
format "Merging :% \n" MergeItemString

try
 	(
	select SourceItem
	)
catch
	(
	try
		(
		MergeItemString = StringFilter (SourceItem as string ) "$'"
		if (( mergeMaxFile RB3_Source_GeoFile SourceItem #deleteOldDups ) == false ) then
			messagebox "Error Merging items" Title:"Error Box"
		)
		catch
		(
		messagebox "Error Merging items" Title:"Error Box"
		)
	)
	
) 
fn RB3_Spline_Trimmer = 
(
Error_Text="Spline Trimmer."
SS = getCurrentSelection()

if SS.count == 0 then
(
messageBox("No Splines Selected")
)
else
(
for i=1 to SS.count do
	(
	StrimShp=SS[i]
	set coordsys World
	
	fp = getKnotPoint StrimShp 1 1
	sp = getKnotPoint StrimShp 1 2
	
	x1=fp.x
	x2=sp.x
	y1=fp.y
	y2=sp.y
	
	SPx=( x1 - x2 )
	SPy=( y1 - y2 )
	
	Rotation_Z_Angle=( Atan (( SPy / SPx) )) 
	Format "Raw Rotation_Z_Angle = % \n" Rotation_Z_Angle 
		
	if ( SPx >= 0 ) then
		( 	Rotation_Z_Angle=( Rotation_Z_Angle-180 )	)
	Format "Adjusted Rotation_Z_Angle = % \n\n" Rotation_Z_Angle

-- Create and rotate reference grid object.
-- Compute Slope of Line

 	RefGrid = grid Width:24 height:24 isSelected:True
	RefGrid.pos = fp
	rotate $ (angleaxis Rotation_Z_Angle [0,0,1])
	set coordsys RefGrid
	
	rsp = getKnotPoint StrimShp 1 2
	TrimTile_Angle=-( Atan (( rsp.z / rsp.x ) )) 
	format "TTA: % % \n" TrimTile_Angle rsp

	Error_Text=Error_Text+"Grid Created."
--	SET BIRD STOP AT FIRST POINT ON LINE
	if TrimTileStop != $'None' then
	(
	Error_Text=Error_Text+"Set Stop."
	set coordsys world
	Select TrimTileStop
	BaseTile = $
	FirstRow = reference Basetile isselected:true
	$.pos = fp
	rotate $ (angleaxis Rotation_Z_Angle [0,0,1])
	move $ [0,0,RB3_ZHeightAdd]
	set coordsys local
	rotate $ (angleaxis TrimTile_Angle [0,1,0])
	$.name = RB3_Name_From_Source $
	$.wirecolor=TrimTileWireColor
 	)

--  SET FIRST TILE AT FIRST POINT ON SPLINE

	Error_Text=Error_Text+"copy first."
	set coordsys world
 	Select TrimTileStyle
	BaseTile = $
	FirstRow = reference Basetile isselected:true
	$.pos = fp
	rotate $ (angleaxis Rotation_Z_Angle [0,0,1])
	move $ [0,0,RB3_ZHeightAdd]
	set coordsys local
	rotate $ (angleaxis TrimTile_Angle [0,1,0])
	$.name = RB3_Name_From_Source $
	$.wirecolor=TrimTileWireColor

--  CALCULATE NUMBER OF TILES TO THE TOP -1 AND COPY UP IN PARENT COOR. SYSTEM

	if ( TrimTileStyle != SourceObjectName[14] ) then
	(
	Error_Text=Error_Text+"Multi-copy."
	dx=distance [0,0,0] rsp
	Spx=( (dx / RB3_TrimLength) as integer)
	for i=1 to (Spx-1) do
		(
		NexTile = reference FirstRow isselected:true
		move $ [((RB3_TrimLength)*i),0,0]
		$.wirecolor=TrimTileWireColor
-- VARY TILE POSITIONS AND
-- +3" IN Z HEIGHT
--		d=( random 0 RB3_ZHeightVari)
--		move $ [0,0,(d-(d/2))]
--		rotate $ (angleaxis (random -RB3_ZRotVari RB3_ZRotVari) [0,0,1])
--		rotate $ (angleaxis (random 0 RB3_YRotVari) [0,1,0])
		)
		
--  DETERMINE IF END LAST TILE IS WITHIN 2" OF END OF LINE.
--	IF NOT, SET END TILE AND MOVE FAR VERTS BACK 
 	d=Spx
	Spx= mod dx RB3_TrimLength
	if Spx > 2 then
		(
		NexTile = copy FirstRow isselected:true
		move $ [((RB3_TrimLength)*d),0,0]
		$.wirecolor=TrimTileWireColor

		FirstRow=NexTile
		select NexTile

		max modify mode
		converttoMesh NexTile
		
		subobjectLevel=1
		set coordsys parent
		move $.selectedVerts [-((RB3_TrimLength - Spx )+1.5),0,0]
		subobjectLevel=0
		)
	)  -- End if not Standing Seam Tile
	else
	(
		Error_Text=Error_Text+"StSeam."
		
		dx= (distance [0,0,0] rsp)-24
		max modify mode
		converttoMesh $
		subobjectLevel=1
		set coordsys parent
		move $.selectedVerts [dx,0,0]
		subobjectLevel=0
		$.wirecolor=TrimTileWireColor
	)
	) -- end i to SS.count
 )
)

fn SelectByStringName SelectString = 
(
max select all
SS = getCurrentSelection()
DFSS =#()

for i=1 to SS.count do
	(
	TempName=SS[i].name	
	if ( (findString TempName SelectString ) != 1 ) then
 		(
		append DFSS i
		)
	)
for i=1 to DFSS.count do
	( 
	deselect SS[i]
	)
select SS
)


fn Standard_Boolean_Roof = 
(
	Error_Text=Error_Text+" Standard Boolean Roof"
	
		set coordsys world
		FirstRow = reference $ isselected:true
		$.pos = Roof_fp
		
		set coordsys local
		rotate $ (angleaxis Rotation_Z_Angle [0,0,1])
		rotate $ (angleaxis Roof_Angle [1,0,0])
		move   $  [-MX,MY,0]		

		set coordsys World
		copy baseshape isSelected:true
		boolshape=$
 		Boolshape.name="Boolean_S_TILE"
		convertToSplineShape boolshape
		Modify_Ext=extrude()
		Modify_Ext.amount=1200
		Modify_Ext.output=1
		addModifier boolshape Modify_Ext
		convertToMesh boolshape
		
		max create mode
	 	boolObj.createBooleanObject FirstRow boolshape 3 4
		boolObj.setBoolOp FirstRow 2
		delete boolshape
		select FirstRow
		move $ [0,0,1.25]


)  -- END STANDARD BOOLEAN ROOF

fn RB3_BuildRidgeSplines =
(
Local RB3SP_CAPS
Local CLSS = #()

set coordsys world
SS = getCurrentSelection()
 RB3SP_CAPS=splineshape ()

if SS.count == 0 then
(
messageBox("No Splines Selected") )
else
(
CurSpline=1
while (CurSpline <= SS.count ) do
	(
	testshape = SS[CurSpline]
	if canConvertTo testshape SplineShape then
		(
		Totknots = numKnots testshape 1 
		EveHeight= getKnotPoint testshape 1 1

		for i= 1  to ( TotKnots-1 ) do
			(
			
			fp = getKnotPoint testshape 1 i
			sp = getKnotPoint testshape 1 (i+1)
			
			if i == 1 then
				(
				sp = getKnotPoint testshape 1 Totknots
				 format "s>%-% : fp=%   sp=%\n" i TotKnots fp sp
				)
			else
				(
				 format "s>%-% : fp=%   sp=%\n" i (i+1) fp sp
				)

--  if there's a z change add segment
			if (floor ( fp.z as integer ) != floor ( sp.z as integer) ) then
				(
				if ( (distance fp sp )>18 ) then
				(
				if fp.z > sp.z then
					(
					RB3SP_CAPS=splineshape ()
					addnewspline RB3SP_CAPS
					NS=numSplines RB3SP_CAPS
					addknot RB3SP_CAPS NS #corner #line sp 1
					addknot RB3SP_CAPS NS #corner #line fp 2
					RB3SP_CAPS.name = uniquename "ZzZ-DRB3-CAPLINE01"		
					updateShape RB3SP_CAPS
					append CLSS RB3SP_CAPS
					)
				else
					(
					RB3SP_CAPS=splineshape ()
					addnewspline RB3SP_CAPS
					NS=numSplines RB3SP_CAPS
					addknot RB3SP_CAPS NS #corner #line fp 1
					addknot RB3SP_CAPS NS #corner #line sp 2
					RB3SP_CAPS.name = uniquename "ZzZ-DRB3-CAPLINE01"
					updateShape RB3SP_CAPS
					append CLSS RB3SP_CAPS
					)
				)
				) 			else
				(
				if ( (distance fp sp )>18 ) then 
				(
				if (fp.z > (EveHeight.z+16)) then
					(
					RB3SP_CAPS=splineshape ()
					addnewspline RB3SP_CAPS
					NS=numSplines RB3SP_CAPS
					addknot RB3SP_CAPS NS #corner #line fp 1
					addknot RB3SP_CAPS NS #corner #line sp 2
					RB3SP_CAPS.name = uniquename "ZzZ-DRB3-CAPLINE01"
					updateShape RB3SP_CAPS
					append CLSS RB3SP_CAPS
					)
				)
				)
			)
		)
	CurSpline=CurSpline+1
	)
-- format "dups dup dups \n\n\n\n"
-- CHECK FOR DUPS
i=1
DCLSS=#()
do
(
fp1 = getKnotPoint CLSS[i] 1 1
sp1 = getKnotPoint CLSS[i] 1 2
for ii=1 to CLSS.count do
	( 
	if ( i != ii ) then
	(
	fp2 = getKnotPoint CLSS[ii] 1 1
	sp2 = getKnotPoint CLSS[ii] 1 2
	if ( ( (distance fp1 fp2 ) < 1 ) and ( (distance sp1 sp2 ) < 1 ) ) then
		(
		if ((findItem DCLSS CLSS[ii] ) == 0 ) then
			(
			append DCLSS CLSS[i]
			)
		exit
		)
	if ( ( (distance sp1 fp2 ) < 1 ) and ( (distance fp1 sp2 ) < 1 ) ) then
		(
		if ((findItem DCLSS CLSS[ii] ) == 0 ) then
			(
			append DCLSS CLSS[i]
			)
		exit
		)
	)
	)
i=i+1
)
while ( i < CLSS.count )
if ( DCLSS.count >0 ) then
	delete DCLSS
try( delete $'Shape01' ) catch()
)
)

fn SplineKnotsToSlope testshape SlopeAngle =
(
Error_Text=Error_Text+"SplineKnotsToSlope"
if canConvertTo testshape SplineShape then
	(
	set coordsys RefGrid
	Totknots = numKnots testshape 1
	FP = getKnotPoint testshape 1 1

	for i=1 to Totknots do
		(
		sp = getKnotPoint testshape 1 i
		Dy = sp.y 
		sp.z = Roof_Height + ( Dy * tan( Roof_Angle ) )
		format "Dy=%  Z change :%" Dy sp.z
		setKnotPoint testshape 1 i sp 
		setKnotType testshape 1 i #corner
		)
	updateShape testshape
	)
)

fn Enhanced_Boolean_Roof = 
(
	Error_Text=Error_Text+"EBoolean Roof"
	set coordsys world 
	max modify mode
	
-- SELECT ENHANCED SOURCE AND SAVE MAPPING GIZMO INFO
	select SourceObjectName[9]
	SavGizPos=$.modifiers[2].gizmo.pos
	GrungeGiz = copy $.modifiers[1]
	GrungeGiz.name= copy $.modifiers[1].name
	
	TotRows= (( RoofWidth / 13 ) as integer)

	Error_Text=Error_Text+"-preloop"

	for h=0 to (TotRows-1) do
		(		
		MY=(h*14)

-- SELECT SOURCE OBJECT AND EFFECT MAPPING
		select SourceObjectName[9]
		RN=( random 0 14 )
		Adx = ( RN* EnhancedXMapWidth )
		RN=( random 0 8 )
		Ady = ( RN * EnhancedYMapWidth )
		RN= random 0 25000
		seed RN
		
		$.modifiers[2].gizmo.pos =$.modifiers[2].gizmo.pos+ [Adx,Ady,0]

		if ( h == ( TotRows-1) ) then
			(MY=MY-1.5)

		Standard_Boolean_Roof ()

 		$.wirecolor=[200,30,20] 
		$.name= RB3_Name_From_Source $ 
		NGrungeGiz = copy GrungeGiz
		addmodifier $ NGrungeGiz
		
		if ( h > 0 ) then
			$.modifiers[1].gizmo.pos.y =($.modifiers[1].gizmo.pos.y - (h *  EnhancedYMapWidth ))

		if ( h != TotRows-1) then
			(
			set coordsys local
			move $ [0,-1.5,0]	
			)
		) 
)  -- END ENHANCED BOOLEAN ROOF


fn TestSplineDirection  =
(
	Error_Text=Error_Text+"Test Spline Direction"
	TSD=0
	CurSpline=1
	while (CurSpline <= SS.count ) do
	(
	selshape = SS[CurSpline]
 	if canConvertTo selshape SplineShape then
		(
		select selshape 
		fp = getKnotPoint selshape 1 1
		sp = getKnotPoint selshape 1 2
		tp = getKnotPoint selshape 1 3
		Vec1_2 = normalize ( sp - fp )
		Vec1_3 = normalize ( tp - fp )
		Cvect= cross Vec1_2 Vec1_3
	
		if Cvect.z < 0 then 
			(
			TS=splineshape ()
			addnewspline TS
			addknot TS 1 #corner #line sp
			addknot TS 1 #corner #line fp
			if ( numKnots selshape  == 3) then
				( addknot TS 1 #corner #line tp )
			else
				(
				for ii= (numKnots selshape) to 3 by -1 do
					(
					tp=getKnotpoint selshape 1 ii
					addknot TS 1 #corner #line tp
 					)
				)
			close TS 1
			updateShape TS
			TS.name=selshape.name
			SS[CurSpline]=TS
			delete selshape
			)
		)
	CurSpline=CurSpline+1
	)	
TSD
)
fn FindMinXMaxY SelSpline = 
(
Local DataX = #()

 Local DataY = #()
Local DataW = #()
Local KnotCount
Local PT

set coordsys RefGrid
Error_Text=Error_Text+"FindMinxMaxY"

knotcount= NumKnots SelSpline 1

for zz=1 to knotcount do 
	(
	PT=getKnotPoint SelSpline 1 zz
	append DataX PT.x
	append Datay PT.y
	Width=sqrt ( (PT.z*PT.z) + (PT.y * PT.y ) )
	append DataW Width
	)

MX=amin DataX
MY=amax DataY
RoofLength=((amax DataX )-(amin DataX))

RoofWidth = amax DataW

PT.x=0 if mx < DataX[1] then
	( PT.x= DataX[1]-mx )
PT

)

fn PullInVerts2inches = 
(
--	Error_Text=Error_Text+"PullInVertSel2"
	FirstRow = $
	
	max modify mode
	set coordsys parent
	subobjectLevel = 1 	 
	VSS= getVertSelection FirstRow
	VSSI = getVertSelection FirstRow 	-- invert selection
	for ii=1 to VSS.count do
		(
		if VSS[ii] then 
			(VSSI[ii]=false)
		else
			(VSSI[ii]=true)
		)
	setVertSelection FirstRow VSSI
	move $.selectedVerts [0,-2,0]
	subobjectLevel=0
	
)
-- TEST TO SEE IF ALL Z'S ARE IN THE SAME PLANE +/- .25"
-- RETURNS 1 IF ALL Z'S ARE IN THE SAME PLANE +/- .25"
-- RETURN 0 IF ANY Z VALUE IS <> BY MORE THAN .25" THAN ANY OTHER Z VALUE.

fn IsSplineFlatInZ testshape =
(
RV=1
if canConvertTo testshape SplineShape then
	(
	Totknots = numKnots testshape 1
	fp = getKnotPoint testshape 1 1
	for i=2 to Totknots do
		(
		sp = getKnotPoint testshape 1 i
		if ( (sp.z	>(fp.z+.25)) or (sp.z	<(fp.z-.25)) ) then
			(
			RV=0
			)
		)
	)
	else
	( RV=0 )
RV
)
fn SplineKnotsToZero testshape =
(
set coordsys world
RV=1
if canConvertTo testshape SplineShape then
	( 	Totknots = numKnots testshape 1
	for i=1 to Totknots do
		(
		fp = getKnotPoint testshape 1 i
		fp.z=0
		setKnotPoint testshape 1 i fp
		setKnotType testshape 1 i #corner
 		)
	)
	else
	( RV=0 )
RV
)
fn RB3_Draw_Roofs = 
(
print "RB3_Draw_Roofs"
progressStart "Roof Monkey 3.1"
--disablesceneredraw()
--try 
(
	set coordsys world
	SS = getCurrentSelection()

	if SS.count == 0 then
		(
		messageBox("No Splines Selected")
		)
	else
		(
		TSB = TestSplineDirection()

		CurSpline=1
		while (CurSpline <= SS.count ) do
		(
		PTE = ((( (CurSpline as float) / (SS.count as float ) )*100) as integer )
		progressUpdate PTE
		print PTE
		
		startshape = SS[CurSpline]
		if canConvertTo startshape SplineShape then
			(
			select startshape
			startshape.name= uniquename (NamedAutoName[1] +"00" )

--  Get first three points in real world space
			set coordsys world
			Roof_fp = getKnotPoint startshape 1 1
			Roof_sp = getKnotPoint startshape 1 2
			Roof_tp = getKnotPoint startshape 1 3
			
 -- compute rotation of grid in R.W.S.

			SPx=( Roof_fp.x - Roof_sp.x )
			SPy=( Roof_fp.y - Roof_sp.y )
 			Rotation_Z_Angle=( Atan (( SPy / SPx) )) 

			if ( SPx >= 0 ) then
 				( 	Rotation_Z_Angle=( Rotation_Z_Angle-180 )	)
 			if (( Rotation_Z_Angle==-270) and (Roof_tp.x > Roof_fp.x)) then ( Rotation_Z_Angle=-90 )
			if (( Rotation_Z_Angle==-90) and (Roof_tp.x < Roof_fp.x)) then ( Rotation_Z_Angle=-270 )
			if (( Rotation_Z_Angle==0) and (Roof_tp.y < Roof_fp.y)) then ( Rotation_Z_Angle=180 )
			if (( Rotation_Z_Angle==-180) and (Roof_tp.y > Roof_fp.y)) then ( Rotation_Z_Angle=0 )

			Format "Adjusted Rotation_Z_Angle = % \n\n" Rotation_Z_Angle

--CREATE AND ROTATE REFERENCE GRID OBJECT. COMPUTE MX,MY OFFSETS.

			RefGrid = grid Width:24 height:24 isSelected:True
			RefGrid.pos = Roof_fp
			rotate $ (angleaxis Rotation_Z_Angle [0,0,1])
			PT=FindMinXmaxY( startshape )
			MX=PT.x
			MY=PT.y

-- CHECK IF SPLINE HAS Z DATA IN IT
			set coordsys world
			HASZ = IsSplineFlatInZ startshape
			format "HASZ = %" HASZ
 			if ( HASZ == 0 ) then
				(
				updateShape startshape
				baseshape = copy startshape 
				baseshape.name= uniquename (NamedAutoName[8] +"00" )
				set coordsys world
				SplineKnotsToZero baseshape
				
				set coordsys RefGrid
				Tp1 = getKnotPoint startshape 1 2
				Tp2 = getKnotPoint startshape 1 3
				rise=abs( Tp2.z - Tp1.z) 
				run=abs( Tp2.y - Tp1.y)
				Roof_Angle= atan( rise / run )
				)
			else				
				(
 				print "Compute Z-slope"
				if ( Roof_Angle > 0 ) and (Roof_Angle<90) then
					( 					
					SplineKnotsToZero startshape
					baseshape=copy startshape
					baseshape.name= uniquename (NamedAutoName[8] +"00" )
					SplineKnotsToSlope startshape Roof_Angle
					set coordsys world
					Roof_fp = getKnotPoint startshape 1 1
					Roof_sp = getKnotPoint startshape 1 2
					Roof_tp = getKnotPoint startshape 1 3 
					)
				else
					(
					baseshape=undefined
					startshape=undefined				 					
					Error_Text="Invalid Roof Angle"
					) 
				)
-- CREATE BASE ROOF IF ROOFBASE OR FLAT TILE IS NEEDED
			select startshape
			if ( (bit.and Style_Tile 32 ) == 32  ) then
				(
				Error_Text="Creating Roof Base"
				SavSel=$
				
				Ext=extrude()
				Ext.amount=1
				Ext.output=1
				
				Baseroof = copy startshape isSelected:true
				addModifier $ Ext
				convertToMesh $
				$.wirecolor = color 220 20 0
				$.name = uniquename ( (NamedAutoName[7] +"00" ) )
				try(
				$.material = currentMaterialLibrary["SCHM0-WOOD_TRM"]
				)catch()
				update baseroof

				U=uvwmap()
				U.maptype=0
				U.length=StdGrimeMapX
				U.width=StdGrimeMapY
				U.MAPchannel = 1
				U.axis=3
				addModifier baseroof U
				U.name = "(1) Grime"
												
				G=uvwmap()
				addModifier baseroof G
				G.length=StdGrimeMapX
				G.width=StdGrimeMapY
				G.name = "(2) Grime"
				G.Mapchannel = 2
				ConverttoPoly BaseRoof
				delete RefGrid
				select SavSel
				)
-- FLAT ASPHALT TILE ROOF - COPY OR MOVE UP BASE ROOF AND ADD UVW
			if ( (bit.and Style_Tile 1 ) == 1  ) then
				(
				Error_Text="Creating Roof Flat Tile"
				max modify mode
				SavSel=$
				
				Ext=extrude()
				Ext.amount=1
				Ext.output=1

				Baseroof = copy startshape isSelected:true
				addModifier $ Ext
				convertToMesh $
				$.wirecolor = [20,200,180]
				$.name= uniquename ( (NamedAutoName[5] +"00" ) )
				try(
				$.material = currentMaterialLibrary["SCHM0-RF_FLAT_TILE"]
				)catch()
				set coordsys World
				move $ [0,0,1.25]
				delete RefGrid

-- Compute Gizmo Rotation through rotation of grid objects
-- take Quat value from Grid object

				set coordsys RefGrid
				
--				RefGrid2 = Plane pos:[0,0,0] Size:[10,10,10]
				RefGrid2 = copy RefGrid 	
				rotate RefGrid2 (angleaxis 180 [0,0,1])
				rotate RefGrid2 (angleaxis Roof_angle [1,0,0])
				set coordsys World
				
				TR=RefGrid2.rotation
				delete RefGrid2

				U=uvwmap()
				U.maptype=0
				U.length=StdMapX
				U.width=StdMapY
				U.MAPchannel = 1
				U.axis=3

				addModifier $ U
				modPanel.setCurrentObject $.modifiers[1]
				subObjectLevel = 1

				set coordsys World				
				GizP1=$.center
				GizDif= Roof_fp-GizP1
				GizP2=( U.Gizmo.position + GizDif )
				
				U.Gizmo.rotation = TR
				U.Gizmo.position = GizP2
				U.name = "(1) Tile Mapping"
								
				G= copy U
				
				addModifier $ G
				G.length=StdGrimeMapX
				G.width=StdGrimeMapY
				G.name = "(2) Roof Grime"
				G.Mapchannel = 2
				GizP1=G.Gizmo.position 
				GizP2=[  (GizP1.x + ( random -StdGrimeMapX StdGrimeMapX)) ,(GizP1.y + ( random -StdGrimeMapY StdGrimeMapY)), GizP1.z  ]
				G.Gizmo.position= GizP2
				
				select SavSel 
 				)
		
-- COPY, PLACE AND BOOLEAN STANDARD S-TILE TILE ROOF

			if ( (bit.and Style_Tile 2 ) == 2  ) then
				(
 				Error_Text="Creating S-Tile Roof"
				MY=0
 				MZ=0
				delete RefGrid

-- COPY, PLACE AND BOOLEAN STANDARD BIRD STOP FOR STILE ROOF
				select SourceObjectName[8]
 				Standard_Boolean_Roof ()
				$.name= RB3_Name_From_Source $
				$.wirecolor=[200,30,20]
				select SourceObjectName[1]
 				Standard_Boolean_Roof ()
				$.name= RB3_Name_From_Source $
				$.wirecolor=[200,30,20]
--  PULL INVERT OF BOOLEANED VERT SELECTION OVER EDGE OF ROOF
				convertToMesh $
				PullInVerts2inches()
				)

-- COPY, PLACE AND BOOLEAN ENHANCED FLAT ASPHALT TILE ROOF
			if ( (bit.and Style_Tile 4 ) == 4  ) then
				(
				Baseroof= copy startshape isSelected:true
				max modify mode
				modPanel.addModToSelection (Extrude ()) 
				$.modifiers[#Extrude].amount = 1
				convertToMesh $
				set coordsys World
				move $ [0,0,1.25]
				$.name= RB3_Name_From_Source $
				)

-- COPY, PLACE AND BOOLEAN ENHANCED S-TILE TILE ROOF
			if ( (bit.and Style_Tile 8 ) == 8  ) then
				(
				Error_Text="Creating Enhanced S-Tile Roof"
				MY=0
 				MZ=0 
-- COPY, PLACE AND BOOLEAN STANDARD BIRD STOP FOR STILE ROOF
				select SourceObjectName[8]
 				Standard_Boolean_Roof ()
				$.name= RB3_Name_From_Source $
				$.wirecolor=[200,30,20]
				
				Enhanced_Boolean_Roof ()
				)

-- COPY, PLACE AND BOOLEAN STANDING SEAM ROOF

			if ( (bit.and Style_Tile 16 ) == 16  ) then
				(
				Error_Text="Creating Standing Seam"
				MY=0
 				MZ=0
 				select SourceObjectName[13]
				Standard_Boolean_Roof ()
				convertToMesh $
				$.name= RB3_Name_From_Source $
				$.wirecolor=[10,10,10]
				)
			delete RefGrid
			)  -- END CANCONVERTSHAPE IF			
			else
			(
			messageBox "Invalid Shape in selection"
			) -- end if conconvert
		if ValidRoof == 0 then
			(
			print CurSpline
			print "First two verts were not parallel on an X or Y Axis"
			)
		CurSpline=CurSpline+1
		Error_Text="Complete Roof"		
 		)-- END WHILE CURSPLINE
	)-- END IF SS.count
	Error_Text="Complete all Roofs"		
	progressUpdate 100
enablesceneredraw()
progressEnd ()
)
-- catch
(
	select SS
	enablesceneredraw()
)  )
rollout Splash_RB31 "Welcome to Roof Monkey 3.1"
(
 bitmap Bm1 filename:("$userscripts\\CGsoldier\\images\\roofmonkey.bmp") width:280 height:150 align:#center
 label lb1 "Merging Roof Building Geometry" align:#center
)
rollout RB3_rollout "Roof Monkey 3.1"
(
	local Angle_control_rise= bezier_float()	
	local Angle_control_run= bezier_float ()

	bitmap Bm2 filename:"$userscripts\\CGsoldier\\images\\roofmonkey.bmp" width:280 height:150 align:#center

--	group "Roof Building"
--		(		
 		spinner Roof_Base "Plate Height:" across:2 align:#center width:100 range:[-9000000000, 9000000000,12 ] type:#worldunits 
		spinner Roof_Over "  Overhang  :" width:80 align:#right range:[-9000000000, 9000000000,12 ] type:#worldunits 
		radiobuttons Roof_pitch "Roof Pitch" labels:#("1/12","2/12","3/12","4/12","5/12","6/12","7/12","Custom") default:8 columns:4	
		spinner Roof_rise "Roof Angle :" range:[1,24,4.0 ] across:2 width:90 align:#center type:#float scale:0.5 controller:Angle_control_rise
		spinner Roof_Run  "/" range:[1,24,12.0] width:50 type:#float scale:0.5 align:#left controller:Angle_control_run 
		checkbox Roof_Abs_UseAngle "Use Absolute Angle :" across:2 checked:false
		spinner Roof_Abs_Angle	range:[.5,88.9,18.33] type:#float scale:.05
		label labelspace01 "                  "
		label labelspace02 "Please check type of roof(s) you wish to create."
 		checkbox Rbase_it "Roof Base Plane" across:2 checked:false 
		checkbox SFtile_it "Flat Tile Plane" checked:false
--		checkbox EFtile_it "Enhanced Flat Tile" across:2 checked:false
		checkbox SStile_it "S Tile Roof  " across:2 checked:true
		checkbox EStile_it "Enhanced S Tile Roof  " across:2 checked:false
		checkbox SSStile_it "Standing Seam Roof  "  checked:false 
--		label labelspace03 "                  "
		button Roof_It "Roof it" width:120 height:35 align:#center
--		)
	group "Adding the Trim"    
	 	(
		button StrimData "Build Ridge Spline Cage" align:#center
		button RevSpline "Reverse Selected Spline(s)" align:#center
		label labelspace10 "                  "
		label labelspace12 "Please check type of cap(s) to create."
		checkbox CB_SFtrim_it "Standard Flat Tile"   across:2 checked:false --		checkbox CB_EFtrim_it "Enhanced Flat Tile" across:2 checked:false
		checkbox CB_SStrim_it "Standard S Tile   "  checked:true
--		checkbox CB_EStrim_it "Enhanced S Tile   " across:2 checked:false
		checkbox CB_SSStrim_it "Standing Seam    "  checked:false 
--		checkbox CB_ESStrim_it "Future use  " across:2 checked:false
		label labelspace11 "                  "
		button TrimLeft_It "Roll Left" width:80 height:25 across:3
		button TrimRidge_It "Hip / Ridge" width:80 height:25 
		button TrimRight_It "Roll Right" width:80 height:25 
 		)
--	group "Auto Group"
--		(
--		button Group_S 	"S-Tile"		 	width:120 height:20 across:2
--		button Group_F 	"Flat Tile" 			wIdth:120 height:20 
--		button Group_SS	"Standing Seam" 	width:120 height:20 across:2 
--		button Group_ES 	"Enhanced S-Tile"	width:120 height:20
--		button Coll_Base     "Collapse Roof Base " width:200 height:25 align:#center
--		)

on Coll_Base pressed do
(
BasSel  =( Collect_visible AutoGroupBase[1] 5 )
format "%\n" BasSel
if (BasSel != undefined) then
	(
	if ( BasSel.count >1 ) then
		(
		BaseOBJ = BasSel[1]
		for i=2 to BasSel.count do
			(
			if ( canconvertto BasSel[i] mesh ) then
					(
					attach BaseOBJ BasSel[i]
					converttoMesh BaseOBJ
					)
			)
		)
	)
)
on Group_S pressed do
(
Collect_and_group AutoGroupStile "RF-STILE"
)
on Group_ES pressed do
(
Collect_and_group AutoGroupEStile "RF-ESTILE"
)
on Group_F pressed do
(
Collect_and_group AutoGroupFtile "RF-FLATTILE"
)

on Group_SS pressed do
(
Collect_and_group AutoGroupSSeam  "RF-STANDINGSEAM"
)
on RevSpline pressed do
(
Reverse_Selection_of_Splines()
)



on RB3_rollout close do
	(
	cp = RB3_Floater.pos	
 	setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RM3" "FloaterX"  (( cp.x ) as String)
	setINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RM3" "FloaterY"  (( cp.y ) as String)  
	)
	
on Roof_pitch changed state do
(
RP=Roof_pitch.state
if RP==1 do
	(
	Angle_control_rise.value=1
	Angle_control_run.value=12
	)
if RP==2 do 	(
	Angle_control_rise.value=2
	Angle_control_run.value=12
	)
if RP==3 do
	(
	Angle_control_rise.value=3
	Angle_control_run.value=12
	)
if RP==4 do
	(
	Angle_control_rise.value=4
	Angle_control_run.value=12
	)
if RP==5 do 	(
	Angle_control_rise.value=5
	Angle_control_run.value=12
	)
if RP==6 do
	(
	Angle_control_rise.value=6
	Angle_control_run.value=12
	)
if RP==7 do
	(
	Angle_control_rise.value=7
	Angle_control_run.value=12
	)
)

on Roof_It pressed do
(
Style_Tile=0

if (SFtile_it.checked == true) then
	(	Style_Tile +=1	)
--if (EFtile_it.checked == true) then --	(	Style_Tile +=4	)
if (SStile_it.checked == true) then
	(	Style_Tile +=2	)
if (EStile_it.checked == true) then
	(	Style_Tile +=8	)
if (SSStile_it.checked == true) then 	(	Style_Tile +=16	)
if (Rbase_it.checked == true) then
 	(	Style_Tile +=32	)
if ( Roof_Abs_UseAngle.state == false ) then
(	Roof_Angle=atan(Angle_control_rise.value/Angle_control_run.value) )
else
( 	Roof_Angle=Roof_Abs_Angle.value )

Roof_Height=Basez=Roof_Base.value - (Roof_Over.value * tan(Roof_Angle))

max modify mode
try
	(
	disablesceneredraw()
	RB3_Draw_Roofs ()
	enablesceneredraw() 
	)
catch
	(
	enablesceneredraw()
--  messagebox Error_Text 
--	messagebox Error_Text title:"Error on Roof Monkey 3.1"
	destroyDialog RB3_rollout  	)
)
on StrimData pressed do
(
max hide inv
RB3_BuildRidgeSplines ()
hide SS
)
on TrimRidge_It pressed do
(
max modify mode
try
(
disablesceneredraw()

if (CB_SFtrim_it.checked == true ) then
	(
	TrimTileStop=$'None'
	TrimTileStyle=SourceObjectName[15]
	RB3_ZHeightAdd=1.25
	RB3_TrimLength=RB3_FTileTrimlen
	SavSS=getCurrentSelection()
	TrimTileWireColor=[20,200,180]
	RB3_Spline_Trimmer ()
	select SavSS
	)
if (CB_SStrim_it.checked == true ) then
	(
	TrimTileStop=SourceObjectName[5]
	TrimTileStyle=SourceObjectName[2]
	RB3_ZHeightAdd=4.25
	RB3_TrimLength=RB3_STileTrimlen
	SavSS=getCurrentSelection()
	TrimTileWireColor=[200,30,20]
	RB3_Spline_Trimmer ()
	select SavSS
	)
if (CB_SSStrim_it.checked == true ) then
	( 	TrimTileStop=$'None'
	TrimTileStyle=SourceObjectName[14]
	RB3_ZHeightAdd=2.25
	RB3_TrimLength=24
	SavSS=getCurrentSelection()
	TrimTileWireColor=[20,20,20]
	RB3_Spline_Trimmer ()
	select SavSS
	)
enablesceneredraw()
)
catch
(
enablesceneredraw()
	(
	delete RefGrid
	)
	messagebox Error_Text title:"Error on Roof Monkey"
	)
)

on TrimRight_It pressed do
(
max modify mode
try (
disablesceneredraw()
 if (CB_SFtrim_it.checked == true ) then
	( 
	TrimTileStop=$'None'
	TrimTileStyle=SourceObjectName[17] 
	RB3_ZHeightAdd=1.25
	RB3_TrimLength=RB3_FTileTrimlen
	SavSS=getCurrentSelection() 	TrimTileWireColor=[20,200,180]
	RB3_Spline_Trimmer ()
	select SavSS
	)
if (CB_SStrim_it.checked == true ) then
	(
	TrimTileStop=SourceObjectName[6]
	TrimTileStyle=SourceObjectName[3]
	RB3_ZHeightAdd=3.75
	RB3_TrimLength=RB3_STileTrimlen
	SavSS=getCurrentSelection()
	TrimTileWireColor=[200,30,20]
	RB3_Spline_Trimmer ()
	select SavSS
	)
if (CB_SSStrim_it.checked == true ) then
	(
	TrimTileStop=$'None'
	TrimTileStyle=SourceObjectName[14]
	RB3_ZHeightAdd=2.25
	RB3_TrimLength=24
	SavSS=getCurrentSelection()
	TrimTileWireColor=[20,20,20]
	RB3_Spline_Trimmer ()
	select SavSS
	)
enablesceneredraw()
)
catch
(
enablesceneredraw()
	(
	delete RefGrid
	)
	messagebox Error_Text title:"Error on Roof Monkey"
	)
)

on TrimLeft_It pressed do
(
max modify mode
try
(
disablesceneredraw()

if (CB_SFtrim_it.checked == true ) then
	(
	TrimTileStop=$'None'
	TrimTileStyle=SourceObjectName[16]

	RB3_ZHeightAdd=1.25
	RB3_TrimLength=RB3_FTileTrimlen
	TrimTileWireColor=[20,200,180]
	SavSS=getCurrentSelection()
	RB3_Spline_Trimmer ()
	select SavSS
	)
if (CB_SStrim_it.checked == true ) then
	(
	TrimTileStop=SourceObjectName[7]
	TrimTileStyle=SourceObjectName[4]
 	RB3_ZHeightAdd=3.75
	RB3_TrimLength=RB3_STileTrimlen
	SavSS=getCurrentSelection()
	TrimTileWireColor=[200,30,20]
	RB3_Spline_Trimmer ()
	select SavSS
	)
if (CB_SSStrim_it.checked == true ) then
	( 
	TrimTileStop=$'None'
	TrimTileStyle=SourceObjectName[14]
	RB3_ZHeightAdd=2.25
	RB3_TrimLength=24
	SavSS=getCurrentSelection()
	TrimTileWireColor=[20,20,20]
	RB3_Spline_Trimmer ()
	select SavSS
	)
enablesceneredraw()
)
catch
(
enablesceneredraw()
	(
	delete RefGrid
	)
	messagebox Error_Text title:"Error on Roof Monkey"
	)
)

) -- End rollout 


FLx= ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RM3" "FloaterX") as integer)
FLy= ((getINISetting "$UI\\Macroscripts\\CGsoldier.ini" "RM3" "FloaterY") as integer)

NeedToMerge=false
for i=1 to SourceObjectName.count do
	(if SourceObjectName[i] == undefined then NeedToMerge=true)
	
AutoGroupBase=#("RF-BASE")
AutoGroupStile =#("RF-STILE","RF-STRIMSTOP","RF-STRIM","RF-STILEBRDSTOP")	 
AutoGroupEStile =#("RF-ESTILE","RF-STRIMSTOP","RF-STRIM","RF-STILEBRDSTOP")	 
AutoGroupFtile =#("RF-TILE","RF-FLATTRIM")	 
AutoGroupSSeam =#("RF-SSEAM","RF-SSTRIM")	 
AutoGroupName=""

if ( NeedToMerge ) then
	(	
	createdialog Splash_RB31 300 190 
	if (( mergeMaxFile RB3_Source_GeoFile #deleteOldDups ) == false ) then
		(
		messagebox "Error Merging items" Title:"Error Box"
		)
	else
		(
	SourceObjectName = #(	$'Z-RB3-STILE-SOURCE',
						 $'Z-RB3-STRIM-SOURCE',$'Z-RB3-STRIM-SOURCE-R',$'Z-RB3-STRIM-SOURCE-L',
						 $'Z-RB3-STRIMSTOP-SOURCE',$'Z-RB3-STRIMSTOP-SOURCE-R',$'Z-RB3-STRIMSTOP-SOURCE-L',
						 $'Z-RB3-STILEBRDSTOP-SOURCE',
						 $'Z-RB3-ESTILE-SOURCE',
						 $'Z-RB3-ESTRIM-SOURCE',$'Z-RB3-ESTRIM-SOURCE-R',$'Z-RB3-ESTRIM-SOURCE-L',
						 $'Z-RB3-SSEAM-SOURCE',
						 $'Z-RB3-SSTRIM-SOURCE',
						 $'Z-RB3-FLATTRIM-SOURCE',$'Z-RB3-FLATTRIM-SOURCE-R',$'Z-RB3-FLATTRIM-SOURCE-L'
						 )
		sleep 5
		LoadMaterialLibrary MatLibFilename
		NeedToMerge = false
		)
	destroydialog Splash_RB31
	) 
	if ( not NeedToMerge ) then
	(
	if (RB3_Floater!= undefined) then closeRolloutFloater RB3_Floater
	if  (( FLy == 0 )) then
	 	( 
--		createDialog RB3_rollout 320 740 150 160
		RB3_Floater = newrolloutfloater "Roof Monkey 3.1" 300 650 150 160
		addrollout  RB3_rollout RB3_Floater 
		 ) 	else
	 	(  -- createDialog RB3_rollout 320 740 FLx FLy
		RB3_Floater = newrolloutfloater "Roof Monkey 3.1"  300 650 FLx FLy
		addrollout RB3_rollout RB3_Floater
		)
	)
)	