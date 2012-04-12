/*
Client:PEN Productions Inc.

Created By: Paul Neale
Company: PEN Productions Inc.
E-Mail: pen_productions@yahoo.com
Start Date: Feb 18 2004

Purpose:

Max version 6x

Usage:
penCNT.eyeControls()
penCNT.characterNode()
penCNT.circleArrowsCurved()

penCNT.RankinObj()


Updated:

Bugs:

ToDo:

*/

struct penCNT
(
	fn coin coinName:undefined=
	(
		global nameStr=coinName
		try(destroyDialog chooseNameR)catch()
		rollout chooseNameR "Choose Name" width:300
		(
			local btW=100
			editText nameEt "Name:"
			button okBt "OK" width:btW across:2
			button cancelBt "Cancel" width:btW
			
			fn makeCoin=
			(
				tool makeCoinT numPoints:2
				(
					local wP1,wP2,c1,t1,minT,maxT
					local vPs=#(
						#view_persp_user,
						#view_iso_user,
						#view_camera,
						#view_spot
					)
					
					on mousepoint clickNum do
					(
						case clickNum of
						(
							1:
							(
								max Create Mode
								disableSceneRedraw()
								wP1=worldPoint
								c1=circle radius:10 pos:wP1
								t1=text()
								t1.text=nameStr
								t1.size=c1.radius/((t1.max.x-t1.min.x)*.006)
								t1.pos=[wP1.x,wP1.y-(t1.max.y-t1.min.y)/2,wP1.z]
								converttosplineshape c1
								converttosplineshape t1
								addAndWeld c1 t1 0
								isVP=findItem vPs (viewport.getType())
								if isVp == 0 do (c1.rotation=(viewport.getTM()).rotation)
								c1.pos=wP1
								addModifier c1 (xform())
								c1.thickness=.2 
								c1.sides=3 
								c1.steps=3 
								c1.displayRenderMesh=false 
								c1.name=(nameStr)
								c1.wireColor = [255,234,0] 
								select c1
								enableSceneRedraw()
								redrawViews()
							)
							2:
							(
								converttosplineshape c1
								nameStr=undefined
								
							)
						)
					)
					on mouseMove moveIt do
					(
						wP2=worldPoint
						c1.xform.gizmo.scale=[(distance wP1 wP2),(distance wP1 wP2),0]*.1
					)
					on mouseAbort del do
					(
						delete c1
						nameStr=undefined
					)
					on stop do
					(
						print "Done"
					)
				)
				startTool makeCoinT
			)
			
			fn doIt=
			(
				destroyDialog chooseNameR
--				nameStr=coinName
				makeCoin()
			)
			
			on nameEt entered text do
			(
				nameStr=nameEt.text
				doIt()
			)
			on okBt pressed do
			(
				nameStr=nameEt.text
				doIt()
			)
			on cancelBt pressed do
			(
				destroyDialog chooseNameR
				nameStr=undefined
			)
			on chooseNameR open do
			(
				setFocus nameEt
			)
		)
		if coinName==undefined then 
		(
			createDialog chooseNameR
		)else
		(
			chooseNameR.nameEt.text=coinName
			chooseNameR.makeCoin()
		)
	),--END coin
	
	fn sphere=
	(
		max Create Mode 
		tool mCnt numPoints:2 
		( 
			local wp1, wp2, shp 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [4.99669,-1.71572e-006,3.43144e-006] [4.99669,-2.75711,3.43144e-006] [4.99669,2.7571,3.43144e-006]
						addKnot shp spln  #bezierCorner #curve [-1.93413e-006,4.99669,3.43144e-006] [2.7571,4.99669,3.43144e-006] [-2.75711,4.99669,3.43144e-006]
						addKnot shp spln  #bezierCorner #curve [-4.99669,-2.15254e-006,3.43144e-006] [-4.9967,2.7571,3.43144e-006] [-4.99669,-2.75711,3.43144e-006]
						addKnot shp spln  #bezierCorner #curve [-1.06048e-006,-4.99669,3.43144e-006] [-2.75711,-4.9967,3.43144e-006] [2.7571,-4.99669,3.43144e-006]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-1.93413e-006,-1.71572e-006,-4.99669] [-1.93413e-006,-2.75711,-4.99669] [-1.93413e-006,2.7571,-4.99669]
						addKnot shp spln  #bezierCorner #curve [-1.71572e-006,4.99669,3.64985e-006] [-1.83624e-006,4.99669,-2.7571] [-1.5952e-006,4.99669,2.75711]
						addKnot shp spln  #bezierCorner #curve [-1.49731e-006,-2.15254e-006,4.9967] [-1.49731e-006,2.7571,4.9967] [-1.49731e-006,-2.75711,4.9967]
						addKnot shp spln  #bezierCorner #curve [-1.71572e-006,-4.99669,2.7762e-006] [-1.5952e-006,-4.9967,2.75711] [-1.83624e-006,-4.99669,-2.7571]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [4.99669,-1.71572e-006,3.43144e-006] [4.99669,-1.5952e-006,-2.7571] [4.99669,-1.83624e-006,2.75711]
						addKnot shp spln  #bezierCorner #curve [-1.93413e-006,-1.93413e-006,4.9967] [2.7571,-1.93413e-006,4.9967] [-2.75711,-1.93413e-006,4.9967]
						addKnot shp spln  #bezierCorner #curve [-4.99669,-1.71572e-006,2.99461e-006] [-4.9967,-1.83624e-006,2.75711] [-4.99669,-1.5952e-006,-2.7571]
						addKnot shp spln  #bezierCorner #curve [-1.06048e-006,-1.49731e-006,-4.99669] [-2.75711,-1.49731e-006,-4.99669] [2.7571,-1.49731e-006,-4.99669]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false
						shp.pos = wp1 
						shp.name=(uniqueName "Sphere_CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
						#stop
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2)*.2,(distance wp1 wp2)*.2,(distance wp1 wp2)*.2] 
				shp.modifiers[#xform].gizmo.scale = scl 
				
				gw.text [0,0,0] (((distance wp1 wp2)*2) as string)
				gw.enlargeUpdateRect #whole
				gw.updateScreen()
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
			on stop do
			(
				print "Done"
			)
		) 
		startTool mCnt
		
	),--END sphere
	
	fn pin=
	(
		tool mCnt numPoints:2
		(
			local wp1, wp2, shp, shp2
			
			on mousePoint clickNum do
			(
				case clickNum of
				(
					1:
					(
						wp1 = worldPoint
						shp = splineShape()
						shp2 = splineShape()
						select shp
						selectmore shp2
						spln = addNewSpline shp
						
						addKnot shp spln #bezierCorner #curve [11.8312,0,0] [11.8312,-6.52827,0] [11.8312,6.52827,0]
						addKnot shp spln #bezierCorner #curve [-5.17156e-007,11.8312,0] [6.52827,11.8312,0] [-6.52827,11.8312,0]
						addKnot shp spln #bezierCorner #curve [-11.8312,-1.03431e-006,0] [-11.8312,6.52827,0] [-11.8312,-6.52827,0]
						addKnot shp spln #bezierCorner #curve [1.55147e-006,-11.8312,0] [-6.52827,-11.8312,0] [6.52827,-11.8312,0]
						close shp spln
						
						spln = addNewSpline shp
						addKnot shp spln #bezierCorner #curve [-5.17156e-007,0,-11.8312] [-5.17156e-007,-6.52827,-11.8312] [-5.17156e-007,6.52827,-11.8312]
						addKnot shp spln #bezierCorner #curve [0,11.8312,5.17156e-007] [-2.8536e-007,11.8312,-6.52827] [2.8536e-007,11.8312,6.52827]
						addKnot shp spln #bezierCorner #curve [5.17156e-007,-1.03431e-006,11.8312] [5.17156e-007,6.52827,11.8312] [5.17156e-007,-6.52827,11.8312]
						addKnot shp spln #bezierCorner #curve [0,-11.8312,-1.55147e-006] [2.8536e-007,-11.8312,6.52827] [-2.8536e-007,-11.8312,-6.52827]
						close shp spln
						
						spln = addNewSpline shp
						addKnot shp spln #bezierCorner #curve [11.8312,0,0] [11.8312,2.8536e-007,-6.52827] [11.8312,-2.8536e-007,6.52827]
						addKnot shp spln #bezierCorner #curve [-5.17156e-007,-5.17156e-007,11.8312] [6.52827,-5.17156e-007,11.8312] [-6.52827,-5.17156e-007,11.8312]
						addKnot shp spln #bezierCorner #curve [-11.8312,0,-1.03431e-006] [-11.8312,-2.8536e-007,6.52827] [-11.8312,2.8536e-007,-6.52827]
						addKnot shp spln #bezierCorner #curve [1.55147e-006,5.17156e-007,-11.8312] [-6.52827,5.17156e-007,-11.8312] [6.52827,5.17156e-007,-11.8312]
						close shp spln
						
						spln = addNewSpline shp2
						addKnot shp2 spln #Corner #curve [0,0,0] [0,0,0] [0,0,0]
						addKnot shp2 spln #Corner #curve [0,-100,0] [0,0,0] [0,0,0]
						--close shp2 spln
						
						shp.pos = wp1
						shp2.pos = wp1
						shp.wireColor = [255,234,0]
						shp2.wireColor = [255,234,0]
						shp2.name = uniqueName "Pin_CNT"
						addModifier shp (xform())
					)
					2:
					(
						converttosplineshape shp
						updateShape shp
						updateShape shp2
						addAndWeld shp2 shp 0
						shp2.thickness=.2 
						shp2.sides=3 
						shp2.steps=3 
						shp2.displayRenderMesh=false
	
					)
				)
			)
			on mouseMove moveIt do
			(
				wp2 = worldPoint
				shp.pos = wp2
				setKnotPoint shp2 1 2 wp2
				updateShape shp2
				scl = [(distance wp1 wp2)/100,(distance wp1 wp2)/100,(distance wp1 wp2)/100]
				shp.modifiers[#xform].gizmo.scale = scl
			)
			on mouseAbort del do
			(
				delete shp
				delete shp2 
			)
			on stop do
			(
				print "Done"
			)
		)
		startTool mCnt	
	),--END pin
	
	fn dArrow= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			local vPs=#(#view_persp_user,#view_iso_user,#view_camera,#view_spot) 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.252712,0.400926,0] [-0.252712,0.133643,0] [-0.302094,0.400926,0]
						addKnot shp spln  #bezierCorner #curve [-0.400859,0.400926,0] [-0.351476,0.400926,0] [-0.267239,0.600326,0]
						addKnot shp spln  #bezierCorner #curve [0,0.999119,0] [-0.13362,0.799722,0] [0.13362,0.799722,0]
						addKnot shp spln  #bezierCorner #curve [0.400859,0.400926,0] [0.267239,0.600326,0] [0.351476,0.400926,0]
						addKnot shp spln  #bezierCorner #curve [0.252712,0.400926,0] [0.302094,0.400926,0] [0.252712,0.133643,0]
						addKnot shp spln  #bezierCorner #curve [0.252712,-0.400926,0] [0.252712,-0.133643,0] [0.302094,-0.400926,0]
						addKnot shp spln  #bezierCorner #curve [0.400859,-0.400926,0] [0.351476,-0.400926,0] [0.267239,-0.600326,0]
						addKnot shp spln  #bezierCorner #curve [0,-0.999119,0] [0.13362,-0.799722,0] [-0.13362,-0.799722,0]
						addKnot shp spln  #bezierCorner #curve [-0.400859,-0.400926,0] [-0.267239,-0.600326,0] [-0.351476,-0.400926,0]
						addKnot shp spln  #bezierCorner #curve [-0.252712,-0.400926,0] [-0.302094,-0.400926,0] [-0.252712,-0.133643,0]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shp.rotation=(viewport.getTM()).rotation) 
						shp.pos = wp1 
						shp.name=(uniqueName "CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	),
		
	fn splineHand= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.472205,-0.642328,-4.40896e-007] [0.635991,-0.530029,-3.22872e-007] [0.472205,-0.642328,-4.40896e-007]
						addKnot shp spln  #bezierCorner #curve [0.472205,-1.05058,-8.93943e-007] [0.472205,-1.05058,-8.93943e-007] [0.230985,-1.14761,-9.93645e-007]
						addKnot shp spln  #bezier #curve [-0.21446,-1.19612,-1.0282e-006] [0.00209733,-1.19612,-1.03981e-006] [-0.438585,-1.19612,-1.02142e-006]
						addKnot shp spln  #bezierCorner #curve [-0.86403,-1.05058,-8.39831e-007] [-0.655108,-1.1476,-9.59589e-007] [-0.86403,-1.05058,-8.39831e-007]
						addKnot shp spln  #corner #curve [-0.86403,-0.736586,-4.90992e-007] [-0.86403,-0.893581,-6.65411e-007] [-0.984944,-0.593831,-3.26918e-007]
						addKnot shp spln  #bezierCorner #curve [-1.10586,-0.451075,-1.62845e-007] [-1.10586,-0.451075,-1.62845e-007] [-1.25194,-0.180801,1.43391e-007]
						addKnot shp spln  #bezierCorner #curve [-1.41144,0.593771,1.01305e-006] [-1.3538,0.167481,5.34685e-007] [-1.41144,0.593771,1.01305e-006]
						addKnot shp spln  #corner #curve [-1.38012,0.936343,1.39365e-006] [-1.39578,0.765057,1.20335e-006] [-1.65397,1.41123,1.93434e-006]
						addKnot shp spln  #bezierCorner #curve [-1.92783,1.88612,2.47502e-006] [-1.92783,1.88612,2.47502e-006] [-2.00999,2.02916,2.63474e-006]
						addKnot shp spln  #bezier #curve [-2.05107,2.2294,2.86212e-006] [-2.05107,2.14359,2.76572e-006] [-2.05107,2.30575,2.94332e-006]
						addKnot shp spln  #bezier #curve [-1.97526,2.42258,3.07148e-006] [-2.0258,2.37015,3.01414e-006] [-1.92472,2.47501,3.12723e-006]
						addKnot shp spln  #bezier #curve [-1.7907,2.50123,3.15139e-006] [-1.8632,2.50123,3.15528e-006] [-1.68387,2.50123,3.14734e-006]
						addKnot shp spln  #bezierCorner #curve [-1.47022,2.23792,2.84432e-006] [-1.57705,2.41346,3.04419e-006] [-1.47022,2.23792,2.84432e-006]
						addKnot shp spln  #corner #curve [-0.975214,1.42203,1.91706e-006] [-1.22272,1.82997,2.38069e-006] [-1.12785,2.00597,2.57264e-006]
						addKnot shp spln  #bezierCorner #curve [-1.28049,2.58991,3.22822e-006] [-1.28049,2.58991,3.22822e-006] [-1.31853,2.73498,3.39295e-006]
						addKnot shp spln  #bezier #curve [-1.33755,2.89053,3.56868e-006] [-1.33755,2.83519,3.50381e-006] [-1.33755,2.99742,3.68762e-006]
						addKnot shp spln  #bezier #curve [-1.26772,3.12957,3.82939e-006] [-1.31427,3.0771,3.77767e-006] [-1.22116,3.18203,3.88805e-006]
						addKnot shp spln  #bezier #curve [-1.05812,3.20827,3.91036e-006] [-1.1513,3.20827,3.91516e-006] [-0.898457,3.20827,3.9037e-006]
						addKnot shp spln  #bezierCorner #curve [-0.713218,2.84208,3.48795e-006] [-0.783489,3.0862,3.75979e-006] [-0.713218,2.84208,3.48795e-006]
						addKnot shp spln  #corner #curve [-0.37105,1.64328,2.13866e-006] [-0.542134,2.24268,2.81331e-006] [-0.371051,2.32614,2.89969e-006]
						addKnot shp spln  #bezierCorner #curve [-0.371051,3.00901,3.66071e-006] [-0.371051,3.00901,3.66071e-006] [-0.371051,3.15759,3.82571e-006]
						addKnot shp spln  #bezier #curve [-0.291235,3.34332,4.02944e-006] [-0.344445,3.26903,3.94919e-006] [-0.238025,3.41761,4.10961e-006]
						addKnot shp spln  #bezier #curve [-0.0517894,3.45476,4.14506e-006] [-0.15821,3.45476,4.14778e-006] [0.15916,3.45476,4.13521e-006]
						addKnot shp spln  #bezierCorner #curve [0.264634,2.95184,3.57104e-006] [0.264634,3.28712,3.94355e-006] [0.264634,2.95184,3.57104e-006]
						addKnot shp spln  #corner #curve [0.231188,1.58581,2.05052e-006] [0.247911,2.26883,2.81078e-006] [0.409873,2.11731,2.63487e-006]
						addKnot shp spln  #bezierCorner #curve [0.588558,2.6488,3.21923e-006] [0.588558,2.6488,3.21923e-006] [0.693424,2.96124,3.56379e-006]
						addKnot shp spln  #bezier #curve [0.97461,3.11746,3.72658e-006] [0.822108,3.11746,3.73283e-006] [1.06225,3.11746,3.72313e-006]
						addKnot shp spln  #bezier #curve [1.17184,3.05168,3.64585e-006] [1.12799,3.09553,3.69612e-006] [1.21569,3.00783,3.59443e-006]
						addKnot shp spln  #bezier #curve [1.23762,2.85161,3.41953e-006] [1.23762,2.94114,3.51868e-006] [1.23762,2.76012,3.31756e-006]
						addKnot shp spln  #bezierCorner #curve [1.19161,2.52849,3.06044e-006] [1.22228,2.65241,3.19801e-006] [1.19161,2.52849,3.06044e-006]
						addKnot shp spln  #bezierCorner #curve [0.834946,1.1505,1.54108e-006] [0.834946,1.1505,1.54108e-006] [0.854001,1.08577,1.46657e-006]
						addKnot shp spln  #bezierCorner #curve [0.883494,0.8507,1.20563e-006] [0.870184,0.985837,1.35613e-006] [0.944644,0.884957,1.24009e-006]
						addKnot shp spln  #bezierCorner #curve [1.1386,0.959148,1.31647e-006] [1.02968,0.921107,1.27845e-006] [1.21657,1.0905,1.45989e-006]
						addKnot shp spln  #bezier #curve [1.39827,1.25464,1.63489e-006] [1.30313,1.189,1.56217e-006] [1.4934,1.32028,1.70236e-006]
						addKnot shp spln  #bezier #curve [1.71226,1.35311,1.73052e-006] [1.59807,1.35311,1.737e-006] [1.8226,1.35311,1.72498e-006]
						addKnot shp spln  #bezierCorner #curve [2.11463,1.1505,1.48958e-006] [1.95672,1.28557,1.64397e-006] [2.11463,1.1505,1.48958e-006]
						addKnot shp spln  #corner #curve [2.17169,1.10479,1.43805e-006] [2.14316,1.12765,1.46382e-006] [1.96604,0.909721,1.22797e-006]
						addKnot shp spln  #corner #curve [1.55475,0.519581,8.07804e-007] [1.7604,0.714651,1.01789e-006] [1.292,0.168444,4.27231e-007]
						addKnot shp spln  #bezierCorner #curve [1.02924,-0.182693,0] [1.02924,-0.182693,0] [0.82167,-0.376817,-1.60263e-007]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false
						shp.pos = wp1 
						shp.name=(uniqueName "Hand_CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2)*.2,(distance wp1 wp2)*.2,(distance wp1 wp2)*.2] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	), --End SplineHand

	fn boxCNT= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			local vPs=#(#view_persp_user,#view_iso_user,#view_camera,#view_spot) 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [1,1,-1] [1,0.333333,-1] [0.333333,1,-1]
						addKnot shp spln  #bezierCorner #curve [-1,1,-1] [-0.333333,1,-1] [-1,0.333333,-1]
						addKnot shp spln  #bezierCorner #curve [-1,-1,-1] [-1,-0.333333,-1] [-0.333333,-1,-1]
						addKnot shp spln  #bezierCorner #curve [1,-1,-1] [0.333333,-1,-1] [1,-0.333333,-1]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [1,-1,-1] [0.333333,-1,-1] [1,-1,-0.333333]
						addKnot shp spln  #bezierCorner #curve [1,-1,1] [1,-1,0.333333] [0.333333,-1,1]
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-1,-1,1] [-0.333333,-1,1] [-1,-1,0.333333]
						addKnot shp spln  #bezierCorner #curve [-1,-1,-1] [-1,-1,-0.333333] [-0.333333,-1,-1]
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [1,1,1] [1,0.333333,1] [0.333333,1,1]
						addKnot shp spln  #bezierCorner #curve [-1,1,1] [-0.333333,1,1] [-1,0.333333,1]
						addKnot shp spln  #bezierCorner #curve [-1,-1,1] [-1,-0.333333,1] [-0.333333,-1,1]
						addKnot shp spln  #bezierCorner #curve [1,-1,1] [0.333333,-1,1] [1,-0.333333,1]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [1,1,-1] [0.333333,1,-1] [1,1,-0.333333]
						addKnot shp spln  #bezierCorner #curve [1,1,1] [1,1,0.333333] [0.333333,1,1]
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-1,1,1] [-0.333333,1,1] [-1,1,0.333333]
						addKnot shp spln  #bezierCorner #curve [-1,1,-1] [-1,1,-0.333333] [-0.333333,1,-1]
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shp.rotation=(viewport.getTM()).rotation) 
						shp.pos = wp1 
						shp.name=(uniqueName "CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	),
		
	fn CircleArrows= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.193668,-0.0500575,0] [0.175549,-0.120182,0] [0.199417,-0.0500383,0]
						addKnot shp spln  #corner #curve [0.210916,-0.05,0] [0.205167,-0.0500192,0] [0.210888,-0.0579177,0]
						addKnot shp spln  #corner #curve [0.210832,-0.0737532,0] [0.21086,-0.0658355,0] [0.232952,-0.0491688,0]
						addKnot shp spln  #corner #curve [0.277192,0,0] [0.255072,-0.0245844,0] [0.255072,0.0245844,0]
						addKnot shp spln  #corner #curve [0.210832,0.0737532,0] [0.232952,0.0491688,0] [0.21086,0.0658355,0]
						addKnot shp spln  #corner #curve [0.210916,0.05,0] [0.210888,0.0579178,0] [0.205167,0.0500187,0]
						addKnot shp spln  #bezierCorner #curve [0.193668,0.0500561,0] [0.199417,0.0500374,0] [0.17555,0.120181,0]
						addKnot shp spln  #bezierCorner #curve [0.05,0.193044,0] [0.120256,0.175384,0] [0.05,0.199001,0]
						addKnot shp spln  #corner #curve [0.05,0.210916,0] [0.05,0.204959,0] [0.0579177,0.210897,0]
						addKnot shp spln  #corner #curve [0.0737532,0.21086,0] [0.0658355,0.210878,0] [0.0491688,0.23297,0]
						addKnot shp spln  #corner #curve [0,0.277192,0] [0.0245844,0.255081,0] [-0.0245844,0.255081,0]
						addKnot shp spln  #corner #curve [-0.0737532,0.21086,0] [-0.0491688,0.23297,0] [-0.0658355,0.210878,0]
						addKnot shp spln  #corner #curve [-0.05,0.210916,0] [-0.0579177,0.210897,0] [-0.05,0.204959,0]
						addKnot shp spln  #bezierCorner #curve [-0.05,0.193044,0] [-0.05,0.199001,0] [-0.120257,0.175384,0]
						addKnot shp spln  #bezierCorner #curve [-0.193668,0.0500547,0] [-0.17555,0.12018,0] [-0.199418,0.0500364,0]
						addKnot shp spln  #corner #curve [-0.210916,0.05,0] [-0.205167,0.0500182,0] [-0.210897,0.0579177,0]
						addKnot shp spln  #corner #curve [-0.21086,0.0737532,0] [-0.210878,0.0658355,0] [-0.23297,0.0491688,0]
						addKnot shp spln  #corner #curve [-0.277192,0,0] [-0.255081,0.0245844,0] [-0.255081,-0.0245844,0]
						addKnot shp spln  #corner #curve [-0.21086,-0.0737532,0] [-0.23297,-0.0491688,0] [-0.210878,-0.0658355,0]
						addKnot shp spln  #corner #curve [-0.210916,-0.05,0] [-0.210897,-0.0579178,0] [-0.205167,-0.0500188,0]
						addKnot shp spln  #bezierCorner #curve [-0.193668,-0.0500564,0] [-0.199417,-0.0500376,0] [-0.175549,-0.120182,0]
						addKnot shp spln  #bezierCorner #curve [-0.05,-0.193044,0] [-0.120256,-0.175385,0] [-0.05,-0.199001,0]
						addKnot shp spln  #corner #curve [-0.05,-0.210916,0] [-0.05,-0.204959,0] [-0.0579177,-0.210888,0]
						addKnot shp spln  #corner #curve [-0.0737532,-0.210832,0] [-0.0658355,-0.21086,0] [-0.0491688,-0.232952,0]
						addKnot shp spln  #corner #curve [0,-0.277192,0] [-0.0245844,-0.255072,0] [0.0245844,-0.255072,0]
						addKnot shp spln  #corner #curve [0.0737532,-0.210832,0] [0.0491688,-0.232952,0] [0.0658355,-0.21086,0]
						addKnot shp spln  #corner #curve [0.05,-0.210916,0] [0.0579177,-0.210888,0] [0.05,-0.204959,0]
						addKnot shp spln  #bezierCorner #curve [0.05,-0.193044,0] [0.05,-0.199001,0] [0.120256,-0.175384,0]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false
						shp.pos = wp1 
						shp.name=(uniqueName "Arrows_CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl *4
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	),

	fn foot= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #smooth #curve [0.398492,0.691396,0] [0.442345,0.531481,0] [0.35464,0.85131,0]
						addKnot shp spln  #smooth #curve [0.0662414,0.98296,0] [0.178222,0.97413,0] [-0.045739,0.991789,0]
						addKnot shp spln  #smooth #curve [-0.27339,0.744372,0] [-0.197254,0.889329,0] [-0.349526,0.599415,0]
						addKnot shp spln  #smooth #curve [-0.390577,0.113217,0] [-0.352366,0.341478,0] [-0.428788,-0.115043,0]
						addKnot shp spln  #smooth #curve [-0.502655,-0.625192,0] [-0.494227,-0.473347,0] [-0.511083,-0.777037,0]
						addKnot shp spln  #smooth #curve [-0.441144,-0.797852,0] [-0.473688,-0.781004,0] [-0.4086,-0.8147,0]
						addKnot shp spln  #bezierCorner #curve [-0.307391,-0.726279,0] [-0.319572,-0.780612,0] [-0.313104,-0.783482,0]
						addKnot shp spln  #smooth #curve [-0.218225,-0.878332,0] [-0.25785,-0.866911,0] [-0.178601,-0.889752,0]
						addKnot shp spln  #bezierCorner #curve [-0.0696461,-0.794802,0] [-0.0865116,-0.860844,0] [-0.0851496,-0.857287,0]
						addKnot shp spln  #smooth #curve [0.0377642,-0.94375,0] [-0.00319896,-0.938568,0] [0.0787274,-0.948933,0]
						addKnot shp spln  #bezierCorner #curve [0.176133,-0.825898,0] [0.167106,-0.871728,0] [0.170599,-0.874749,0]
						addKnot shp spln  #smooth #curve [0.292599,-1.01978,0] [0.245183,-1.01522,0] [0.340015,-1.02433,0]
						addKnot shp spln  #smooth #curve [0.460627,-0.853236,0] [0.4545,-1.02711,0] [0.466753,-0.679361,0]
						addKnot shp spln  #smooth #curve [0.329358,0.0234715,0] [0.339714,-0.233967,0] [0.319002,0.28091,0]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false
						shp.pos = wp1 
						shp.name=(uniqueName "R_Foot_CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	),
	
	fn characterNode= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp, numClick
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.536726,0.0222865,0] [-0.524093,0.0222925,0] [-0.536726,0.035751,0]
						addKnot shp spln  #bezierCorner #curve [-0.536726,0.0626799,0] [-0.536726,0.0492154,0] [-0.572915,0.0417866,0]
						addKnot shp spln  #bezierCorner #curve [-0.645291,0,0] [-0.609103,0.0208933,0] [-0.609103,-0.0208933,0]
						addKnot shp spln  #bezierCorner #curve [-0.536726,-0.0626799,0] [-0.572915,-0.0417866,0] [-0.536726,-0.0492154,0]
						addKnot shp spln  #bezierCorner #curve [-0.536726,-0.0222863,0] [-0.536726,-0.0357509,0] [-0.524093,-0.0222921,0]
						addKnot shp spln  #bezierCorner #curve [-0.499509,-0.0223328,0] [-0.511623,-0.022305,0] [-0.488353,-0.27544,0]
						addKnot shp spln  #bezierCorner #curve [-0.0373993,-0.498619,0] [-0.288518,-0.48,0] [-0.0373147,-0.527136,0]
						addKnot shp spln  #bezierCorner #curve [-0.0372839,-0.586082,0] [-0.0372906,-0.55649,0] [-0.0861638,-0.586082,0]
						addKnot shp spln  #bezierCorner #curve [-0.183923,-0.586082,0] [-0.135044,-0.586082,0] [-0.122616,-0.69227,0]
						addKnot shp spln  #bezierCorner #curve [0,-0.904647,0] [-0.0613078,-0.798458,0] [0.0613078,-0.798458,0]
						addKnot shp spln  #bezierCorner #curve [0.183923,-0.586082,0] [0.122616,-0.69227,0] [0.135044,-0.586082,0]
						addKnot shp spln  #bezierCorner #curve [0.0372837,-0.586082,0] [0.0861636,-0.586082,0] [0.0372899,-0.55649,0]
						addKnot shp spln  #bezierCorner #curve [0.0373899,-0.498619,0] [0.037312,-0.527137,0] [0.288513,-0.480006,0]
						addKnot shp spln  #bezierCorner #curve [0.499509,-0.0223345,0] [0.488352,-0.275444,0] [0.511558,-0.0223023,0]
						addKnot shp spln  #bezierCorner #curve [0.536726,-0.0222844,0] [0.524054,-0.0222895,0] [0.536726,-0.0357496,0]
						addKnot shp spln  #bezierCorner #curve [0.536726,-0.0626799,0] [0.536726,-0.0492147,0] [0.572915,-0.0417866,0]
						addKnot shp spln  #bezierCorner #curve [0.645291,0,0] [0.609103,-0.0208933,0] [0.609103,0.0208933,0]
						addKnot shp spln  #bezierCorner #curve [0.536726,0.0626799,0] [0.572915,0.0417866,0] [0.536726,0.0492149,0]
						addKnot shp spln  #bezierCorner #curve [0.536726,0.0222849,0] [0.536726,0.0357499,0] [0.524035,0.0222907,0]
						addKnot shp spln  #bezierCorner #curve [0.499508,0.0223421,0] [0.511533,0.0223053,0] [0.488348,0.275445,0]
						addKnot shp spln  #bezierCorner #curve [0.0373993,0.498619,0] [0.288515,0.480001,0] [0.0373424,0.515057,0]
						addKnot shp spln  #bezierCorner #curve [0.0372978,0.548839,0] [0.0373128,0.531855,0] [0.0544188,0.548839,0]
						addKnot shp spln  #bezierCorner #curve [0.0886606,0.548839,0] [0.0715397,0.548839,0] [0.0591071,0.600028,0]
						addKnot shp spln  #bezierCorner #curve [0,0.702404,0] [0.0295535,0.651216,0] [-0.0295535,0.651216,0]
						addKnot shp spln  #bezierCorner #curve [-0.0886606,0.548839,0] [-0.0591071,0.600028,0] [-0.0715392,0.548839,0]
						addKnot shp spln  #bezierCorner #curve [-0.0372965,0.548839,0] [-0.0544178,0.548839,0] [-0.0373103,0.531842,0]
						addKnot shp spln  #bezierCorner #curve [-0.0373898,0.498619,0] [-0.0373374,0.515041,0] [-0.288513,0.480006,0]
						addKnot shp spln  #bezierCorner #curve [-0.499509,0.0223345,0] [-0.488352,0.275444,0] [-0.511623,0.0223058,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0,0.00207515,0.404481] [0.00892673,-0.00588266,0.404197] [-0.00892674,-0.00588266,0.404197]
						addKnot shp spln  #bezier #curve [-0.0472643,-0.00986156,0.387932] [-0.0428373,-0.00986156,0.407234] [-0.0516913,-0.00986155,0.368631]
						addKnot shp spln  #smooth #curve [-0.138131,0.00207516,0.0345728] [-0.105886,8.57082e-005,0.0918113] [-0.170376,0.00406461,-0.0226656]
						addKnot shp spln  #smooth #curve [-0.240733,0.00207516,0.044502] [-0.237401,0.00207516,-0.0141636] [-0.244065,0.00207516,0.103168]
						addKnot shp spln  #smooth #curve [-0.158121,0.00207515,0.386567] [-0.178084,0.00207515,0.300467] [-0.138159,0.00207514,0.472666]
						addKnot shp spln  #smooth #curve [-0.120957,0.00207514,0.561101] [-0.124841,0.00207514,0.500795] [-0.117074,0.00207514,0.621408]
						addKnot shp spln  #smooth #curve [-0.134821,0.00207513,0.748406] [-0.103275,0.00207513,0.74808] [-0.166368,0.00207513,0.748733]
						addKnot shp spln  #smooth #curve [-0.310238,0.00207514,0.563061] [-0.270521,0.00207514,0.582919] [-0.349955,0.00207514,0.543202]
						addKnot shp spln  #smooth #curve [-0.373123,0.00207513,0.629256] [-0.388017,0.00207514,0.587884] [-0.358229,0.00207513,0.670627]
						addKnot shp spln  #smooth #curve [-0.220875,0.00207513,0.811292] [-0.262246,0.00207513,0.76661] [-0.179503,0.00207512,0.855973]
						addKnot shp spln  #smooth #curve [-0.124892,0.00207512,0.897345] [-0.161705,0.00207512,0.879141] [-0.0880796,0.00207512,0.915548]
						addKnot shp spln  #smooth #curve [0,0.00207512,0.920513] [-0.0416307,0.00207512,0.920513] [0.0416307,0.00207512,0.920513]
						addKnot shp spln  #smooth #curve [0.124892,0.00207512,0.897345] [0.0880797,0.00207512,0.915548] [0.161705,0.00207512,0.879141]
						addKnot shp spln  #smooth #curve [0.220875,0.00207513,0.811292] [0.179503,0.00207512,0.855973] [0.262246,0.00207513,0.76661]
						addKnot shp spln  #smooth #curve [0.373123,0.00207513,0.629256] [0.358229,0.00207513,0.670627] [0.388017,0.00207514,0.587884]
						addKnot shp spln  #smooth #curve [0.310238,0.00207514,0.563061] [0.349955,0.00207514,0.543202] [0.270521,0.00207514,0.582919]
						addKnot shp spln  #smooth #curve [0.134821,0.00207513,0.748406] [0.166368,0.00207513,0.748733] [0.103275,0.00207513,0.74808]
						addKnot shp spln  #smooth #curve [0.120957,0.00207514,0.561101] [0.117074,0.00207514,0.621408] [0.124841,0.00207514,0.500795]
						addKnot shp spln  #smooth #curve [0.158121,0.00207515,0.386567] [0.138159,0.00207514,0.472666] [0.178084,0.00207515,0.300467]
						addKnot shp spln  #smooth #curve [0.240733,0.00207516,0.044502] [0.244065,0.00207516,0.103168] [0.237401,0.00207516,-0.0141636]
						addKnot shp spln  #smooth #curve [0.138131,0.00207516,0.0345728] [0.170376,0.00406461,-0.0226656] [0.105886,8.57082e-005,0.0918113]
						addKnot shp spln  #bezier #curve [0.0472643,-0.00986156,0.387932] [0.0516913,-0.00986155,0.368631] [0.0428373,-0.00986156,0.407234]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [0.106185,0.00207512,1.06357] [0.106185,0.00207512,1.00498] [0.106185,0.00207512,1.12216]
						addKnot shp spln  #bezier #curve [0,0.00207511,1.16975] [0.0585913,0.00207511,1.16975] [-0.0585914,0.00207511,1.16975]
						addKnot shp spln  #bezier #curve [-0.106185,0.00207512,1.06357] [-0.106185,0.00207512,1.12216] [-0.106185,0.00207512,1.00498]
						addKnot shp spln  #bezier #curve [0,0.00207512,0.957383] [-0.0585914,0.00207512,0.957383] [0.0585914,0.00207512,0.957383]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.pos = wp1 
						shp.name=(uniqueName "CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
						
					--	scl = [50,50,50] 
					--	shp.modifiers[#xform].gizmo.scale = scl 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	) ,

	fn rankinObj= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.534965,0.0222134,0] [-0.522374,0.0222194,0] [-0.534965,0.0356337,0]
						addKnot shp spln  #bezierCorner #curve [-0.534965,0.0624743,0] [-0.534965,0.0490539,0] [-0.571036,0.0416495,0]
						addKnot shp spln  #bezierCorner #curve [-0.643174,0,0] [-0.607105,0.0208248,0] [-0.607105,-0.0208248,0]
						addKnot shp spln  #bezierCorner #curve [-0.534965,-0.0624743,0] [-0.571036,-0.0416495,0] [-0.534965,-0.0490539,0]
						addKnot shp spln  #bezierCorner #curve [-0.534965,-0.0222132,0] [-0.534965,-0.0356336,0] [-0.522374,-0.022219,0]
						addKnot shp spln  #bezierCorner #curve [-0.49787,-0.0222595,0] [-0.509945,-0.0222318,0] [-0.486751,-0.274536,0]
						addKnot shp spln  #bezierCorner #curve [-0.0372766,-0.496983,0] [-0.287572,-0.478425,0] [-0.0371923,-0.525407,0]
						addKnot shp spln  #bezierCorner #curve [-0.0371616,-0.584159,0] [-0.0371683,-0.554664,0] [-0.0858811,-0.584159,0]
						addKnot shp spln  #bezierCorner #curve [-0.18332,-0.584159,0] [-0.134601,-0.584159,0] [-0.122214,-0.689999,0]
						addKnot shp spln  #bezierCorner #curve [0,-0.901679,0] [-0.0611067,-0.795839,0] [0.0611067,-0.795839,0]
						addKnot shp spln  #bezierCorner #curve [0.18332,-0.584159,0] [0.122214,-0.689999,0] [0.134601,-0.584159,0]
						addKnot shp spln  #bezierCorner #curve [0.0371614,-0.584159,0] [0.0858809,-0.584159,0] [0.0371676,-0.554664,0]
						addKnot shp spln  #bezierCorner #curve [0.0372672,-0.496983,0] [0.0371896,-0.525408,0] [0.287567,-0.478431,0]
						addKnot shp spln  #bezierCorner #curve [0.49787,-0.0222612,0] [0.48675,-0.27454,0] [0.50988,-0.0222291,0]
						addKnot shp spln  #bezierCorner #curve [0.534965,-0.0222113,0] [0.522335,-0.0222164,0] [0.534965,-0.0356323,0]
						addKnot shp spln  #bezierCorner #curve [0.534965,-0.0624743,0] [0.534965,-0.0490532,0] [0.571036,-0.0416495,0]
						addKnot shp spln  #bezierCorner #curve [0.643174,0,0] [0.607105,-0.0208248,0] [0.607105,0.0208248,0]
						addKnot shp spln  #bezierCorner #curve [0.534965,0.0624743,0] [0.571036,0.0416495,0] [0.534965,0.0490534,0]
						addKnot shp spln  #bezierCorner #curve [0.534965,0.0222118,0] [0.534965,0.0356326,0] [0.522316,0.0222176,0]
						addKnot shp spln  #bezierCorner #curve [0.497869,0.0222688,0] [0.509855,0.0222321,0] [0.486746,0.274541,0]
						addKnot shp spln  #bezierCorner #curve [0.0372766,0.496983,0] [0.287569,0.478426,0] [0.0372199,0.513367,0]
						addKnot shp spln  #bezierCorner #curve [0.0371754,0.547038,0] [0.0371904,0.53011,0] [0.0542403,0.547038,0]
						addKnot shp spln  #bezierCorner #curve [0.0883697,0.547038,0] [0.071305,0.547038,0] [0.0589132,0.59806,0]
						addKnot shp spln  #bezierCorner #curve [0,0.7001,0] [0.0294565,0.64908,0] [-0.0294565,0.64908,0]
						addKnot shp spln  #bezierCorner #curve [-0.0883697,0.547038,0] [-0.0589132,0.59806,0] [-0.0713045,0.547038,0]
						addKnot shp spln  #bezierCorner #curve [-0.0371742,0.547038,0] [-0.0542393,0.547038,0] [-0.0371879,0.530097,0]
						addKnot shp spln  #bezierCorner #curve [-0.0372671,0.496983,0] [-0.0372149,0.513351,0] [-0.287567,0.478431,0]
						addKnot shp spln  #bezierCorner #curve [-0.49787,0.0222612,0] [-0.48675,0.27454,0] [-0.509945,0.0222326,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [-0.1068,0,0.0576947] [-0.108367,0,0.0550516] [-0.101471,0,0.0666771]
						addKnot shp spln  #bezier #curve [-0.0987124,0,0.0933106] [-0.100783,0,0.0819511] [-0.0953288,0,0.11187]
						addKnot shp spln  #smooth #curve [-0.106835,0,0.206477] [-0.107788,0,0.177479] [-0.105883,0,0.235475]
						addKnot shp spln  #smooth #curve [-0.0929985,0,0.267299] [-0.0953046,0,0.243006] [-0.0906924,0,0.291591]
						addKnot shp spln  #smooth #curve [-0.0929985,0,0.352232] [-0.0933934,0,0.323148] [-0.0926036,0,0.381315]
						addKnot shp spln  #smooth #curve [-0.0906291,0,0.441798] [-0.0933239,0,0.414675] [-0.0879343,0,0.468921]
						addKnot shp spln  #smooth #curve [-0.0768299,0,0.51497] [-0.0804774,0,0.49488] [-0.0731824,0,0.53506]
						addKnot shp spln  #smooth #curve [-0.0687442,0,0.562337] [-0.0706435,0,0.5442] [-0.0668449,0,0.580474]
						addKnot shp spln  #bezier #curve [-0.065434,0,0.623792] [-0.0623064,0,0.609768] [-0.0700569,0,0.644519]
						addKnot shp spln  #bezier #curve [-0.0873032,0,0.684752] [-0.0807056,0,0.665667] [-0.0919042,0,0.698062]
						addKnot shp spln  #bezier #curve [-0.104411,0,0.726033] [-0.0935268,0,0.718953] [-0.112035,0,0.730993]
						addKnot shp spln  #bezierCorner #curve [-0.175268,0,0.725094] [-0.159184,0,0.722608] [-0.193026,0,0.726351]
						addKnot shp spln  #bezierCorner #curve [-0.228524,0,0.728847] [-0.210784,0,0.727577] [-0.239304,0,0.727214]
						addKnot shp spln  #bezierCorner #curve [-0.267551,0,0.727443] [-0.255152,0,0.725445] [-0.288788,0,0.730409]
						addKnot shp spln  #bezierCorner #curve [-0.331262,0,0.736363] [-0.310025,0,0.733377] [-0.343238,0,0.738196]
						addKnot shp spln  #bezierCorner #curve [-0.351698,0,0.727443] [-0.343527,0,0.728952] [-0.351698,0,0.727443]
						addKnot shp spln  #corner #curve [-0.352193,0,0.727443] [-0.351946,0,0.727443] [-0.36225,0,0.728153]
						addKnot shp spln  #bezier #curve [-0.376908,0,0.730733] [-0.372307,0,0.728863] [-0.379436,0,0.731761]
						addKnot shp spln  #bezierCorner #curve [-0.4034,0,0.734666] [-0.397275,0,0.735083] [-0.442736,0,0.666383]
						addKnot shp spln  #bezier #curve [-0.465252,0,0.502699] [-0.465252,0,0.587176] [-0.465252,0,0.284749]
						addKnot shp spln  #bezierCorner #curve [-0.113061,0,0.0513134] [-0.315365,0,0.101823] [-0.110637,0,0.0531051]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.403212,0,0.734955] [0.442669,0,0.666606] [0.403212,0,0.734955]
						addKnot shp spln  #bezierCorner #curve [0.381124,0,0.730248] [0.38445,0,0.731228] [0.377486,0,0.730409]
						addKnot shp spln  #bezierCorner #curve [0.357374,0,0.727443] [0.357374,0,0.727443] [0.3517,0,0.728532]
						addKnot shp spln  #bezier #curve [0.346423,0,0.735894] [0.350639,0,0.734358] [0.335546,0,0.739854]
						addKnot shp spln  #bezier #curve [0.297895,0,0.730248] [0.307651,0,0.732181] [0.266101,0,0.723947]
						addKnot shp spln  #bezier #curve [0.196606,0,0.726033] [0.228386,0,0.731096] [0.177199,0,0.722941]
						addKnot shp spln  #bezier #curve [0.135762,0,0.726521] [0.154047,0,0.724698] [0.128887,0,0.727207]
						addKnot shp spln  #bezier #curve [0.110057,0,0.726033] [0.115329,0,0.729504] [0.100015,0,0.719421]
						addKnot shp spln  #bezier #curve [0.0943646,0,0.687567] [0.0986142,0,0.699919] [0.0874805,0,0.667558]
						addKnot shp spln  #bezier #curve [0.0715384,0,0.623792] [0.0762339,0,0.645775] [0.0669055,0,0.602101]
						addKnot shp spln  #smooth #curve [0.0805955,0,0.544054] [0.0776617,0,0.566408] [0.0835293,0,0.521699]
						addKnot shp spln  #smooth #curve [0.0891414,0,0.489665] [0.0866083,0,0.506708] [0.0916744,0,0.472622]
						addKnot shp spln  #smooth #curve [0.0957937,0,0.441798] [0.0944462,0,0.458216] [0.0971413,0,0.42538]
						addKnot shp spln  #smooth #curve [0.0972266,0,0.391157] [0.0972266,0,0.409991] [0.0972266,0,0.372322]
						addKnot shp spln  #smooth #curve [0.0957937,0,0.328792] [0.0959552,0,0.349742] [0.0956322,0,0.307843]
						addKnot shp spln  #smooth #curve [0.0962577,0,0.265459] [0.0945946,0,0.281641] [0.0979208,0,0.249277]
						addKnot shp spln  #smooth #curve [0.105772,0,0.231699] [0.103948,0,0.240141] [0.107597,0,0.223258]
						addKnot shp spln  #smooth #curve [0.107205,0,0.214811] [0.107597,0,0.227558] [0.106813,0,0.202064]
						addKnot shp spln  #smooth #curve [0.103422,0,0.155218] [0.104291,0,0.178985] [0.102552,0,0.131451]
						addKnot shp spln  #bezier #curve [0.101989,0,0.0722086] [0.0995193,0,0.0967064] [0.103003,0,0.0621462]
						addKnot shp spln  #bezierCorner #curve [0.113912,0,0.0515199] [0.108418,0,0.0567734] [0.315793,0,0.102334]
						addKnot shp spln  #bezier #curve [0.465251,0,0.502699] [0.465251,0,0.285057] [0.465251,0,0.587295]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.0686932,0,0.0834846] [0.0698009,0,0.0700071] [0.0697803,0,0.0887718]
						addKnot shp spln  #smooth #curve [0.0705867,0,0.105047] [0.071141,0,0.0944138] [0.0700324,0,0.115681]
						addKnot shp spln  #smooth #curve [0.0653672,0,0.147285] [0.0686934,0,0.129545] [0.062041,0,0.165025]
						addKnot shp spln  #smooth #curve [0.0506296,0,0.211485] [0.0525349,0,0.193197] [0.0487243,0,0.229774]
						addKnot shp spln  #smooth #curve [0.0539355,0,0.257015] [0.0559176,0,0.241373] [0.0519535,0,0.272657]
						addKnot shp spln  #smooth #curve [0.0387373,0,0.305336] [0.0447586,0,0.282351] [0.032716,0,0.328322]
						addKnot shp spln  #smooth #curve [0.017808,0,0.394927] [0.0237554,0,0.368197] [0.0118605,0,0.421656]
						addKnot shp spln  #smooth #curve [0.00305271,0,0.465715] [0.0070161,0,0.458446] [-0.000910679,0,0.472984]
						addKnot shp spln  #smooth #curve [-0.00597239,0,0.438543] [-0.00240723,0,0.454017] [-0.00953754,0,0.423069]
						addKnot shp spln  #smooth #curve [-0.0183382,0,0.372873] [-0.0135055,0,0.395074] [-0.0231709,0,0.350672]
						addKnot shp spln  #smooth #curve [-0.0349689,0,0.305336] [-0.0295016,0,0.32472] [-0.0404361,0,0.285953]
						addKnot shp spln  #smooth #curve [-0.0511417,0,0.256572] [-0.048998,0,0.272361] [-0.0532854,0,0.240782]
						addKnot shp spln  #smooth #curve [-0.0478311,0,0.210601] [-0.045372,0,0.231008] [-0.0502901,0,0.190194]
						addKnot shp spln  #smooth #curve [-0.065896,0,0.134129] [-0.0617398,0,0.162042] [-0.0700523,0,0.106217]
						addKnot shp spln  #bezierCorner #curve [-0.0727687,0,0.0431266] [-0.0654001,0,0.0660541] [-0.0490589,0,0.0393906]
						addKnot shp spln  #bezier #curve [-9.53674e-007,0,0.0374463] [-0.0247674,0,0.0374463] [0.024528,0,0.0374463]
						addKnot shp spln  #bezierCorner #curve [0.072104,0,0.0430079] [0.048614,0,0.0393567] [0.0720668,0,0.0430589]
						addKnot shp spln  #bezierCorner #curve [0.0720196,0,0.0431435] [0.0720501,0,0.0430927] [0.0709085,0,0.056587]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [-9.53674e-007,0,1.0058] [0.277853,0,1.0058] [-0.277855,0,1.0058]
						addKnot shp spln  #bezier #curve [-0.503086,0,0.502699] [-0.503086,0,0.780532] [-0.503086,0,0.224861]
						addKnot shp spln  #bezier #curve [-9.53674e-007,0,-0.000371218] [-0.277855,0,-0.000371218] [0.277853,0,-0.000371218]
						addKnot shp spln  #bezier #curve [0.503086,0,0.502699] [0.503086,0,0.224861] [0.503086,0,0.780532]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [-9.53674e-007,0,0.967947] [-0.1649,0,0.967947] [0.163893,0,0.967947]
						addKnot shp spln  #bezierCorner #curve [0.390845,0,0.755178] [0.307958,0,0.883213] [0.389992,0,0.755621]
						addKnot shp spln  #bezierCorner #curve [0.344055,0,0.756986] [0.358779,0,0.756848] [0.313947,0,0.762923]
						addKnot shp spln  #bezierCorner #curve [0.256037,0,0.771052] [0.287848,0,0.766213] [0.242901,0,0.770127]
						addKnot shp spln  #bezierCorner #curve [0.216583,0,0.768244] [0.229735,0,0.769198] [0.203295,0,0.766213]
						addKnot shp spln  #bezierCorner #curve [0.177604,0,0.771997] [0.188744,0,0.770163] [0.177604,0,0.771997]
						addKnot shp spln  #bezierCorner #curve [0.158107,0,0.771997] [0.158107,0,0.771997] [0.145432,0,0.776064]
						addKnot shp spln  #bezierCorner #curve [0.120053,0,0.784193] [0.132724,0,0.780132] [0.104289,0,0.787998]
						addKnot shp spln  #bezier #curve [0.0810595,0,0.779981] [0.09097,0,0.778246] [0.0643396,0,0.782907]
						addKnot shp spln  #bezier #curve [0.0316072,0,0.817961] [0.0284791,0,0.796275] [0.0323586,0,0.82317]
						addKnot shp spln  #bezierCorner #curve [0.0382767,0,0.84236] [0.037643,0,0.838443] [0.0398617,0,0.844689]
						addKnot shp spln  #bezier #curve [0.0434794,0,0.845634] [0.041821,0,0.843385] [0.0474854,0,0.851068]
						addKnot shp spln  #bezierCorner #curve [0.0482416,0,0.872381] [0.0494847,0,0.864075] [0.0472827,0,0.872834]
						addKnot shp spln  #bezierCorner #curve [0.0411081,0,0.870974] [0.042541,0,0.871904] [0.0411081,0,0.870974]
						addKnot shp spln  #bezierCorner #curve [0.036366,0,0.901925] [0.0368099,0,0.900834] [0.030344,0,0.916126]
						addKnot shp spln  #bezierCorner #curve [-0.00073576,0,0.923026] [0.0198879,0,0.922957] [-0.00549126,0,0.921935]
						addKnot shp spln  #bezierCorner #curve [-0.0150118,0,0.919724] [-0.0102673,0,0.920825] [-0.0303311,0,0.91268]
						addKnot shp spln  #bezierCorner #curve [-0.0344906,0,0.871904] [-0.034235,0,0.892595] [-0.0346599,0,0.871742]
						addKnot shp spln  #bezierCorner #curve [-0.0421166,0,0.872381] [-0.0386043,0,0.874369] [-0.0437865,0,0.863186]
						addKnot shp spln  #bezierCorner #curve [-0.0326142,0,0.843768] [-0.0406313,0,0.845515] [-0.0307732,0,0.840211]
						addKnot shp spln  #bezierCorner #curve [-0.0254688,0,0.819365] [-0.0270691,0,0.822947] [-0.0216312,0,0.799801]
						addKnot shp spln  #bezier #curve [-0.0535297,0,0.78794] [-0.0416574,0,0.793069] [-0.0594163,0,0.785397]
						addKnot shp spln  #bezierCorner #curve [-0.0782795,0,0.779981] [-0.0699048,0,0.778426] [-0.08459,0,0.781693]
						addKnot shp spln  #bezierCorner #curve [-0.0972834,0,0.785125] [-0.0909357,0,0.783409] [-0.118754,0,0.788661]
						addKnot shp spln  #bezierCorner #curve [-0.151985,0,0.771997] [-0.135817,0,0.77545] [-0.151985,0,0.771997]
						addKnot shp spln  #bezierCorner #curve [-0.171466,0,0.771997] [-0.171466,0,0.771997] [-0.182827,0,0.770163]
						addKnot shp spln  #bezierCorner #curve [-0.210955,0,0.768244] [-0.19748,0,0.766145] [-0.223936,0,0.769198]
						addKnot shp spln  #bezierCorner #curve [-0.249932,0,0.771052] [-0.236932,0,0.770127] [-0.281538,0,0.766282]
						addKnot shp spln  #bezier #curve [-0.337914,0,0.756986] [-0.307602,0,0.762866] [-0.350998,0,0.754448]
						addKnot shp spln  #bezierCorner #curve [-0.382622,0,0.756517] [-0.37082,0,0.759151] [-0.384993,0,0.755444]
						addKnot shp spln  #bezierCorner #curve [-0.392397,0,0.75278] [-0.391511,0,0.752908] [-0.309752,0,0.882165]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.345228,0,0.885281] [-0.343107,0,0.887159] [-0.359525,0,0.901159]
						addKnot shp spln  #corner #curve [-0.388119,0,0.932916] [-0.373822,0,0.917038] [-0.375963,0,0.94327]
						addKnot shp spln  #bezierCorner #curve [-0.363808,0,0.953624] [-0.363808,0,0.953624] [-0.35879,0,0.957619]
						addKnot shp spln  #bezier #curve [-0.351253,0,0.961283] [-0.354598,0,0.960175] [-0.347914,0,0.96239]
						addKnot shp spln  #bezier #curve [-0.341249,0,0.961193] [-0.344569,0,0.962357] [-0.337935,0,0.960031]
						addKnot shp spln  #bezier #curve [-0.333156,0,0.95517] [-0.335243,0,0.958009] [-0.330466,0,0.951509]
						addKnot shp spln  #bezier #curve [-0.330136,0,0.943108] [-0.329488,0,0.94749] [-0.330783,0,0.938739]
						addKnot shp spln  #bezierCorner #curve [-0.337987,0,0.929578] [-0.333387,0,0.93424] [-0.33546,0,0.930193]
						addKnot shp spln  #bezier #curve [-0.331778,0,0.930377] [-0.333389,0,0.930469] [-0.328333,0,0.930182]
						addKnot shp spln  #bezierCorner #curve [-0.320788,0,0.928027] [-0.32467,0,0.929374] [-0.320788,0,0.928027]
						addKnot shp spln  #corner #curve [-0.301359,0,0.92064] [-0.311073,0,0.924334] [-0.304202,0,0.91855]
						addKnot shp spln  #corner #curve [-0.309888,0,0.914369] [-0.307045,0,0.916459] [-0.31735,0,0.917068]
						addKnot shp spln  #bezierCorner #curve [-0.324812,0,0.919767] [-0.324812,0,0.919767] [-0.329191,0,0.921236]
						addKnot shp spln  #bezier #curve [-0.33525,0,0.922808] [-0.332673,0,0.922251] [-0.337831,0,0.923366]
						addKnot shp spln  #bezier #curve [-0.341448,0,0.923332] [-0.3399,0,0.923535] [-0.342998,0,0.92313]
						addKnot shp spln  #bezierCorner #curve [-0.345679,0,0.922083] [-0.344408,0,0.92271] [-0.346591,0,0.921596]
						addKnot shp spln  #bezierCorner #curve [-0.349702,0,0.919141] [-0.347933,0,0.920617] [-0.349702,0,0.919141]
						addKnot shp spln  #corner #curve [-0.357583,0,0.912407] [-0.353643,0,0.915774] [-0.351344,0,0.905243]
						addKnot shp spln  #corner #curve [-0.338865,0,0.890916] [-0.345104,0,0.89808] [-0.340986,0,0.889038]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.362378,0,0.917912] [-0.367019,0,0.92324] [-0.354926,0,0.924175]
						addKnot shp spln  #bezierCorner #curve [-0.347474,0,0.930438] [-0.347474,0,0.930438] [-0.344248,0,0.933033]
						addKnot shp spln  #bezier #curve [-0.340608,0,0.937442] [-0.341962,0,0.935366] [-0.339252,0,0.93952]
						addKnot shp spln  #bezier #curve [-0.338717,0,0.943771] [-0.33862,0,0.941625] [-0.338814,0,0.945919]
						addKnot shp spln  #bezier #curve [-0.340734,0,0.949463] [-0.339481,0,0.947817] [-0.342569,0,0.951874]
						addKnot shp spln  #bezier #curve [-0.348158,0,0.95319] [-0.345042,0,0.95313] [-0.351281,0,0.953249]
						addKnot shp spln  #bezierCorner #curve [-0.359053,0,0.948336] [-0.354922,0,0.951627] [-0.359053,0,0.948336]
						addKnot shp spln  #corner #curve [-0.376302,0,0.933898] [-0.367677,0,0.941117] [-0.371661,0,0.928569]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.273166,0,0.946375] [-0.271803,0,0.944614] [-0.274317,0,0.942739]
						addKnot shp spln  #bezier #curve [-0.277514,0,0.937444] [-0.275769,0,0.939769] [-0.279255,0,0.935122]
						addKnot shp spln  #bezier #curve [-0.284007,0,0.931398] [-0.281418,0,0.933114] [-0.288282,0,0.928566]
						addKnot shp spln  #bezier #curve [-0.295925,0,0.927833] [-0.292231,0,0.927371] [-0.29963,0,0.928296]
						addKnot shp spln  #bezier #curve [-0.304844,0,0.933243] [-0.302608,0,0.930078] [-0.306155,0,0.935098]
						addKnot shp spln  #bezier #curve [-0.307113,0,0.93926] [-0.306917,0,0.937103] [-0.307308,0,0.941419]
						addKnot shp spln  #bezier #curve [-0.306199,0,0.945407] [-0.307005,0,0.943471] [-0.305393,0,0.947346]
						addKnot shp spln  #bezierCorner #curve [-0.302718,0,0.950903] [-0.304228,0,0.949177] [-0.301588,0,0.952154]
						addKnot shp spln  #bezier #curve [-0.297201,0,0.955984] [-0.299764,0,0.953865] [-0.291974,0,0.960306]
						addKnot shp spln  #bezierCorner #curve [-0.286064,0,0.966265] [-0.288227,0,0.96369] [-0.286603,0,0.9672]
						addKnot shp spln  #bezier #curve [-0.287102,0,0.968039] [-0.286949,0,0.967791] [-0.288784,0,0.97077]
						addKnot shp spln  #bezier #curve [-0.292711,0,0.972539] [-0.290652,0,0.972276] [-0.295503,0,0.972897]
						addKnot shp spln  #bezier #curve [-0.302359,0,0.969579] [-0.298735,0,0.971922] [-0.305743,0,0.967392]
						addKnot shp spln  #bezier #curve [-0.308736,0,0.963064] [-0.307864,0,0.965204] [-0.309606,0,0.960928]
						addKnot shp spln  #bezierCorner #curve [-0.308394,0,0.955017] [-0.309487,0,0.958242] [-0.308394,0,0.955017]
						addKnot shp spln  #bezierCorner #curve [-0.315697,0,0.951182] [-0.315697,0,0.951182] [-0.316977,0,0.954309]
						addKnot shp spln  #bezier #curve [-0.31722,0,0.959851] [-0.317492,0,0.9572] [-0.316947,0,0.962507]
						addKnot shp spln  #bezier #curve [-0.313618,0,0.967975] [-0.315751,0,0.965224] [-0.311482,0,0.970731]
						addKnot shp spln  #bezier #curve [-0.304899,0,0.975676] [-0.308575,0,0.97331] [-0.30125,0,0.978024]
						addKnot shp spln  #bezier #curve [-0.295218,0,0.980124] [-0.298011,0,0.979497] [-0.292428,0,0.980751]
						addKnot shp spln  #bezier #curve [-0.288307,0,0.980217] [-0.290121,0,0.980775] [-0.286495,0,0.97966]
						addKnot shp spln  #bezierCorner #curve [-0.283286,0,0.976984] [-0.284822,0,0.978578] [-0.282358,0,0.975976]
						addKnot shp spln  #bezierCorner #curve [-0.279217,0,0.970974] [-0.281002,0,0.973973] [-0.279217,0,0.970974]
						addKnot shp spln  #bezierCorner #curve [-0.273863,0,0.961978] [-0.273863,0,0.961978] [-0.27013,0,0.955706]
						addKnot shp spln  #bezier #curve [-0.266341,0,0.950298] [-0.267621,0,0.951814] [-0.265061,0,0.948782]
						addKnot shp spln  #bezierCorner #curve [-0.261818,0,0.946434] [-0.263553,0,0.947494] [-0.261818,0,0.946434]
						addKnot shp spln  #bezierCorner #curve [-0.268765,0,0.942269] [-0.268765,0,0.942269] [-0.270336,0,0.943246]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.282952,0,0.960901] [-0.282952,0,0.960901] [-0.284883,0,0.958337]
						addKnot shp spln  #bezier #curve [-0.292724,0,0.951204] [-0.288168,0,0.955137] [-0.295301,0,0.948979]
						addKnot shp spln  #bezier #curve [-0.297825,0,0.945956] [-0.29699,0,0.947215] [-0.298659,0,0.944698]
						addKnot shp spln  #bezier #curve [-0.29907,0,0.942044] [-0.299074,0,0.943392] [-0.299066,0,0.940697]
						addKnot shp spln  #bezier #curve [-0.297908,0,0.938334] [-0.298676,0,0.939461] [-0.29673,0,0.936609]
						addKnot shp spln  #bezier #curve [-0.292945,0,0.935393] [-0.295074,0,0.935636] [-0.290819,0,0.935151]
						addKnot shp spln  #bezier #curve [-0.285854,0,0.937606] [-0.288465,0,0.935893] [-0.283269,0,0.939302]
						addKnot shp spln  #bezier #curve [-0.279983,0,0.943756] [-0.281315,0,0.941345] [-0.278648,0,0.946172]
						addKnot shp spln  #bezier #curve [-0.278321,0,0.951193] [-0.278084,0,0.948646] [-0.278504,0,0.953158]
						addKnot shp spln  #bezierCorner #curve [-0.281308,0,0.958544] [-0.2795,0,0.955608] [-0.281308,0,0.958544]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.253414,0,0.951277] [-0.25111,0,0.952553] [-0.261027,0,0.964779]
						addKnot shp spln  #corner #curve [-0.276253,0,0.991782] [-0.26864,0,0.97828] [-0.273997,0,0.993033]
						addKnot shp spln  #corner #curve [-0.269485,0,0.995537] [-0.271741,0,0.994285] [-0.267905,0,0.992641]
						addKnot shp spln  #bezierCorner #curve [-0.266324,0,0.989745] [-0.266324,0,0.989745] [-0.265496,0,0.995955]
						addKnot shp spln  #bezier #curve [-0.255713,0,1.00393] [-0.261966,0,1.00073] [-0.252997,0,1.00532]
						addKnot shp spln  #bezier #curve [-0.247523,0,1.00634] [-0.250259,0,1.00612] [-0.244791,0,1.00656]
						addKnot shp spln  #bezier #curve [-0.240659,0,1.00527] [-0.242501,0,1.0062] [-0.23882,0,1.00434]
						addKnot shp spln  #bezierCorner #curve [-0.235787,0,1.00114] [-0.237198,0,1.00296] [-0.234884,0,0.999954]
						addKnot shp spln  #bezierCorner #curve [-0.232102,0,0.994415] [-0.233656,0,0.997712] [-0.232102,0,0.994415]
						addKnot shp spln  #corner #curve [-0.219928,0,0.968579] [-0.226015,0,0.981497] [-0.222301,0,0.967438]
						addKnot shp spln  #corner #curve [-0.227048,0,0.965157] [-0.224675,0,0.966298] [-0.233269,0,0.97785]
						addKnot shp spln  #bezierCorner #curve [-0.23949,0,0.990544] [-0.23949,0,0.990544] [-0.240902,0,0.993426]
						addKnot shp spln  #bezier #curve [-0.243534,0,0.996577] [-0.242248,0,0.995439] [-0.244821,0,0.997716]
						addKnot shp spln  #bezier #curve [-0.248343,0,0.998441] [-0.246425,0,0.998341] [-0.250263,0,0.998542]
						addKnot shp spln  #bezier #curve [-0.254237,0,0.997049] [-0.252232,0,0.99808] [-0.257441,0,0.995402]
						addKnot shp spln  #bezier #curve [-0.26099,0,0.989904] [-0.259701,0,0.993011] [-0.262277,0,0.986803]
						addKnot shp spln  #bezierCorner #curve [-0.25863,0,0.977403] [-0.261474,0,0.982632] [-0.25863,0,0.977403]
						addKnot shp spln  #corner #curve [-0.246503,0,0.955105] [-0.252567,0,0.966254] [-0.248807,0,0.953829]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.208883,0,0.973626] [-0.206467,0,0.974673] [-0.217533,0,0.993163]
						addKnot shp spln  #corner #curve [-0.234834,0,1.03224] [-0.226184,0,1.0127] [-0.232118,0,1.03342]
						addKnot shp spln  #corner #curve [-0.226686,0,1.03577] [-0.229402,0,1.03459] [-0.221942,0,1.0246]
						addKnot shp spln  #corner #curve [-0.212454,0,1.00225] [-0.217198,0,1.01342] [-0.208643,0,1.01055]
						addKnot shp spln  #corner #curve [-0.201019,0,1.02715] [-0.204831,0,1.01885] [-0.197555,0,1.02844]
						addKnot shp spln  #corner #curve [-0.190626,0,1.03101] [-0.194091,0,1.02972] [-0.194509,0,1.02338]
						addKnot shp spln  #corner #curve [-0.202274,0,1.00811] [-0.198391,0,1.01575] [-0.192573,0,1.00137]
						addKnot shp spln  #corner #curve [-0.173172,0,0.987871] [-0.182872,0,0.994618] [-0.176205,0,0.986758]
						addKnot shp spln  #corner #curve [-0.182272,0,0.984532] [-0.179239,0,0.985645] [-0.190069,0,0.989977]
						addKnot shp spln  #corner #curve [-0.205664,0,1.00087] [-0.197867,0,0.995422] [-0.206727,0,0.998501]
						addKnot shp spln  #corner #curve [-0.208852,0,0.993767] [-0.207789,0,0.996134] [-0.206446,0,0.988101]
						addKnot shp spln  #corner #curve [-0.201635,0,0.976769] [-0.204041,0,0.982435] [-0.204051,0,0.975721]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.185083,0,1.04207] [-0.182319,0,1.043] [-0.186056,0,1.04491]
						addKnot shp spln  #corner #curve [-0.188,0,1.05059] [-0.187028,0,1.04775] [-0.185192,0,1.05153]
						addKnot shp spln  #corner #curve [-0.179577,0,1.0534] [-0.182385,0,1.05246] [-0.178648,0,1.05055]
						addKnot shp spln  #corner #curve [-0.17679,0,1.04485] [-0.177719,0,1.0477] [-0.179555,0,1.04392]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.167224,0,0.989949] [-0.164727,0,0.990784] [-0.172248,0,1.00461]
						addKnot shp spln  #corner #curve [-0.182296,0,1.03394] [-0.177272,0,1.01928] [-0.179573,0,1.03485]
						addKnot shp spln  #corner #curve [-0.174128,0,1.03667] [-0.17685,0,1.03576] [-0.169329,0,1.02193]
						addKnot shp spln  #corner #curve [-0.159732,0,0.992452] [-0.16453,0,1.00719] [-0.162229,0,0.991618]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.148279,0,0.996035] [-0.145751,0,0.996772] [-0.152734,0,1.01088]
						addKnot shp spln  #corner #curve [-0.161643,0,1.04057] [-0.157188,0,1.02573] [-0.159167,0,1.0413]
						addKnot shp spln  #corner #curve [-0.154215,0,1.04275] [-0.156691,0,1.04202] [-0.15331,0,1.03957]
						addKnot shp spln  #bezierCorner #curve [-0.152405,0,1.0364] [-0.152405,0,1.0364] [-0.150231,0,1.04228]
						addKnot shp spln  #bezier #curve [-0.138932,0,1.0479] [-0.145736,0,1.04616] [-0.135977,0,1.04866]
						addKnot shp spln  #bezier #curve [-0.130413,0,1.04845] [-0.13313,0,1.04884] [-0.127699,0,1.04806]
						addKnot shp spln  #bezier #curve [-0.123954,0,1.04589] [-0.125545,0,1.04721] [-0.122364,0,1.04458]
						addKnot shp spln  #bezierCorner #curve [-0.120109,0,1.04079] [-0.121086,0,1.04288] [-0.119489,0,1.03944]
						addKnot shp spln  #bezierCorner #curve [-0.117995,0,1.03342] [-0.118785,0,1.03698] [-0.117995,0,1.03342]
						addKnot shp spln  #corner #curve [-0.111806,0,1.00554] [-0.114901,0,1.01948] [-0.114372,0,1.00495]
						addKnot shp spln  #corner #curve [-0.119505,0,1.00377] [-0.116938,0,1.00436] [-0.122779,0,1.01752]
						addKnot shp spln  #bezierCorner #curve [-0.126053,0,1.03127] [-0.126053,0,1.03127] [-0.126797,0,1.0344]
						addKnot shp spln  #bezier #curve [-0.128671,0,1.03805] [-0.127667,0,1.03666] [-0.129675,0,1.03944]
						addKnot shp spln  #bezier #curve [-0.132951,0,1.04093] [-0.131102,0,1.04041] [-0.134802,0,1.04145]
						addKnot shp spln  #bezier #curve [-0.139008,0,1.04086] [-0.136825,0,1.04143] [-0.142495,0,1.03996]
						addKnot shp spln  #bezier #curve [-0.147168,0,1.03538] [-0.145226,0,1.03813] [-0.149105,0,1.03264]
						addKnot shp spln  #bezierCorner #curve [-0.147617,0,1.02267] [-0.14924,0,1.02839] [-0.147617,0,1.02267]
						addKnot shp spln  #corner #curve [-0.140695,0,0.998247] [-0.144156,0,1.01046] [-0.143223,0,0.997509]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.0680016,0,1.0133] [-0.06519,0,1.01365] [-0.0708178,0,1.03448]
						addKnot shp spln  #corner #curve [-0.0764501,0,1.07684] [-0.0736339,0,1.05566] [-0.0732893,0,1.07723]
						addKnot shp spln  #corner #curve [-0.0669675,0,1.07802] [-0.0701284,0,1.07763] [-0.0645007,0,1.0568]
						addKnot shp spln  #corner #curve [-0.0595669,0,1.01435] [-0.0620338,0,1.03557] [-0.0623785,0,1.014]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.0456403,0,1.01578] [-0.0430156,0,1.01599] [-0.0470115,0,1.03122]
						addKnot shp spln  #corner #curve [-0.0497538,0,1.0621] [-0.0483826,0,1.04666] [-0.0471824,0,1.06231]
						addKnot shp spln  #corner #curve [-0.0420397,0,1.06273] [-0.0446111,0,1.06252] [-0.0417931,0,1.05944]
						addKnot shp spln  #bezierCorner #curve [-0.0415465,0,1.05615] [-0.0415465,0,1.05615] [-0.0382326,0,1.06146]
						addKnot shp spln  #bezier #curve [-0.0260314,0,1.0647] [-0.0330466,0,1.06436] [-0.022984,0,1.06485]
						addKnot shp spln  #bezier #curve [-0.0175766,0,1.06352] [-0.0201604,0,1.06444] [-0.0149968,0,1.06259]
						addKnot shp spln  #bezier #curve [-0.0117661,0,1.05971] [-0.0130598,0,1.06132] [-0.0104737,0,1.0581]
						addKnot shp spln  #bezierCorner #curve [-0.00902772,0,1.05394] [-0.00956469,0,1.05618] [-0.00869373,0,1.05249]
						addKnot shp spln  #bezierCorner #curve [-0.00844257,0,1.0463] [-0.00849908,0,1.04994] [-0.00844257,0,1.0463]
						addKnot shp spln  #corner #curve [-0.00799973,0,1.01774] [-0.00822115,0,1.03202] [-0.0106323,0,1.01768]
						addKnot shp spln  #corner #curve [-0.0158975,0,1.01756] [-0.0132649,0,1.01762] [-0.0163331,0,1.03169]
						addKnot shp spln  #bezierCorner #curve [-0.0167687,0,1.04581] [-0.0167687,0,1.04581] [-0.0168676,0,1.04902]
						addKnot shp spln  #bezier #curve [-0.0179669,0,1.05298] [-0.0172643,0,1.05141] [-0.0186698,0,1.05455]
						addKnot shp spln  #bezier #curve [-0.0215794,0,1.05666] [-0.0198735,0,1.05578] [-0.0232875,0,1.05754]
						addKnot shp spln  #bezier #curve [-0.027524,0,1.05782] [-0.0252724,0,1.05793] [-0.0311214,0,1.05764]
						addKnot shp spln  #bezier #curve [-0.0366217,0,1.05409] [-0.0341659,0,1.05639] [-0.0390718,0,1.0518]
						addKnot shp spln  #bezierCorner #curve [-0.0396242,0,1.04173] [-0.0400599,0,1.04767] [-0.0396242,0,1.04173]
						addKnot shp spln  #corner #curve [-0.0377662,0,1.01642] [-0.0386952,0,1.02907] [-0.0403909,0,1.0162]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.00409992,0,1.01778] [0.00673291,0,1.01774] [0.00422309,0,1.03328]
						addKnot shp spln  #corner #curve [0.00446944,0,1.06428] [0.00434627,0,1.04878] [0.00704911,0,1.06425]
						addKnot shp spln  #corner #curve [0.0122085,0,1.06417] [0.00962878,0,1.06421] [0.0121368,0,1.06087]
						addKnot shp spln  #bezierCorner #curve [0.0120652,0,1.05757] [0.0120652,0,1.05757] [0.015876,0,1.06254]
						addKnot shp spln  #bezier #curve [0.0283323,0,1.06459] [0.0213172,0,1.06493] [0.0313796,0,1.06444]
						addKnot shp spln  #bezier #curve [0.0366338,0,1.0626] [0.0341513,0,1.06377] [0.0391124,0,1.06143]
						addKnot shp spln  #bezier #curve [0.0420503,0,1.05825] [0.0409175,0,1.05997] [0.0431819,0,1.05652]
						addKnot shp spln  #bezierCorner #curve [0.0442201,0,1.05224] [0.0439012,0,1.05452] [0.0444125,0,1.05076]
						addKnot shp spln  #bezierCorner #curve [0.0440657,0,1.04458] [0.0443606,0,1.04821] [0.0440657,0,1.04458]
						addKnot shp spln  #corner #curve [0.0417542,0,1.01611] [0.04291,0,1.03034] [0.039128,0,1.0163]
						addKnot shp spln  #corner #curve [0.0338756,0,1.01669] [0.0365018,0,1.01649] [0.0348037,0,1.03079]
						addKnot shp spln  #bezierCorner #curve [0.0357319,0,1.0449] [0.0357319,0,1.0449] [0.0359426,0,1.0481]
						addKnot shp spln  #bezier #curve [0.0352296,0,1.05215] [0.0357779,0,1.05052] [0.0346811,0,1.05377]
						addKnot shp spln  #bezier #curve [0.0319887,0,1.05616] [0.0336015,0,1.05511] [0.0303737,0,1.0572]
						addKnot shp spln  #bezier #curve [0.0261836,0,1.05789] [0.0284356,0,1.05778] [0.0225856,0,1.05805]
						addKnot shp spln  #bezier #curve [0.0167691,0,1.05505] [0.0194352,0,1.0571] [0.0141093,0,1.05301]
						addKnot shp spln  #bezierCorner #curve [0.0125892,0,1.04304] [0.0127276,0,1.04899] [0.0125892,0,1.04304]
						addKnot shp spln  #corner #curve [0.0119989,0,1.01766] [0.012294,0,1.03035] [0.0093659,0,1.0177]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [0.0532115,0,1.03842] [0.0524382,0,1.03062] [0.0540595,0,1.04697]
						addKnot shp spln  #bezier #curve [0.0628112,0,1.0566] [0.0572163,0,1.05308] [0.0674945,0,1.05954]
						addKnot shp spln  #bezier #curve [0.0792084,0,1.05971] [0.0730007,0,1.06059] [0.0861098,0,1.05872]
						addKnot shp spln  #bezier #curve [0.0950228,0,1.05087] [0.091418,0,1.05574] [0.0986135,0,1.04601]
						addKnot shp spln  #bezier #curve [0.0983265,0,1.03268] [0.0996688,0,1.03992] [0.097239,0,1.0268]
						addKnot shp spln  #bezier #curve [0.0930643,0,1.01931] [0.0954699,0,1.02236] [0.0906622,0,1.01627]
						addKnot shp spln  #bezier #curve [0.0839129,0,1.0128] [0.0876162,0,1.01411] [0.08022,0,1.01149]
						addKnot shp spln  #bezier #curve [0.0723902,0,1.01169] [0.0763939,0,1.01112] [0.0659662,0,1.01259]
						addKnot shp spln  #bezier #curve [0.0574737,0,1.01987] [0.0610308,0,1.01529] [0.0539029,0,1.02447]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [0.0616308,0,1.03754] [0.0623095,0,1.04344] [0.060952,0,1.03164]
						addKnot shp spln  #bezier #curve [0.0640407,0,1.02382] [0.0617758,0,1.02708] [0.0662999,0,1.02057]
						addKnot shp spln  #bezier #curve [0.073304,0,1.01812] [0.0693703,0,1.01868] [0.0772085,0,1.01757]
						addKnot shp spln  #bezier #curve [0.0837463,0,1.02104] [0.0806694,0,1.01854] [0.086831,0,1.02356]
						addKnot shp spln  #bezier #curve [0.0899194,0,1.03379] [0.0889053,0,1.02779] [0.0908753,0,1.03944]
						addKnot shp spln  #bezier #curve [0.0879614,0,1.04732] [0.0902435,0,1.04397] [0.0856735,0,1.05069]
						addKnot shp spln  #bezier #curve [0.0782946,0,1.05327] [0.0824338,0,1.05268] [0.0740931,0,1.05387]
						addKnot shp spln  #bezier #curve [0.0672871,0,1.05028] [0.0704038,0,1.05286] [0.0641781,0,1.0477]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.115311,0,1.00475] [0.117792,0,1.00416] [0.112557,0,1.02117]
						addKnot shp spln  #corner #curve [0.107048,0,1.05402] [0.109802,0,1.0376] [0.110056,0,1.05341]
						addKnot shp spln  #corner #curve [0.116073,0,1.05219] [0.113064,0,1.0528] [0.118215,0,1.03746]
						addKnot shp spln  #bezierCorner #curve [0.120358,0,1.02273] [0.120358,0,1.02273] [0.120768,0,1.01955]
						addKnot shp spln  #bezierCorner #curve [0.121209,0,1.01291] [0.121051,0,1.01627] [0.122472,0,1.01513]
						addKnot shp spln  #bezierCorner #curve [0.126201,0,1.0208] [0.124133,0,1.01776] [0.126201,0,1.0208]
						addKnot shp spln  #corner #curve [0.143826,0,1.0456] [0.135014,0,1.0332] [0.14666,0,1.04483]
						addKnot shp spln  #corner #curve [0.152327,0,1.04328] [0.149493,0,1.04405] [0.142469,0,1.02985]
						addKnot shp spln  #corner #curve [0.122754,0,1.00299] [0.132611,0,1.01642] [0.120273,0,1.00357]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.177308,0,0.992549] [0.17678,0,0.990386] [0.173747,0,0.991183]
						addKnot shp spln  #bezier #curve [0.167614,0,0.990381] [0.17052,0,0.990467] [0.164713,0,0.990296]
						addKnot shp spln  #bezier #curve [0.158839,0,0.991691] [0.161795,0,0.990736] [0.15396,0,0.993268]
						addKnot shp spln  #bezier #curve [0.148622,0,0.998788] [0.150564,0,0.995611] [0.146675,0,1.00197]
						addKnot shp spln  #bezier #curve [0.147293,0,1.00913] [0.146212,0,1.00541] [0.147926,0,1.01132]
						addKnot shp spln  #bezier #curve [0.150584,0,1.01466] [0.149019,0,1.01316] [0.15215,0,1.01616]
						addKnot shp spln  #bezier #curve [0.15596,0,1.01778] [0.153944,0,1.0172] [0.157979,0,1.01835]
						addKnot shp spln  #bezierCorner #curve [0.162428,0,1.01848] [0.160137,0,1.01858] [0.16411,0,1.01838]
						addKnot shp spln  #bezier #curve [0.169839,0,1.01733] [0.166585,0,1.01802] [0.176477,0,1.01594]
						addKnot shp spln  #bezierCorner #curve [0.184821,0,1.01503] [0.18146,0,1.01512] [0.185216,0,1.01604]
						addKnot shp spln  #bezier #curve [0.185561,0,1.01695] [0.185462,0,1.01668] [0.186648,0,1.01997]
						addKnot shp spln  #bezier #curve [0.185584,0,1.02414] [0.186661,0,1.02237] [0.184123,0,1.02655]
						addKnot shp spln  #bezier #curve [0.177255,0,1.02984] [0.181346,0,1.02847] [0.173436,0,1.03112]
						addKnot shp spln  #bezier #curve [0.168186,0,1.03077] [0.170402,0,1.03142] [0.165973,0,1.03011]
						addKnot shp spln  #bezierCorner #curve [0.162106,0,1.02548] [0.163947,0,1.02835] [0.162106,0,1.02548]
						addKnot shp spln  #bezierCorner #curve [0.154555,0,1.0288] [0.154555,0,1.0288] [0.156203,0,1.03175]
						addKnot shp spln  #bezier #curve [0.160385,0,1.0354] [0.158142,0,1.03396] [0.162632,0,1.03684]
						addKnot shp spln  #bezier #curve [0.168982,0,1.03764] [0.165502,0,1.0376] [0.172469,0,1.03769]
						addKnot shp spln  #bezier #curve [0.180439,0,1.03563] [0.176298,0,1.03703] [0.184549,0,1.03424]
						addKnot shp spln  #bezier #curve [0.189952,0,1.03083] [0.18772,0,1.03262] [0.192181,0,1.02904]
						addKnot shp spln  #bezier #curve [0.194332,0,1.02548] [0.193638,0,1.02725] [0.195026,0,1.02372]
						addKnot shp spln  #bezierCorner #curve [0.194934,0,1.01954] [0.195223,0,1.02174] [0.194725,0,1.01819]
						addKnot shp spln  #bezierCorner #curve [0.192771,0,1.01261] [0.194003,0,1.01588] [0.192771,0,1.01261]
						addKnot shp spln  #bezierCorner #curve [0.189074,0,1.00282] [0.189074,0,1.00282] [0.186497,0,0.995992]
						addKnot shp spln  #bezier #curve [0.18463,0,0.989657] [0.185017,0,0.991603] [0.184242,0,0.987711]
						addKnot shp spln  #bezierCorner #curve [0.184428,0,0.983712] [0.184175,0,0.98573] [0.184428,0,0.983712]
						addKnot shp spln  #bezierCorner #curve [0.17684,0,0.986548] [0.17684,0,0.986548] [0.176625,0,0.988385]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.182567,0,1.00926] [0.182567,0,1.00926] [0.179358,0,1.00917]
						addKnot shp spln  #bezier #curve [0.168893,0,1.01085] [0.174808,0,1.00974] [0.165546,0,1.01148]
						addKnot shp spln  #bezier #curve [0.161609,0,1.01157] [0.163114,0,1.0117] [0.160105,0,1.01144]
						addKnot shp spln  #bezier #curve [0.157774,0,1.01011] [0.158826,0,1.01095] [0.156723,0,1.00926]
						addKnot shp spln  #bezier #curve [0.155598,0,1.00688] [0.155999,0,1.00819] [0.154983,0,1.00489]
						addKnot shp spln  #bezier #curve [0.156392,0,1.00117] [0.155254,0,1.00299] [0.157528,0,0.999356]
						addKnot shp spln  #bezier #curve [0.162541,0,0.997005] [0.159575,0,0.997978] [0.16548,0,0.99604]
						addKnot shp spln  #bezier #curve [0.171011,0,0.996247] [0.168295,0,0.995786] [0.173732,0,0.996709]
						addKnot shp spln  #bezier #curve [0.177862,0,0.999584] [0.176018,0,0.99781] [0.179284,0,1.00095]
						addKnot shp spln  #bezierCorner #curve [0.181748,0,1.0065] [0.18058,0,1.00326] [0.181748,0,1.0065]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.212238,0,0.979843] [0.210807,0,0.980225] [0.212238,0,0.979843]
						addKnot shp spln  #bezierCorner #curve [0.210332,0,0.973086] [0.210332,0,0.973086] [0.208117,0,0.973562]
						addKnot shp spln  #bezier #curve [0.204604,0,0.974844] [0.206209,0,0.97415] [0.201981,0,0.975977]
						addKnot shp spln  #bezier #curve [0.199009,0,0.978696] [0.200116,0,0.977254] [0.1979,0,0.980141]
						addKnot shp spln  #bezier #curve [0.197284,0,0.983273] [0.197324,0,0.981663] [0.197244,0,0.984884]
						addKnot shp spln  #bezierCorner #curve [0.199898,0,0.99226] [0.198112,0,0.98788] [0.199898,0,0.99226]
						addKnot shp spln  #corner #curve [0.210001,0,1.01704] [0.204949,0,1.00465] [0.208066,0,1.01782]
						addKnot shp spln  #corner #curve [0.204196,0,1.01937] [0.206131,0,1.0186] [0.204942,0,1.02126]
						addKnot shp spln  #corner #curve [0.206435,0,1.02505] [0.205689,0,1.02316] [0.208391,0,1.02426]
						addKnot shp spln  #corner #curve [0.212303,0,1.02269] [0.210347,0,1.02348] [0.213749,0,1.02624]
						addKnot shp spln  #corner #curve [0.216642,0,1.03334] [0.215196,0,1.02979] [0.219962,0,1.03366]
						addKnot shp spln  #corner #curve [0.226602,0,1.0343] [0.223282,0,1.03398] [0.224486,0,1.02933]
						addKnot shp spln  #corner #curve [0.220253,0,1.01938] [0.222369,0,1.02435] [0.222919,0,1.01822]
						addKnot shp spln  #corner #curve [0.228251,0,1.0159] [0.225585,0,1.01706] [0.227425,0,1.01405]
						addKnot shp spln  #corner #curve [0.225775,0,1.01033] [0.2266,0,1.01219] [0.223138,0,1.01148]
						addKnot shp spln  #corner #curve [0.217864,0,1.01377] [0.220501,0,1.01262] [0.212528,0,1.00123]
						addKnot shp spln  #bezierCorner #curve [0.207193,0,0.988695] [0.207193,0,0.988695] [0.206311,0,0.986623]
						addKnot shp spln  #bezier #curve [0.205884,0,0.984531] [0.205875,0,0.985235] [0.205893,0,0.983827]
						addKnot shp spln  #bezier #curve [0.206559,0,0.982571] [0.206119,0,0.983174] [0.207,0,0.981968]
						addKnot shp spln  #bezier #curve [0.208861,0,0.980953] [0.207767,0,0.98143] [0.209682,0,0.980596]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.239403,0,1.02029] [0.24204,0,1.01905] [0.240661,0,1.02302]
						addKnot shp spln  #corner #curve [0.243176,0,1.02846] [0.241919,0,1.02574] [0.245854,0,1.0272]
						addKnot shp spln  #corner #curve [0.251211,0,1.02468] [0.248533,0,1.02594] [0.249911,0,1.02198]
						addKnot shp spln  #corner #curve [0.247313,0,1.01657] [0.248612,0,1.01927] [0.244676,0,1.01781]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.216303,0,0.97027] [0.218685,0,0.969148] [0.222801,0,0.984342]
						addKnot shp spln  #corner #curve [0.235798,0,1.01249] [0.229299,0,0.998414] [0.238394,0,1.01126]
						addKnot shp spln  #corner #curve [0.243588,0,1.00882] [0.240991,0,1.01004] [0.236875,0,0.994845]
						addKnot shp spln  #corner #curve [0.223449,0,0.966903] [0.230162,0,0.980874] [0.221067,0,0.968025]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [0.242054,0,0.983665] [0.238536,0,0.976664] [0.245911,0,0.991344]
						addKnot shp spln  #bezier #curve [0.257534,0,0.997196] [0.251051,0,0.995919] [0.262961,0,0.998264]
						addKnot shp spln  #bezier #curve [0.273955,0,0.994216] [0.268476,0,0.997266] [0.280045,0,0.990824]
						addKnot shp spln  #bezier #curve [0.285549,0,0.980295] [0.283932,0,0.986138] [0.28716,0,0.974475]
						addKnot shp spln  #bezier #curve [0.28211,0,0.962128] [0.285961,0,0.968411] [0.27899,0,0.957037]
						addKnot shp spln  #bezier #curve [0.272407,0,0.95154] [0.275745,0,0.953523] [0.269073,0,0.949561]
						addKnot shp spln  #bezier #curve [0.261527,0,0.948738] [0.265455,0,0.948636] [0.25761,0,0.94884]
						addKnot shp spln  #bezier #curve [0.250373,0,0.951835] [0.253908,0,0.949873] [0.2447,0,0.954982]
						addKnot shp spln  #bezier #curve [0.239382,0,0.964822] [0.241062,0,0.959274] [0.237697,0,0.970393]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [0.249598,0,0.979825] [0.252347,0,0.985089] [0.246849,0,0.974561]
						addKnot shp spln  #bezier #curve [0.246928,0,0.966153] [0.245982,0,0.970007] [0.247872,0,0.962309]
						addKnot shp spln  #bezier #curve [0.253533,0,0.957514] [0.250061,0,0.959446] [0.256979,0,0.955597]
						addKnot shp spln  #bezier #curve [0.264329,0,0.956497] [0.260557,0,0.95526] [0.26811,0,0.957738]
						addKnot shp spln  #bezier #curve [0.274661,0,0.966181] [0.271563,0,0.960945] [0.277581,0,0.971117]
						addKnot shp spln  #bezier #curve [0.277686,0,0.979517] [0.278612,0,0.975565] [0.276757,0,0.983479]
						addKnot shp spln  #bezier #curve [0.270794,0,0.988536] [0.274448,0,0.986503] [0.267086,0,0.990599]
						addKnot shp spln  #bezier #curve [0.259446,0,0.98969] [0.263282,0,0.990984] [0.25562,0,0.988399]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.277418,0,0.93687] [0.279628,0,0.935437] [0.285753,0,0.949938]
						addKnot shp spln  #corner #curve [0.302421,0,0.976075] [0.294087,0,0.963007] [0.304587,0,0.974673]
						addKnot shp spln  #corner #curve [0.308918,0,0.971869] [0.306753,0,0.973271] [0.307106,0,0.969112]
						addKnot shp spln  #bezierCorner #curve [0.305294,0,0.966355] [0.305294,0,0.966355] [0.311163,0,0.968545]
						addKnot shp spln  #bezier #curve [0.322804,0,0.963663] [0.317041,0,0.967677] [0.325308,0,0.96192]
						addKnot shp spln  #bezier #curve [0.328782,0,0.957568] [0.3273,0,0.959878] [0.330261,0,0.955261]
						addKnot shp spln  #bezier #curve [0.331062,0,0.951006] [0.331017,0,0.953068] [0.331106,0,0.948945]
						addKnot shp spln  #bezierCorner #curve [0.329712,0,0.944766] [0.330651,0,0.946865] [0.32909,0,0.943411]
						addKnot shp spln  #bezierCorner #curve [0.32551,0,0.938351] [0.327689,0,0.941273] [0.32551,0,0.938351]
						addKnot shp spln  #corner #curve [0.308436,0,0.915456] [0.316973,0,0.926903] [0.306313,0,0.917014]
						addKnot shp spln  #corner #curve [0.302067,0,0.92013] [0.30419,0,0.918572] [0.310344,0,0.931589]
						addKnot shp spln  #bezierCorner #curve [0.31862,0,0.943049] [0.31862,0,0.943049] [0.320499,0,0.945651]
						addKnot shp spln  #bezier #curve [0.322042,0,0.949456] [0.321642,0,0.947786] [0.322442,0,0.951127]
						addKnot shp spln  #bezier #curve [0.321425,0,0.954576] [0.322239,0,0.952837] [0.320611,0,0.956318]
						addKnot shp spln  #bezier #curve [0.317424,0,0.959124] [0.319277,0,0.957839] [0.314464,0,0.961176]
						addKnot shp spln  #bezier #curve [0.307943,0,0.961722] [0.311291,0,0.962046] [0.304601,0,0.9614]
						addKnot shp spln  #bezierCorner #curve [0.298021,0,0.953761] [0.301298,0,0.95873] [0.298021,0,0.953761]
						addKnot shp spln  #corner #curve [0.284046,0,0.932571] [0.291034,0,0.943166] [0.281837,0,0.934004]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.324106,0,0.921009] [0.321799,0,0.916569] [0.324106,0,0.921009]
						addKnot shp spln  #bezierCorner #curve [0.331154,0,0.916999] [0.331154,0,0.916999] [0.329571,0,0.914297]
						addKnot shp spln  #bezier #curve [0.329602,0,0.909107] [0.329064,0,0.911668] [0.33014,0,0.90655]
						addKnot shp spln  #bezier #curve [0.334581,0,0.901804] [0.331801,0,0.904129] [0.337384,0,0.899459]
						addKnot shp spln  #bezier #curve [0.342215,0,0.8982] [0.339916,0,0.898251] [0.344519,0,0.898149]
						addKnot shp spln  #bezier #curve [0.347618,0,0.900342] [0.346321,0,0.898855] [0.348783,0,0.901677]
						addKnot shp spln  #bezier #curve [0.348578,0,0.905045] [0.349114,0,0.903247] [0.348206,0,0.906295]
						addKnot shp spln  #bezier #curve [0.343944,0,0.912477] [0.346678,0,0.908786] [0.340251,0,0.917461]
						addKnot shp spln  #bezier #curve [0.336624,0,0.92335] [0.337781,0,0.921065] [0.335465,0,0.925638]
						addKnot shp spln  #bezier #curve [0.335184,0,0.930117] [0.334982,0,0.92789] [0.335387,0,0.932347]
						addKnot shp spln  #bezier #curve [0.337572,0,0.936157] [0.336176,0,0.934361] [0.338841,0,0.93779]
						addKnot shp spln  #bezier #curve [0.34231,0,0.939751] [0.340418,0,0.938993] [0.344203,0,0.940511]
						addKnot shp spln  #bezierCorner #curve [0.348325,0,0.940606] [0.34621,0,0.940793] [0.349932,0,0.940482]
						addKnot shp spln  #bezier #curve [0.354023,0,0.93898] [0.351835,0,0.939947] [0.356213,0,0.938013]
						addKnot shp spln  #bezier #curve [0.360369,0,0.934987] [0.358333,0,0.936683] [0.363435,0,0.932433]
						addKnot shp spln  #bezier #curve [0.367358,0,0.927001] [0.365765,0,0.929762] [0.368948,0,0.924245]
						addKnot shp spln  #bezier #curve [0.369553,0,0.919432] [0.369674,0,0.921715] [0.369432,0,0.917152]
						addKnot shp spln  #bezierCorner #curve [0.366963,0,0.912131] [0.368563,0,0.914719] [0.366963,0,0.912131]
						addKnot shp spln  #bezierCorner #curve [0.360144,0,0.916806] [0.360144,0,0.916806] [0.361405,0,0.918832]
						addKnot shp spln  #bezier #curve [0.361274,0,0.923118] [0.361788,0,0.920937] [0.360759,0,0.925303]
						addKnot shp spln  #bezier #curve [0.356679,0,0.929601] [0.35923,0,0.927475] [0.353667,0,0.932111]
						addKnot shp spln  #bezier #curve [0.349069,0,0.933541] [0.351118,0,0.933415] [0.347023,0,0.933666]
						addKnot shp spln  #bezier #curve [0.344504,0,0.931852] [0.345502,0,0.933097] [0.343869,0,0.931059]
						addKnot shp spln  #bezierCorner #curve [0.343591,0,0.929068] [0.343566,0,0.930131] [0.343596,0,0.927984]
						addKnot shp spln  #bezierCorner #curve [0.344776,0,0.925421] [0.343991,0,0.926769] [0.345241,0,0.924668]
						addKnot shp spln  #bezier #curve [0.349194,0,0.919179] [0.346731,0,0.922597] [0.352747,0,0.914248]
						addKnot shp spln  #bezier #curve [0.356147,0,0.90842] [0.355042,0,0.910648] [0.357249,0,0.906196]
						addKnot shp spln  #bezier #curve [0.357443,0,0.901757] [0.35768,0,0.90397] [0.357207,0,0.899546]
						addKnot shp spln  #bezier #curve [0.354388,0,0.895454] [0.356182,0,0.897446] [0.352632,0,0.893505]
						addKnot shp spln  #bezier #curve [0.347697,0,0.891499] [0.350399,0,0.892196] [0.345,0,0.890803]
						addKnot shp spln  #bezier #curve [0.339133,0,0.891877] [0.342152,0,0.890934] [0.336121,0,0.892819]
						addKnot shp spln  #bezier #curve [0.330442,0,0.896792] [0.333236,0,0.89446] [0.325814,0,0.900655]
						addKnot shp spln  #bezier #curve [0.322089,0,0.908439] [0.323026,0,0.904505] [0.321148,0,0.912384]
						close shp spln
						shp.pos = wp1 
						shp.name=(uniqueName "Rankin") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
						
						shp.modifiers[#xform].gizmo.scale = [50,50,50]

					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
			--	wp2 = worldPoint 
			--	scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
			--	shp.modifiers[#xform].gizmo.scale = scl 
				shp.pos=worldPoint
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	),

	fn eyeControls= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp, shpR, shpL
			local vPs=#(#view_persp_user,#view_iso_user,#view_camera,#view_spot) 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						--Center
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.391231,-0.24933,0] [0.310132,-0.379191,0] [0.310919,-0.195467,0]
						addKnot shp spln  #bezier #curve [0.258,0,0] [0.258,-0.103848,0] [0.258,0.103848,0]
						addKnot shp spln  #bezierCorner #curve [0.391232,0.249331,0] [0.31092,0.195467,0] [0.310132,0.379191,0]
						addKnot shp spln  #bezier #curve [0,0.465339,0] [0.16502,0.465339,0] [-0.165021,0.465339,0]
						addKnot shp spln  #bezierCorner #curve [-0.391231,0.24933,0] [-0.310135,0.37919,0] [-0.310919,0.195467,0]
						addKnot shp spln  #bezier #curve [-0.258,0,0] [-0.258,0.103848,0] [-0.258,-0.103848,0]
						addKnot shp spln  #bezierCorner #curve [-0.391231,-0.24933,0] [-0.310919,-0.195467,0] [-0.310132,-0.379192,0]
						addKnot shp spln  #bezier #curve [0,-0.465339,0] [-0.165019,-0.465339,0] [0.16502,-0.465339,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.262936,0.159271,0] [-0.218416,0.159271,0] [-0.262936,0.219097,0]
						addKnot shp spln  #corner #curve [-0.262936,0.33875,0] [-0.262936,0.278924,0] [-0.219816,0.33875,0]
						addKnot shp spln  #corner #curve [-0.133576,0.33875,0] [-0.176696,0.33875,0] [-0.133576,0.331657,0]
						addKnot shp spln  #corner #curve [-0.133576,0.31747,0] [-0.133576,0.324564,0] [-0.168763,0.31747,0]
						addKnot shp spln  #corner #curve [-0.239136,0.31747,0] [-0.203949,0.31747,0] [-0.239136,0.299271,0]
						addKnot shp spln  #corner #curve [-0.239136,0.26287,0] [-0.239136,0.281071,0] [-0.206189,0.26287,0]
						addKnot shp spln  #corner #curve [-0.140296,0.26287,0] [-0.173243,0.26287,0] [-0.140296,0.255777,0]
						addKnot shp spln  #corner #curve [-0.140296,0.24159,0] [-0.140296,0.248684,0] [-0.173243,0.24159,0]
						addKnot shp spln  #corner #curve [-0.239136,0.24159,0] [-0.206189,0.24159,0] [-0.239136,0.221244,0]
						addKnot shp spln  #corner #curve [-0.239136,0.180551,0] [-0.239136,0.200897,0] [-0.202549,0.180551,0]
						addKnot shp spln  #corner #curve [-0.129376,0.180551,0] [-0.165963,0.180551,0] [-0.129376,0.173457,0]
						addKnot shp spln  #corner #curve [-0.129376,0.159271,0] [-0.129376,0.166364,0] [-0.173896,0.159271,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.100256,0.109304,0] [-0.0950295,0.107522,0] [-0.100256,0.109304,0]
						addKnot shp spln  #bezierCorner #curve [-0.102776,0.129866,0] [-0.102776,0.129866,0] [-0.0979549,0.128562,0]
						addKnot shp spln  #bezier #curve [-0.0901543,0.127911,0] [-0.0937476,0.127911,0] [-0.0852514,0.127911,0]
						addKnot shp spln  #bezier #curve [-0.0783877,0.130363,0] [-0.0813292,0.128728,0] [-0.0754462,0.131997,0]
						addKnot shp spln  #bezier #curve [-0.071158,0.137225,0] [-0.0730258,0.134278,0] [-0.0697617,0.139428,0]
						addKnot shp spln  #bezierCorner #curve [-0.0644161,0.153653,0] [-0.0675224,0.144909,0] [-0.0640078,0.154878,0]
						addKnot shp spln  #bezierCorner #curve [-0.0624561,0.159047,0] [-0.0633545,0.156676,0] [-0.0624561,0.159047,0]
						addKnot shp spln  #corner #curve [-0.112016,0.28947,0] [-0.0872361,0.224259,0] [-0.104135,0.28947,0]
						addKnot shp spln  #corner #curve [-0.0883736,0.28947,0] [-0.0962545,0.28947,0] [-0.0747827,0.251929,0]
						addKnot shp spln  #bezierCorner #curve [-0.0611918,0.214387,0] [-0.0611918,0.214387,0] [-0.0576655,0.204864,0]
						addKnot shp spln  #bezierCorner #curve [-0.0517199,0.184352,0] [-0.0545082,0.194852,0] [-0.0491474,0.194135,0]
						addKnot shp spln  #bezierCorner #curve [-0.0425937,0.213459,0] [-0.0461053,0.203837,0] [-0.0425937,0.213459,0]
						addKnot shp spln  #corner #curve [-0.0148562,0.28947,0] [-0.0287249,0.251465,0] [-0.00751782,0.28947,0]
						addKnot shp spln  #corner #curve [0.00715885,0.28947,0] [-0.000179489,0.28947,0] [-0.0174571,0.223229,0]
						addKnot shp spln  #bezierCorner #curve [-0.042073,0.156987,0] [-0.042073,0.156987,0] [-0.0473814,0.142762,0]
						addKnot shp spln  #bezier #curve [-0.0544455,0.127604,0] [-0.0515188,0.132975,0] [-0.0583834,0.120378,0]
						addKnot shp spln  #bezier #curve [-0.0679183,0.11169,0] [-0.0628565,0.115063,0] [-0.0729802,0.108317,0]
						addKnot shp spln  #bezier #curve [-0.0860461,0.106631,0] [-0.0790228,0.106631,0] [-0.0902928,0.106631,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.115099,0.201271,0] [0.111748,0.191998,0] [0.115099,0.201271,0]
						addKnot shp spln  #bezierCorner #curve [0.137849,0.198471,0] [0.137849,0.198471,0] [0.134258,0.185165,0]
						addKnot shp spln  #bezier #curve [0.117897,0.167491,0] [0.127608,0.174838,0] [0.108186,0.160144,0]
						addKnot shp spln  #bezier #curve [0.0806851,0.156471,0] [0.0957817,0.156471,0] [0.0616684,0.156471,0]
						addKnot shp spln  #bezier #curve [0.0354519,0.174027,0] [0.0465907,0.162323,0] [0.0243132,0.185732,0]
						addKnot shp spln  #bezier #curve [0.0187438,0.223268,0] [0.0187438,0.202146,0] [0.0187438,0.245128,0]
						addKnot shp spln  #bezier #curve [0.0356357,0.274165,0] [0.0243745,0.262094,0] [0.046897,0.286235,0]
						addKnot shp spln  #bezier #curve [0.0794601,0.29227,0] [0.0615051,0.29227,0] [0.0968434,0.29227,0]
						addKnot shp spln  #bezier #curve [0.122059,0.274504,0] [0.111043,0.286348,0] [0.133076,0.262659,0]
						addKnot shp spln  #bezier #curve [0.138584,0.224511,0] [0.138584,0.245995,0] [0.138584,0.223204,0]
						addKnot shp spln  #bezierCorner #curve [0.138461,0.218631,0] [0.138543,0.221244,0] [0.138461,0.218631,0]
						addKnot shp spln  #bezierCorner #curve [0.0414238,0.218631,0] [0.0414238,0.218631,0] [0.0422405,0.204423,0]
						addKnot shp spln  #bezier #curve [0.0535601,0.185995,0] [0.0462859,0.193545,0] [0.0608343,0.178445,0]
						addKnot shp spln  #bezier #curve [0.0807726,0.174671,0] [0.0699051,0.174671,0] [0.0888634,0.174671,0]
						addKnot shp spln  #bezier #curve [0.10149,0.181016,0] [0.0957693,0.176786,0] [0.107211,0.185247,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.0425438,0.236831,0] [0.0432818,0.248144,0] [0.0425438,0.236831,0]
						addKnot shp spln  #bezierCorner #curve [0.115344,0.236831,0] [0.115344,0.236831,0] [0.114361,0.247739,0]
						addKnot shp spln  #bezier #curve [0.106996,0.261374,0] [0.111565,0.255908,0] [0.099937,0.269821,0]
						addKnot shp spln  #bezier #curve [0.0796176,0.274071,0] [0.0908322,0.274071,0] [0.0694705,0.274071,0]
						addKnot shp spln  #bezier #curve [0.0540238,0.263936,0] [0.0609393,0.270692,0] [0.0471084,0.257179,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.156784,0.198191,0] [0.159234,0.184406,0] [0.156784,0.198191,0]
						addKnot shp spln  #bezierCorner #curve [0.178624,0.201551,0] [0.178624,0.201551,0] [0.179849,0.192873,0]
						addKnot shp spln  #bezier #curve [0.18885,0.181603,0] [0.183258,0.186224,0] [0.194443,0.176981,0]
						addKnot shp spln  #bezier #curve [0.212303,0.174671,0] [0.20226,0.174671,0] [0.222426,0.174671,0]
						addKnot shp spln  #bezier #curve [0.234836,0.180826,0] [0.229937,0.176722,0] [0.239735,0.18493,0]
						addKnot shp spln  #bezier #curve [0.242184,0.195272,0] [0.242184,0.189745,0] [0.242184,0.200231,0]
						addKnot shp spln  #bezier #curve [0.235766,0.206976,0] [0.240056,0.204149,0] [0.232787,0.208938,0]
						addKnot shp spln  #bezier #curve [0.213199,0.214413,0] [0.225254,0.211395,0] [0.196956,0.218479,0]
						addKnot shp spln  #bezier #curve [0.17947,0.225003,0] [0.185716,0.222023,0] [0.173224,0.227982,0]
						addKnot shp spln  #bezier #curve [0.165263,0.237366,0] [0.168488,0.232103,0] [0.162037,0.24263,0]
						addKnot shp spln  #bezier #curve [0.160424,0.254812,0] [0.160424,0.248445,0] [0.160424,0.260604,0]
						addKnot shp spln  #bezier #curve [0.164414,0.270907,0] [0.161754,0.265969,0] [0.167074,0.275845,0]
						addKnot shp spln  #bezierCorner #curve [0.175277,0.28321,0] [0.170695,0.279946,0] [0.178716,0.285742,0]
						addKnot shp spln  #bezier #curve [0.189334,0.289639,0] [0.183401,0.287885,0] [0.195266,0.291393,0]
						addKnot shp spln  #bezier #curve [0.208422,0.29227,0] [0.201629,0.29227,0] [0.218654,0.29227,0]
						addKnot shp spln  #bezier #curve [0.23537,0.287874,0] [0.227636,0.290805,0] [0.243103,0.284942,0]
						addKnot shp spln  #bezier #curve [0.252494,0.275965,0] [0.248811,0.280973,0] [0.256176,0.270957,0]
						addKnot shp spln  #bezierCorner #curve [0.260104,0.255871,0] [0.258713,0.264259,0] [0.260104,0.255871,0]
						addKnot shp spln  #bezierCorner #curve [0.238544,0.253071,0] [0.238544,0.253071,0] [0.237561,0.259668,0]
						addKnot shp spln  #bezier #curve [0.229995,0.268519,0] [0.234711,0.264817,0] [0.225279,0.27222,0]
						addKnot shp spln  #bezier #curve [0.210001,0.274071,0] [0.218614,0.274071,0] [0.199831,0.274071,0]
						addKnot shp spln  #bezier #curve [0.188225,0.269074,0] [0.192572,0.272405,0] [0.183877,0.265743,0]
						addKnot shp spln  #bezier #curve [0.181704,0.257376,0] [0.181704,0.261844,0] [0.181704,0.254532,0]
						addKnot shp spln  #bezierCorner #curve [0.184412,0.249697,0] [0.182607,0.251972,0] [0.186214,0.247341,0]
						addKnot shp spln  #bezierCorner #curve [0.192899,0.243844,0] [0.189044,0.245389,0] [0.195113,0.243033,0]
						addKnot shp spln  #bezier #curve [0.21246,0.238239,0] [0.201627,0.241142,0] [0.228117,0.234044,0]
						addKnot shp spln  #bezier #curve [0.245168,0.228017,0] [0.239028,0.23067,0] [0.251307,0.225364,0]
						addKnot shp spln  #bezier #curve [0.25962,0.21645,0] [0.256125,0.221509,0] [0.263116,0.211391,0]
						addKnot shp spln  #bezier #curve [0.264864,0.1976,0] [0.264864,0.205107,0] [0.264864,0.190256,0]
						addKnot shp spln  #bezier #curve [0.25843,0.176851,0] [0.262719,0.18334,0] [0.254141,0.170363,0]
						addKnot shp spln  #bezier #curve [0.239865,0.161795,0] [0.247953,0.165344,0] [0.231777,0.158245,0]
						addKnot shp spln  #bezier #curve [0.212416,0.156471,0] [0.222628,0.156471,0] [0.195505,0.156471,0]
						addKnot shp spln  #bezier #curve [0.173754,0.166992,0] [0.182618,0.159978,0] [0.164891,0.174007,0]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shp.rotation=(viewport.getTM()).rotation) 
						shp.pos = wp1 
						shp.name=(uniqueName "CNT_Eyes") 
						addModifier shp (xform()) 
						shp.wireColor = (color 0 0 100) 
						
						--Right
						shpR = splineShape() 
						select shpR 
						spln = addNewSpline shpR
						addKnot shpR spln  #bezierCorner #curve [-0.239701,0.137469,0] [-0.192204,0.222147,0] [-0.265044,0.137469,0]
						addKnot shpR spln  #corner #curve [-0.266118,0.137469,0] [-0.265581,0.137469,0] [-0.266118,0.164331,0]
						addKnot shpR spln  #corner #curve [-0.266118,0.218057,0] [-0.266118,0.191194,0] [-0.30743,0.145371,0]
						addKnot shpR spln  #corner #curve [-0.390054,0,0] [-0.348742,0.0726856,0] [-0.348742,-0.0726856,0]
						addKnot shpR spln  #corner #curve [-0.266118,-0.218057,0] [-0.30743,-0.145371,0] [-0.266118,-0.191194,0]
						addKnot shpR spln  #corner #curve [-0.266118,-0.137469,0] [-0.266118,-0.164331,0] [-0.265581,-0.137469,0]
						addKnot shpR spln  #bezierCorner #curve [-0.239701,-0.137469,0] [-0.265044,-0.137469,0] [-0.192205,-0.222147,0]
						addKnot shpR spln  #bezier #curve [0.00247353,-0.279107,0] [-0.101447,-0.279107,0] [0.156481,-0.279107,0]
						addKnot shpR spln  #bezier #curve [0.281581,0,0] [0.281581,-0.154008,0] [0.281581,0.154008,0]
						addKnot shpR spln  #bezier #curve [0.00247341,0.279107,0] [0.156481,0.279107,0] [-0.101447,0.279107,0]
						close shpR spln
						shpR.thickness=.2 
						shpR.sides=3 
						shpR.steps=3 
						shpR.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shpR.rotation=(viewport.getTM()).rotation) 
						shpR.pos = wp1 + ([-0.558,0,0])
						shpR.name=(uniqueName "CNT_Reye") 
						addModifier shpR (xform()) 
						shpR.wireColor = (color 0 100 0) 
						
						--Left
						shpL = splineShape() 
						select shpL 
						spln = addNewSpline shpL
						addKnot shpL spln  #bezierCorner #curve [0.239701,0.137469,0] [0.192204,0.222147,0] [0.265044,0.137469,0]
						addKnot shpL spln  #corner #curve [0.266118,0.137469,0] [0.265581,0.137469,0] [0.266118,0.164331,0]
						addKnot shpL spln  #corner #curve [0.266118,0.218057,0] [0.266118,0.191194,0] [0.30743,0.145371,0]
						addKnot shpL spln  #corner #curve [0.390054,0,0] [0.348742,0.0726856,0] [0.348742,-0.0726856,0]
						addKnot shpL spln  #corner #curve [0.266118,-0.218057,0] [0.30743,-0.145371,0] [0.266118,-0.191194,0]
						addKnot shpL spln  #corner #curve [0.266118,-0.137469,0] [0.266118,-0.164331,0] [0.265581,-0.137469,0]
						addKnot shpL spln  #bezierCorner #curve [0.239701,-0.137469,0] [0.265044,-0.137469,0] [0.192205,-0.222147,0]
						addKnot shpL spln  #bezier #curve [-0.00247353,-0.279107,0] [0.101447,-0.279107,0] [-0.156481,-0.279107,0]
						addKnot shpL spln  #bezier #curve [-0.281581,0,0] [-0.281581,-0.154008,0] [-0.281581,0.154008,0]
						addKnot shpL spln  #bezier #curve [-0.00247341,0.279107,0] [-0.156481,0.279107,0] [0.101447,0.279107,0]
						close shpL spln
						shpL.thickness=.2 
						shpL.sides=3 
						shpL.steps=3 
						shpL.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shpL.rotation=(viewport.getTM()).rotation) 
						shpL.pos = wp1 + ([0.558,0,0]) 
						shpL.name=(uniqueName "CNT_Leye") 
						addModifier shpL (xform()) 
						shpL.wireColor = (color 100 0 0)
						
						shpR.parent=shp
						shpL.parent=shp
						select shp
					) 
					2: 
					( 
						--Center
						converttosplineshape shp 
						updateShape shp 
						--Right
						converttosplineshape shpR 
						updateShape shpR 
						--Left
						converttosplineshape shpL 
						updateShape shpL 
	
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				--Center
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
				
				--Right
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shpR.modifiers[#xform].gizmo.scale = scl 
				shpR.pos = wp1 + (([-0.558,0,0])*(distance wp1 wp2))
				
				--Left
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shpL.modifiers[#xform].gizmo.scale = scl 
				shpL.pos = wp1 + (([0.558,0,0])*(distance wp1 wp2))
			) 
			on mouseAbort del do 
			( 
				--Center
				delete shp 
				
				--Right
				delete shpR 
	
				--Left
				delete shpL 
			) 
		) 
		startTool cnt 
	),

	fn circleArrowsCurved= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			local vPs=#(#view_persp_user,#view_iso_user,#view_camera,#view_spot) 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.259949,-0.0659588,0.376849] [0.236002,-0.158674,0.372798] [0.263737,-0.0658929,0.375957]
						addKnot shp spln  #bezierCorner #curve [0.530105,-0.119644,0.270836] [0.478984,-0.111898,0.297162] [0.579896,-0.126526,0.241956]
						addKnot shp spln  #corner #curve [0.701751,-0.140576,0.155854] [0.640823,-0.133551,0.198905] [0.701672,-0.162515,0.151588]
						addKnot shp spln  #corner #curve [0.701514,-0.206394,0.143056] [0.701593,-0.184454,0.147322] [0.758437,-0.137596,0.0960808]
						addKnot shp spln  #corner #curve [0.872284,0,0.00212939] [0.815361,-0.0687979,0.0491051] [0.815361,0.0687979,0.0491051]
						addKnot shp spln  #corner #curve [0.701514,0.206394,0.143056] [0.758437,0.137596,0.0960808] [0.701593,0.184454,0.147322]
						addKnot shp spln  #corner #curve [0.701751,0.140576,0.155854] [0.701672,0.162515,0.151588] [0.640823,0.13355,0.198905]
						addKnot shp spln  #bezierCorner #curve [0.530105,0.119642,0.270836] [0.579896,0.126525,0.241956] [0.478984,0.111895,0.297162]
						addKnot shp spln  #bezierCorner #curve [0.259949,0.0659552,0.37685] [0.263737,0.0658897,0.375957] [0.236003,0.158671,0.372798]
						addKnot shp spln  #bezierCorner #curve [0.0676692,0.258667,0.377046] [0.162294,0.233375,0.37283] [0.0676692,0.262586,0.376123]
						addKnot shp spln  #bezierCorner #curve [0.135121,0.525725,0.271176] [0.123252,0.475302,0.297572] [0.146975,0.574634,0.242204]
						addKnot shp spln  #corner #curve [0.178503,0.693075,0.155854] [0.162739,0.633855,0.199029] [0.206344,0.689638,0.151568]
						addKnot shp spln  #corner #curve [0.262025,0.682765,0.142996] [0.234184,0.686202,0.147282] [0.174683,0.745938,0.0960407]
						addKnot shp spln  #corner #curve [0,0.872284,0.00212939] [0.0873415,0.809111,0.049085] [-0.0873415,0.809111,0.049085]
						addKnot shp spln  #corner #curve [-0.262025,0.682765,0.142996] [-0.174683,0.745938,0.0960406] [-0.234184,0.686202,0.147282]
						addKnot shp spln  #corner #curve [-0.178503,0.693075,0.155854] [-0.206344,0.689638,0.151568] [-0.162739,0.633855,0.199029]
						addKnot shp spln  #bezierCorner #curve [-0.135121,0.525725,0.271176] [-0.146975,0.574634,0.242204] [-0.123252,0.475302,0.297572]
						addKnot shp spln  #bezierCorner #curve [-0.0676692,0.258667,0.377046] [-0.0676692,0.262586,0.376123] [-0.162295,0.233375,0.37283]
						addKnot shp spln  #bezierCorner #curve [-0.259949,0.0659534,0.37685] [-0.236003,0.158669,0.372799] [-0.263738,0.0658881,0.375957]
						addKnot shp spln  #bezierCorner #curve [-0.530106,0.119641,0.270836] [-0.478985,0.111893,0.297162] [-0.579897,0.126524,0.241956]
						addKnot shp spln  #corner #curve [-0.701751,0.140576,0.155854] [-0.640824,0.13355,0.198905] [-0.701698,0.16251,0.151568]
						addKnot shp spln  #corner #curve [-0.701593,0.20638,0.142996] [-0.701646,0.184445,0.147282] [-0.75849,0.137586,0.0960407]
						addKnot shp spln  #corner #curve [-0.872284,0,0.00212939] [-0.815387,0.0687932,0.049085] [-0.815387,-0.0687932,0.049085]
						addKnot shp spln  #corner #curve [-0.701593,-0.20638,0.142996] [-0.75849,-0.137586,0.0960407] [-0.701646,-0.184445,0.147282]
						addKnot shp spln  #corner #curve [-0.701751,-0.140576,0.155854] [-0.701698,-0.16251,0.151568] [-0.640823,-0.13355,0.198905]
						addKnot shp spln  #bezierCorner #curve [-0.530104,-0.119643,0.270836] [-0.579895,-0.126525,0.241956] [-0.478984,-0.111896,0.297162]
						addKnot shp spln  #bezierCorner #curve [-0.259949,-0.0659574,0.37685] [-0.263737,-0.0658917,0.375957] [-0.236002,-0.158674,0.372798]
						addKnot shp spln  #bezierCorner #curve [-0.0676692,-0.258669,0.377046] [-0.162294,-0.233378,0.37283] [-0.0676692,-0.262588,0.376123]
						addKnot shp spln  #bezierCorner #curve [-0.135121,-0.525726,0.271176] [-0.123252,-0.475303,0.297572] [-0.146975,-0.574635,0.242204]
						addKnot shp spln  #corner #curve [-0.178503,-0.693075,0.155854] [-0.162739,-0.633855,0.199029] [-0.206344,-0.689613,0.151588]
						addKnot shp spln  #corner #curve [-0.262025,-0.682688,0.143056] [-0.234184,-0.68615,0.147322] [-0.174683,-0.745887,0.0960808]
						addKnot shp spln  #corner #curve [0,-0.872284,0.00212939] [-0.0873415,-0.809085,0.0491051] [0.0873415,-0.809085,0.0491051]
						addKnot shp spln  #corner #curve [0.262025,-0.682688,0.143056] [0.174683,-0.745887,0.0960808] [0.234184,-0.68615,0.147322]
						addKnot shp spln  #corner #curve [0.178503,-0.693075,0.155854] [0.206344,-0.689613,0.151588] [0.162739,-0.633855,0.199029]
						addKnot shp spln  #bezierCorner #curve [0.135121,-0.525726,0.271176] [0.146975,-0.574635,0.242204] [0.123252,-0.475303,0.297572]
						addKnot shp spln  #bezierCorner #curve [0.0676692,-0.258669,0.377046] [0.0676692,-0.262588,0.376123] [0.162294,-0.233377,0.37283]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shp.rotation=(viewport.getTM()).rotation) 
						shp.pos = wp1 
						shp.name=(uniqueName "CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	),
	
	fn rotateCNT= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			local vPs=#(#view_persp_user,#view_iso_user,#view_camera,#view_spot) 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.921799,-0.390183,0] [0.927848,-0.377209,0] [0.871157,-0.509798,0]
						addKnot shp spln  #bezier #curve [0.70692,-0.70692,0] [0.797433,-0.616406,0] [0.525893,-0.887946,0]
						addKnot shp spln  #bezier #curve [1.31134e-007,-1,0] [0.275893,-1,0] [-0.551786,-1,0]
						addKnot shp spln  #bezier #curve [-1,0,0] [-1,-0.551786,0] [-1,0.551786,0]
						addKnot shp spln  #bezier #curve [0,1,0] [-0.551786,1,0] [0.275893,1,0]
						addKnot shp spln  #bezier #curve [0.70692,0.70692,0] [0.525893,0.887946,0] [0.797433,0.616406,0]
						addKnot shp spln  #bezierCorner #curve [0.921798,0.390137,0] [0.871157,0.509752,0] [0.927848,0.377164,0]
						addKnot shp spln  #corner #curve [0.940401,0.352319,0] [0.934125,0.364741,0] [0.965003,0.363865,0]
						addKnot shp spln  #corner #curve [1.01421,0.386957,0] [0.989604,0.375411,0] [1.00695,0.282353,0]
						addKnot shp spln  #corner #curve [0.992431,0.0731435,0] [0.999689,0.177748,0] [0.907634,0.134822,0]
						addKnot shp spln  #corner #curve [0.738039,0.258179,0] [0.822837,0.196501,0] [0.762698,0.269603,0]
						addKnot shp spln  #corner #curve [0.812015,0.292452,0] [0.787356,0.281027,0] [0.805588,0.306225,0]
						addKnot shp spln  #bezierCorner #curve [0.793111,0.332971,0] [0.799161,0.319998,0] [0.749559,0.43584,0]
						addKnot shp spln  #bezier #curve [0.607951,0.607951,0] [0.685793,0.53011,0] [0.452268,0.763634,0]
						addKnot shp spln  #bezier #curve [0,0.86,0] [0.237268,0.86,0] [-0.474536,0.86,0]
						addKnot shp spln  #bezier #curve [-0.86,0,0] [-0.86,0.474536,0] [-0.86,-0.474536,0]
						addKnot shp spln  #bezier #curve [0,-0.86,0] [-0.474536,-0.86,0] [0.237268,-0.86,0]
						addKnot shp spln  #bezier #curve [0.607951,-0.607951,0] [0.452268,-0.763634,0] [0.685793,-0.53011,0]
						addKnot shp spln  #bezierCorner #curve [0.793111,-0.333016,0] [0.749559,-0.435885,0] [0.799161,-0.320043,0]
						addKnot shp spln  #corner #curve [0.812015,-0.292542,0] [0.805588,-0.306293,0] [0.787356,-0.281118,0]
						addKnot shp spln  #corner #curve [0.738039,-0.25827,0] [0.762698,-0.269694,0] [0.822837,-0.196591,0]
						addKnot shp spln  #corner #curve [0.992431,-0.0732344,0] [0.907634,-0.134913,0] [0.999689,-0.177839,0]
						addKnot shp spln  #corner #curve [1.01421,-0.387048,0] [1.00695,-0.282444,0] [0.989604,-0.375502,0]
						addKnot shp spln  #corner #curve [0.940401,-0.35241,0] [0.965003,-0.363956,0] [0.934125,-0.36481,0]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shp.rotation=(viewport.getTM()).rotation) 
						shp.pos = wp1 
						shp.name=(uniqueName "CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	),

	fn positionCNT= 
	( 
		max Create Mode 
		tool cnt numPoints:2 
		( 
			local wp1, wp2, shp 
			local vPs=#(#view_persp_user,#view_iso_user,#view_camera,#view_spot) 
			on mousePoint clickNum do 
			( 
				case clickNum of 
				( 
					1: 
					( 
						wp1 = worldPoint 
						shp = splineShape() 
						select shp 
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.341236,0.341236,-0.341236] [0.341236,0.113745,-0.341236] [0.113745,0.341236,-0.341236]
						addKnot shp spln  #bezierCorner #curve [-0.341236,0.341236,-0.341236] [-0.113745,0.341236,-0.341236] [-0.341236,0.113745,-0.341236]
						addKnot shp spln  #bezierCorner #curve [-0.341236,-0.341236,-0.341236] [-0.341236,-0.113745,-0.341236] [-0.113745,-0.341236,-0.341236]
						addKnot shp spln  #bezierCorner #curve [0.341236,-0.341236,-0.341236] [0.113745,-0.341236,-0.341236] [0.341236,-0.113745,-0.341236]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.341236,-0.341236,-0.341236] [0.113745,-0.341236,-0.341236] [0.341236,-0.341236,-0.113745]
						addKnot shp spln  #bezierCorner #curve [0.341236,-0.341236,0.341236] [0.341236,-0.341236,0.113745] [0.113745,-0.341236,0.341236]
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.341236,-0.341236,0.341236] [-0.113745,-0.341236,0.341236] [-0.341236,-0.341236,0.113745]
						addKnot shp spln  #bezierCorner #curve [-0.341236,-0.341236,-0.341236] [-0.341236,-0.341236,-0.113745] [-0.113745,-0.341236,-0.341236]
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.341236,0.341236,0.341236] [0.341236,0.113745,0.341236] [0.113745,0.341236,0.341236]
						addKnot shp spln  #bezierCorner #curve [-0.341236,0.341236,0.341236] [-0.113745,0.341236,0.341236] [-0.341236,0.113745,0.341236]
						addKnot shp spln  #bezierCorner #curve [-0.341236,-0.341236,0.341236] [-0.341236,-0.113745,0.341236] [-0.113745,-0.341236,0.341236]
						addKnot shp spln  #bezierCorner #curve [0.341236,-0.341236,0.341236] [0.113745,-0.341236,0.341236] [0.341236,-0.113745,0.341236]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [0.341236,0.341236,-0.341236] [0.113745,0.341236,-0.341236] [0.341236,0.341236,-0.113745]
						addKnot shp spln  #bezierCorner #curve [0.341236,0.341236,0.341236] [0.341236,0.341236,0.113745] [0.113745,0.341236,0.341236]
						spln = addNewSpline shp
						addKnot shp spln  #bezierCorner #curve [-0.341236,0.341236,0.341236] [-0.113745,0.341236,0.341236] [-0.341236,0.341236,0.113745]
						addKnot shp spln  #bezierCorner #curve [-0.341236,0.341236,-0.341236] [-0.341236,0.341236,-0.113745] [-0.113745,0.341236,-0.341236]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-7.82597e-005,0,0] [-7.82597e-005,0,0] [-7.8286e-005,0.161036,0]
						addKnot shp spln  #corner #curve [-7.83384e-005,0.483109,0] [-7.83122e-005,0.322073,0] [-7.83384e-005,0.483109,0]
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [1.21132e-005,0.776032,-0.0760571] [0.0419794,0.776032,-0.0760571] [-0.0419551,0.776032,-0.0760571]
						addKnot shp spln  #bezier #curve [-0.076045,0.776032,0] [-0.076045,0.776032,-0.0419673] [-0.076045,0.776032,0.0419673]
						addKnot shp spln  #bezier #curve [1.21132e-005,0.776032,0.0760571] [-0.0419551,0.776032,0.0760571] [0.0419794,0.776032,0.0760571]
						addKnot shp spln  #bezier #curve [0.0760692,0.776032,0] [0.0760692,0.776032,0.0419673] [0.0760692,0.776032,-0.0419673]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.000138595,0.776463,-0.0764409] [0.000138595,0.776463,-0.0764409] [0.000168745,0.850976,-0.0510631]
						addKnot shp spln  #corner #curve [0.000229044,1,-0.000307506] [0.000198894,0.925488,-0.0256853] [0.000198894,0.925238,0.0252753]
						addKnot shp spln  #corner #curve [0.000138595,0.775713,0.0764409] [0.000168745,0.850475,0.0508581] [0.000138595,0.775713,0.0764409]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.0763023,0.776463,0] [-0.0763023,0.776463,0] [-0.0508943,0.850976,0]
						addKnot shp spln  #corner #curve [-7.84227e-005,1,0] [-0.0254864,0.925488,0] [0.0254742,0.925238,0]
						addKnot shp spln  #corner #curve [0.0765795,0.775713,0] [0.0510269,0.850475,0] [0.0765795,0.775713,0]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0,7.82597e-005,0] [0,7.82597e-005,0] [0,7.82597e-005,0.161587]
						addKnot shp spln  #corner #curve [1.52454e-007,7.82597e-005,0.48476] [0,7.82597e-005,0.323173] [1.52454e-007,7.82597e-005,0.48476]
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [0.0760574,-1.22396e-005,0.776032] [0.0760574,-0.0419795,0.776032] [0.0760574,0.041955,0.776032]
						addKnot shp spln  #bezier #curve [2.41422e-007,0.0760449,0.776032] [0.0419675,0.0760449,0.776032] [-0.041967,0.0760449,0.776032]
						addKnot shp spln  #bezier #curve [-0.0760569,-1.22396e-005,0.776032] [-0.0760569,0.041955,0.776032] [-0.0760569,-0.0419795,0.776032]
						addKnot shp spln  #bezier #curve [2.5472e-007,-0.0760693,0.776032] [-0.041967,-0.0760693,0.776032] [0.0419675,-0.0760693,0.776032]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.0764411,-0.000138721,0.776463] [0.0764411,-0.000138721,0.776463] [0.0510634,-0.000168883,0.850976]
						addKnot shp spln  #corner #curve [0.00030782,-0.000229207,1] [0.0256856,-0.000199045,0.925488] [-0.025275,-0.000199045,0.925238]
						addKnot shp spln  #corner #curve [-0.0764407,-0.000138721,0.775713] [-0.0508578,-0.000168883,0.850475] [-0.0764407,-0.000138721,0.775713]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [2.44882e-007,0.0763022,0.776463] [2.44882e-007,0.0763022,0.776463] [2.67987e-007,0.0508942,0.850976]
						addKnot shp spln  #corner #curve [3.14196e-007,7.82597e-005,1] [2.91092e-007,0.0254862,0.925488] [2.91013e-007,-0.0254744,0.925238]
						addKnot shp spln  #corner #curve [2.44646e-007,-0.0765796,0.775713] [2.6783e-007,-0.051027,0.850475] [2.44646e-007,-0.0765796,0.775713]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0,7.82597e-005,0] [0,7.82597e-005,0] [0.162772,7.82597e-005,0]
						addKnot shp spln  #corner #curve [0.488317,7.82597e-005,0] [0.325545,7.82597e-005,0] [0.488317,7.82597e-005,0]
						spln = addNewSpline shp
						addKnot shp spln  #bezier #curve [0.776032,-1.22396e-005,-0.0760571] [0.776032,-0.0419795,-0.0760571] [0.776032,0.041955,-0.0760571]
						addKnot shp spln  #bezier #curve [0.776032,0.0760449,0] [0.776032,0.0760449,-0.0419673] [0.776032,0.0760449,0.0419673]
						addKnot shp spln  #bezier #curve [0.776032,-1.22396e-005,0.0760571] [0.776032,0.041955,0.0760571] [0.776032,-0.0419795,0.0760571]
						addKnot shp spln  #bezier #curve [0.776032,-0.0760693,0] [0.776032,-0.0760693,0.0419673] [0.776032,-0.0760693,-0.0419673]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.776463,-0.000138721,-0.0764409] [0.776463,-0.000138721,-0.0764409] [0.850976,-0.000168883,-0.0510631]
						addKnot shp spln  #corner #curve [1,-0.000229207,-0.000307506] [0.925488,-0.000199045,-0.0256853] [0.925238,-0.000199045,0.0252753]
						addKnot shp spln  #corner #curve [0.775713,-0.000138721,0.0764409] [0.850475,-0.000168883,0.0508581] [0.775713,-0.000138721,0.0764409]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.776463,0.0763022,0] [0.776463,0.0763022,0] [0.850976,0.0508942,0]
						addKnot shp spln  #corner #curve [1,7.82597e-005,0] [0.925488,0.0254862,0] [0.925238,-0.0254744,0]
						addKnot shp spln  #corner #curve [0.775713,-0.0765796,0] [0.850475,-0.051027,0] [0.775713,-0.0765796,0]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [2.01774e-007,7.82597e-005,0.641872] [2.01774e-007,7.82597e-005,0.641872] [2.39248e-007,7.82597e-005,0.761248]
						addKnot shp spln  #corner #curve [3.14196e-007,7.82597e-005,1] [2.76722e-007,7.82597e-005,0.880624] [3.14196e-007,7.82597e-005,1]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-7.83635e-005,0.636843,0] [-7.83635e-005,0.636843,0] [-7.83832e-005,0.757895,0]
						addKnot shp spln  #corner #curve [-7.84227e-005,1,0] [-7.84029e-005,0.878948,0] [-7.84227e-005,1,0]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.640362,7.82597e-005,0] [0.640362,7.82597e-005,0] [0.760241,7.82597e-005,0]
						addKnot shp spln  #corner #curve [1,7.82597e-005,0] [0.880121,7.82597e-005,0] [1,7.82597e-005,0]
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [0.5,0.0586,0] [0.5,0.0518083,0] [0.522176,0.042174,0]
						addKnot shp spln  #corner #curve [0.566528,0.00932187,0] [0.544352,0.0257479,0] [0.587085,0.0238812,0]
						addKnot shp spln  #corner #curve [0.6282,0.053,0] [0.607643,0.0384406,0] [0.6282,0.0463125,0]
						addKnot shp spln  #corner #curve [0.6282,0.0329375,0] [0.6282,0.039625,0] [0.611659,0.0211266,0]
						addKnot shp spln  #bezierCorner #curve [0.595119,0.00931562,0] [0.595119,0.00931562,0] [0.588317,0.00445937,0]
						addKnot shp spln  #bezierCorner #curve [0.579844,-0.000790629,0] [0.583225,0.00109062,0] [0.584458,-0.00371147,0]
						addKnot shp spln  #bezierCorner #curve [0.594356,-0.0110438,0] [0.589296,-0.00712917,0] [0.594356,-0.0110438,0]
						addKnot shp spln  #corner #curve [0.6282,-0.0363594,0] [0.611278,-0.0237016,0] [0.6282,-0.0425729,0]
						addKnot shp spln  #corner #curve [0.6282,-0.055,0] [0.6282,-0.0487865,0] [0.607861,-0.0402094,0]
						addKnot shp spln  #corner #curve [0.567184,-0.0106281,0] [0.587523,-0.0254188,0] [0.54479,-0.0266188,0]
						addKnot shp spln  #corner #curve [0.5,-0.0586,0] [0.522395,-0.0426094,0] [0.5,-0.0516667,0]
						addKnot shp spln  #corner #curve [0.5,-0.0378,0] [0.5,-0.0447333,0] [0.522758,-0.0216813,0]
						addKnot shp spln  #bezierCorner #curve [0.545516,-0.00556251,0] [0.545516,-0.00556251,0] [0.548111,-0.00372292,0]
						addKnot shp spln  #bezierCorner #curve [0.553472,-0.000168754,0] [0.550764,-0.001925,0] [0.549284,0.00255,0]
						addKnot shp spln  #bezierCorner #curve [0.544603,0.0057875,0] [0.546328,0.00453541,0] [0.544603,0.0057875,0]
						addKnot shp spln  #corner #curve [0.5,0.038225,0] [0.522302,0.0220062,0] [0.5,0.0450167,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.0094,0.5,0] [-0.00373333,0.5,0] [-0.0094,0.518102,0]
						addKnot shp spln  #corner #curve [-0.0094,0.554306,0] [-0.0094,0.536204,0] [-0.0258667,0.578938,0]
						addKnot shp spln  #corner #curve [-0.0588,0.6282,0] [-0.0423333,0.603569,0] [-0.0519969,0.6282,0]
						addKnot shp spln  #corner #curve [-0.0383906,0.6282,0] [-0.0451938,0.6282,0] [-0.0256922,0.608819,0]
						addKnot shp spln  #bezierCorner #curve [-0.0129938,0.589438,0] [-0.0129938,0.589438,0] [-0.00837708,0.582183,0]
						addKnot shp spln  #bezierCorner #curve [9.06251e-005,0.567762,0] [-0.00401562,0.574958,0] [0.00395937,0.574506,0]
						addKnot shp spln  #bezierCorner #curve [0.0142062,0.5904,0] [0.00866459,0.582052,0] [0.0142062,0.5904,0]
						addKnot shp spln  #corner #curve [0.0390438,0.6282,0] [0.026625,0.6093,0] [0.0456292,0.6282,0]
						addKnot shp spln  #corner #curve [0.0588,0.6282,0] [0.0522146,0.6282,0] [0.0417333,0.603569,0]
						addKnot shp spln  #corner #curve [0.0076,0.554306,0] [0.0246667,0.578938,0] [0.0076,0.536204,0]
						addKnot shp spln  #corner #curve [0.0076,0.5,0] [0.0076,0.518102,0] [0.00193333,0.5,0]
						close shp spln
						spln = addNewSpline shp
						addKnot shp spln  #corner #curve [-0.0507,0,0.5] [-0.0169,0,0.5] [-0.0507,0,0.505271]
						addKnot shp spln  #corner #curve [-0.0507,0,0.515813] [-0.0507,0,0.510542] [-0.0178266,0,0.556758]
						addKnot shp spln  #bezierCorner #curve [0.0150469,0,0.597703] [0.0150469,0,0.597703] [0.019649,0,0.603578]
						addKnot shp spln  #bezierCorner #curve [0.0282406,0,0.613] [0.0240469,0,0.608677] [0.0282406,0,0.613]
						addKnot shp spln  #corner #curve [-0.0433,0,0.613] [-0.00752969,0,0.613] [-0.0433,0,0.618067]
						addKnot shp spln  #corner #curve [-0.0433,0,0.6282] [-0.0433,0,0.623133] [-0.0127,0,0.6282]
						addKnot shp spln  #corner #curve [0.0485,0,0.6282] [0.0179,0,0.6282] [0.0485,0,0.623133]
						addKnot shp spln  #corner #curve [0.0485,0,0.613] [0.0485,0,0.618067] [0.0244729,0,0.58341]
						addKnot shp spln  #corner #curve [-0.0235813,0,0.524231] [0.000445829,0,0.553821] [-0.0261208,0,0.521221]
						addKnot shp spln  #corner #curve [-0.0312,0,0.5152] [-0.0286604,0,0.51821] [-0.0039,0,0.5152]
						addKnot shp spln  #corner #curve [0.0507,0,0.5152] [0.0234,0,0.5152] [0.0507,0,0.510133]
						addKnot shp spln  #corner #curve [0.0507,0,0.5] [0.0507,0,0.505067] [0.0169,0,0.5]
						close shp spln
						shp.thickness=.2 
						shp.sides=3 
						shp.steps=3 
						shp.displayRenderMesh=false 
						isVP=findItem vPs (viewport.getType()) 
						if isVp == 0 do (shp.rotation=(viewport.getTM()).rotation) 
						shp.pos = wp1 
						shp.name=(uniqueName "CNT") 
						addModifier shp (xform()) 
						shp.wireColor = [255,234,0] 
					) 
					2: 
					( 
						converttosplineshape shp 
						updateShape shp 
					) 
				) 
			) 
			on mouseMove moveIt do 
			( 
				wp2 = worldPoint 
				scl = [(distance wp1 wp2),(distance wp1 wp2),(distance wp1 wp2)] 
				shp.modifiers[#xform].gizmo.scale = scl 
			) 
			on mouseAbort del do 
			( 
				delete shp 
			) 
		) 
		startTool cnt 
	) 
		 
	
	

)