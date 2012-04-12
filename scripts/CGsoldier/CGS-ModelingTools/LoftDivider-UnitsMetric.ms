--  Script to determine the Length
--  repeat for Lofted Curbs and Sidewalks
--  based on current materials tileing.
(	
	set coordsys world

-- Size of Sidewalk map tiling in feet
	TileSide = 2.7432
-- Size of Curb map tiling in feet
	TileCurb = 2.7432

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
					( select SS[1] ; EndSelect=SS[2] )
				else 	
					( select SS[2] ; EndSelect=SS[1])
				)
			else
				( 
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
					Totdis=Totdis + ( distance fp sp )
					fp=sp
					)
				Totdis=Totdis*1.163
				TotWalk =  ( Totdis / Tileside )
				TotCurb = ( Totdis / Tilecurb )
				Totdis =  ( Totdis as integer )

				Format "Length: %  Walk: %  Curb:% \n" Totdis TotWalk TotCurb
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
