macroScript LC category:"KrakatoaToolbar" tooltip:"Lighting Cache Toggle" icon:#("KrakatoaTools",10)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "EnableLightingCache")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "EnableLightingCache" ((not (FranticParticles.getBoolProperty "EnableLightingCache")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
