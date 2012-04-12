
--  Script to determine the Length
--  repeat for Lofted Curbs and Sidewalks
--  based on current materials tileing.
(	
fn AddUVWMappingto SS UVWname Mtype Mvar =
(
			U=uvwmap()
			U.mapChannel=Mtype.x
			U.maptype=Mtype.y
			U.axis=Mtype.z

			if Mvar.x != 0 then
				(
				U.length=Mvar.x
				U.width=Mvar.y
				U.height=Mvar.z
				)
			U.name = UVWname
			addModifier SS U
		
)
	loadMaterialLibrary "\\\\lucetiusdesign\ld-files\V-Drive\matlibs\LD-SITE.mat"
	set coordsys world

-- Size of Sidewalk map tiling in feet
	TileSide = 9
-- Size of Curb map tiling in feet
	TileCurb = 9

	SS = getCurrentSelection()

	if SS.count == 0 then
		(
		messageBox("Nothing Selected")
		)
	else
		(
		if (SS.count == 1) or (SS.count == 2) then
			(
			if (SS.count == 2 ) then
				(
				if ( canConvertTo SS[1] SplineShape ) then
					(
					SS[1].name = uniquename "Z-PATH_CURB"
					SS[2].name = uniquename "SITE_BASE:CURB"  
					select SS[1] ; EndSelect=SS[2]
					)
				else 	
					(
					SS[2].name = uniquename "Z-PATH_CURB"
					SS[1].name = uniquename "SITE_BASE:CURB"   
					select SS[2] ; EndSelect=SS[1]
					)
				)
			else
				(
				SS[1].name = uniquename "SITE_BASE:CURB" 
				EndSelect=SS[1]
				)
			if canConvertTo $ SplineShape then
				(
				Totdis = 0
				Tk= numKnots $ 1
				fp= getKnotPoint $ 1 1
				print TK
				for i=2 to TK do
					(
					sp = getKnotPoint $ 1 i
					Totdis=Totdis + ( distance fp sp )h
					print i
					fp=sp
					)
				Totdis=Totdis/12
				TotWalk =  ( Totdis / Tileside )
				TotCurb = ( Totdis / Tilecurb )
				Totdis =  ( Totdis as integer )

				Format "Length: %  Walk: %  Curb:% \n" Totdis TotWalk TotCurb
				if ( isclosed $ 1 ) then
					(
					NewGrass =  reference $ 
					EM= Edit_Mesh()
					addModifier NewGrass EM
					NewGrass.wirecolor=[0,83,0]
					NewGrass.name= uniquename "SITE_BASE:GRASS"
					move NewGrass [0,0,6]
						try 
						(
						if scenematerials["VR-GRASS"] == undefined then
							(
							NewGrass.material = CurrentMaterialLibrary["VR-GRASS"]
							)
						else
							(
							NewGrass.material = scenematerials["VR-GRASS"]	
							)
						) 
						catch()
--				  	AddUVWMappingto NewGrass "(1) diff" [1,4,1] [7800,7800,7800]
--					AddUVWMappingto NewGrass "(2) bump" [2,4,1] [180,180,180]
					)
				)
			else
				(
				print "Invalid Object"
				deselect $
				)
			select EndSelect
			max modify mode
			)
		else
			(
			messageBox("More than two items Selected")
			)
		)
	
)