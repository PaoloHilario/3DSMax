macroScript AE category:"KrakatoaToolbar" tooltip:"Ambient Extinction Toggle" icon:#("KrakatoaTools",8)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "PME:UseExtinction")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "PME:UseExtinction" ((not (FranticParticles.getBoolProperty "PME:UseExtinction")) as string)
			Krakatoa_GUI_AmbientPME.refresh_GUI()
		)catch()
	)
)
