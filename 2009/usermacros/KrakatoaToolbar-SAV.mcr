macroScript SelectionToMap
category: "PolyBoost"
tooltip: "SelectionToMap"
icon:#("PB_Icons2", 13)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do
	(
	if keyboard.shiftpressed then PolyBSelToBitmap $ 512 512 1 0
	else PolyBSelToBitmap $ 256 256 1 0
	)
)
	local oldMode = (FranticParticles.getProperty "ParticleMode")
			if oldMode == "Save Particles To File Sequence" then
				FranticParticles.setProperty "ParticleMode" "Render Scene Particles"
			else
				FranticParticles.setProperty "ParticleMode" "Save Particles To File Sequence"
			Krakatoa_GUI_Main.refresh_GUI()
		)catch()
	)
)
