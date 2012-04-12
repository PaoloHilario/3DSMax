macroScript vrsceneExport category:"VRay" buttontext:".vrscene exporter" tooltip:"Export the current view to a .vrscene file" (
	-- local res=messageBox "No UI yet; please use 'vrscene_printScene <scenefilename>' in MaxScript listener" title:".vrscene exporter"
	vrscene_exportAnim=false
	createDialog vrsceneExportRollout modal: true
)
