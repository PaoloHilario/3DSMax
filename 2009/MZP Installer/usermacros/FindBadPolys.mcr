macroScript FindBadPolys 
	category: "FindBadPolys" 
	tooltip: "FindBadPolys" 
	Icon:"FBP"
(
		
		rollout fbp "FBP v2.1" width:96 height:176
		(
			button find "Go find 'em" pos:[8,16] width:80 height:32
			radiobuttons sides "" pos:[24,60] width:51 height:48 labels:#("Tri", "Quad", "NGon")
			label lbBusy "" pos:[8,144] width:80 height:16
			progressBar bar "" pos:[8,120] width:80 height:16
			
			on find pressed do
			(
				case sides.state of
				(
					1:
					(
							--stores faces
							facelist = #() 	
							--tests if an object has been selected
							if $ == undefined or selection.count>1 then
							(
								format "select 1 object"
								messagebox "SELECT ONE OBJECT" title:"Hey!"
							)
								else
							(	
								
								converttopoly($)
								for i in 1 to $.getnumfaces() do
								(
									-- listener printout
									setwaitcursor()
									bar.value = 100.0*i/$.getnumfaces()
									format "Face#% - %\n" i (polyop.getfacedeg $ i)
									-- if the face has more than 4 verts or is undefined store it in the array
									if (polyop.getfacedeg $ i) == 3  do
										append facelist i
								)
							
							-- select the faces in the array
							undo on
							(
								polyop.setfaceselection $ facelist
								max modify mode	
								subobjectlevel = 4
								lbBusy.caption = "Tris: "
								lbBusy.caption += facelist.count as string
							)
							)
					)
					2:
					(
							--stores faces
							facelist = #() 	
							--tests if an object has been selected
							if $ == undefined or selection.count>1 then
							(
								format "select 1 object"
								messagebox "SELECT AN OBJECT FIRST" title:"Hey!"
							)
							else
							(	
								
								converttopoly($)
								for i in 1 to $.getnumfaces() do
								(
									-- listener printout
									setwaitcursor()
									bar.value = 100.0*i/$.getnumfaces()
									format "Face#% - %\n" i (polyop.getfacedeg $ i)
									-- if the face has more than 4 verts or is undefined store it in the array
									if(polyop.getfacedeg $ i) == 4  do
										append facelist i
								)
							-- select the faces in the array
							undo on
							(
								polyop.setfaceselection $ facelist	
								max modify mode
								subobjectlevel = 4
								lbBusy.caption = "Quads: "
								lbBusy.caption += facelist.count as string
							)
							)
					)
					3:
					(
							--stores faces
							facelist = #() 	
							--tests if an object has been selected
							if $ == undefined or selection.count>1 then
							(
								format "select 1 object"
								messagebox "SELECT AN OBJECT FIRST" title:"Hey!"
							)
							else
							(	
								
								converttopoly($)
								for i in 1 to $.getnumfaces() do
								(
									-- listener printout
									setwaitcursor()
									bar.value = 100.0*i/$.getnumfaces()
									format "Face#% - %\n" i (polyop.getfacedeg $ i)
									-- if the face has more than 4 verts or is undefined store it in the array
									if ((polyop.getfacedeg $ i) == undefined) or ((polyop.getfacedeg $ i) > 4)  do
										append facelist i
								)
							-- select the faces in the array
							undo on
							(
								polyop.setfaceselection $ facelist
								max modify mode	
								subobjectlevel = 4
								lbBusy.caption = "NGons: "
								lbBusy.caption += facelist.count as string
							)
							)
					)
				)
			)
		)createdialog fbp
)