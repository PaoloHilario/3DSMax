/* FumeFx & Pflow Create Dialog 0.06
Created:  	Feb 23, 2007	
Last Updated:	Nov.25, 2007
Author :  John Rand (littl3fish@gmail.com) 
Version:  3ds max 8, 9 32&64bit
           	FumeFX 1.0+
		   
			v.02 used start object creation method instead of predefined objects.
			v.03 add buttons for FumeFX Dynamics floater and modify panel.
				added dialog position memory.
			v.04 add button for particle flow dialog toggle.
				added rollout for forces and deflectors.
				added rolout for playback controls and time config.
			v.05 added height position memory
				added scroll position memory
				added rollout memory
				Renamed all variables to less common usages
			v.06 Added Fume & Flow Object Selector
				added added toggles for render dialog and Mat. editor	
				
		would like to add checkbox for playback controls to enable "key mode"
		
		Script is for my workflow with FumeFX and Particle flow.
		It contains various dialog toggles (with Right-click actions), object creation	shortcuts,
		playback controls, and a filtered object selector for Fume objects, Pflow, and Spacewarps.
 
		
Installs file FumeFlowFloater_06.ms in your "~\scripts" folder.
Creates file FumeFlowfloater.ini in your "~\plugcfg" folder.		   
Installs file FumeFlowFloater.mcr in your"~\ui\macroscripts" folder.
Installs all icons:
	"real" FumeFX*.bmp 
	"my" FumeIcons*.bmp 
	"my" SW_Drag_Vortex*.bmp
	"my" PFicons*.bmp
in "~\$usericons" folder.

***********************************************************************************************
MODIFY THIS AT YOUR OWN RISK
*/
--start
global xForFFXDialogLocation = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "FumeFloater Dialog Position" "Position x" as integer
global yForFFXDialogLocation = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "FumeFloater Dialog Position" "Position y" as integer
global widthForFFXDialog = 200
global heightForFFXDialog = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "FumeFloater Dialog Size" "Size h" as integer
global sForFFXDialogScroll = 0 
global gForFFXDialogScroll = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Fume Rollout" "Scroll Position" as integer
global rFumeRLT = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Fume Rollout" "Rolled State" as string
global rFumeFlowObjSel = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Selector Rollout" "Rolled State" as string
global rSourceRLT = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Source Rollout" "Rolled State" as string
global rPFlowRLT = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "PFlow Rollout" "Rolled State" as string
global rPlayBackRLT = getINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "PlayBack Rollout" "Rolled State" as string
global FumeRLT, FumeFlowObjSel, PFlowRLT, SourceRLT, PlayBackRLT, FumeCreate

--functions
fn CreateFFX =
	(
	startObjectCreation FumeFX
	)
	
fn SimpleSource =
	(
	startObjectCreation Simple_Src
	)
	
fn ObjectSource =
	(
	startObjectCreation Object_Src
	)

fn ParticleSource =
	(
	startObjectCreation Particle_Src
	)

fn GravityVCTR =
	(
	startObjectCreation GravityVector
	)

--Rollout Position	
fn FumeRLTPos = 
	(
	if gForFFXDialogScroll == undefined then FumeRLT.scrollPos = 200
	else FumeRLT.scrollPos=gForFFXDialogScroll 
	)
	
--Reads .ini for last setting of rollout.open
fn rolloutMemCTRL = 
	(
	if rFumeRLT == "true" then FumeRLT.open = true
	else FumeRLT.open = false
	
	if rFumeFlowObjSel == "true" then FumeFlowObjSel.open = true
	else FumeFlowObjSel.open = false

	if rSourceRLT == "true" then SourceRLT.open = true
	else SourceRLT.open = false
	
	if rPFlowRLT == "true" then PFlowRLT.open = true
	else PFlowRLT.open = false
	
	if rPlaybackRLT == "true" then PlayBackRLT.open = true
	else PlayBackRLT.open = false
	)
	
--Determines if Command panel is open, determines if object is selected 
fn ModModeCom =
	(
	while cui.commandPanelOpen == false do
		(
		max hide command panel toggle
		if cui.commandPanelOpen == true then exit
		)
	max modify mode
	if CurrentObject == false then
		(
		max modify mode
		)
	if CurrentObject == true then
		(	
		modPanel.setCurrentObject $
		)
	)
 
	
	
--Rollouts
--	
--FumeFX Grid rollout




rollout FumeRLT "Toggles" 

	(  
		--Button Fires a Quick Render / Right Click open the render dialog
		button QuickRender "Quick Render/Render Dialog" tooltip:"Quick Render/Render Dialog" \
					images:#("$ui\icons\Render_24i.bmp","$ui\icons\Render_24i.bmp",13,5,8,1,1) \
					height:27 width:27 across:6 align:#left offset:[-10,0]
		on QuickRender pressed do
			(
			max quick render
			)
		on QuickRender rightclick do
			(
			actionMan.executeAction 0 "60010"  -- Render: Render Scene Dialog Toggle
			) 

		--Button toggles the Particle View.		
		checkbutton PRTCLView "Particle View" tooltip:"Particle View Toggle / Right-Click Enviroment Dialog" \
					images:#("$usericons\PFIcons_24i.bmp","$usericons\PFIcons_24i.bmp",2,2,2,1,1) \
					height:27 width:27 across:6 align:#left offset:[-6,0] checked:false
		on PRTCLView changed state do
			if state == on 
			then particleFlow.openParticleView()  -- Particle View Open/Close Toggle
			else actionMan.executeAction 135018554 "32771"
			 
			
		on PRTCLView rightclick do
			(
			actionMan.executeAction 0 "40029"  -- Render: Environment Dialog Toggle
			) 
		
		--Button toggles the FumeFX Dynamics Floater.		
		button FumeEdit "Fume Edit" tooltip:"FumeFX UI Toggle" \
					images:#("$usericons\FumeFX_24i.bmp","$usericons\FumeFX_24i.bmp",4, 3,3,1,1) \
					height:27 width:27 across:6 align:#left offset:[-2,0] 
		on FumeEdit pressed do
			(
			actionMan.executeAction 12121256 "40011"  -- FumeFX Dynamics: Floater Display
			)
			
		--Button toggles the Layer Manager.		
		checkbutton LayerMan  tooltip:"Layer Manager" \
					images:#("$ui\icons\LayerToolbar_24i.bmp","$ui\icons\LayerToolbar_24i.bmp",6,5,5,1,1) \
					height:27 width:27 across:6 align:#center offset:[2,0] checked:false
		on LayerMan changed state do
			if state == on 
			then macros.run "Layers" "LayerManager" -- Layer Manager
			else layermanager.closeDialog() 

		--Button toggles the Material Editor.		
		checkbutton MatEdit "Material Editor" tooltip:"Material Editor" \
					images:#("$ui\icons\Maintoolbar_24i.bmp","$ui\icons\Maintoolbar_24i.bmp",100,65,65,1,1) \
					height:27 width:27 across:6 align:#center offset:[6,0] checked:false
		on MatEdit changed state do
			if state == on 
			then MatEditor.Open() 
			else MatEditor.Close()
			  -- Material editor
			

		--Button looks for selected object and returns to the modify panel with selection.
		--If no objects are selected it returns to the modify panel.
		--Right-click toggles Command Panel Show/Hide Toggle.	
		checkbutton ModMode "Modify Panel"  tooltip:"Modify Panel Toggle \\ Right-click Track View" \
					images:#("$ui\icons\TaskPanel_i.bmp", "$ui\icons\TaskPanel_i.bmp",6, 2,2, 0, 0) \
					height:27 width:27 across:6 align:#right offset:[12,0] checked:false
		on ModMode changed state do
			if state == on 
			then ModModeCom() 
			else max hide command panel toggle
			--(
			--ModModeCom()
			--)
		on ModMode rightclick do 
			(
			macros.run "Track View" "LaunchFCurveEditor"
			)
		
		--This registers current X,Y position and height h of FumeFX dialog box to
		--the "plugcfg\FumeFlowfloater.ini".	
		on FumeRLT close do 
			(
				local xForFFXDialogPosition
				local yForFFXDialogPosition
				local heightForFFXDialog
				local sForFFXDialogScroll
				
				--position
				xForFFXDialogPosition = FumeCreate.pos.x as string
				yForFFXDialogPosition = FumeCreate.pos.y as string
				setINISetting (getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "FumeFloater Dialog Position" "Position x" xForFFXDialogPosition
				setINISetting (getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "FumeFloater Dialog Position" "Position y" yForFFXDialogPosition 
				--height
				heightForFFXDialog = FumeCreate.size.y as string
				setINISetting (getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "FumeFloater Dialog Size" "Size h" heightForFFXDialog
 				--scroll position
				sForFFXDialogScroll = FumeRLT.scrollPos as string
				setINISetting (getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Fume Rollout" "Scroll Position" sForFFXDialogScroll
			)
		--Rollout roll up/down state	
		on FumeRLT rolledUp state do
			(
			if state then
			setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Fume Rollout" "Rolled State" "true"
			else setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Fume Rollout" "Rolled State" "false" 
			)

	)

--Fume&Flow Object Selector Rollout

rollout FumeFlowObjSel "Fume&Flow Object Selector" 
	(
		checkbox FGObj "Fume Grids" across:2 align:#left offset:[0,0]
		checkbox FOObj "Fume Obj" align:#left offset:[5,0]
		checkbox SWObj "SpaceWarps" across:2 align:#left offset:[0,0]
		checkbox PFObj "PFlow" align:#left offset:[5,0]
		dropdownlist FumeFlowSel "Click to Select" 
		button refresh "Refresh List" color:blue height:16 align:#right offset:[-4,-46]

		on refresh pressed do
			(
			FF_array = #()
				if FGObj.checked do
					(
					for o in objects do if classof o == FumeFX do append FF_array o.name
					)
				if FOObj.checked do
					(
					for o in objects do if classof o == Particle_Src do append FF_array o.name
					for o in objects do if classof o == Object_Src do append FF_array o.name
					for o in objects do if classof o == Simple_Src do append FF_array o.name
					for o in objects do if classof o == GravityVector do append FF_array o.name
					)
				if PFObj.checked do
					(
					for o in objects do if classof o == PF_Source do append FF_array o.name
					)
				if SWObj.checked do
					(
					for o in objects do if superclassof o == SpacewarpObject do append FF_array o.name
					)

				FumeFlowSel.items = FF_array
			)
		on FumeFlowSel selected nameIndex do 
		select (getNodeByName FumeFlowSel.items[nameIndex])
		
	--Read Checkbox states... can't figure this out at the moment :(
	

	--Rollout roll up/down state	
		on FumeFlowObjSel rolledUp state do
			(
			if state then
			setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Selector Rollout" "Rolled State" "true"
			else setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Selector Rollout" "Rolled State" "false" 
			)
 
	)

--Source rollout

rollout SourceRLT "FumeFX Objects"  
	(
		button CreateGrid "Create Grid" tooltip:"FumeFX Grid" \
				images:#("$usericons\FumeIcon_24i.bmp","FumeIcon_24i.bmp",6,2,2,1,1) \
				height:30 width:30 across:5 align:#left offset:[-5,0]
			on CreateGrid pressed do
			(
			CreateFFX()
			)
		
		button CreateSimpleSRC "Simple Source" \
				images:#("$usericons\FumeIcon_24i.bmp","FumeIcon_24i.bmp",6,3,3,1,1) \
				height:30 width:30 across:5 align:#left offset:[-2,0]
			on CreateSimpleSRC pressed do
			(
			SimpleSource ()
			)
			
		button CreateObjectSRC "Object Source"  \
				images:#("$usericons\FumeIcon_24i.bmp","FumeIcon_24i.bmp",6,4,4,1,1) \
				height:30 width:30 across:5 align:#center offset:[0,0]
			on CreateObjectSRC pressed do
			(
			ObjectSource ()
			)

		button CreateParticleSRC "Particle Source"  \
				images:#("$usericons\FumeIcon_24i.bmp","FumeIcon_24i.bmp",6,5,5,1,1) \
				height:30 width:30 across:5 align:#right offset:[2,0]
			on CreateParticleSRC pressed do
			(
			ParticleSource () 
			)
	
		button CreateGravityVCTR "Gravity Vector"  \
				images:#("$usericons\FumeIcon_24i.bmp","FumeIcon_24i.bmp",6,6,6,1,1) \
				height:30 width:30 across:5 align:#right offset:[5,0]
			on CreateGravityVCTR pressed do
			(
			GravityVCTR ()
			)
			
		--Rollout roll up/down state	
		on SourceRLT rolledUp state do
			(
			if state then
			setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Source Rollout" "Rolled State" "true"
			else setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "Source Rollout" "Rolled State" "false" 
			)

	)

--Rollout Particle Flow, Forces, and Deflectors
rollout PFlowRLT "Forces & Deflectors"  
	(
		button CreateGravSW "Gravity" tooltip:"Gravity" \
					images:#("$ui\icons\SW_PartDyn_24i.bmp","SW_PartDyn_24i.bmp",5,1,1,1,1) \
					height:30 width:30 across:5 align:#left offset:[-5,0] 
			on CreateGravSW pressed do
			(
			startObjectCreation Gravity
			)
			
		button CreateWindSW "Wind" tooltip:"Wind" \
					images:#("$ui\icons\SW_PartDyn_24i.bmp","SW_PartDyn_24i.bmp",5,2,2,1,1) \
					height:30 width:30 align:#left offset:[-2,0]
			on CreateWindSW pressed do
			(
			startObjectCreation Wind
			)

		button CreateVortSW "Vortex" tooltip:"Vortex" \
					images:#("$usericons\SW_DragVortex_24i.bmp","SW_DragVortex_24i.bmp",2,2,2,1,1) \
					height:30 width:30 align:#center offset:[0,0]
			on CreateVortSW pressed do
			(
			startObjectCreation Vortex
			)

		button CreateDragSW "Drag" tooltip:"Drag" \
					images:#("$usericons\SW_DragVortex_24i.bmp","SW_DragVortex_24i.bmp",2,1,1,1,1) \
					height:30 width:30 align:#right offset:[2,0]
			on CreateDragSW pressed do
			(
			startObjectCreation Drag
			)

		button CreateMotorSW "Motor" tooltip:"Motor" \
					images:#("$ui\icons\SW_PartDyn_24i.bmp","SW_PartDyn_24i.bmp",5,3,3,1,1) \
					height:30 width:30 align:#right offset:[5,0]
			on CreateMotorSW pressed do
			(
			startObjectCreation Motor
			)
			
--Force & Deflector rollout SECOND ROW
		
		button CreatePushSW "Push" tooltip:"Push" \
					images:#("$ui\icons\SW_PartDyn_24i.bmp","SW_PartDyn_24i.bmp",5,5,5,1,1) \
					height:30 width:30 align:#left offset:[-5,0]
			on CreatePushSW pressed do
			(
			startObjectCreation PushSpaceWarp On_Time:0f Off_Time:30f Basic_Force:1 units:0 \
					Feedback_On:0 Reversible:0 Control_Gain:50 Target_Speed:100 Enable_Variation:0 \
					Variation_Period_1:0.625f Amplitude_1:100 Variation_Phase_1:0 Variation_Period_2:0.625f \
					Amplitude_2:100 Range_Enable:0 Range_Value:1000 Variation_Phase_2:0
			)

		button CreateDeflSW "Deflector" tooltip:"Deflector" \
					images:#("$ui\icons\SW_PartOnly_24i.bmp","SW_PartOnly_24i.bmp",7,4,4,1,1) \
					height:30 width:30 align:#left offset:[30,-35]
			on CreateDeflSW pressed do
			(
			startObjectCreation Deflector bounce:1
			)


		button CreateSDeflSW "SDeflector" tooltip:"Spherical Deflector" \
					images:#("$ui\icons\SW_PartOnly_24i.bmp","SW_PartOnly_24i.bmp",7,6,6,1,1) \
					height:30 width:30 align:#center offset:[0,-35]
			on CreateSDeflSW pressed do
			(
			startObjectCreation SDeflector bounce:1 bouncevar:0 chaos:0 friction:0 radius:0
			)

		button CreateUDeflSW "UDeflector" tooltip:"Universal Deflector" \
					images:#("$ui\icons\SW_PartOnly_24i.bmp","SW_PartOnly_24i.bmp",7,7,7,1,1) \
					height:30 width:30 align:#right offset:[-30,-35]
			on CreateUDeflSW pressed do
			(
			startObjectCreation UDeflector bounce:1 bouncevar:0 chaos:0 friction:0 radius:0
			)

		button CreateUOmniDeflSW "UOmniFlect" tooltip:"UOmniFlect" \
					images:#("$ui\icons\SW_PartOnly_24i.bmp","SW_PartOnly_24i.bmp",7,2,2,1,1) \
					height:30 width:30 align:#right offset:[5,-35]
			on CreateUOmniDeflSW pressed do
			(
			startObjectCreation UOmniFlect timeOn:0f timeOff:100f affects:100 bounce:1 bouncevar:0 \
					chaos:0 friction:0 refracts:100 deceleration:1 decelVar:0 Refraction:50 refractionVar:0 \
					diffusion:0 diffusionVar:0 Spawn:100 passVelocity:1 passVelocityVar:0 radius:0
			)
		--Rollout roll up/down state
		on PFlowRLT rolledUp state do
			(
			if state then
			setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "PFlow Rollout" "Rolled State" "true"
			else setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "PFlow Rollout" "Rolled State" "false" 
			)
	)

--Playback rollout, contains time controls in the same order as the max interface.

rollout PlayBackRLT "Playback Controls"  height:100 
	(	
		button StartTIM "Start" tooltip:"Go to Start" \
					images:#("$ui\icons\VCRControls_24i.bmp","$ui\icons\VCRControls_24i.bmp",28,1,2,1,1)\
					height:30 width:30 across:5 align:#left offset:[-5,0]
			on StartTIM pressed do
			(
			max time start --actionMan.executeAction 0 "50019"
			)

		button OneMinusTIM "-1" tooltip:"1 Frame Back" \
					images:#("$ui\icons\VCRControls_24i.bmp","$ui\icons\VCRControls_24i.bmp",28,3,4,1,1) \
					height:30 width:30 align:#left offset:[-2,0]
			on OneMinusTIM pressed do
			(
			sliderTime -= 1
			)

		checkbutton PlayTIM "Play" tooltip:"Play / Right-Click Time Config" checked:false \
					images:#("$ui\icons\VCRControls_24i.bmp","VCRControls_24i.bmp",28,7,25,1,1) \
					height:30 width:30 align:#center offset:[0,0]
			on PlayTIM changed state do
			if state == off
			then stopAnimation ()
			else playAnimation ()
			on PlayTIM rightclick do (max time config)  -- Tools: Time Configuration ""actionMan.executeAction 0 "329"
			
		button OnePlusTIM "+1" tooltip:"1 Frame Forward" \
					images:#("$ui\icons\VCRControls_24i.bmp","$ui\icons\VCRControls_24i.bmp",28,11,12,1,1) \
					height:30 width:30 align:#right offset:[2,0]
			on OnePlusTIM pressed do
			(
			sliderTime += 1
			)

		button EndTIM "End" tooltip:"Go to End" \
					images:#("$ui\icons\VCRControls_24i.bmp","$ui\icons\VCRControls_24i.bmp",28,15,16,1,1) \
					height:30 width:30 align:#right offset:[5,0]
			on EndTIM pressed do
			(
			max time end --actionMan.executeAction 0 "50019"
			)
		--Rollout roll up/down state	
		on PlayBackRLT rolledUp state do
			(
			if state then
			setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "PlayBack Rollout" "Rolled State" "true"
			else setINISetting(getdir #maxroot + "\\plugcfg\FumeFlowfloater.ini") "PlayBack Rollout" "Rolled State" "false" 
			)
	)

	
if FumeCreate != undefined do
				(
				closeRolloutFloater FumeCreate
				)

if sForFFXDialogScroll != undefined do
				(
				sForFFXDialogScroll=0
				)



--Create Dialog

FumeCreate = newRolloutFloater "Fume & Flow"  widthForFFXDialog heightForFFXDialog 
FumeCreate.pos=[xForFFXDialogLocation,yForFFXDialogLocation]	

addRollout FumeRLT FumeCreate
addRollout FumeFlowObjSel FumeCreate
addRollout SourceRLT FumeCreate 
addRollout PFlowRLT FumeCreate 
addRollout PlayBackRLT FumeCreate 
	FumeRltPos ()
	rolloutMemCTRL ()
	
--end
