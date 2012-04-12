macroScript Ox_EG_GS_Brush category:"Ornatrix" tooltip:"Ox Grow/Shrink Brush"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.GSBrush()
	)
)
