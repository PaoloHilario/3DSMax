macroScript XRefMan
category:"BFDtools"
buttontext:"XRefMan"
tooltip:"XRefMan - Manage XRefs"
icon:#("BFDtools-Icons",28)
(

------------------------------------------------------------------------------------------
-- Contents:
--		XRefMan - Description: Manage XRefs
--
-- Requires:
--		jbFunctions.ms
--		jbLib.dlx
------------------------------------------------------------------------------------------

if (
	if (jbFunctionsCurrentVersion == undefined OR (jbFunctionsCurrentVersion() < 11)) then (
		local str = "This script requires jbFunctions to run properly.\n\nYou can get the latest version at http://www.johnburnett.com/.\n\nWould you like to connect there now?"
		if (QueryBox str title:"Error") then ( try (ShellLaunch "http://www.johnburnett.com/" "") catch () )
		FALSE
	) else (
		jbFunctionsVersionCheck #( #("jbFunctions",11), #("jbLib",1) )
	)
) then (

	local thisTool = BFDtool	toolName:"XRefMan"			\
								author:"John Burnett"		\
								createDate:[4,11,2000]		\
								modifyDate:[5,21,2001]		\
								version:5					\
								defFloaterSize:[970,273]	\
								autoLoadRolloutStates:true	\
								autoLoadFloaterSize:true

	fn makeObjXRefUNC obj = (
		try (
			if classOf obj == XRefObject then (
				local flag = true
				local UNCpath

				if obj.filename != "" then (
					UNCpath = getUNCpath obj.filename
					if UNCpath == undefined then
						flag = false
					else
						obj.filename = UNCpath
				)

				if obj.proxyFilename != "" then (
					UNCpath = getUNCpath obj.proxyFilename
					if UNCpath == undefined then
						flag = false
					else
						obj.proxyFilename = UNCpath
				)

				updateXRef obj
				return flag
			) else ( return false )
		) catch ( return false )
	)

	fn makeSceneXRefUNC i = (
		try (
			if (i < 1) OR (i > xrefs.getXRefFileCount()) then return false

			local x = xrefs.getXRefFile i
			local UNCpath = getUNCpath x.filename
			if UNCpath != undefined then (
				x.filename = UNCpath
				return true
			) else (
				return false
			)
		) catch ( return false )
	)

	rollout DLGaboutRollout "About" (
		button DLGhelp "Help"
		label DLGAbout01 "" offset:[0,5]
		label DLGAbout02 ""
		label DLGAbout03 ""

		on DLGhelp pressed do (
			local helpStr = "Help Goes Here"
			messageBox helpStr title:"XRefMan Help"
		)

		on DLGaboutRollout open do (
			DLGabout01.text = thisTool.toolName
			DLGabout02.text = thisTool.author
			DLGabout03.text =	(thisTool.modifyDate.x as integer) as string + "." +
								(thisTool.modifyDate.y as integer) as string + "." +
								(thisTool.modifyDate.z as integer) as string
		)

		on DLGaboutRollout close do ( thisTool.closeTool() )
	)

	rollout DLGmainRollout "Main Rollout" (
		fn updateUI = (
		)

--		multilistbox DLGsceneXRefList "" items:#()
--		multilistbox DLGobjXRefList "" items:#()

		groupBox DLGqueueGroup "Add Scene XRef As UNC:" pos:[4,7] width:767 height:179
			button DLGaddXRefAsUNC "Add To Queue" pos:[13,157] width:150 height:21 align:#center
			button DLGremoveXRef "Remove From Queue" pos:[166,157] width:150 height:21 align:#center
			listbox DLGxrefQueue "Scene XRef Queue:" pos:[13,22] width:750 height:8 align:#center
			button DLGaddNow "Add Queue To Scene Now" pos:[614,157] width:150 height:21 align:#center
		groupBox DLGutilGroup "Utils:" pos:[775,7] width:163 height:72
			button DLGconvertAll "Convert All To UNC Paths" pos:[781,26] width:150 height:21 align:#center
			button DLGprintSceneXRefs "Print Scene XRefs" pos:[781,52] width:150 height:21 align:#center
		groupBox DLGsetPropsGroup "Scene XRefs Props:" pos:[775,81] width:163 height:105
			checkbox DLGsceneDisabled "Disabled" pos:[784,100] width:65 height:15 align:#left
			checkbox DLGsceneHidden "Hidden" pos:[784,120] width:58 height:15 align:#left
			checkbox DLGsceneBoxDisplay "Box Display" pos:[784,140] width:79 height:15 align:#left
			button DLGsetSceneProps "Set Scene XRefs Props" pos:[781,160] width:150 height:21

		on DLGaddXRefAsUNC pressed do (
			local f = getOpenFilename caption:"Open File" types:"3D Studio MAX (*.max)|*.MAX|All files (*.*)|*.*|"
			if (f != undefined) do (
				local UNC = getUNCpath f
				if UNC != undefined then (
					DLGxrefQueue.items = DLGxrefQueue.items + #(UNC)
				)
			)
		)

		on DLGremoveXRef pressed do (
			local i = DLGxrefQueue.selection
			local ar = DLGxrefQueue.items
			if (i > 0 AND i <= ar.count) do (
				DeleteItem ar i
				DLGxrefQueue.items = ar
			)
		)

		on DLGaddNow pressed do (
			ProgressStart "Adding XRefs..."
			DisableSceneRedraw()
			i = 0.0
			tot = DLGxrefQueue.items.count as float
			for fName in DLGxrefQueue.items do (
				try (
					local x = xrefs.AddNewXRefFile fName #noLoad
					x.hidden = DLGsceneHidden.checked
					x.disabled = DLGsceneDisabled.checked
					x.boxDisp = DLGsceneBoxDisplay.checked
					UpdateXRef x
				) catch ()
				i += 1.0
				if NOT (ProgressUpdate (i/tot*100.0)) then exit
			)
			EnableSceneRedraw()
			ProgressEnd()
		)

		on DLGconvertAll pressed do (
			local badFlag = false

			for obj in objects do (
				if classOf obj == XRefObject then (
					if NOT (makeObjXRefUNC obj) then badFlag = true
				)
			)

			for i in 1 to xrefs.getXRefFileCount() do (
				if NOT (makeSceneXRefUNC i) then badFlag = true
			)

			if badFlag then (
				local msgStr = "One or more XRef Paths Could Not Be Fixed\n\nDouble check the paths manually in the \"File\" dropdown menu."
				messageBox msgStr title:"Warning"
			)
		)

		on DLGprintSceneXRefs pressed do (
			local oldColor = outputTextColor
			local printDivide
			fn printDivide = format "------------------------------------------------------------------------------------------------------------------------------------------------------\n"

			outputTextColor = blue
			local XRefCount = xrefs.getXRefFileCount()
			format "\n"
			printDivide()
			format "% Scene XRefs:\n" XRefCount
			printDivide()
			for i in 1 to XRefCount do (
				local x = xrefs.getXRefFile i
				outputTextColor = blue; format "%: " i; print (filenameFromPath x.filename)
				outputTextColor = black; format "   "; print x.filename; outputTextColor = blue
			)
			printDivide()

			outputTextColor = oldColor
			format "\n"
		)

		on DLGsetSceneProps pressed do (
			for i in 1 to xrefs.getXRefFileCount() do (
				local x = xrefs.getXRefFile i
				x.hidden = DLGsceneHidden.checked
				x.boxDisp = DLGsceneBoxDisplay.checked
				x.disabled = DLGsceneDisabled.checked
			)
		)
	)

	thisTool.addRoll #(DLGaboutRollout,DLGmainRollout) rolledUp:#(true,false)

	thisTool.openTool thisTool
)
)
