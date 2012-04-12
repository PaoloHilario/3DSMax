macroScript PC category:"KrakatoaToolbar" tooltip:"Particle Cache Toggle" icon:#("KrakatoaTools",9)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "EnableParticleCache")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "EnableParticleCache" ((not (FranticParticles.getBoolProperty "EnableParticleCache")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
