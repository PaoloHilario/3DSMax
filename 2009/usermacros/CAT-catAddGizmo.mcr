macroScript catAddGizmo
			category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Add Gizmo" 
            buttontext:"Add Gizmo" 
            Icon:#("CAT",6)
(
	on execute do (	
		try(	
			rGizmos.openDialog();
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
