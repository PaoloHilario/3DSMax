macroScript GV category:"KrakatoaToolbar" tooltip:"Render Geometry Vertices" icon:#("KrakatoaTools",14)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "RenderGeometryVertices")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "RenderGeometryVertices" ((not (FranticParticles.getBoolProperty "RenderGeometryVertices")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
