macroScript CO category:"KrakatoaToolbar" tooltip:"Override Particle Colors Toggle" icon:#("KrakatoaTools",7)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "UseGlobalColorOverride")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "UseGlobalColorOverride" ((not (FranticParticles.getBoolProperty "UseGlobalColorOverride")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
			Krakatoa_GUI_Channels.updateMemChannels()
		)catch()
	)
)
