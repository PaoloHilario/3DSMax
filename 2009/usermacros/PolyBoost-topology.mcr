macroScript topology
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
