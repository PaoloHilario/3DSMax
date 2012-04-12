macroScript LT category:"KrakatoaToolbar" tooltip:"Use Lighting Toggle" icon:#("KrakatoaTools",3)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "UseLighting")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "UseLighting" ((not (FranticParticles.getBoolProperty "UseLighting")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
			Krakatoa_GUI_Channels.updateMemChannels()
		)catch()
	)
)
