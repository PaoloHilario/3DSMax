macroScript Decr_Dense_Count category:"Ornatrix" tooltip:"Ox Decrease Hair Count"
(
	for i=1 to selection.count do (
		hfgMod = OxFindSelOccurenceOf(#Ox_Hair_from_Guides) instance:selection[i]
		if(hfgMod!=undefined) then
		(
			hfgMod.invalidateCache()
			hfgMod[2].value=hfgMod[2].value*0.5
			if(hfgMod[2].value<1) then hfgMod[2].value=1
		)
	)
)
