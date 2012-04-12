-------------------------------------------------------------------------------
-- IncludeExclude.ms
-- By: Matthew Chastain 
-- Modified On: 12/14/2001
-- 
-- Allows you to include or exclude a selection of objects with a selection of 
-- lights.  All using only one selection! You also have the option to add or subtract
-- to the list selection as well as create a new one.
--
-- If you only select a light without any geometry, then the lights list will
-- toggle between Include and Exclude.
--
-- To Install: Run the macroscript like any other script (Maxscript->Run Script)
-- This will place the macroscript into the command list of Customize UI. From there
-- you can add the utility as a button or to your Quad Menu.
--
-- tested and written for use with Max 4.2
-------------------------------------------------------------------------------

-- Changed to Dialog with position saving
-- Incorporated into the focus360 hoard January 30, 2004
-- macroscript IncludeExclude
(

global currentList
global inclErExcl
global theLights = #()
global theObjects = #() 

fn addSelection theLight =
(
	newList = currentList + theObjects
	if inclErExcl == 1 then
	(
		theLight.includeList = newList
	)
	else
	(
		theLight.excludeList = newList 
	)
)

fn subSelection theLight =
(
	temparray = #()

	for i = 1 to currentList.count do
	(
		found = findItem theObjects currentList[i]
		if found == 0 then
		(
			append temparray currentList[i]
		)
	)
		
	if inclErExcl == 1 then
	(
		theLight.includeList = temparray
	)
	else
	(
		theLight.excludeList = temparray
	)
)

fn newSelection theLight = 
(
	if inclErExcl == 1 then
	(
		theLight.includeList = theObjects
	)
	else
	(
		theLight.excludeList = theObjects
	)
)

fn invertLight theLight =
(	
	if theLight.includeList == undefined then
	(
		tempInv = theLight.excludeList
		theLight.includeList = tempInv
	)
	else
	(
		tempInv = theLight.includeList
		theLight.excludeList = tempInv
	)
)

fn sortCurrentSelection =
(
	theLights = #()
	theObjects = #()

	selectedObjects = getcurrentselection()
	for i = 1 to selectedObjects.count do
	(
		if (superclassof selectedObjects[i]) == light then
		(
			append theLights selectedObjects[i]
		)
		else
		(
			append theObjects selectedObjects[i]
		)
	)
)

fn getLightList selectedLight =
(
	if selectedLight.includeList == undefined then
	(
		currentList = selectedLight.excludeList
	)
	else
	(
		currentList = selectedLight.includeList
	)
)

fn main inclExcl inclRxclType addNSub =
(
	sortCurrentSelection()
	
	inclErExcl = inclExcl
	
	for i = 1 to theLights.count do
	(
		getLightList theLights[i]
		
		theLights[i].inclExclType = inclRxclType
				
		if (theLights.count > 0) and (theObjects.count == 0) then
		(
			invertLight theLights[i]
			return ok
		)
		
		case addNSub of
		(
			1: addSelection theLights[i]
			2: newSelection theLights[i]
			3: subSelection theLights[i]
		)
	)
)

rollout InclExclmanager "Light Include/Exclude Manager" width:230 height:220
(
	radiobuttons inclExcl "" pos:[50,11] width:145 height:16 labels:#("Include", "Exclude") default:1 columns:2
	
	GroupBox grp1 "Type of:" pos:[7,33] width:218 height:38
	radiobuttons inclRxclType "" pos:[18,48] width:226 height:16 enabled:true labels:#("Illumination", "Shadow", "Both") default:3 columns:3

	GroupBox grp2 "Apply to List:" pos:[7,78] width:217 height:48
	radiobuttons addNSub "" pos:[30,101] width:174 height:16 labels:#("Add", "New", "Subtract") default:2 columns:3

	button doit "Do It!" pos:[56,144] width:129 height:24
	button clearLists "Clear Light Lists" pos:[71,181] width:102 height:25

	on InclExclmanager close do
	(
	-- Save Floater Pos
		TP = getdialogpos InclExclmanager
		setINISetting "$ui\Focus360_Scripts.ini" "IncEx_LightMan" "FloaterX"  (( TP.x ) as String)
		setINISetting "$ui\Focus360_Scripts.ini" "IncEx_LightMan" "FloaterY"  (( TP.y ) as String)
	)
	on doit pressed do
	(
		 main inclExcl.state inclRxclType.state addNSub.state
--		 deselect $*
	)
	
	on clearLists pressed do
	(
		allObjects = getcurrentselection()
	
		selectedLights = #()
		
		-- Sort the selected Objects by superclass
		--
		for i = 1 to allObjects.count do
		(
			if (superclassof allObjects[i]) == light then
			(
				append selectedLights allObjects[i]
			)
		)
		
		clear = #()
		for i = 1 to selectedLights.count do
		(
			selectedLights[i].includeList = clear
			selectedLights[i].excludeList = clear
		)
		
		deselect allObjects
	)
)

-- Create a floater
--
try  (destroyDialog InclExclmanager )catch()

FLx= ((getINISetting "$ui\Focus360_Scripts.ini" "IncEx_LightMan" "FloaterX") as integer)
FLy= ((getINISetting "$ui\Focus360_Scripts.ini" "IncEx_LightMan" "FloaterY") as integer)

if FLy != "" then
	createDialog InclExclmanager 230 220 FLx FLy
else
	createDialog InclExclmanager


)