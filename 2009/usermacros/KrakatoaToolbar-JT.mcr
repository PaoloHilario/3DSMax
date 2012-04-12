macroScript JT category:"KrakatoaToolbar" tooltip:"Jittered Motion Blur Toggle" icon:#("KrakatoaTools",6)
(
	on isEnabled return (renderers.current.classid as string == "#(-1204370534, -399920359)")
	on isChecked return try(FranticParticles.getBoolProperty "JitteredMotionBlur")catch(false)
	on execute do (
		try(
			FranticParticles.setProperty "JitteredMotionBlur" ((not (FranticParticles.getBoolProperty "JitteredMotionBlur")) as string)
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
