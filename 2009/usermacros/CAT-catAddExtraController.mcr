macroScript catAddExtraController
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Add Extra Controller" 
            buttontext:"Add Extra Controller" 
            Icon:#("CAT",6)
(
	fn filtertracks t = ( return true; )
	on execute do (	
		try(
			tvp=trackview.pickTrackDlg  options:((2^14)+(2^22)+(2^23)+(2^24)+(2^26))
			if tvp==undefined then return OK;
			-- without this print statement this script crashes. !!???!!!
			print tvp.anim;
			local val = tvp.anim.value;
			-- if the following line fails then we bail
			tvp.client[tvp.subNum].controller = Bezier_Float();
			local layerfloat = selection[1][3].CreateLayerFloat();
			-- make sure the new controller defaults to the orrignal value
			layerfloat.SetupVal = val;
			tvp.client[tvp.subNum].controller = layerfloat;
		)catch(	return false; )
	)
	on isVisible do 
	(
   		if selection.count != 1 then return false;
		try( 
			if(selection[1][3].catparent.catmode!=0) then return false;
		)catch(	return false; )
		return true;
	)
)
