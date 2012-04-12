(
Global 	TheLastUndoScale = #()
Global	TheLastUndoRotation = #()
Global	TheLastUndoObj = #()	
Global  TheLastUndopos =#()
Global  Varigator_Floater

rollout variegator_rollout "Variegator"
(
	group "Geometry - Scale and Rotate"
 		(
	 	radiobuttons PickAction labels:#("Scale", "Rotate", "Scale and Rotate") default:3 columns:1
	 	spinner Scale_Range "Scale Range %:" range:[0,400,10] type:#integer fieldwidth:40 enabled:true
 		spinner Rotate_Step "Rotation Step:" range:[0,180,90] type:#integer fieldwidth:30 enabled:true
		spinner Rotate_Range "Rotation Range:" range:[0,180,180] type:#integer fieldwidth:30 enabled:true
		Label lb1 "Affect Pivots"
		button MinzCenter "Center & Min Z" width:145 height:20 align:#center
		Label lb2 ""		
	 	checkbox Pivot_Adjust "About Object Center" checked:false align:#center
		button Plunger "Scale and Rotate!" width:145 height:20 align:#center 
		button PressTheUndo "Undo Last" width:145 height:20 align:#center
	 	)
  
on variegator_rollout close do
(
-- Save Floater Pos/size
	setINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterX"  (( Varigator_Floater.pos.x ) as String)
	setINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterY"  (( Varigator_Floater.pos.y ) as String)
	setINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterSX"  (( Varigator_Floater.size.x ) as String)
	setINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterSY"  (( Varigator_Floater.size.y ) as String)

)

on PickAction changed ActionState do
	(
	if ActionState == 1 then
		(
		Scale_Range.enabled = true
		Rotate_Step.enabled = false
		Rotate_Range.enabled = false
		Plunger.text = "Scale!"
		)
	if ActionState == 2 then
		(
		Scale_Range.enabled = false
		Rotate_Step.enabled = true
		Rotate_Range.enabled = true
		Plunger.text = "Rotate!"
		)
	if ActionState == 3 then
		(
		Scale_Range.enabled = true
		Rotate_Step.enabled = true
		Rotate_Range.enabled = true
		Plunger.text = "Scale and Rotate!"
		)
	)
		
on Rotate_Step changed Step_Val do 
	(
	if Step_Val > Rotate_Range.value then Rotate_Range.value = Step_Val
	) 
on Rotate_Range changed Range_Val do
 	(
	if Range_Val < Rotate_Step.value then Rotate_Step.value = Range_Val
	)
on MinzCenter pressed do
	(
	 SelSet = selection as array
	 for n = 1 to SelSet.count do
    	(
	    b=selset[n] 
    	try 
			(
			b.pivot=b.center
			b.pivot.z =b.min.z 
		    )	
		catch ()
		)
	)
on PressTheUndo pressed do
(
	print "Undo!"
	SelSet = selection as array  
	if TheLastUndoObj.count > 0 then
	(
	for i = 1 to TheLastUndoObj.count do 	
		( 	
		n=TheLastUndoObj[i]
		n.rotation=TheLastUndoRotation[i]
		n.scale=TheLastUndoscale[i]
		n.pos= TheLastUndopos[i]

		)
	)
	
)
on Plunger pressed do
	( 
	-- ********************************************************************************
 	-- Main Code 	-- Objects to be changed should be selected. 	
	-- ******************************************************************************** 	
	--Initialize variables 
	
	TheLastUndoObj = #()
	TheLastUndoScale = #()
	TheLastUndoRotation = #()
	TheLastUndopos =#()

		
	SelSet = selection as array  
	for n = 1 to SelSet.count do 	
	( 	
	if isgrouphead SelSet[n] or isopengroupmember SelSet[n] or not isgroupmember SelSet[n] then 	
		( 	
		TempPivot = SelSet[n].pivot 

		append TheLastUndoObj Selset[n]
		append TheLastUndoScale Selset[n].scale
		append TheLastUndoRotation Selset[n].rotation
 		append TheLastUndopos Selset[n].pos
		
		if Pivot_Adjust.checked then
			 SelSet[n].pivot = SelSet[n].center 	
	  	if Scale_Range.enabled then 		
			( 		
			RandScale = random (1 - (Scale_Range.value * 0.01)) (1 + (Scale_Range.value * 0.01)) 
			scale SelSet[n] [RandScale, RandScale, RandScale] 	
			) 		
		if Rotate_Range.enabled then 	
			( 			
			RandRotate = random 0 ((Rotate_Range.value/Rotate_Step.value) as integer) * Rotate_Step.value
			RandArrow = random 0 1
			if RandArrow == 0 then RandRotate = 360 - RandRotate
			rotate SelSet[n] RandRotate z_axis 	
			) 				
 			SelSet[n].pivot = TempPivot 
		) 	
	)   
	) -- end do Plunger
) --  END variegator_rollout ROLLOUT

rollout Mat_Rand_Rollout "Controls" width:180 height:180
(
	group "Setup"
	(
	spinner Numberofmats "# of Materials   " align:#center width:130 height:16 range:[2,24,4] type:#integer tooltip:"Number of materials"
	button CopyMats "Copy Material in Editor"  width:130 height:22 tooltip:"Copies Material in Slot one over mats in following slots"
	button EOutScale "Effect Output Amount"  width:130 height:22 tooltip:"Effects Output Amount in Diff Map"
 	spinner OutScaleB range:[0,3,.8 ] across:2 type:#float fieldwidth:40 enabled:true
 	spinner OutScaleT range:[0,3,1.2] type:#float fieldwidth:40 enabled:true
	button ERGBscale "Effect RGB Level"  width:130 height:22 tooltip:"Effects RGB Levels"
 	spinner RGBScaleB range:[0,3,.8 ] across:2 type:#float fieldwidth:40 enabled:true
 	spinner RGBScaleT range:[0,3,1.2] type:#float fieldwidth:40 enabled:true
	)
	button Apply "Apply Randomized Material" width:150 height:22 
On EOutScale pressed do
	(
	for i=1 to Numberofmats.value do
		(
		NV= random OutScaleB.value OutScaleT.value
		try
		(
		meditMaterials[i].diffuseMap.output.Output_Amount = NV
		) catch()	
		)	
	)

On ERGBScale pressed do
	(
	for i=1 to Numberofmats.value do
		(
		NV= random RGBScaleB.value RGBScaleT.value
		try
		(
		meditMaterials[i].diffuseMap.output.RGB_Level = NV
		) catch()	
		)	
	)


On CopyMats pressed do
	(
	TextMessage = "Copy Material Slot 1 over Slots 2-"+ ( Numberofmats.value as string )
	if ( queryBox TextMessage Title:"Copy Material Verification" ) then
		(
		  TM=getMeditMaterial 1
	  	  TMname=TM.name
		  format "%\n" Numberofmats.value
		  for i=1 to Numberofmats.value do
				(
			    TM.name=TMname+"-"+ ( i as string )
				setMeditMaterial i TM
				TM = copy TM		
				)
		)
	)
On Apply pressed do
	(
	for i = 1 to selection.count do
		(
		selection[i].material = meditMaterials[(random 1 Numberofmats.value)]
		)
	)
) --  END Mat_Rand_Rollout ROLLOUT

-- Load Floater Pos
	FLx= ((getINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterX") as integer)
	FLy= ((getINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterY") as integer)
	FSx= ((getINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterSX") as integer)
	FSy= ((getINISetting "$ui\Focus360_Scripts.ini" "Material_Randomizer" "FloaterSY") as integer)

	if  ( FSy == 0 ) then
	 	( 
		Varigator_Floater = newrolloutfloater "Variegator" 200 380 20 200
		addrollout variegator_rollout Varigator_Floater
		addrollout Mat_Rand_Rollout Varigator_Floater
		 )
	else
	 	(
		Varigator_Floater = newrolloutfloater "Variegator" FSx FSy FLx FLy
		addrollout variegator_rollout Varigator_Floater
		addrollout Mat_Rand_Rollout Varigator_Floater 
		)



)
