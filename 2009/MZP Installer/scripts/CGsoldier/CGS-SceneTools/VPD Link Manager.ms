-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
--- IPDS Link Manager v1.0 beta
--- Written for Scenario Design, Inc. 
--- By Paolo Hilario				
--- http://www.cgsoldier.com	
-------------------------------------------------------------------------------
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Manages all Xrefs scenes and objects, File Links, and creates pseudo
-- file linking for all importable file types. Extends functionality to existing
-- file link capabilities in MAX for IPDS Master Models.
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- 
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Revision History:
--
-------------------------------------------------------------------------------

(	--Begin Script
---------------------------------------------------------------------------------------------------------------------------------------------
--- Persistent Global Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
---------------------------------------------------------------------------------------------------------------------------------------------

-- 	FileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"
	try(destroyDialog IPDS_LinkMgr)catch()
	FLx = ((getINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterX") as integer)
	FLy = ((getINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterY") as integer)
	FLw = ((getINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterW") as integer)
	FLh = ((getINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterH") as integer)
		
---------------------------------------------------------------------------------------------------------------------------------------------	
--- Functions ---
---------------------------------------------------------------------------------------------------------------------------------------------

	fn SetDialog X =
		(
		Dpos = GetDialogPos X
		Dsize = getDialogSize X	
		setINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterX"  (( Dpos.x ) as String)
		setINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterY"  (( Dpos.y ) as String)
		setINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterW"  (( Dsize.x ) as String)
		setINISetting "$UI\\Macroscripts\\IPDS.ini" "IPDS_LinkMgr" "FloaterH"  (( Dsize.y ) as String)
		)
		
	fn gatherobjects = 
		(
		global Orig_Objset = objects as array
		)

	fn array_difference array1 array2= 
		(
		newarray = #()
		for i =1 to array1.count do
			(
			if (finditem array2 array1[i]) == 0 then append newarray array1[i]
			)
		return newarray
		)
		
	global IPDStag_filelink;
	fn IPDStag_filelink filepath = 
		(
		objset = (array_difference (objects as array) OG_Objset)
		for obj in objset do 
			(
			setuserprop obj "linkpath" filepath
			)
		)

	global IPDStag_merge;
	fn IPDStag_merge objset mergepath= 
		(
		for obj in objset do 
			(
			setuserprop obj "mergepath" mergepath
			)
		)

	global IPDStag_import;
	fn IPDStag_import objset importpath= 
		(
		for obj in objset do 
			(
			setuserprop obj "importpath" importpath
			)
		)
		

	fn getIconFromBitmap thePath number iconFileName =
		(
		theFileName = getDir #image +"\\icon_"+ iconFileName +".bmp"
		if not doesFileExist theFileName do
			(
			tempBmp = openBitmap thePath
			iconBmp = bitmap 16 15
			for v = 0 to 14 do
			setPixels iconBmp [0,v] (getPixels tempBmp [(number-1)*16, v] 16)
			iconBmp.filename = theFileName
			save iconBmp
			close iconBmp 
			close tempBmp
			) 
		img = dotNetClass "System.Drawing.Image" --create an image
		ilTv.images.add (img.fromFile theFileName) --add to the list
		)
		
	fn initTreeView tv =
		(
		tv.Indent = 28
-- 		iconDir = (getDir #ui) + "\\icons\\"
-- 		getIconFromBitmap (iconDir + "Standard_16i.bmp") 2 "Sphere" 
-- 		getIconFromBitmap (iconDir + "Standard_16i.bmp") 1 "Box"
-- 		getIconFromBitmap (iconDir + "Lights_16i.bmp") 3 "Light"
-- 		getIconFromBitmap (iconDir + "Cameras_16i.bmp") 2 "Camera"
-- 		getIconFromBitmap (iconDir + "Helpers_16i.bmp") 1 "Helper"
		)
		
	fn addChildren theNode theChildren =
		(
		for c in theChildren do
			(
			newNode = theNode.Nodes.add c --add to the parent!
			newNode.tag = dotNetMXSValue c --.tag can contain a MXS value
			)
		)
		
	fn getlinks = 
		(
		links = #()
		linkcount = FileLinkMgr.numLinks
		if linkcount > 0 do
			(
			for obj in objects do
				(
				if (getuserprop obj "linkpath") != undefined do appendifunique links (getuserprop obj "linkpath")
				)
			)
		return links
		)
	
	global getXRFscenes;
	fn getXRFscenes =
		(
		nodes = #()
		xrefcount = xrefs.getXRefFileCount()
		if xrefcount > 0 do
			(
			for i = 1 to xrefcount do
				(
				append nodes ((xrefs.getXRefFile i).filename)
				)
			)
		return nodes
		)
	
	fn getXRFobj = 
		(
		nodes = #()
		xref = #() 
		for obj in objects do 
			(
			if classof obj == XRefObject do (append xref obj)
			)
		if xref.count > 0 do
			(
			for obj in xref do
				(
				append nodes (obj.srcItemName)
				)
			)
		return nodes
		)
	
	fn getMerged = 
		(
		nodes = #()
		for obj in objects do 
			(
			if (getuserprop obj "mergepath") != undefined do (appendifunique nodes (getuserprop obj "mergepath"))
			)
		return nodes
		)
		
	fn getImported = 
		(
		nodes = #()
		for obj in objects do 
			(
			if (getuserprop obj "importpath") != undefined do (appendifunique nodes (getuserprop obj "importpath"))
			)
		return nodes
		)
	
	fn fillInTreeView tv =
		(
		rootNodes = #("File Links", "Xref Scenes", "Xref Objects", "Merged Files", "Imported Files")
		for i = 1 to rootNodes.count do (newNode = tv.Nodes.add rootNodes[i])
		getlinks()
		if (getXRFscenes()).count > 0 do try(addChildren tv.nodes.item[1] (getXRFscenes()))catch()
		if (getXRFobj()).count > 0 do try(addChildren tv.nodes.item[2] (getXRFobj()))catch()
		if (getMerged()).count > 0 do try(addChildren tv.nodes.item[3] (getMerged()))catch()
		if (getImported()).count > 0 do try(addChildren tv.nodes.item[4] (getImported()))catch()
		for i = 0 to 4 do (tv.nodes.item[i].ExpandAll())
		)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Main Rollout
---------------------------------------------------------------------------------------------------------------------------------------------

global IPDS_LinkMgr;
rollout IPDS_LinkMgr "IPDS Link Manager V1.0 Beta"
	(
	dotNetControl tv "TreeView" width:(IPDS_LinkMgr.width - 135 as integer) height:(IPDS_LinkMgr.height - 60 as integer) align:#left
	edittext et1 "File Path:" labelontop: true width:(IPDS_LinkMgr.width - 135 as integer)
	button bt1 "File Link" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),10]
	button bt2 "Xref Scene" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),40]
	button bt3 "Xref Object" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),70]
	button bt4 "Merge File" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),100]
	button bt5 "Import File" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),130]
	button bt6 "Update" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),180]
	button bt7 "Bind" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),210]
	button bt8 "Delete" align:#right width:100 Height:25 pos:[(IPDS_LinkMgr.width - 110),240]
	
	--- Interface Actions ---
		
	on tv Click arg do 
		(
		 --First get the TreeView node below the mouse cursor
		 --The arg argument has properties .x and .y with the current pos.
		 --Use showProperties arg to see what is available...
		--We use the TreeView method GetNodeAt to see what was clicked:
		hitNode = tv.GetNodeAt (dotNetObject "System.Drawing.Point" arg.x arg.y)
		if hitNode != undefined do
			(
			try(print hitNode.tag.value)catch()
-- 			try(select hitNode.tag.value)catch(max select none)
			)
		)
	
	on bt1 pressed do 
		(
		file = getOpenFileName caption:"Link AutoCAD File" types:"AutoCAD dwg(*.dwg)|*.dwg|AutoCAD dxf(*.dxf)|*.dxf"
		if file != undefined then FileLinkMgr.Attach file
		tv.nodes.clear()
		fillInTreeView tv
		)
		
	on bt2 pressed do 
		(
		file = getOpenFileName caption:"Link AutoCAD File" types:"3DSmax max(*.max)|*.max"
		if file != undefined then xrefs.addNewXRefFile file
		tv.nodes.clear()
		fillInTreeView tv
		)
		
	on bt3 pressed do 
		(
		file = getOpenFileName caption:"Link AutoCAD File" types:"3DSmax max(*.max)|*.max"
		if file != undefined then xrefs.addNewXRefObject file
		tv.nodes.clear()
		fillInTreeView tv
		)
		
	on bt4 pressed do 
		(
		premergeobjects = (objects as array)
		file = getOpenFileName caption:"Merge MAX File" types:"3DSmax max(*.max)|*.max"
		if file != undefined then mergeMAXFile file #prompt #select
		postmergeobjects = (objects as array)
		IPDStag_merge (array_difference postmergeobjects premergeobjects) file
		tv.nodes.clear()
		fillInTreeView tv
		)
		
	on bt5 pressed do 
		(
		premergeobjects = (objects as array)
		file = getOpenFileName caption:"Merge MAX File" types:"All(*.*)|*.*"
		if file != undefined then importFile file 
		postmergeobjects = (objects as array)
		IPDStag_import (array_difference postmergeobjects premergeobjects) file
		tv.nodes.clear()
		fillInTreeView tv
		)
		
	--- Dialog Actions --- 
	
	on IPDS_LinkMgr open do
		(
		initTreeView tv 
		fillInTreeView tv
		SetDialog IPDS_LinkMgr
		)
		
	on IPDS_LinkMgr moved position do
		(
		SetDialog IPDS_LinkMgr
		)
		
	on IPDS_LinkMgr resized size do
		(
		bt1.pos = [(IPDS_LinkMgr.width - 110),10]
		bt2.pos = [(IPDS_LinkMgr.width - 110),40]
		bt3.pos = [(IPDS_LinkMgr.width - 110),70]
		bt4.pos = [(IPDS_LinkMgr.width - 110),100]
		bt5.pos = [(IPDS_LinkMgr.width - 110),130]
		bt6.pos = [(IPDS_LinkMgr.width - 110),180]
		bt7.pos = [(IPDS_LinkMgr.width - 110),210]
		bt8.pos = [(IPDS_LinkMgr.width - 110),240]	
		et1.pos = [15,(IPDS_LinkMgr.height - 30)]
		et1.width = (IPDS_LinkMgr.width - 135 as integer)
		tv.size = dotNetObject "System.Drawing.Size" (IPDS_LinkMgr.width - 135 as integer) (IPDS_LinkMgr.height - 60 as integer)
		SetDialog IPDS_LinkMgr
		)
	
	on IPDS_LinkMgr close do
		(
		SetDialog IPDS_LinkMgr
		)
	)

---------------------------------------------------------------------------------------------------------------------------------------------
--- Create IPDS File Link Manager Dialog
---------------------------------------------------------------------------------------------------------------------------------------------
	(
	createDialog IPDS_LinkMgr 440 320 FLx FLy style:#(#style_titlebar,#style_sysmenu,#style_minimizebox,#style_maximizebox,#style_resizing)
	)
)	-- End Script