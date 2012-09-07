-------------------------------------------------------------------------------
-- CGsoldier.mcr
-- MacroScripts File
-- By PaoloHilario (paolo@cgsoldier.com)
-- Feb 29th 2004
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
(
-------------------------------------------------------------------------------
--- Startup Function FileIns --- 
-------------------------------------------------------------------------------

include "$userScripts\\CGsoldier\\functions\\CGS_func.mse"

-------------------------------------------------------------------------------
--- CGsoldier Scripts - Launchers
-------------------------------------------------------------------------------
	

MacroScript CGS_ST category:"CGsoldier Tools" tooltip:"CGsoldier Scene Tools" Icon:#("CGsoldier",2)
	(
	include "$userScripts\\CGsoldier\\CGS-SceneTools.mse"
	)
	
MacroScript CGS_RD category:"CGsoldier Tools" tooltip:"CGsoldier R&D Scripts" Icon:#("CGsoldier", 3)
	(
	include "$userScripts\\CGsoldier\\CGS-R&DTools.mse"
	)
	
MacroScript CGS_MT category:"CGsoldier Tools" tooltip:"CGsoldier Modeling Tools" Icon:#("CGsoldier", 12)
	(
	include "$userScripts\\CGsoldier\\CGS-ModelingTools.mse"
	)

	
-------------------------------------------------------------------------------
--- CGsoldier Scripts - Scene Tools
-------------------------------------------------------------------------------

-- MacroScript PassMonkey category:"CGS-SceneTools" tooltip:"CGS-PassMonkey" Icon:#("CGsoldier", 1)
-- 	(
-- 	include "$userScripts\\CGsoldier\\CGS-SceneTools\\CGS-PassMonkey.mse"
-- 	)
	
-------------------------------------------------------------------------------
--- CGsoldier Scripts - Modeling Tools
-------------------------------------------------------------------------------

-- MacroScript AffectPivot category:"CGS-ModelingTools" tooltip:"Affect Pivot"
-- 	(
-- 	include "$userScripts\\CGsoldier\\CGS-ModelingTools\\AffectPivot.mse"
-- 	)
	

-------------------------------------------------------------------------------------------
---- Blur Scripts
-------------------------------------------------------------------------------------------	

-- MacroScript ActiveMtlSlot category:"CGS-Scripts_Blur" tooltip:"ActiveMtlSlot"
-- 	(
-- 	Include "$userscripts/BlurScripts/ActiveMtlSlot.ms"
-- 	)

-------------------------------------------------------------------------------------------
---- End Script Loader
-------------------------------------------------------------------------------------------	
)