--PolyBoost Macroscripts----------------------------

Macroscript PolyBoost
category: "PolyBoost"
tooltip: "PolyBoost"
icon:#("PB_Icons1", 1)
(
filein ((GetDir #Scripts) + "\PolyBoost\PolyBoost.mse")
)

Macroscript Loop
category: "PolyBoost"
tooltip: "Loop"
icon:#("PB_Icons1", 2)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript Ring
category: "PolyBoost"
tooltip: "Ring"
icon:#("PB_Icons1", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRing $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript GrowLoop
category: "PolyBoost"
tooltip: "Growloop"
icon:#("PB_Icons1", 4)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBGrowLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript GrowRing
category: "PolyBoost"
tooltip: "GrowRing"
icon:#("PB_Icons1", 5)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBGrowShrinkRing $ keyboard.altpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript ShrinkLoop
category: "PolyBoost"
tooltip: "ShrinkLoop"
icon:#("PB_Icons1", 6)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBShrinkLoop $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript Outline
category: "PolyBoost"
tooltip: "Outline"
icon:#("PB_Icons1", 27)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBOutline $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript Tops
category: "PolyBoost"
tooltip: "Tops"
icon:#("PB_Icons1", 7)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBSelectTops $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript Similar
category: "PolyBoost"
tooltip: "Similar"
icon:#("PB_Icons1", 8)
(
on execute do PolyBoost.Simifunc()
)

Macroscript SimilarQuick
category: "PolyBoost"
tooltip: "SimilarQuick"
icon:#("PB_Icons1", 8)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.SimiQfunc()
)

Macroscript SharpEdges
category: "PolyBoost"
tooltip: "SharpEdges"
icon:#("PB_Icons1", 9)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	if subobjectLevel == 2 do PolyBGetHardEdges $ (keyboard.shiftpressed) (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript InsertLoop
category: "PolyBoost"
tooltip: "InsertLoop"
icon:#("PB_Icons1", 16)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Insloopfunc()
)

Macroscript RemoveLoop
category: "PolyBoost"
tooltip: "RemoveLoop"
icon:#("PB_Icons1", 17)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBRemoveLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript Smooth
category: "PolyBoost"
tooltip: "Smooth"
icon:#("PB_Icons1", 18)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Smoothfunc()
)

Macroscript Hard
category: "PolyBoost"
tooltip: "Hard"
icon:#("PB_Icons1", 19)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Hardfunc()
)

Macroscript SmoothThirty
category: "PolyBoost"
tooltip: "SmoothThirty"
icon:#("PB_Icons1", 20)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Thirtyfunc()
)

Macroscript Random
category: "PolyBoost"
tooltip: "Random"
icon:#("PB_Icons1", 21)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRandomSelect $ 25.0 0 1 keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript RandomDialog
category: "PolyBoost"
tooltip: "RandomDialog"
icon:#("PB_Icons1", 21)
(
on execute do PolyBoost.RandDfunc()
)

Macroscript RandomGrow
category: "PolyBoost"
tooltip: "RandomGrow"
icon:#("PB_Icons1", 23)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRandomGrowShrink $ true (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript RandomShrink
category: "PolyBoost"
tooltip: "RandomShrink"
icon:#("PB_Icons1", 24)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBRandomGrowShrink $ false (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript Pattern1
category: "PolyBoost"
tooltip: "Pattern1"
icon:#("PB_Icons1", 25)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern1 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Pattern2
category: "PolyBoost"
tooltip: "Pattern2"
icon:#("PB_Icons1", 26)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern2 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Pattern3
category: "PolyBoost"
tooltip: "Pattern3"
icon:#("PB_Icons2", 1)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern3 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Pattern4
category: "PolyBoost"
tooltip: "Pattern4"
icon:#("PB_Icons2", 2)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern4 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Pattern5
category: "PolyBoost"
tooltip: "Pattern5"
icon:#("PB_Icons2", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern5 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Pattern6
category: "PolyBoost"
tooltip: "Pattern6"
icon:#("PB_Icons2", 4)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern6 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Pattern7
category: "PolyBoost"
tooltip: "Pattern7"
icon:#("PB_Icons2", 5)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern7 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Pattern8
category: "PolyBoost"
tooltip: "Pattern8"
icon:#("PB_Icons2", 6)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPattern8 $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript GrowLine
category: "PolyBoost"
tooltip: "GrowLine"
icon:#("PB_Icons2", 7)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternGrowline $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Checker
category: "PolyBoost"
tooltip: "Checker"
icon:#("PB_Icons2", 8)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternChecker $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript OneRing
category: "PolyBoost"
tooltip: "OneRing"
icon:#("PB_Icons2", 9)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternOnering $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Dots
category: "PolyBoost"
tooltip: "Dots"
icon:#("PB_Icons2", 10)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBPatternDots $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
	redrawviews()
	)
)

Macroscript Store
category: "PolyBoost"
tooltip: "Store"
icon:#("PB_Icons2", 11)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Storefunc()
)

Macroscript Paste
category: "PolyBoost"
tooltip: "Paste"
icon:#("PB_Icons2", 12)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Pastefunc()
)

Macroscript SelectionToMap
category: "PolyBoost"
tooltip: "SelectionToMap"
icon:#("PB_Icons2", 13)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do
	(
	if keyboard.shiftpressed then PolyBSelToBitmap $ 512 512 1 0
	else PolyBSelToBitmap $ 256 256 1 0
	)
)

Macroscript Even
category: "PolyBoost"
tooltip: "Even"
icon:#("PB_Icons2", 14)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBEvenOdd $ 0 1 keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript Odd
category: "PolyBoost"
tooltip: "Odd"
icon:#("PB_Icons2", 15)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBEvenOdd $ 1 1 keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript PerspectiveSelect
category: "PolyBoost"
tooltip: "PerspectiveSelect"
icon:#("PB_Icons2", 16)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	if subobjectlevel == 2 or subobjectlevel == 3 then
		(
		PolyBPerspectiveSelect $ 30.0 (Inverse(getViewTM())).row3 true keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
		)
	else PolyBPerspectiveSelect $ 30.0 (Inverse(getViewTM())).row3 false keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript LoopMode_toggle
category: "PolyBoost"
tooltip: "LoopMode_toggle"
icon:#("PB_Icons2", 17)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.ModeLoopRing 1
)

Macroscript RingMode_toggle
category: "PolyBoost"
tooltip: "RingMode_toggle"
icon:#("PB_Icons2", 18)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.ModeLoopRing 2
)

Macroscript StepMode_toggle
category: "PolyBoost"
tooltip: "StepMode_toggle"
icon:#("PB_Icons2", 19)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Stepfunc()
)

Macroscript DottedLoop
category: "PolyBoost"
tooltip: "DottedLoop"
icon:#("PB_Icons2", 20)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PolyBDotLoop $ 1 keyboard.shiftpressed keyboard.altpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript BuildLoopEnd
category: "PolyBoost"
tooltip: "BuildLoopEnd"
icon:#("PB_Icons2", 21)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildEnd $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript BuildLoopCorner
category: "PolyBoost"
tooltip: "BuildLoopCorner"
icon:#("PB_Icons2", 22)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildCorner $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript CornerLoop
category: "PolyBoost"
tooltip: "CornerLoop"
icon:#("PB_Icons2", 23)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildCornerLoop $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript EndedDoubleLoop
category: "PolyBoost"
tooltip: "EndedDoubleLoop"
icon:#("PB_Icons2", 24)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBBuildEndLoops $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript DistanceConnect
category: "PolyBoost"
tooltip: "DistanceConnect"
icon:#("PB_Icons2", 25)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBDistanceConnect $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript Fill
category: "PolyBoost"
tooltip: "Fill"
icon:#("PB_Icons2", 26)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBSelectFill $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript FillHole
category: "PolyBoost"
tooltip: "FillHole"
icon:#("PB_Icons3", 1)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBSelectFillHole $ (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript RandomConnect
category: "PolyBoost"
tooltip: "RandomConnect"
icon:#("PB_Icons3", 2)
(
on execute do PolyBoost.Randconfunc()
)

Macroscript FlowConnect
category: "PolyBoost"
tooltip: "FlowConnect"
icon:#("PB_Icons3", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Flowfunc true
)

Macroscript LoopTools
category: "PolyBoost"
tooltip: "Loop Tools"
icon:#("PB_Icons3", 4)
(
on execute do PolyBoost.FlowDfunc()
)

Macroscript PaintConnect_toggle
category: "PolyBoost"
tooltip: "PaintConnect_toggle"
icon:#("PB_Icons3", 5)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.PaintCgofunc()
)

Macroscript AdjustLoops
category: "PolyBoost"
tooltip: "AdjustLoops"
icon:#("PB_Icons3", 6)
(
on execute do PolyBoost.FlowDfunc()
)

Macroscript UV_SelectionToBase
category: "PolyBoost"
tooltip: "UV_SelectionToBase"
icon:#("PB_Icons3", 7)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_ToBasefunc()
)

Macroscript UV_SelectionFromBase
category: "PolyBoost"
tooltip: "UV_SelectionFromBase"
icon:#("PB_Icons3", 8)
(
on isEnabled return PolyBoost.validUVobj2func()
on execute do PolyBoost.UV_ToUvfunc()
)

Macroscript UV_Loop
category: "PolyBoost"
tooltip: "UV_Loop"
icon:#("PB_Icons3", 9)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_Loopfunc()
)

Macroscript UV_Ring
category: "PolyBoost"
tooltip: "UV_Ring"
icon:#("PB_Icons3", 10)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_Ringfunc()
)

Macroscript UV_GrowLoop
category: "PolyBoost"
tooltip: "UV_GrowLoop"
icon:#("PB_Icons3", 11)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_GLoopfunc()
)

Macroscript UV_ShrinkLoop
category: "PolyBoost"
tooltip: "UV_ShrinkLoop"
icon:#("PB_Icons3", 12)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_ShLoopfunc()
)

Macroscript UV_GrowRing
category: "PolyBoost"
tooltip: "UV_GrowRing"
icon:#("PB_Icons3", 13)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_GRingfunc()
)

Macroscript RotateCW
category: "PolyBoost"
tooltip: "RotateCW"
icon:#("PB_Icons3", 17)
(
on isEnabled return (selection.count == 1)
on execute do 
	(
	if keyboard.shiftpressed then PolyBoost.SmartRotate 30
	else PolyBoost.SmartRotate 90
	)
)

Macroscript RotateCCW
category: "PolyBoost"
tooltip: "RotateCCW"
icon:#("PB_Icons3", 18)
(
on isEnabled return (selection.count == 1)
on execute do
	(
	if keyboard.shiftpressed then PolyBoost.SmartRotate -30
	else PolyBoost.SmartRotate -90
	)
)

Macroscript ResetXForm
category: "PolyBoost"
tooltip: "ResetXForm"
icon:#("PB_Icons3", 19)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do PolyBoost.Resetxfunc $
)

Macroscript GetSize
category: "PolyBoost"
tooltip: "GetSize"
icon:#("PB_Icons3", 20)
(
on isEnabled return (selection.count == 1)
on execute do PolyBoost.GetSizefunc()
)

Macroscript CenterPivot
category: "PolyBoost"
tooltip: "CenterPivot"
icon:#("PB_Icons3", 22)
(
on isEnabled return (selection.count != 0)
on execute do (for i in selection do i.pivot = i.center)
)

Macroscript PivotToOrigo
category: "PolyBoost"
tooltip: "PivotToOrigo"
icon:#("PB_Icons3", 23)
(
on isEnabled return (selection.count != 0)
on execute do (for i in selection do i.pivot = [0,0,0])
)

Macroscript ObjectToCenter
category: "PolyBoost"
tooltip: "ObjectToCenter"
icon:#("PB_Icons3", 24)
(
on isEnabled return (selection.count != 0)
on execute do (for i in selection do i.pos = [0,0,0])
)

Macroscript Help
category: "PolyBoost"
tooltip: "PolyBoostHelp"
icon:#("PB_Icons3", 25)
(
PB_helpfile = (GetDir #Scripts) + "\\PolyBoost\\Help\\PolyBoost.chm"
shellLaunch PB_helpfile ""
)

Macroscript Quickclone
category: "PolyBoost"
tooltip: "Quickclone"
icon:#("PB_Icons3", 26)
(
on isEnabled return (selection.count == 1)
on execute do
	(
	if keyboard.altpressed do PolyBoost.Clonefunc()
	PolyBoost.Clonefunc()
	)
)

Macroscript Topology
category: "PolyBoost"
tooltip: "Topology_interface"
icon:#("PB_Icons4", 1)
(
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.interface()
	)
)

Macroscript TopoWall
category: "PolyBoost"
tooltip: "TopoWall"
icon:#("PB_Icons4", 2)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.dobrick()
	)
)

Macroscript TopoTiles
category: "PolyBoost"
tooltip: "TopoTiles"
icon:#("PB_Icons4", 3)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.twomos()
	)
)

Macroscript TopoTiles2
category: "PolyBoost"
tooltip: "TopoTiles2"
icon:#("PB_Icons4", 4)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.tile2()
	)
)

Macroscript TopoBrick
category: "PolyBoost"
tooltip: "TopoBrick"
icon:#("PB_Icons4", 5)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.Bricksfunc()
	)
)

Macroscript TopoHive
category: "PolyBoost"
tooltip: "TopoHive"
icon:#("PB_Icons4", 6)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.hive()
	)
)

Macroscript TopoMosaic
category: "PolyBoost"
tooltip: "TopoMosiac"
icon:#("PB_Icons4", 7)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.mos()
	)
)

Macroscript TopoFloor
category: "PolyBoost"
tooltip: "TopoFloor"
icon:#("PB_Icons4", 8)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.floor()
	)
)

Macroscript TopoFloor2
category: "PolyBoost"
tooltip: "TopoFloor2"
icon:#("PB_Icons4", 9)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.floor2()
	)
)

Macroscript TopoSkin
category: "PolyBoost"
tooltip: "TopoSkin"
icon:#("PB_Icons4", 10)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.skin()
	)
)

Macroscript TopoHoler
category: "PolyBoost"
tooltip: "TopoHoler"
icon:#("PB_Icons4", 11)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.holer()
	)
)

Macroscript TopoEdgedir
category: "PolyBoost"
tooltip: "TopoEdgedir"
icon:#("PB_Icons4", 12)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.Edgedir()
	)
)

Macroscript TopoSimplify
category: "PolyBoost"
tooltip: "TopoSimplify"
icon:#("PB_Icons4", 13)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.Simplify()
	)
)

Macroscript TopoChaos
category: "PolyBoost"
tooltip: "TopoChaos"
icon:#("PB_Icons4", 14)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.chaos()
	)
)

Macroscript TopoFours
category: "PolyBoost"
tooltip: "TopoFours"
icon:#("PB_Icons4", 15)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.brick4()
	)
)

Macroscript TopoStars
category: "PolyBoost"
tooltip: "TopoStars"
icon:#("PB_Icons4", 16)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.star()
	)
)

Macroscript TopoCross
category: "PolyBoost"
tooltip: "TopoCross"
icon:#("PB_Icons4", 17)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.cross()
	)
)

Macroscript TopoPlanks
category: "PolyBoost"
tooltip: "TopoPlanks"
icon:#("PB_Icons4", 18)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.planks()
	)
)

Macroscript TopoPlanks2
category: "PolyBoost"
tooltip: "TopoPlanks2"
icon:#("PB_Icons4", 19)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.planks2()
	)
)

Macroscript TopoPlanks3
category: "PolyBoost"
tooltip: "TopoPlanks3"
icon:#("PB_Icons4", 20)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.planks3()
	)
)

Macroscript TopoPlanks4
category: "PolyBoost"
tooltip: "TopoPlanks4"
icon:#("PB_Icons4", 21)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.planks4()
	)
)

Macroscript TopoTatter
category: "PolyBoost"
tooltip: "TopoTatter"
icon:#("PB_Icons4", 22)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.net()
	)
)

Macroscript TopoScrapV
category: "PolyBoost"
tooltip: "TopoScrapV"
icon:#("PB_Icons4", 23)
(
on isEnabled return (selection.count == 1) and (Modpanel.getcurrentObject () == $.baseobject) and Filters.Is_EditPoly()
on execute do 
	(
	if PolyBTopo == undefined do filein ((GetDir #Scripts) + "\PolyBoost\PB_Ptopo.mse")
	PolyBTopo.remverts()
	)
)

Macroscript Numeric
category: "PolyBoost"
tooltip: "Numeric"
icon:#("PB_Icons5", 1)
(
on execute do PolyBoost.NumericDfunc()
)

Macroscript InsertVert_1
category: "PolyBoost"
tooltip: "InsertVert_1"
icon:#("PB_Icons5", 8)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBInsertVert $ 1 (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript InsertVert_2
category: "PolyBoost"
tooltip: "InsertVert_2"
icon:#("PB_Icons5", 9)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBInsertVert $ 2 (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript CreatePolygon
category: "PolyBoost"
tooltip: "CreatePolygon"
icon:#("PB_Icons5", 3)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.CreatePolygon()
)

Macroscript SpinEdge
category: "PolyBoost"
tooltip: "SpinEdge"
icon:#("PB_Icons5", 2)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBSpinEdge $ keyboard.shiftpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript PolyDraw
category: "PolyBoost"
tooltip: "PolyDraw"
icon:#("PB_Icons5", 4)
(
on execute do PBPolyDraw.Drawpolyfunc()
)

Macroscript UVvertical
category: "PolyBoost"
tooltip: "UVvertical"
icon:#("PB_Icons5", 10)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_Lineup 1
)

Macroscript UVhorizontal
category: "PolyBoost"
tooltip: "UVhorizontal"
icon:#("PB_Icons5", 11)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do PolyBoost.UV_Lineup 2
)

Macroscript EmptyObject
category: "PolyBoost"
tooltip: "EmptyObject"
icon:#("PB_Icons5", 7)
(
on execute do PBPolyDraw.Emptyobj()
)
Macroscript SkinGrow
category: "PolyBoost"
tooltip: "SkinGrow"
icon:#("PB_Icons5", 18)
(
on isEnabled return PolyBoost.ValidSkinMod()
on execute do PolyBoost.SkinGrow()
)

Macroscript SkinShrink
category: "PolyBoost"
tooltip: "SkinShrink"
icon:#("PB_Icons5", 19)
(
on isEnabled return PolyBoost.ValidSkinMod()
on execute do PolyBoost.SkinShrink()
)

Macroscript SkinLoop
category: "PolyBoost"
tooltip: "SkinLoop"
icon:#("PB_Icons5", 20)
(
on isEnabled return PolyBoost.ValidSkinMod()
on execute do PolyBoost.SkinLoopRing 1
)

Macroscript SkinRing
category: "PolyBoost"
tooltip: "SkinRing"
icon:#("PB_Icons5", 21)
(
on isEnabled return PolyBoost.ValidSkinMod()
on execute do PolyBoost.SkinLoopRing 2
)

Macroscript SkinElement
category: "PolyBoost"
tooltip: "SkinElement"
icon:#("PB_Icons5", 22)
(
on isEnabled return PolyBoost.ValidSkinMod()
on execute do PolyBoost.SkinElement()
)

Macroscript ClothElement
category: "PolyBoost"
tooltip: "ClothElement"
icon:#("PB_Icons5", 27)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothElement()
)

Macroscript ClothLoop
category: "PolyBoost"
tooltip: "ClothLoop"
icon:#("PB_Icons5", 25)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothLoopRing 1
)

Macroscript ClothRing
category: "PolyBoost"
tooltip: "ClothRing"
icon:#("PB_Icons5", 26)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothLoopRing 2
)

Macroscript ClothGrow
category: "PolyBoost"
tooltip: "ClothGrow"
icon:#("PB_Icons5", 23)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothGrowShrink 1
)

Macroscript ClothShrink
category: "PolyBoost"
tooltip: "ClothShrink"
icon:#("PB_Icons5", 24)
(
on isEnabled return PolyBoost.ValidClothmod()
on execute do PolyBoost.ClothGrowShrink 2
)

Macroscript GeoPoly
category: "PolyBoost"
tooltip: "GeoPoly"
icon:#("PB_Icons5", 12)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do (if subobjectlevel == 4 do PolyBGeoPoly $ (PolyBoost.isEP()) (modpanel.getcurrentobject()))
)

Macroscript CenterLoop
category: "PolyBoost"
tooltip: "CenterLoop"
icon:#("PB_Icons5", 13)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBCenterLoop $ true (PolyBoost.isEP()) (modpanel.getcurrentobject())
)

Macroscript SetFlow
category: "PolyBoost"
tooltip: "SetFlow"
icon:#("PB_Icons5", 14)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		if subobjectlevel == 2 then PolyBSetFlow $ false keyboard.shiftpressed (PolyBoost.isEP()) cursel
		else if subobjectlevel == 1 do PolyBSetFlowVertex $ (PolyBoost.isEP()) cursel
		)
	)
)

Macroscript ViewportCanvas
category: "PolyBoost"
tooltip: "ViewportCanvas"
icon:#("PB_Icons5", 15)
(
on execute do filein ((GetDir #Scripts) + "\PolyBoost\ViewportCanvas.mse")
)

Macroscript UVWTweak
category: "PolyBoost"
tooltip: "UVWTweak"
icon:#("PB_Icons5", 16)
(
on execute do PolyBoost.UVtweakgo 1
)

Macroscript UVWTweak_UndoRedo
category: "PolyBoost"
tooltip: "UVWTweak_UndoRedo"
icon:#("PB_Icons5", 17)
(
on execute do PolyBoost.UVtweakUndoRedo()
)

Macroscript Multihide
category: "PolyBoost"
tooltip: "Multihide"
icon:#("PB_Icons5", 28)
(
on execute do PolyBoost.Multihide()
)

Macroscript PolyShift
category: "PolyBoost"
tooltip: "PolyShift"
icon:#("PB_Icons4", 24)
(
on execute do 
	(
	filein ((GetDir #Scripts) + "\PolyBoost\PB_PolyShift.mse")
	)
)

macroScript PolyDraw_Build_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Build_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BuildModel 1
	)
)

macroScript PolyDraw_Build_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Build_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BuildModel 2
	)
)

macroScript PolyDraw_Build_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Build_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BuildModel 3
	)
)

macroScript PolyDraw_Connect_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = false
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 1
	)
)

macroScript PolyDraw_Connect_Grid_SetFlow
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Grid_SetFlow"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = true
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 1
	)
)

macroScript PolyDraw_Connect_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = false
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 2
	)
)

macroScript PolyDraw_Connect_Surface_SetFlow
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Surface_SetFlow"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = true
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 2
	)
)

macroScript PolyDraw_Connect_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = false
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 3
	)
)

macroScript PolyDraw_Connect_Selection_SetFlow
category: "PolyBoost"
tooltip: "PolyDraw_Connect_Selection_SetFlow"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBo_PDsetflow = true
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PaintModel 3
	)
)

macroScript PolyDraw_SwiftLoop_Grid
category: "PolyBoost"
tooltip: "PolyDraw_SwiftLoop_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PBPlacego 1
	)
)

macroScript PolyDraw_SwiftLoop_Surface
category: "PolyBoost"
tooltip: "PolyDraw_SwiftLoop_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PBPlacego 2
	)
)

macroScript PolyDraw_SwiftLoop_Selection
category: "PolyBoost"
tooltip: "PolyDraw_SwiftLoop_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.PBPlacego 3
	)
)

macroScript PolyDraw_Border_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Border_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BorderTool 1
	)
)

macroScript PolyDraw_Border_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Border_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BorderTool 2
	)
)

macroScript PolyDraw_Border_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Border_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.BorderTool 3
	)
)

macroScript PolyDraw_Move_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Move_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.Movetoolini 1
	)
)

macroScript PolyDraw_Move_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Move_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.Movetoolini 2
	)
)

macroScript PolyDraw_Move_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Move_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.Movetoolini 3
	)
)

macroScript PolyDraw_Optimizer_Grid
category: "PolyBoost"
tooltip: "PolyDraw_Optimizer_Grid"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.OptiModel 1
	)
)

macroScript PolyDraw_Optimizer_Surface
category: "PolyBoost"
tooltip: "PolyDraw_Optimizer_Surface"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.OptiModel 2
	)
)

macroScript PolyDraw_Optimizer_Selection
category: "PolyBoost"
tooltip: "PolyDraw_Optimizer_Selection"
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	PBPolyDraw.PDtoolcheck()
	PBPolyDraw.OptiModel 3
	)
)

Macroscript Quadrify
category: "PolyBoost"
tooltip: "Quadrify"
icon:#("PB_Icons4", 25)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do PolyBoost.Quadrify()
)

Macroscript Space_Loops
category: "PolyBoost"
tooltip: "Space Loops"
icon:#("PB_Icons4", 28)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBSpaceLoop $ keyboard.shiftpressed false (PolyBoost.isEP()) cursel
		)
	)
)

Macroscript Curve_Loops
category: "PolyBoost"
tooltip: "Curve Loops"
icon:#("PB_Icons4", 27)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBCurveLoop $ keyboard.shiftpressed false true (PolyBoost.isEP()) cursel
		)
	)
)

Macroscript Circle_Loops
category: "PolyBoost"
tooltip: "Circle Loops"
icon:#("PB_Icons4", 29)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBCircleLoop $ keyboard.shiftpressed false (PolyBoost.isEP()) cursel
		)
	)
)

Macroscript Straighten_Loops
category: "PolyBoost"
tooltip: "Straighten Loops"
icon:#("PB_Icons4", 30)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBStraightLoop $ keyboard.shiftpressed false false (PolyBoost.isEP()) cursel
		)
	)
)

Macroscript Relax_Loops
category: "PolyBoost"
tooltip: "Relax Loops"
icon:#("PB_Icons4", 31)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do
	(
	cursel = modpanel.getcurrentobject()
	if classof cursel == Edit_Poly or PolyBoost.validobjfunc() do
		(
		PolyBRelaxLoop $ keyboard.shiftpressed false (PolyBoost.isEP()) cursel
		)
	)
)

Macroscript UV_Stitch
category: "PolyBoost"
tooltip: "UV Stitch"
icon:#("PB_Icons4", 26)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do 
	(
	PolyBoost.UV_stitch()
	)
)

Macroscript StepLoop
category: "PolyBoost"
tooltip: "StepLoop"
icon:#("PB_Icons1", 22)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBStepLoop $ keyboard.shiftpressed keyboard.altpressed (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript SymmetrySelectX
category: "PolyBoost"
tooltip: "SymmetrySelectX"
icon:#("PB_Icons3", 27)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBSymmetrySelect $ 0 (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript SymmetrySelectY
category: "PolyBoost"
tooltip: "SymmetrySelectY"
icon:#("PB_Icons3", 28)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBSymmetrySelect $ 1 (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript SymmetrySelectZ
category: "PolyBoost"
tooltip: "SymmetrySelectZ"
icon:#("PB_Icons3", 29)
(
on isEnabled return PolyBoost.ValidEPmacro()
on execute do 
	(
	PolyBSymmetrySelect $ 2 (PolyBoost.isEP()) (modpanel.getcurrentobject())
	)
)

Macroscript Symmetry_Tools
category: "PolyBoost"
tooltip: "Symmetry Tools"
icon:#("PB_Icons3", 14)
(
on execute do 
	(
	PolyBoost.SymmetryD()
	)
)

Macroscript UV_SpaceVertical
category: "PolyBoost"
tooltip: "UV SpaceVertical"
icon:#("PB_Icons3", 16)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do 
	(
	PolyBoost.UV_Space 1
	)
)

Macroscript UV_SpaceHorizontal
category: "PolyBoost"
tooltip: "UV SpaceHorizontal"
icon:#("PB_Icons3", 15)
(
on isEnabled return PolyBoost.ValidUVobjfunc()
on execute do 
	(
	PolyBoost.UV_Space 0
	)
)