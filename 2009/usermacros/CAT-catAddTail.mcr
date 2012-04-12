macroScript catAddTail
			category:"CAT" 
            internalcategory:"CAT" 
            tooltip:"Add Tail" 
            buttontext:"Add Tail" 
            Icon:#("CAT",6)
(
	on execute do (	
		try(	selection[1][3].AddTail()
		)catch(	return false; )
	)
	on isVisible do 
	(
   		if selection.count != 1 then return false;
		try( 
			if(selection[1][3].catparent.catmode!=0) then return false;
			if(classof selection[1][3].controller)!=HubTrans then return false;
		)catch(	return false; )
		return true;
	)
)
