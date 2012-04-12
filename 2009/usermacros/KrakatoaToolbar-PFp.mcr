macroScript PFp category:"KrakatoaToolbar" tooltip:"Render PFlow Phantom" icon:#("KrakatoaTools",12)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "RenderParticleFlowPhantom")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "RenderParticleFlowPhantom" ((not (FranticParticles.getBoolProperty "RenderParticleFlowPhantom")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
