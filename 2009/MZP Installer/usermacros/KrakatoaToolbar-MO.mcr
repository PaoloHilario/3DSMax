macroScript MO category:"KrakatoaToolbar" tooltip:"Use Matte Objects Toggle" icon:#("KrakatoaTools",5)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "Matte:UseMatteObjects")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "Matte:UseMatteObjects" ((not (FranticParticles.getBoolProperty "Matte:UseMatteObjects")) as string)
			Krakatoa_GUI_MatteObjects.refresh_GUI()
		)catch()
	)
)
