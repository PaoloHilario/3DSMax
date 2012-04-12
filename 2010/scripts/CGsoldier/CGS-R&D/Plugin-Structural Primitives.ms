plugin simpleObject IBeam
name:"I-Beam"
classID:#(0x19358a29, 0x7e5ea46)
category:"Structural"

( 
local box1, box2

parameters main rollout:params
	(
	length type:#worldUnits ui:length default:1E-3
	width type:#worldUnits ui:width default:1E-3
	height type:#worldUnits ui:height default:1E-3
	od type:#worldUnits ui:height default:1E-3
	)

rollout params "SquareTube"
	(
	DropDownList dd1 "Type:" items:#("W28", "W38")
	spinner width "Width:" type:#worldUnits range:[1E-3,1E9,1E-3]
	spinner length "Length:" type:#worldUnits range:[-1E9,1E9,1E-3]
	spinner Height "Height:" type:#worldUnits range:[-1E9,1E9,1E-3]
	spinner od "OD:" type:#worldUnits range:[-1E9,1E9,1E-3]
	)

on buildMesh do
	(
	if box1 == undefined then
	(box1 = createInstance box; box2 = createInstance box)
	box1.height = height; box2.height = height
	box1.width = width; box2.width = width * 2
	box1.length = length; box2.length = length * 2
	mesh = box2.mesh - box1.mesh
	)

tool create
	(
	on mousePoint click do
		case click of
		(
		1: nodeTM.translation = gridPoint
		3: #stop
		)

	on mouseMove click do
		case click of
		(
		2: (width = abs gridDist.x; length = abs gridDist.y)
		3: height = gridDist.z
		)
	)
)

