macroScript Macro3
	category:"DragAndDrop"
	toolTip:""
(
	
	obj = $

	newobj = pickObject prompt:"pick rail to modify" 


	for objprop in getPropNames obj do 
	( 
	objpropval = getProperty obj objprop
	setproperty newobj 	objprop objpropval
	)
)
