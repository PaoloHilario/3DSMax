macroScript Create_Partings category:"Ornatrix" tooltip:"Ox Create Partings"
(
	hfgMod = OxFindSelOccurenceOf(#Ox_Hair_from_Guides)
	if(hfgMod!=undefined) then
	(
		max modify mode
		modPanel.setCurrentObject hfgMod
		hfgMod.CreatePartings()
	)
)
