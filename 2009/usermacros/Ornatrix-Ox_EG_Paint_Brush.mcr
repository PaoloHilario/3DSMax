macroScript Ox_EG_Paint_Brush category:"Ornatrix" tooltip:"Ox Paint Brush"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.PaintBrush()
	)
)
