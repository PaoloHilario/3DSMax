macroScript Ox_EG_Import_Spline category:"Ornatrix" tooltip:"Ox Import Spline"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.ImportSpline()
	)
)
