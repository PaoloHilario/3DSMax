macroScript Ox_EG_Control_Point category:"Ornatrix" tooltip:"Ox Change Control Point(s)"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.CPChange()
	)
)
