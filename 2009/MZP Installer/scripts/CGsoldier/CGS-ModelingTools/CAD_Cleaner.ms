for m in selection do 
	(	
	try	
		(	
			max group ungroup 
			deleteModifier m 1	
		(
	    new_z = 0 --m.pos.z 
	    for s = 1 to (numSplines m) do 
	    ( 
	      for k = 1 to (numKnots m s) do 
	      ( 
	        knt = getKnotPoint m s k 
	
	        in_vec = getInVec m s k 
	
	        out_vec = getOutVec m s k 
	
	        knt.z = in_vec.z = out_vec.z = new_z 
	
	        setInVec m s k in_vec 
	
	        setOutVec m s k out_vec 
	
	        setKnotPoint m s k knt 
	      )--end k loop 
	    )--end s loop 
	    updateshape m 
		m.pivot.z =m.min.z
	)
)
	catch ()
)
