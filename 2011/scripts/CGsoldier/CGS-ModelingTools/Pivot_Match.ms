-------------------------------------------------------------------------------
-- Pivot Match
-- By Paolo Hilario (paolo@cgsoldier.com)
-- v 1.1
-- Last Updated On: 04/21/08
-- tested using Max 2008
-------------------------------------------------------------------------------

(--Begin Script
	
---------------------------------------------------------------------------------------------------------------------------------------------
--- Local Variable Structure
---------------------------------------------------------------------------------------------------------------------------------------------

	local TP

---------------------------------------------------------------------------------------------------------------------------------------------
--- Rollout Definition
---------------------------------------------------------------------------------------------------------------------------------------------

	rollout Match_Pivot "Match_Pivot"
		(
		group "Source"
			(
			pickbutton Add	"Target" width:100 height:15 align:#center
			label targetmsg "Pick Target Object"
			)
		group "Destination"		
			(
			button Match "Match Pivots" width:100 height:15 align:#center 		
			label alertmsg12 "Select objects to match"
			label selmsg "pivots to target item "
			)
		group "About..."
			(
			button Directions "How to Use" width:100 height:15 align:#center
			label labelss01 "Match Pivot"
			label labelss02 "Version 1.1 - 04/21/08"
			label labelss03 "Paolo Hilario" align:#center
			label labelss05 "cgsoldier@gmail.com" align:#center
			)
	
		on Directions pressed do
			(
			messageBox "This script moves the pivot(s) of an object(s) to the pivot of the target object \n\n Target must be a singular object\n\n First select target object and moves its pivot to the desired location \n with that object still selected press the 'Target' button \n Then select an object or group of objects and press 'Match Pivot' button. \n Objects in groups need to be open." beep:false title:"How to use Match Pivot"
			)
			
		 on Add picked obj do
			(
			TP = obj.pivot
			targetmsg.text = obj.name
			deselect obj
			)
			
		on Match pressed do
			(
			selmesh = getcurrentselection()
			if selmesh.count == 0 do
				(
				messageBox "Nothing Selected." 
				)
			if selmesh.count > 0 do
				(
				for i = 1 to selmesh.count do 
					(
					selmesh[i].pivot = TP	
					)
				deselect $
				redrawviews()
				print "Done" 		
				)
			) 
		 
		 ) -- end util

	VG_Floater = newrolloutfloater "Match_Pivot" 190 300 850 200
 	addrollout Match_Pivot VG_Floater
 )
