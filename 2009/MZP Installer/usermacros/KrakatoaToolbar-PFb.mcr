macroScript PFb category:"KrakatoaToolbar" tooltip:"Render PFlow BBox" icon:#("KrakatoaTools",13)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "RenderParticleFlowBBox")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "RenderParticleFlowBBox" ((not (FranticParticles.getBoolProperty "RenderParticleFlowBBox")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
