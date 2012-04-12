macroScript NR category:"KrakatoaToolbar" tooltip:"Use Normals Toggle" icon:#("KrakatoaTools",4)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "Lighting:Specular:Enabled")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "Lighting:Specular:Enabled" ((not (FranticParticles.getBoolProperty "Lighting:Specular:Enabled")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
			Krakatoa_GUI_Channels.updateMemChannels()
		)catch()
	)
)
