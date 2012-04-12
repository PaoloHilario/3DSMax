macroScript MB category:"KrakatoaToolbar" tooltip:"Motion Blur Toggle" icon:#("KrakatoaTools",1)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "EnableMotionBlur")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "EnableMotionBlur" ((not (FranticParticles.getBoolProperty "EnableMotionBlur")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
			Krakatoa_GUI_Channels.updateMemChannels()
		)catch()
	)
)
