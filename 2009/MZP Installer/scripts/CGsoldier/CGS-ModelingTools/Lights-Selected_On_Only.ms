(
-- ********************************************************************************
-- Turns on selected lights only.
-- ********************************************************************************
hairlites = 0
-- Save current selection for future use.
SelSet = selection as array
-- Turn off all lights in file.
for f = 1 to lights.count do
	(
	if superclassof lights[f] == light then 
		if classof lights[f] != hfreedirect then
		if classof lights[f] != hfreespot then
		if classof lights[f] != htargetdirect then
		if classof lights[f] != htargetspot then
		if classof lights[f] != homni then
	lights[f].on = false
	)
-- Turn on lights in selection.
for n = 1 to SelSet.count do
	(
	if superclassof SelSet[n] == light then 
			if classof SelSet[n] == hfreedirect then hairlites = hairlites + 1 else
			if classof SelSet[n] == hfreespot then hairlites = hairlites + 1 else
			if classof SelSet[n] == htargetdirect then hairlites = hairlites + 1 else
			if classof SelSet[n] == htargetspot then hairlites = hairlites + 1 else
			if classof SelSet[n] == homni then hairlites = hairlites + 1 else
		SelSet[n].on = true
	)

if hairlites > 0 then messageBox ((hairlites as string) + " hair-enabled light(s) selected \r plus others in scene not affected by script." )\
title:"A reminder from Conrad" beep:true
)