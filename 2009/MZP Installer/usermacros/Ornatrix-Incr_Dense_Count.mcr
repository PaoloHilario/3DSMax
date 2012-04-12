macroScript Incr_Dense_Count category:"Ornatrix" tooltip:"Ox Increase Hair Count"
(
	for i=1 to selection.count do (
		hfgMod = OxFindSelOccurenceOf #Ox_Hair_from_Guides instance:selection[i]
		if(hfgMod!=undefined) then
		(
			hfgMod.invalidateCache()
			hfgMod[2].value=hfgMod[2].value*2
		)
	)
)
