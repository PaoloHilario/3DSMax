macroScript KrakatoaShadows category:"Krakatoa" icon:#("Krakatoa",4)
(
	global Krakatoa_MatteShadows_Utility 
	try(destroyDialog Krakatoa_MatteShadows_Utility )catch()
	rollout Krakatoa_MatteShadows_Utility "Krakatoa: Shadows On Geometry"
	(
		local theRenderers = (for i in rendererClass.classes where not matchPattern (i as string) pattern:"*Missing*" and not matchPattern (i as string) pattern:"*VUE*" and not matchPattern (i as string) pattern:"*Krakatoa*" collect i)
		local theRPresets =  join (getFiles (getdir #renderpresets  + "\\*.rps"))  (getFiles (getdir #maxroot + "\\renderpresets\\*.rps") )
		
		group "Shadows Data Location"
		(
			button btn_pickDataLocation "Select Shadows Data Location..." width:280
			edittext edt_dataLocation text:"" offset:[5,0] width:280 align:#right
			edittext edt_dataPrefix "File Prefix:" text:"" offset:[5,0] fieldwidth:225 align:#right
			button btn_resolveDataLocation "Get Shadows Data Location From Render Path..." width:280
		)	
		group "Add and Remove Shadows"
		(
			button btn_addShadows "ADD KRAKATOA SHADOWS TO THE SCENE" width:280 height:30 enabled:false
			button btn_removeShadows "REMOVE Krakatoa Shadows From The Scene" width:280
		)	
		
		group "Switch Renderers"
		(
			label lbl_currentRenderer "" align:#left
			dropdownlist ddl_assignRenderer items:(for i in theRenderers collect i as string) width:185 across:2 align:#left
			button btn_assignRenderer "Assign Renderer" align:#right  width:90 offset:[4,0]
			dropdownlist ddl_renderPresets items:(for i in theRPresets collect getFileNameFile i) width:185 across:2 align:#left
			button btn_loadPreset "Load Preset" align:#right  width:90 offset:[4,0]
			button btn_restoreKrakatoa "RESTORE Krakatoa Renderer" width:280
		)	

		fn enablecontrols =
		(
			btn_restoreKrakatoa.enabled = (classof renderers.current) != Krakatoa 
			lbl_currentRenderer.text = "Current Renderer : " + (classof renderers.current) as string
		)
		
		on btn_assignRenderer pressed do
		(
			if classof renderers.current == Krakatoa do
				RenderPresets.Save 0 ((getdir #renderpresets) + "\\krakatoa_pre_shadows.rps") #{1,4..64}
			renderers.current = theRenderers[ddl_assignRenderer.selection]()
			enablecontrols()
		)
		
		on btn_restoreKrakatoa pressed do
		(
			if (doesFileExist ((getdir #renderpresets) + "\\krakatoa_pre_shadows.rps") == true) do
				renderpresets.LoadAll 0 ((getdir #renderpresets) + "\\krakatoa_pre_shadows.rps") 
			enablecontrols()	
		)
		
		on btn_loadPreset pressed do
		(
			if (doesFileExist theRPresets[ddl_renderPresets.selection] ) do
			(
				RenderPresets.Save 0 ((getdir #renderpresets) + "\\krakatoa_pre_shadows.rps") #{1,4..64}
				renderpresets.LoadAll 0 theRPresets[ddl_renderPresets.selection]
			)	
			enablecontrols()
		)
		
		on btn_pickDataLocation pressed do
		(
			thePath = getOpenFileName types:"OpenEXR Attenuation File (*.exr)|*.exr"
			if thePath != undefined and doesFileExist thePath then
			(
				edt_dataLocation.text = getFileNamePath thePath
				edt_dataPrefix.text = (filterString (getFileNameFile thePath) "_")[1]
				btn_addShadows.enabled = true
			)
			else
				btn_addShadows.enabled = false
		)
		
		on btn_resolveDataLocation pressed do
		(
			if rendOutputFileName != "" and doesFileExist rendOutputFileName do
			(
				local thePath = getFilenamePath rendOutputFileName + "shadows"
				if doesFileExist thePath do 
				(
					edt_dataLocation.text = thePath
					edt_dataPrefix.text = (filterString (getFileNameFile rendOutputFileName) "_")[1]
					btn_addShadows.enabled = true
				)	
			)	
		)		
		
		on btn_removeShadows pressed do
		(
			theLights = for o in Objects where findItem light.classes (classof o) > 0 collect o
			for o in theLights do 
			(
				if o.projectormap != undefined then
				(
					if matchpattern o.projectormap.name pattern:(o.name+"_Krakatoa_Shadow_Multiply") then
						o.projectormap = o.projectormap.map1
					else	
						if matchpattern o.projectormap.name pattern:(o.name+"_Krakatoa_Shadow_Map") then
							o.projectormap = undefined
				)			
			)	
		)		
		
		on edt_dataLocation entered txt do
		(
			if doesFileExist txt then
			(
				btn_addShadows.enabled = true
			)
			else
				btn_addShadows.enabled = false
		)
		
		on btn_addShadows pressed do
		(
			format "Applying Krakatoa Shadows from [%]\n" edt_dataLocation.text
			st0 = timestamp()
			theLights = for o in Objects where findItem light.classes (classof o) > 0 collect o
			for o in theLights do
			(
				if o.projectormap != undefined and matchpattern o.projectormap.name pattern:"*_Krakatoa_Shadow_*" then
				(
					format "\t--Skipping Light % - Krakatoa Shadow Map already applied.\n" o
				)
				else
				(
					st = timestamp()
					format ">Processing Light %\n" o
					theFiles = getFiles (edt_dataLocation.text + "\\" + edt_dataPrefix.text + "*_" + o.name + "_*.exr")
					theFiles = for f in theFiles where not matchPattern (getFileNameFile f) pattern:"*_shadowbuffer_*" collect f
					sort theFiles
					format "\tFiles Collecting and Sorting Time: %ms\n" (timestamp()-st)
					st = timestamp()
					if theFiles.count > 0 then
					(
						format "\t>Creating IFL...\n" o
						theBaseFilename = getFileNameFile theFiles[1]
						theHashesName = FranticParticles.ReplaceSequenceNumberWithHashes theBaseFilename 
						cnt = 0
						for i = 1 to theHashesName.count where theHashesName[i] == "#" do cnt += 1
						theIFLName = (getFileNamePath theFiles[1] + theBaseFilename + ".ifl")
						theFirstFrame = execute (substring (getFilenameFile theBaseFilename) (theBaseFilename.count-cnt+1) cnt)
						if classof theFirstFrame != Integer do theFirstFrame = 0
						format "\t\tFirst Frame = %\n" theFirstFrame 
						theLastFrame = execute (substring (getFilenameFile theFiles[theFiles.count]) ((getFilenameFile theFiles[theFiles.count]).count-cnt+1) cnt)
						if classof theLastFrame != Integer do theLastFrame= 0
						format "\t\tLast Frame = %\n" theLastFrame
						theIFL = createFile theIFLName
						local lastGoodImage = ""
						local lastGoodFrame = 0					
						for i = theFirstFrame to theLastFrame do
						(
							local theFileToWrite = (FranticParticles.ReplaceSequenceNumber theFiles[1] i)
							if doesFileExist theFileToWrite then
							(
								format "\t\t+Writing Attenuation Map For Frame % to IFL File.\n" i
								format "%\n" (filenameFromPath theFileToWrite) to:theIFL
								lastGoodImage = theFileToWrite 
								lastGoodFrame = i
							)	
							else
							(
								format "\t\t--WARNING: Attenuation Map For Frame % is Missing! Including last good frame % instead. \n" i lastGoodFrame 
								format "%\n" (filenameFromPath lastGoodImage) to:theIFL
							)	
						)	
						close theIFL
						theBmp = bitmaptexture filename:theIFLName name:(o.name+"_Krakatoa_Shadow_Map")
						theBmp.output.invert = true
						theBmp.starttime = theFirstFrame 
						theBmp.endCondition = 2
						if matchPattern ((classof o) as string) pattern:"*Omni*" then
						(
							theBmp.coords.mappingType = 1
							theBmp.coords.mapping = 0
						)
						else
						(
							theBmp.coords.mappingType = 0
							theBmp.coords.mapping = 0						
						)
						if o.projectormap != undefined then
						(
							newMap = rgb_multiply name:(o.name+"_Krakatoa_Shadow_Multiply")
							newMap.map1 = o.projectormap
							newMap.map2 = theBmp
							o.projectormap = newMap
						)					
						else
							o.projectormap = theBmp
					)
					else
						format "\t--Could Not Find Shadow Map Data For %\n" o
					format "\tMap Processing Time: %ms\n" (timestamp()-st)
				)
			)--end o
			freescenebitmaps()
			gc light:true
			format "Total Processing Time: %ms\n\n" (timestamp()-st0)
		)--end btn
		
		on Krakatoa_MatteShadows_Utility open do
		(
			enablecontrols()
			btn_resolveDataLocation.pressed()
		)
		
		
	)--end rollout
	createDialog Krakatoa_MatteShadows_Utility 300 340
)	 