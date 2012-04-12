-------------------------------------------------------------------------------
-- Vray Light Materials On
-- MacroScripts File
-- By PaoloHilario (paolo@cgsoldier.com)
-- June 19th 2008
-------------------------------------------------------------------------------

(
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------	

local mats=#() 	
for mat in scenematerials do (append mats mat)	
local ltmats=#()
for i=1 to mats.count do (if classof mats[i] == VRayLightMtl do append ltmats mats[i])
	
for i=1 to ltmats.count do 
	(
	mult = getinisetting (maxfilepath + "RM-DATA\\" + (substring maxfilename 1 (maxfilename.count - 4) + "_VRLM.ini")) "VrayLightMaterial" (ltmats[i].name)
	ltmats[i].multiplier = (mult as integer)
	)
)