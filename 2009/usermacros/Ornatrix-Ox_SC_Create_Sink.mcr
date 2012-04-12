macroScript Ox_SC_Create_Sink category:"Ornatrix" tooltip:"Ox Create Sink"
(
	scMod = OxFindSelOccurenceOf(#Ox_Surf_Comb)
	if(scMod!=undefined) then 
	(
		max modify mode
		modPanel.setCurrentObject scMod
		scMod.CreateSink()
	)
)
