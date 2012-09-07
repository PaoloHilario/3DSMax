-- Works on current selection
-- SelectString = $'nameofnode*s


Global F360Lib_Copy_Mapping = #()
Global F360Lib_Copy_Mapping_Name=#()

struct F360lib 
(
fn IsDateNewer dateStrA dateStrB =
(
	try
	(
		local dateA = DateAsPoint3 dateStrA
		local dateB = DateAsPoint3 dateStrB

		-- check for same date
		if (dateA == dateB) then
		(
			-- if same, compare seconds
			local secA = DateAsSeconds dateStrA
			local secB = DateAsSeconds dateStrB

			return (secA > secB)
		) else (
			-- if different, see which has the newer date
			if (dateA[DATE_YEAR] == dateA[DATE_YEAR]) then
			(
				if (dateA[DATE_MONTH] == dateB[DATE_MONTH]) then
				(
					return (dateA[DATE_DAY] > dateB[DATE_DAY])
				) else (
					return (dateA[DATE_MONTH] > dateB[DATE_MONTH])
				)
			) else (
				return (dateA[DATE_YEAR] > dateB[DATE_YEAR])
			)
		)
	) catch ( undefined )
),
fn Copy_UVW_Mapping SelObj =
(
F360Lib_Copy_Mapping=#()
F360Lib_Copy_Mapping_Name=#()
for z=1 to Selobj.modifiers.count do
	(
	if ( (substring (Selobj.modifiers[z] as string ) 1 6 ) == "Uvwmap") then
		(
		AM=Selobj.modifiers[z]
		append F360Lib_Copy_Mapping AM
		append F360Lib_Copy_Mapping_Name AM.name
		)
	)
),
fn Paste_UVW_Mapping_Copy SelObj =
(
for z=F360Lib_Copy_Mapping.count to 1 by -1 do
	(
	AM = copy F360Lib_Copy_Mapping [z]
	AM.name= F360Lib_Copy_Mapping_Name[z]
	addmodifier SelObj AM
	)
),
fn Paste_UVW_Mapping_Instance SelObj =
(
for z=F360Lib_Copy_Mapping.count to 1 by -1 do
	(
	AM = F360Lib_Copy_Mapping [z]
	AM.name= F360Lib_Copy_Mapping_Name[z]
	addmodifier SelObj AM
	)
),

fn  Reverse_Splines SelObjs =
(
set coordsys world
max modify mode

if SelObjs.count > 0 then
	(		
	for i=1 to SelObjs.count do
		(
		SelObj = SelObjs[i]
		if ( canConvertTo SelObj SplineShape )  then
			(
			reverse SelObj 1
			updateShape SelObj
			)
		)
	)
),

-- A scripted function that does the same as the Reset Transform
-- Utility.
--									Larry Minton
--
fn resetXForm  obj = 
(
	-- Get the original node transform matrix
	local ntm = obj.transform
	
	-- The new object transform only inherits position
	obj.transform=transMatrix obj.pos
	
	-- Compute the pivot transform matrix
	local piv=obj.objecttransform * inverse obj.transform
	
	-- Reset the object offsets to 0
	obj.objectoffsetPos  = [0,0,0]
	obj.objectoffsetRot = (quat 0 0 0 1)
	obj.objectoffsetScale = [1,1,1]
	
	-- Take the position out of the original node transform matrix since we don't reset position
	ntm.translation=[0,0,0]
	
	-- Apply the pivot transform matrix to the modified original node transform matrix
	-- to get the XForm gizmo transform
	ntm = piv * ntm
	
	-- apply an XForm modifier to the node
	local xformMod=xform()
	addmodifier obj xformMod
	
	-- set the XForm modifier's gizmo tranform
	xformMod.gizmo.transform=ntm
	
	-- return value of ok
	ok
),

fn DigitToString TextNum NumbDigits = 
(
local TN,lTN

TN = ( TextNum as string )
lTN = TN.count
if lTN < NumbDigits then
	(
	TN = (subString "00000000000000000000" 1 ( NumbDigits - lTN ) ) + ( TextNum as string )
	)
TN
),
fn Remove_Character SourceString Rchar= 
(
local TN=""
local TM=#()

TM=filterString SourceString Rchar
if (TM.count > 1 )  then
	(
	TN=TM[1]
	for i=2 to TM.count do
		TN=TN+TM[i]
	TM=TN
	)
TM
),
fn Make_Upper_Case instring =
(
local upper,lower,outstring
upper="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
lower="abcdefghijklmnopqrstuvwxyz"

outstring=copy instring 
for i=1 to outstring.count do
	(
	j=findString lower outstring[i]
	if ( j != undefined) then
		(
		outstring[i]=upper[j]
		)
	)
outstring
),
-- CONVERTS POINT3 STRING "[ X , Y , Z]" TO POINT3 NUMBER VALUE

fn String_to_Point3 SourceString = 
(
PV3=undefined
if sourceString != undefined then
(
TM = filterString SourceString "[, ]"

if (Tm.count ==3) then
	(
	try
	(
	PV3=[0,0,0]
	PV3.x = TM[1] as float
	PV3.y = TM[2] as float
	PV3.z = TM[3] as float
	)
	catch ( PV3=undefined )
	)
PV3
)
),
-- .Remove_Mapping_Modifiers [ Node ]
--
-- written By Keith R Morrison, June 04, 2003
--
-- Removes ONLY Uvwmapping types in modifier stack
-- from Node passed to it in SelObj
--
-- Returns number of Modifiers removed
--
fn Remove_Mapping_Modifiers SelObj =
(
local MtDel=#();
local ReturnValue = 0;

for i=1 to SelObj.modifiers.count do
	(
	if  substring (SelObj.modifiers[i] as string) 1 7 == "Uvwmap:" then
		Append MtDel i;
	)
if ( MtDel.count > 0 ) then
	( 
	for i=MtDel.count to 1 by -1 do
		(
		deletemodifier SelObj MtDel[i];
		)
	ReturnValue=MtDel.count;
	)
ReturnValue ;
),

--  Adds UVW mapping and name to Selection or object
--  AddUVWMapping [ object or selection ] Name [Mapchannel, Maptype, Axis ] [Length, Width, Height]
--  UVW name = Text string of name to give modifier
--	

fn AddUVWMapping SS UVWname Mtype Mvar =
	(
				U=uvwmap()
				U.mapChannel=Mtype.x
				U.maptype=Mtype.y
				U.axis=Mtype.z

				if ( Mvar.x != 0 ) then
					(
					U.length=Mvar.x
					U.width=Mvar.y
					U.height=Mvar.z
					)
				U.name = UVWname
				addModifier SS U
	)

)