macroScript PFg category:"KrakatoaToolbar" tooltip:"Render PFlow Geometry" icon:#("KrakatoaTools",11)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "RenderParticleFlowGeometry")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "RenderParticleFlowGeometry" ((not (FranticParticles.getBoolProperty "RenderParticleFlowGeometry")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
