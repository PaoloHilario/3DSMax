macroScript VRayProxyAnimationControl category:"Leandro Salerno" buttontext:"V-Ray Proxy Animation Control" (



rollout a "-  VRayProxy Animation Control -" width:601 height:353
(
	edittext edt_changepath "" pos:[382,332] width:177 height:14
	spinner spn_framesMin "" pos:[110,31] width:70 height:16 range:[-3000,3000,0]
	spinner spn_framesMax "" pos:[110,53] width:70 height:16 range:[-3000,3000,0]
	spinner spn_speedMax "" pos:[284,53] width:70 height:16 range:[-1000,1000,1]
	spinner spn_speedMin "" pos:[284,31] width:70 height:16 range:[-1000,1000,1]
	spinner spn_scaleMax "" pos:[461,53] width:70 height:16 range:[-1000,1000,1]
	spinner spn_scaleMin "" pos:[461,31] width:70 height:16 range:[-1000,1000,1]
	button btn_changepath "Browse" pos:[492,312] width:67 height:18
	button btn21 "Change display" pos:[25,271] width:145 height:18
	button btn_rnd_offset "Random offset frames" pos:[25,101] width:145 height:18
	button btn_select_unhide "Select all unhide VRayProxys" pos:[396,203] width:150 height:18
	button btn_select_hide "Select all hide VRayProxys" pos:[396,236] width:150 height:18
	button btn_select_all "Select all VRayProxys" pos:[396,271] width:150 height:18
	button btn_reset_offset "Reset offset frames" pos:[25,125] width:145 height:18
	button btn_reset_scale "Reset Scale" pos:[401,125] width:145 height:18
	button btn_random_speed "Random Speed" pos:[214,101] width:145 height:18
	button btn_ramdom_scale "Random Scale" pos:[401,101] width:145 height:18
	button btn_reset_speed "Reset Speed" pos:[214,125] width:145 height:18
	button btn_cambia_animacion "Change playback" pos:[214,271] width:145 height:18
	label lbl1 "VrayProxys: " pos:[25,73] width:77 height:16
	label lbl_offset "" pos:[92,73] width:77 height:15
	label lbl168 "VrayProxys selected: " pos:[396,178] width:110 height:16
	label lbl169 "" pos:[504,178] width:77 height:15
	label lbl203 "VrayProxys: " pos:[213,244] width:77 height:16
	label lbl204 "" pos:[281,244] width:77 height:15
	label lbl309 "Scale MIN:" pos:[402,32] width:59 height:15
	label lbl310 "Scale MAX:" pos:[398,53] width:63 height:15
	label lbl_speed "" pos:[279,73] width:77 height:15
	label lbl313 "VrayProxys: " pos:[400,73] width:57 height:16
	label lbl_scale "" pos:[471,71] width:77 height:15
	label lbl311 "VrayProxys: " pos:[214,73] width:77 height:16
	label lbl103 "VrayProxys: " pos:[21,244] width:77 height:16
	label lbl104 "" pos:[88,244] width:77 height:15 
	label lbl5 "Mesh file:" pos:[388,314] width:77 height:16
	label lbl4 "Offset frames MIN:" pos:[20,32] width:90 height:15 
	label lbl8 "Offset frames MAX:" pos:[16,53] width:94 height:15
	label lbl6 "Speed MIN:" pos:[225,32] width:59 height:15
	label lbl7 "Speed MAX:" pos:[221,53] width:63 height:15
	label lbl_avisos "" pos:[17,328] width:316 height:21 
	radiobuttons rdo_playback "" pos:[248,174] width:72 height:64 labels:#("Loop", "Play once", "Ping Pong", "Still") default:2 columns:1
	radiobuttons rdo1 "" pos:[43,174] width:99 height:48 labels:#("bounding box", "preview form file", "point") default:2 columns:1
	progressBar pb_offset "ProgressBar" pos:[26,90] width:143 height:8 
	progressBar pb15 "ProgressBar" pos:[25,260] width:143 height:8 
	progressBar pb38 "ProgressBar" pos:[214,260] width:143 height:8 
	progressBar pb_speed "ProgressBar" pos:[215,90] width:143 height:8 
	progressBar pb_scale "ProgressBar" pos:[401,90] width:143 height:8 
	GroupBox grp1 "Animation on selected proxys" pos:[10,6] width:550 height:147
	GroupBox grp15 "Display" pos:[10,156] width:177 height:145
	GroupBox grp78 "Playback" pos:[196,156] width:177 height:145
	GroupBox grp88 "Selection" pos:[382,156] width:177 height:145
	checkbutton ckb_link_frames "L" pos:[184,32] width:14 height:36
	checkbutton ckb_link_speed "L" pos:[358,32] width:14 height:36
	checkbutton ckb_link_scale "L" pos:[535,32] width:14 height:36
	

		
		
		
			
	on a open do
	(
		edt_changepath.text = maxfilepath --getdir #proxies  
		)
	on edt_changepath entered text do
	(
	for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					x.filename = edt_changepath.text
					
					
				)
				
			)
	
	)
	on spn_framesMin changed val do
	(
		if ckb_link_frames.state ==true then 
				spn_framesMax.value=spn_framesMin.value
			
		)

	on spn_framesMax changed val do
	(
		if ckb_link_frames.state ==true then 
				spn_framesMin.value=spn_framesMax.value
			
		)
	on spn_speedMax changed val do
	(
		if ckb_link_speed.state ==true then 
				spn_speedMin.value=spn_speedMax.value
			
		)
	on spn_speedMin changed val do
	(
		if ckb_link_speed.state ==true then 
				spn_speedMax.value=spn_speedMin.value
			
		)
	on spn_scaleMax changed val do
	(
			if ckb_link_scale.state ==true then 
				spn_scaleMin.value=spn_scaleMax.value
			
		)
	on spn_scaleMin changed val do
	(
		if ckb_link_scale.state ==true then 
			spn_scaleMax.value=spn_scaleMin.value
			
	)
	
	

	
	on btn_changepath pressed do
	(
		try (
		nuevoProxy = getOpenFileName caption:"Choose external proxy mesh file" \
		types:"VRay mesh (*.vrmesh)|*.vrmesh|All files|*.*|"
		lbl_avisos.caption="No VRayProxys selected"
		
	for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					x.filename = nuevoProxy
					edt_changepath.text = nuevoProxy
					
				)
				
			)
			
		)
	catch (
		lbl_avisos.caption="No VRayProxys selected"
		) 
		)
	on btn21 pressed do
	(
	
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
			 
		if selection.count==0 then (
			lbl_avisos.caption="No VRayProxys selected"
		)
		
		else(
			lbl_avisos.caption=""
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl104.caption = proxynumselect as string
					progreso += 1
					pb15.value = 100. * progreso/seleccion 
					
					case rdo1.state of
					(
						
						1: x.display = 0 
						2: x.display = 1 
						3: x.display = 2 
						
					)
					
					
					)
				
				)
			)
				
	)
	on btn_rnd_offset pressed do
	(
			framesmin = spn_framesMin.value
			framesmax = spn_framesMax.value
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
			 
		if selection.count==0 then (
			lbl_avisos.caption="No VRayProxys selected"
		)
		
		else(
		lbl_avisos.caption=""
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl_offset.caption = proxynumselect as string
					progreso += 1
					pb_offset.value = 100. * progreso/seleccion 
					
					x.anim_offset = random framesmin framesmax
					
					
					)
				
				)
			)
	)
	on btn_select_unhide pressed do
	(
			deselect selection
			selectallproxys = for obj in objects where (classof obj == VrayProxy) and (obj.ishidden == false) collect obj
			select selectallproxys
			lbl169.caption= selectallproxys.count as string
		)
	on btn_select_hide pressed do
	(
			deselect selection
			selectallproxys = for obj in objects where (classof obj == VrayProxy) and (obj.ishidden == true) collect obj
			select selectallproxys
			lbl169.caption= selectallproxys.count as string
		)
	on btn_select_all pressed do
	(
			deselect selection
			selectallproxys = for obj in objects where (classof obj == VrayProxy) collect obj
			select selectallproxys
			lbl169.caption= selectallproxys.count as string
		)
	on btn_reset_offset pressed do
	(
			spn_framesMin.value = 0
			spn_framesMax.value = 0
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
			 
		
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl_offset.caption = proxynumselect as string
					progreso += 1
					pb_offset.value = 100. * progreso/seleccion 
					
					x.anim_offset = 0
					
					
					)
				
				)
				
	)
	on btn_reset_scale pressed do
	(
	
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
			spn_scaleMin.value = 1
			spn_scaleMax.value = 1 
		
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl_scale.caption = proxynumselect as string
					progreso += 1
					pb_scale.value = 100. * progreso/seleccion 
					
					x.scale = [1,1,1]
					
					
					)
				
				)
				
	)
	on btn_random_speed pressed do
	(
			speedmin = spn_speedMin.value
			speedmax = spn_speedMax.value
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
			 
				if selection.count==0 then (
			lbl_avisos.caption="No VRayProxys selected"
		)
		
		else(
			lbl_avisos.caption=""
		
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl_speed.caption = proxynumselect as string
					progreso += 1
					pb_speed.value = 100. * progreso/seleccion 
					
					x.anim_speed = random speedmin speedmax
					
					
					)
				
				)
			)
				
	)
	on btn_ramdom_scale pressed do
	(
			scalemin = spn_scaleMin.value
			scalemax = spn_scaleMax.value
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
			 
		if selection.count==0 then (
			lbl_avisos.caption="No VRayProxys selected"
		)
		
		else(
			lbl_avisos.caption=""
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl_scale.caption = proxynumselect as string
					progreso += 1
					pb_scale.value = 100. * progreso/seleccion 
					
					scala_rnd= random scalemin scalemax
					
					x.scale = [scala_rnd,scala_rnd,scala_rnd]
					
					)
				
				)
			)
	)
	on btn_reset_speed pressed do
	(
	
			spn_speedMin.value = 1
			spn_speedMax.value = 1
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
			 
		
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl_speed.caption = proxynumselect as string
					progreso += 1
					pb_speed.value = 100. * progreso/seleccion 
					
					x.anim_speed = 1
					
					
					)
				
				)
				
	)
	on btn_cambia_animacion pressed do
	(
	
			proxynumselect = 0
			seleccion = selection.count
			progreso = 0
		
		
			 if selection.count==0 then (
			lbl_avisos.caption="No VRayProxys selected"
		)
		
		else(
			lbl_avisos.caption=""
		
		for x in selection do
			(
				
				if classof x == VrayProxy then
				(
					
					proxynumselect += 1
					lbl204.caption = proxynumselect as string
					progreso += 1
					pb38.value = 100. * progreso/seleccion 
					
					case rdo_playback.state of
					(
						
						1: x.anim_type = 0 
						2: x.anim_type = 1 
						3: x.anim_type = 2 
						4: x.anim_type = 3
						
					)
					
					
					)
				
				)
					)
				
	)
	on ckb_link_frames changed state do
	(
		if ckb_link_frames.state ==true then
		(
			spn_framesMax.value = spn_framesMin.value
			btn_rnd_offset.caption = "Change frames"
		)
			else
		(
		btn_rnd_offset.caption = "Random offset frames"
		)
		
		)
	on ckb_link_speed changed state do
	(
		if ckb_link_speed.state ==true then (
			
		spn_speedMax.value = spn_speedMin.value	
		btn_random_speed.caption="Change Speed"
		)
		else (
			btn_random_speed.caption="Random Speed"
		)
			)
	on ckb_link_scale changed state do
	(
		if ckb_link_scale.state ==true then (
			spn_scaleMax.value = spn_ScaleMin.value	
			btn_ramdom_scale.caption ="Change scale"
		)
		else(
		btn_ramdom_scale.caption ="Random scale"
			
			)
			)
)
	

rollout acerca "- About -" width:580 height:120
(
	label lbl3 "Buenos Aires, Argentina (2008)" pos:[219,97] width:153 height:16
	label lbl4 " it works since V-Ray 1.50.SP2" pos:[216,29] width:164 height:16
	--label lbl5 "http://" pos:[5,35] width:110 height:20
	label lbl6 "leandrojsalerno@gmail.com" pos:[226,82] width:133 height:16
	label lbl36 "V-Ray Proxy Animation Control v1.0" pos:[209,12] width:173 height:15 
	label lbl53 "Leandro Salerno" pos:[250,55] width:89 height:16
)


dialogo = newRolloutFloater "V-Ray Proxy Animation Control v1.0" 580 410

addRollout a dialogo
--addRollout ayuda dialogo
addRollout acerca dialogo

acerca.open = 0
--ayuda.open = 0

)
