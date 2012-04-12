
vPDDataCA = attributes vPDData

(

local sc_vpd_blue =openBitMap ((getDir #usericons) + "\\sc_vpd_blue.jpg")	
	
parameters main rollout:params

(

'vPD_name' Type:#string UI:'vPD_name' Default:"WALL 01"

'vPD_assembly' Type:#string UI:'vPD_assembly' Default:"Wall Type 1"

'vPD_type' Type:#string UI:'vPD_type' Default:"Wall"
	
'vPD_Length' Type:#string UI:'vPD_Length' Default:"30'-0\""
	
'vPD_Height' Type:#string UI:'vPD_Height' Default:"9'-0\""
	

)

 

rollout params "VPD Data"

(
	
imgTag scn_vpd_blue tooltip:"www.scenario-vpd.com" style:#bmp_tile bitmap:sc_vpd_blue	align:#center

Edittext 'vPD_name' "Name:" fieldWidth:130 labelOnTop:true	readonly:true
Edittext 'vPD_assembly' "Assembly:" fieldWidth:130 labelOnTop:true	readonly:true
Edittext 'vPD_type' "Object Type:" fieldWidth:130 labelOnTop:true	readonly:true	
Edittext 'vPD_Length' "Length:" fieldWidth:130 labelOnTop:true	readonly:true
Edittext 'vPD_Height' "Height:" fieldWidth:130 labelOnTop:true	readonly:true	

button 'getdatabase' "Object Data"

	


)

)

 custAttributes.add $ vPDDataCA

$.vPD_Height = (($.max.z - $.min.z)/12) as string + " ft"
$.vPD_Length = (($.max.y - $.min.y)/12) as string + " ft"
$.vPD_type = "Wall"
$.vPD_assembly = "Type 02"
$.vPD_name = $.name