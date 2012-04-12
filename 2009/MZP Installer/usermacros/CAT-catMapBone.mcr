macroScript catMapBone
            category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Map Bone" 
            buttontext:"Map Bone" 
            Icon:#("CAT",6)
(
	on execute do (	
		try(
			local src = pickObject prompt:"Pick a source node to capture animation from"
			if src != undefined then(
				rCATRigMapping.MapNodes src selection[1] undefined;
			)
		)catch( )
	)
	on isVisible do 
	(
   		if selection.count != 1 or not rCaptureAnim.open then return false;
		try( 
			if(selection[1][3].catparent.catmode==0) then return false;
		)catch(	return false; )
		return true;
	)
)
