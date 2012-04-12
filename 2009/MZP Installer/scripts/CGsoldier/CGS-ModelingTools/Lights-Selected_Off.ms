(
-- ********************************************************************************
-- Turns off selected lights.
-- ********************************************************************************
hairlites = 0
-- Save current selection for future use.
SelSet = selection as array
-- Turn on lights in selection.
for n = 1 to SelSet.count do
	(
	if superclassof SelSet[n] == light then 
			if classof SelSet[n] == hfreedirect then hairlites = hairlites + 1 else
			if classof SelSet[n] == hfreespot then hairlites = hairlites + 1 else
			if classof SelSet[n] == htargetdirect then hairlites = hairlites + 1 else
			if classof SelSet[n] == htargetspot then hairlites = hairlites + 1 else
			if classof SelSet[n] == homni then hairlites = hairlites + 1 else
		SelSet[n].on = false
	)

if hairlites > 0 then messageBox ((hairlites as string) + " hair-enabled light(s) selected \r not affected by script." )\
title:"A reminder from Conrad" beep:true
)