macroScript catLoadPose
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Load Pose" 
            buttontext:"Load Pose" 
            Icon:#("CAT",6)
(
	on execute do (	
		try(
	   		if selection.count != 1 then return false;
			rLoadFile.openDialog selection[1] "Pose" ".pse";
		)catch()
	)
	on isVisible do 
	(
		try(
	   		if selection.count != 1 then return false;
			local catcontrol = GetCATNodeGroup selection[1];
			if catcontrol == undefined then return false;
			if catcontrol.catparent.catmode == 0 then return false;
			if catcontrol.catparent.NumLayers == 0 then return false;
			if catcontrol.catparent.selectedlayer < 1 then return false;
			if catcontrol.catparent.layers.controller[catcontrol.catparent.selectedlayer].LayerType =="CATMotion" then return false;
			return true;
		)catch( return false; )
	)
)
