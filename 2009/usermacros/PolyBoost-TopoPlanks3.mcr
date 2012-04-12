macroScript TopoPlanks3
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
