macroScript Delete_Sel_Partings category:"Ornatrix" tooltip:"Ox Delete Selected Partings"
(
	hfgMod = OxFindSelOccurenceOf(#Ox_Hair_from_Guides)
	if(hfgMod!=undefined) then
	(
		max modify mode
		modPanel.setCurrentObject hfgMod
		hfgMod.DeleteSelPartings()
	)
)
