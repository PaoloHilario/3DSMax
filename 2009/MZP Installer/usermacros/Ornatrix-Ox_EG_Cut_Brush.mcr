macroScript Ox_EG_Cut_Brush category:"Ornatrix" tooltip:"Ox Cut Brush"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.CutBrush()
	)
)
