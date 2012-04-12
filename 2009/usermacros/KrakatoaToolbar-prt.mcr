macroScript prt category:"KrakatoaToolbar" tooltip:"Render PRT Loaders" icon:#("KrakatoaTools",17)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "RenderKrakatoaLoaders")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "RenderKrakatoaLoaders" ((not (FranticParticles.getBoolProperty "RenderKrakatoaLoaders")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
