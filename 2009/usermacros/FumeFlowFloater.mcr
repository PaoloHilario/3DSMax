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
		
		This macroscript adds buttons/icons for FumeFX and a button/icon for the Fume & Flow Dialog 
		to the Fume&Flow category in the customize menu. 	
		
Installs file FumeFlowFloater_06.ms in your "~\scripts" folder.
Creates file FumeFlowfloater.ini in your "~\plugcfg" folder.		   
Installs file FumeFlowFloater.mcr in your"~\ui\macroscripts" folder.
Installs all icons:
	"real" FumeFX*.bmp 
	"my" FumeIcons*.bmp 
	"my" SW_Drag_Vortex*.bmp
	"my" PFicons*.bmp
in "~\ui\icons" folder.

***********************************************************************************************
MODIFY THIS AT YOUR OWN RISK
*/
--start

macroScript FumeFX_Create_Dialog
	enabledIn:#("max")
	Category:"Fume&Flow"
	toolTip:"Create Dialog"
	icon:#("FumeIcon",1)
	ButtonText:"FumeFX Create Dialog"
		(
		fileIn "$userscripts\\Misc\\FumeFlowFloater_06.ms"
		)

macroScript CreateFFX
	category:"Fume&Flow"
	toolTip:"Create Grid"
	icon:#("FumeIcon",2)
	ButtonText:"FumeFX Grid"
		(
		startObjectCreation FumeFX
		)
	

macroScript SimpleSource
	category:"Fume&Flow"
	toolTip:"Create Simple Source"
	icon:#("FumeIcon",3)
	ButtonText:"Simple Source"
		(
		startObjectCreation Simple_Src
		)
	

macroScript ObjectSource
	category:"Fume&Flow"
	toolTip:"Create Object Source"
	icon:#("FumeIcon",4)
	ButtonText:"Object Source"
		(
		startObjectCreation Object_Src
		)
	
macroScript ParticleSource
	category:"Fume&Flow"
	toolTip:"Create Particle Source"
	icon:#("FumeIcon",5)
	ButtonText:"Particle Source"
		(
		startObjectCreation Particle_Src
		)
	

macroScript GravityVCTR
	category:"Fume&Flow"
	toolTip:"Create Gravity Vector"
	icon:#("FumeIcon",6)
	ButtonText:"Gravity Vector"
		(
		startObjectCreation GravityVector
		)

--end