macroScript Ox_EG_Create_Root category:"Ornatrix" tooltip:"Ox Create Root"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.CreateRoot()
	)
)
