-- Selection Drop script by Keith Morrison 6-29-01
-- Please report any bugs 


 (
	rollout Sel_Drop "Selection Drop"
         (
  		button dropit "Drop" width:100 height:15 align:#center
 		spinner Prcent "Percent:" type:#float range:[0,100,50] scale:1
 	    group "About..."
     	(
 		button Directions "How to Use" width:100 height:15 align:#center
		label labelss01 "Selection Drop"
 		label labelss02 "Version 1.0 - 06/27/01"
 		label labelss03 "by Keith Morrison"
		label labelss05 " Focus 360"
		)
on Directions pressed do
(
messageBox  "This script randomly removes a percentage of objects from the current selection set \nSpinner controls the percent of the selection to be dropped\n\nSelect all objects to be considered in the set and press 'Drop' \n" beep:false title:"How to use selection drop" 
)
on dropit pressed do
(
try
(
disablesceneredraw()
selmesh = getCurrentSelection()

if selmesh.count == 0 do
		(
		messageBox "Nothing Selected."
		)
if selmesh.count > 1 do
		(
		tobjects= selmesh.count
		dr = ( tobjects * (Prcent.value/100))
		while dr > 0 do
			(
			Deln=random 1 (selmesh.count)
			deleteItem selmesh Deln 
			dr=dr-1
			)
		)
select selmesh
enablesceneredraw()
)
catch
(
enablesceneredraw()
)
)
)

	VG_Floater = newrolloutfloater "Selection Drop" 190 210 20 200
 	addrollout Sel_Drop VG_Floater
 ) 