-------------------------------------------------------------------------------
-- Maps Display Off
-- MacroScripts File
-- By PaoloHilario (paolo@cgsoldier.com)
-- June 19th 2008
-------------------------------------------------------------------------------

(
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------	

local StdMats=#() 	
for mat in scenematerials do (if classof mat == Standardmaterial do (append StdMats mat))
local	VrayMats=#()
for mat in scenematerials do (if classof mat == VRayMtl do (append VrayMats mat))
local	MsubMats=#()
for mat in scenematerials do (if classof mat == Multimaterial do (append MsubMats mat))
	
for i=1 to StdMats.count do 
	(
	if StdMats[i].diffuseMap != undefined do (showTextureMap StdMats[i] StdMats[i].diffuseMap off)
	)
	
for i=1 to VrayMats.count do 
	(
	if VrayMats[i].texmap_diffuse != undefined do (showTextureMap VrayMats[i] VrayMats[i].texmap_diffuse off)
	)
	
for i=1 to MsubMats.count do 
	(
	for j=1 to MsubMats[i].numsubs do
		(
		if classof MsubMats[i].materialList[j] == Standardmaterial and MsubMats[i].materialList[j].diffuseMap != undefined do (showTextureMap MsubMats[i] MsubMats[i].materialList[j].diffuseMap off)
		if classof MsubMats[i].materialList[j] == VRayMtl and MsubMats[i].materialList[j].texmap_diffuse != undefined do (showTextureMap MsubMats[i] MsubMats[i].materialList[j] off)
		)
	)
)