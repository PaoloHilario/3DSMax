macroScript Ox_EG_Cut_Strands category:"Ornatrix" tooltip:"Ox Cut Strands"
(
	egMod = OxFindSelOccurenceOf(#Ox_Edit_Guides)
	if(egMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject egMod
		egMod.CutStrands()
	)
)
