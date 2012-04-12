(
Global Material_FileData= "P:\\3D Resources\\Shared\\Render Management\\Max Object Material List.txt"

Global UndoOriginal=#() 
Global UndoNew=#()
Global Site_Rollout_Prefixer
Global One_Rename_Floater
Global Full_Rename_Rollout
Global Loft_Construction_Rollout
Global Newtext=""
Global EndPrefix=25
Global LoftConRoll=45
Global Undo_control=0
Global ObjMatLib=#()
Global ObjName=#()
Global ObjWireColor =#()
Global ObjMatName=#()
Global ObjUVWName1=#()
Global ObjUVWType1=#()
Global ObjUVWSize1=#()
Global ObjUVWName2=#()
Global ObjUVWType2=#()
Global ObjUVWSize2=#()
Global ObjUVWName3=#()
Global ObjUVWType3=#()
Global ObjUVWSize3=#()
Global ObjArchiName=#()
Global D 

Global Rollout_Type_Name = "VMSin"
Global Radio_Name_Type = 1
Global Check_Apply_Name = true
Global Check_Apply_Mapping = true
Global Check_Apply_Material = true
Global Valid_Rollout_Types=#("VMSin","VMSex","IND","SITE")
 
fn  MappingConvertType TypeString ch = 
(
Tstring=#("PLANAR","CYLINDRICAL","SPHERICAL","SHRINK","BOX","FACE")
RT=[1,1,2]
SG= findItem Tstring TypeString
if ( SG !=0 ) then
	RT= [ch,(SG-1),2]
if ( TypeString == "DOORMAPPER" ) then
	RT= [0,0,0]
RT
)

fn AddOptionText =
(
print "AddOptionText"

SS = getCurrentSelection()
if SS.count == 0 then
	(
	Messagebox "Nothing Selected"
	)
else
	(
	for i=1 to SS.count do
		(
		Currentname = SS[i].name
		if ( ((substring Currentname 1 1 ) as integer ) == undefined ) then
			(
			if ( NewText == "ClearOptions" ) then
				(
				Newname = Currentname 
				)
 			else
				(
				NewName = NewText+Currentname
				)
			)
		else
			(
			if ( NewText == "ClearOptions" ) then
				(
				NewText2 = ( filterString Currentname "-" )
 
--				format "\n wackoff % = % \n" NewText2[1] ( NewText2[1].count + 1 )
				
				a=NewText2[1].count + 1
				b=Currentname.count-a
				Newname = subString Currentname (a+1) (b)
				)
			else
				(
				NewName = (subString NewText 1 2) + Currentname
				)
			)
--		format "from :% -=> %\n" Currentname NewName

		SS[i].name = uniquename NewName
		)
	)
)

fn Load_Obj_Arrays  =
(
local CurrentMatLib=""

ObjMatLib=#()
ObjName=#()
ObjWireColor =#()
ObjMatName=#()
ObjUVWName1=#()
ObjUVWType1=#()
ObjUVWSize1=#()
ObjUVWName2=#()
ObjUVWType2=#()
ObjUVWSize2=#()
ObjUVWName3=#()
ObjUVWType3=#()
ObjUVWSize3=#()
ObjArchiName=#()

try(FS = openFile Material_FileData mode:"r" )catch()

if ( FS != undefined ) then	(
	do
	(
	NLine=readdelimitedString FS "\n"
	D = filterString NLine "\t"
	if (D.count>0) then
	(
	if (  (substring D[1] 1 1) != "*" ) then 
	(
	if ( D[1]=="MATLIB" )  then
		(
		CurrentMatLib=D[2]
--		format "CML : % \n" D[2]
		)
	else
		(
		if (D[14] != undefined ) then
		(
		if ( Rollout_Type_Name == D[14] ) then
			(
	 		append ObjMatLib CurrentMatLib
			append ObjName D[1]
			append ObjMatName  D[2]
			append ObjWireColor  ( f360Lib.String_to_Point3 D[3] )
			append ObjUVWName1 D[4 ]
			append ObjUVWType1  ( MappingConvertType D[5 ] 1 )
			append ObjUVWSize1  ( f360Lib.String_to_Point3 D[6 ])
			append ObjUVWName2  D[7 ]
			append ObjUVWType2  ( MappingConvertType D[8] 2 )
			append ObjUVWSize2  ( f360Lib.String_to_Point3 D[9 ] )
			append ObjUVWName3  D[10 ]
			append ObjUVWType3  ( MappingConvertType D[11] 3 )
			append ObjUVWSize3  ( f360Lib.String_to_Point3 D[12 ] )
			append ObjArchiName  D[ 13 ]
			)
		)
		)
	)
	)
	)
	while ( not eof FS)
	close FS
	)
)
-- DEFINE Name_Mat_UVW_Selected in GLOBAL referance

Check_Apply_Name = ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Name") == "true" )
Check_Apply_Mapping = ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Mapping") == "true" )
Check_Apply_Material = ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Material") == "true" )
	
fn Define_Full_Rename =
 (

-- BUILD STANDARD OBJECTS NAME ROLLOUT

F_String = "rollout Full_Rename_Rollout \"Name with standard "+Rollout_Type_Name+" Names\" width:300 height:500\n(\n"


-- BUILD BUTTONS
 for i=1 to ObjName.count do
	if ( mod i 2 == 1 ) then
		F_string=F_string + "\n	button "+( f360Lib.Remove_Character ObjName[i] "-" )+"_but \""+ObjName[i]+"\" across:2 width:98 height:20 align:#left Tooltip:\""+ObjName[i]+"\"\n"
	else
		F_string=F_string + "\n	button "+( f360Lib.Remove_Character ObjName[i] "-" )+"_but \""+ObjName[i]+"\"  width:98 height:20 align:#right  Tooltip:\""+ObjName[i]+"\"\n"

if ( mod ObjName.count 2 == 1 ) then
		F_string=F_string + "\n	button StJHold_but2 \"---\"  width:98 height:20 align:#right \n "


-- BUILD ACTIONS


for i=1 to ObjName.count do
		F_string=F_string + "\non "+( f360Lib.Remove_Character ObjName[i] "-")+"_but pressed do \n( Name_Mat_UVW_Selected  ("+( i as string )+")\n)\n"

F_String = F_String +"	edittext S_CUSTOM  across:2 fieldwidth:84\n	button AS_CUSTOM \"Custom\"  width:76 height:20"
F_String = F_String + "\non S_CUSTOM entered SNewText do\n	(\n	NewColor= [0,0,0]\n	NewText=SNewText\n 	if NewText != \"\"  then\n		(\n		Full_Rename (NewColor)\n		)\n	)\non AS_CUSTOM pressed do\n	(\n	NewColor= [0,0,0]\n	NewText=S_CUSTOM.text\n	if NewText != \"\"  then\n		(\n		Full_Rename (NewColor)\n	)\n	)\n)"

--format "%\n" F_String
F_String
)

fn UndoTextEdit = 
(	
SS = getCurrentSelection ()
if ( UndoNew.count != 0 ) then
	(
	for i=1 to SS.count do
		(
		for ii=1 to UndoOriginal.count do
			(
			if ( SS[i].name == UndoNew[ii] ) then
				(
				SS[i].name = UndoOriginal[ii]
				)
			)
		)
	)
)
fn PrefixSelection =
(
SS = getCurrentSelection()
if SS.count == 0 then
	(
	Messagebox "Nothing Selected"
	)
else
	(
	for i=1 to SS.count do
		(
		Currentname = SS[i].name
		append 	UndoOriginal Currentname
		Currentname= f360Lib.Make_Upper_Case   Currentname
		NewText = f360Lib.Make_Upper_Case   NewText
		SS[i].name=( uniquename ( NewText+Currentname ))
		append Undonew SS[i].name
		Undo_control=1
		)
	)
)

--*******************************************************************************
----
--    Define Roll Outs
--
--
--*******************************************************************************rollout Options_rollout "Option Sets"
(
	button btn1A  "1A-" across:4 width:40 height:18
	button btn1B  "1B-"  width:40 height:18
	button btn1C  "1C-" width:40 height:18
	button btn1D  "1D-" width:40 height:18
	
	button btn2A  "2A-" across:4 width:40 height:18
	button btn2B  "2B-" width:40 height:18
	button btn2C  "2C-" width:40 height:18
	button btn2D  "2D-" width:40 height:18
	
	button btn3A  "3A-" across:4 width:40 height:18
	button btn3B  "3B-"  width:40 height:18
	button btn3C  "3C-" width:40 height:18
	button btn3D  "3D-" width:40 height:18

	button btn4A  "4A-" across:4 width:40 height:18
 	button btn4B  "4B-" width:40 height:18
	button btn4C  "4C-" width:40 height:18
	button btn4D  "4D-" width:40 height:18
	
	button btn5A  "5A-" across:4 width:40 height:18
 	button btn5B  "5B-" width:40 height:18
	button btn5C  "5C-" width:40 height:18
	button btn5D  "5D-" width:40 height:18
	
	button Clopts "Clear Options"  width:160 height:18 align:#center
	

-- *****************************  Option Buttons

on btn1A pressed do
	(NewText="1A-";AddOptionText ())
on btn1B pressed do
	(NewText="1B-";AddOptionText ())
on btn1C pressed do
	(NewText="1C-";AddOptionText ())
on btn1D pressed do
	(NewText="1D-";AddOptionText ())

on btn2A pressed do
	(NewText="2A-";AddOptionText ())
on btn2B pressed do
	(NewText="2B-";AddOptionText ())
on btn2C pressed do
	(NewText="2C-" ;AddOptionText ())
on btn2D pressed do
	(NewText="2D-";AddOptionText ())
on btn3A pressed do
	(NewText="3A-";AddOptionText ())
on btn3B pressed do
	(NewText="3B-";AddOptionText ())
on btn3C pressed do
	(NewText="3C-";AddOptionText ())
on btn3D pressed do
 	(NewText="3D-";AddOptionText ())
on btn4A pressed do
	(NewText="4A-";AddOptionText ())
on btn4B pressed do
	(NewText="4B-";AddOptionText ())
on btn4C pressed do
	(NewText="4C-";AddOptionText ())
on btn4D pressed do
	(NewText="4D-";AddOptionText ())
on btn5A pressed do
	(NewText="5A-";AddOptionText ())
on btn5B pressed do
	(NewText="5B-";AddOptionText ())
on btn5C pressed do
	(NewText="5C-";AddOptionText ())
on btn5D pressed do
	(NewText="5D-";AddOptionText ())

	
on CLopts pressed do
	(NewText="ClearOptions";AddOptionText ())
)
rollout Main_Rename "Main Selection" width:300 height:50
(
radioButtons Roll_Type  "" labels:#("VMS-int","VMS-ext","IND","SITE") columns:2 default:Radio_Name_Type
--button Pre_Undo "Undo Last Change" highlightColor:[200,200,200] width:160 height:18
checkbox MR_Name "Rename Object" checked:Check_Apply_Name
checkbox MR_Mapping "Apply UVW Mapping" checked:Check_Apply_Mapping
checkbox MR_Mats "Apply Materials" checked:Check_Apply_Material

on Main_Rename close do
(
-- Save Floater Pos/size
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterX"  (( One_Rename_Floater.pos.x ) as String)
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterY"  (( One_Rename_Floater.pos.y ) as String)
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterSX"  (( One_Rename_Floater.size.x ) as String)
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterSY"  (( One_Rename_Floater.size.y ) as String)
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Name"  (Check_Apply_Name as string )
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Mapping"  (Check_Apply_Mapping as string )
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Material"   ( Check_Apply_Material as string )
	setINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Name_Type"   (Radio_Name_Type as string)

)
on MR_Name changed BB do
(Check_Apply_Name = BB )

on MR_Mapping changed BB do
(Check_Apply_Mapping = BB )

on MR_Mats changed BB do
(Check_Apply_Material = BB )

on Pre_Undo pressed do 
	(
	if ( Undo_control == 0 ) then
		( messageBox "Nothing to undo")
	else	
		(UndoTextEdit ())
	)

on Roll_Type changed CS do
(
Radio_Name_Type=CS
if ( CS == 1 ) then
	(
	Rollout_Type_Name = "VMSin"
	removeRollout Full_Rename_Rollout One_Rename_Floater
	removerollout Site_Rollout_Prefixer One_Rename_Floater rolledUp:true
	removerollout Loft_Construction_Rollout One_Rename_Floater rolledUp:true
	removerollout Options_rollout One_Rename_Floater 
	Load_Obj_Arrays()
	a=Define_Full_Rename()
	execute a
	addrollout Full_Rename_Rollout One_Rename_Floater rolledUp:false 
	addrollout Options_rollout One_Rename_Floater rolledUp:false
	)
if ( CS == 2 ) then
	(
	Rollout_Type_Name = "VMSex"
	removeRollout Full_Rename_Rollout One_Rename_Floater
	removerollout Site_Rollout_Prefixer One_Rename_Floater rolledUp:true
	removerollout Loft_Construction_Rollout One_Rename_Floater rolledUp:true
	removerollout Options_rollout One_Rename_Floater 

	Load_Obj_Arrays()
	a=Define_Full_Rename()
	execute a
	addrollout Full_Rename_Rollout One_Rename_Floater rolledUp:false 
	addrollout Options_rollout One_Rename_Floater rolledUp:false
	)

if ( CS == 3 ) then
	(
	Rollout_Type_Name = "IND"
	removeRollout Full_Rename_Rollout One_Rename_Floater
	removerollout Site_Rollout_Prefixer One_Rename_Floater rolledUp:true
	removerollout Loft_Construction_Rollout One_Rename_Floater rolledUp:true
	removerollout Options_rollout One_Rename_Floater 
	Load_Obj_Arrays()
	a=Define_Full_Rename()
	execute a
	addrollout Full_Rename_Rollout One_Rename_Floater rolledUp:false 
	)
if ( CS == 4 ) then
	(
	Rollout_Type_Name = "SITE"	removeRollout Full_Rename_Rollout One_Rename_Floater
	removerollout Site_Rollout_Prefixer One_Rename_Floater rolledUp:true
	removerollout Loft_Construction_Rollout One_Rename_Floater rolledUp:true
	removerollout Options_rollout One_Rename_Floater 
	Load_Obj_Arrays()
	a=Define_Full_Rename()
	execute a
	addrollout Full_Rename_Rollout One_Rename_Floater rolledUp:false
	addrollout Site_Rollout_Prefixer One_Rename_Floater rolledUp:true
	addrollout Loft_Construction_Rollout One_Rename_Floater rolledUp:true
	)
)
)
rollout Site_Rollout_Prefixer "Add Site Prefixs"  width:300 height:400
(
--	button Pre_Undo "Undo Last Change" pos:[15,0] highlightColor:[200,200,200] width:160 height:18
	button Pre_EX   "EX-" pos:[13,20] width:76 height:18 tooltip:"All Exterior Items"
	button Pre_LX   "LX-" pos:[100,20] width:76 height:18 tooltip:"Light Sources"
	button Pre_PLP  "PLP-" pos:[13,40] width:76 height:18 tooltip:"Plants"
	button Pre_PLT  "PLT-" pos:[100,40] width:76 height:18 tooltip:"Trees"
	button Pre_WA   "WA-" pos:[13,60] width:76 height:18 tooltip:"Water Features"
	button Pre_GS   "GS-" pos:[100,60] width:76 height:18 tooltip:"People"
	button Pre_CAR  "CAR-" pos:[13,80] width:76 height:18 tooltip:"Automobiles"
	button Pre_CARANI   "CAR-ANI-" pos:[100,80] width:76 height:18 tooltip:"Animated Automobiles"
	button Pre_BLDG     "BLDG-" pos:[13,100] width:76 height:18 tooltip:"Buildings"
	button Pre_XEX  "---" pos:[100,100] width:76 height:18
	button Pre_ZS   "Z-S_" pos:[13,120] width:76 height:18
	button Pre_ZP   "Z-P_" pos:[100,120] width:76 height:18 tooltip:"Z- Non Renderables"


-- *******************  Prefix buttons 

on Pre_Undo pressed do 
	(	if ( Undo_control == 0 ) then
		( messageBox "Nothing to undo")
	else	
		(UndoTextEdit ())
	)
on Pre_EX pressed do
	(	NewText="EX-" ;PrefixSelection () )
on Pre_LX pressed do
	(NewText="LX-" ; PrefixSelection ())
on Pre_PLP pressed do
	(NewText="PLP-";PrefixSelection ())
on Pre_PLT pressed do
	(NewText="PLT-";PrefixSelection ())
on Pre_WA pressed do
	(NewText="WA-";PrefixSelection ())	
on Pre_GS pressed do
	(NewText="GS-";PrefixSelection ())
on Pre_CAR pressed do
	(NewText="CAR-";PrefixSelection ())
on Pre_CARANI pressed do
	(NewText="CAR-ANI-";PrefixSelection ())
on Pre_BLDG pressed do
	(NewText="BLDG-";PrefixSelection ())
on Pre_ZS pressed do
	(NewText="Z-S_";PrefixSelection ())
on Pre_ZP pressed do
	(NewText="Z-P_";PrefixSelection ())
on P_CUSTOM entered PNewText do
	(
	NewText=PNewText
	format "char -=>%<=- \n" ( subString NewText ( Newtext.count) 1 )
	if (( subString NewText ( Newtext.count ) 1 ) != "-") then
		(NewText=NewText+"-")
	PrefixSelection ()
	)
on AP_CUSTOM pressed do
	(
	NewText=P_CUSTOM.text	if NewText != ""  then
		(
		if (( subString NewText ( Newtext.count ) 1 ) != "-") then
			(NewText=NewText+"-")
		PrefixSelection ()
		)
	)	
)
rollout Loft_Construction_Rollout "Loft Construction Names" width:300 height:500
(
	button R_ZSR 	"Z-P_MAINLINE" pos:[13,25] width:76 height:18 tooltip:"Road Path"
	button R_ROD  	"EX-ROD" pos:[100,25] width:76 height:18 tooltip:"Road"
 	button R_EXSA  	"EX-SWK_A" pos:[13, LoftConRoll] width:76 height:18 tooltip:"Side Walk Side A"
	button R_EXSB  	"EX-SWK_B" pos:[100,LoftConRoll] width:76 height:18  tooltip:"Side Side Walk B"
	button R_CRBA  	"EX-CRB_A" pos:[13, LoftConRoll+20] width:76 height:18 tooltip:"Curb Side A"
	button R_CRBB  	"EX-CRB_B" pos:[100,LoftConRoll+20] width:76 height:18 tooltip:"Curb Side B"
	button R_GRSA  	"EX-GRS_A" pos:[13, LoftConRoll+40] width:76 height:18 tooltip:"Grass Side A"
	button R_GRSB 	"EX-GRS_B" pos:[100,LoftConRoll+40] width:76 height:18 tooltip:"Grass Side B"
	button R_RAMPA 	"EX-RAMP_A" pos:[13, LoftConRoll+60] width:76 height:18 tooltip:"Ramps Side A"
	button R_RAMPB 	"EX-RAMP_B" pos:[100,LoftConRoll+60] width:76 height:18 tooltip:"Ramps Side B"
	button R_XXX  	"---" pos:[13, LoftConRoll+80] width:76 height:18 tooltip:"future use"
	button R_XXy  	"---" pos:[100,LoftConRoll+80] width:76 height:18 tooltip:"future use"
	
-- ***************************** Secondary buttons
on R_ZSR pressed do
	(
	macros.run "Focus360 Build" "Loft_Divider"
	NewColor= [55,75,83]
	NewText="Z-P_MAINLINE"
	Full_Rename (NewColor)
	)
on R_ROD pressed do
	(
	NewColor= [55,69,83]
	NewText="EX-ROD"
	Full_Rename (NewColor)
	)on R_EXSA pressed do
	(
	NewColor= [169,169,112]
	NewText="EX-SWK_A"
	Full_Rename (NewColor)
	)
on R_EXSB pressed do
	(
	NewColor= [169,169,112]
	NewText="EX-SWK_B"
	Full_Rename (NewColor)
	)
on R_CRBA pressed do
	(
	NewColor= [125,125,83]
	NewText="EX-CRB_A"
	Full_Rename (NewColor)
	)
on R_CRBB pressed do
	(
	NewColor= [125,125,83]	NewText="EX-CRB_B"
	Full_Rename (NewColor)
	)
on R_GRSA pressed do
	(
	NewColor= [0,83,0]
	NewText="EX-GRS_A"
	Full_Rename (NewColor)
	) 
on R_GRSB pressed do
	(
	NewColor= [0,83,0]
	NewText="EX-GRS_B"
	Full_Rename (NewColor)
	) 
on R_ZSC pressed do
	(
	NewColor= [0,0,0]	NewText="Z-P-CRB"
	Full_Rename (NewColor)
	)
on R_RAMPA pressed do
	(
	NewColor= [155,155,100]	
	NewText="EX-RAMP_A"
	Full_Rename (NewColor)
	)
on R_RAMPB pressed do
	(
	NewColor= [155,155,100]
	NewText="EX-RAMP_B"	Full_Rename (NewColor)	)
on S_CUSTOM entered SNewText do
	(
	NewColor= [0,0,0]
	NewText=SNewText
	if NewText != ""  then
		(
		Full_Rename (NewColor)
		)
	)
on AS_CUSTOM pressed do
	(
	NewColor= [0,0,0]
	NewText=S_CUSTOM.text
	if NewText != ""  then
		(
		Full_Rename (NewColor)
		)
	)
)
-- LOAD STANDARD MATERIALS FROM LIST

	FLx= ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterX") as integer)
	FLy= ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterY") as integer)
	FSx= ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterSX") as integer)
	FSy= ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "FloaterSY") as integer)
	Check_Apply_Name = ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Name") == "true" )
	Check_Apply_Mapping = ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Mapping") == "true" )
	Check_Apply_Material = ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Material") == "true" )
	Radio_Name_Type = ((getINISetting "$ui\Focus360_Scripts.ini" "Super_Namer_1" "Name_Type") as integer)

try(Rollout_Type_Name = Valid_Rollout_Types[Radio_name_Type])catch()

execute "fn Full_Rename NColor =(SS = getCurrentSelection();if SS.count == 0 then\n(\nMessagebox \"Nothing Selected\"\n)\nelse\n(\nfor i=1 to SS.count do\n(Currentname = SS[i].name;NewText = f360Lib.Make_Upper_Case   NewText;SS[i].name=( uniquename ( NewText ))\nif NColor != [0,0,0] then\n(SS[i].wireColor=Ncolor))))"

execute "
fn Name_Mat_UVW_Selected SelObj =
	(
	SS= getcurrentselection()
	ValidLib = true
	if ( getMatLibFileName () != ObjMatLib[SelObj] ) then 
		 (
		ValidLib = false
		 if ( loadMaterialLibrary ObjMatLib[SelObj] ) then
		 	(
			 format \"Loaded Lib %\"  ObjMatLib[SelObj] 
		          matlib = currentmateriallibrary
			ValidLib = true
			)
			else
 			(
			messagebox (\"Error load Mat Lib :\"+ObjMatLib[SelObj]+\"\n\") 
			)
		)
	if ( ValidLib == true )  then
		(
		format \" Apply : % \n\" ObjMatName[SelObj]
			for zz = 1 to SS.count do
			(
			sel = SS[zz]
			if (Check_Apply_Name == true ) then
				(sel.name = uniquename ObjName[SelObj])
			if (Check_Apply_Material == true ) then
				(try (sel.material = currentmateriallibrary [ ObjMatName[SelObj] ]) catch( format \"% Material not applied\" (sel.name) ))
	 		sel.wirecolor = ObjWireColor[SelObj]
			if (Check_Apply_Mapping == true ) then
				(
				f360Lib.Remove_Mapping_Modifiers Sel
				if ( ObjUVWName1[SelObj] != \"x\") then
					(
					if (ObjUVWType1[SelObj] != [0,0,0]  ) then
						(
						f360Lib.AddUVWMapping sel ( \"(1) \"+ObjUVWName1[SelObj] ) ObjUVWType1[SelObj] ObjUVWSize1[SelObj]
						)
					)
				if ( ObjUVWName2[SelObj] != \"x\") then
					(
					f360Lib.AddUVWMapping sel ( \"(2) \"+ObjUVWName2[SelObj] ) ObjUVWType2[SelObj] ObjUVWSize2[SelObj]
					)
				if ( ObjUVWName3[SelObj] != \"x\") then
					(
					f360Lib.AddUVWMapping sel ( \"(3) \"+ObjUVWName3[SelObj] ) ObjUVWType3[SelObj] ObjUVWSize3[SelObj]
					)
				)
			)
		)
	)
"

	Load_Obj_Arrays()
	Undo_control=0

	if ( One_Rename_Floater!=undefined ) then closeRolloutFloater One_Rename_Floater
	
	if  ( FSy == 0 ) then
	 	( One_Rename_Floater = newrolloutfloater "Super Namer 1.0" 250 550 20 160 ;Radio_Name_Type = 1;Check_Apply_Name=true;Check_Apply_Mapping=true; Check_Apply_Material=true)
	else
	 	( One_Rename_Floater = newrolloutfloater "Super Namer 1.0"  FSx FSy FLx FLy )
	a=Define_Full_Rename()
	execute a
	addrollout Main_Rename One_Rename_Floater
	addrollout Full_Rename_Rollout One_Rename_Floater rolledUp:false

	if  ( Radio_Name_Type < 3) then
		(
		addrollout Options_rollout One_Rename_Floater rolledUp:false
		)
	if  ( Radio_Name_Type == 4) then
		(
		addrollout Site_Rollout_Prefixer One_Rename_Floater rolledUp:true
		addrollout Loft_Construction_Rollout One_Rename_Floater rolledUp:true
		)
)