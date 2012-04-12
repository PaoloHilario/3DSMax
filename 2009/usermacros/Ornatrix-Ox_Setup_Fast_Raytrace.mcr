macroScript Ox_Setup_Fast_Raytrace category:"Ornatrix" tooltip:"Ox Setup Fast Raytrace"
(
	if($ != undefined) then (
		oxRt = Ox_Hair_Raytrace_Fast()
		for i in selection do (
			oxRt.AddHair i
		)
		
		addAtmospheric oxRt
	)
)
