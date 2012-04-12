macroScript catPinBone
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Pin Bone" 
            buttontext:"Pin Bone" 
            Icon:#("CAT",6)
(
	on execute do (	
		if selection.count == 1 and (classof $[3].controller)==HubTrans then
			selection[1][3].pinhub = not selection[1][3].pinhub;
	)
	on isVisible do 
	(
		try(
			if selection.count == 1 and (classof selection[1][3].controller)==HubTrans and selection[1][3].catparent.catmode!=0 then
				return true;
		)catch()
		return false;
	)
	on isChecked do (
		try(
			if selection.count == 1 and (classof selection[1][3].controller)==HubTrans then
				return $[3].controller.pinhub;
		)catch()
		return false;
	)
)
