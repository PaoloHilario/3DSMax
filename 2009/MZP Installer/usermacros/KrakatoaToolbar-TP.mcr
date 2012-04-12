macroScript TP category:"KrakatoaToolbar" tooltip:"Render Thinking Particles" icon:#("KrakatoaTools",16)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "RenderThinkingParticles")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "RenderThinkingParticles" ((not (FranticParticles.getBoolProperty "RenderThinkingParticles")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
