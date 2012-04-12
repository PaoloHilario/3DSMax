macroScript KrakatoaLog category:"Krakatoa" tooltip:"Toggle Krakatoa Log Window On/Off" buttontext:"Krakatoa Log Window" icon:#("Krakatoa",2)
(
	on isChecked return try(FranticParticles.LogWindowVisible)catch(false)
	on execute do
	(
		try(FranticParticles.LogWindowVisible = not FranticParticles.LogWindowVisible)catch()
	)
)
