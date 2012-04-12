macroScript KrakatoaAutoLog category:"Krakatoa" tooltip:"Auto-Open Log Window On Output On/Off" buttontext:"Krakatoa Auto-Open Log" icon:#("Krakatoa",3)
(
	on isChecked return try(FranticParticles.PopupLogWindowOnMessage )catch(false)
	on execute do
	(
		try(FranticParticles.PopupLogWindowOnMessage = not FranticParticles.PopupLogWindowOnMessage )catch()
	)
)
