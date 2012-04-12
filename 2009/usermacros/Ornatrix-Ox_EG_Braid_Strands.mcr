macroScript Ox_EG_Braid_Strands category:"Ornatrix" tooltip:"Ox Braid Strands"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.BraidStrands()
	)
)
