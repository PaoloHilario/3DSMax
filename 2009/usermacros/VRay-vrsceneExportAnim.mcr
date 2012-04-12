macroScript vrsceneExportAnim category:"VRay" buttontext:".vrscene animation exporter" tooltip:"Export the current view animation to a .vrscene file" (
	-- local res=messageBox "No UI yet; please use 'vrscene_printSceneAnim <scenefilename> <startFrame> <endFrame>' in MaxScript listener" title:".vrscene exporter"
	vrscene_exportAnim=true
	createDialog vrsceneExportRollout modal: true
)
