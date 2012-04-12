macroScript op category:"KrakatoaToolbar" tooltip:"Render Other Particles" icon:#("KrakatoaTools",18)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "RenderParticleObjectExt")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "RenderParticleObjectExt" ((not (FranticParticles.getBoolProperty "RenderParticleObjectExt")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
