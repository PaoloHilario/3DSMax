-------------------------------------------------------------------------------
-- RockWorkCalculator.ms
-- By Paolo Hilario (paolo@cgsoldier.com) & Ron Soule (Paolo's Math Pimp)
-- v 1.02
-- Created On: 02/26/08
-- tested using Max 2008
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Description:
-- Allows you to quickly measure the Surface Area of a Poly or Mesh
-- and get the concrete volume and weight of rockwork
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Instructions:
-- Choose a Poly or Mesh and Run the Script
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
--- Include Scripts & Kill Old Windows
-------------------------------------------------------------------------------
	
FileIn "$userscripts\\CGsoldier\\functions\\CGS_func.mse"	

-------------------------------------------------------------------------------
--- Function Definition
-------------------------------------------------------------------------------

(
-- Local Variables

local facecount
local facearea
local areatotal = 0
local volume = 0
local weight = 0
if units.SystemType == #millimeters then thk = 76.2 else thk = 3.0

-- The Script
if selection.count == 1 then
	(
	reset_X_form()
	
	case classof $ of
		(
		Editable_Poly:
			(
			facecount= polyop.getnumfaces $
			facearea = #()
				for i = 1 to facecount do
					(
					append facearea (polyop.getfacearea $ i)
					)
				for i = 1 to facearea.count do
					(
					areatotal = areatotal + facearea [i] -- square millimeters or inches as float values
					volume = volume + (facearea [i]*thk)	-- cubic millimeters or cubic inches
					)
				data = 
						(
						case (units.SystemType) of
							(
							#inches:
								(
								"Surface Area: " + (areatotal/144) as string +" ft^2" + "\n" +
								--"Price: " +"$" + (((areatotal/144)*75) as integer) as string + "\n" + 
								"Concrete Volume: " + (volume/12^3) as string + " ft^3" + "\n" +
								"Concrete Weight: " + ((volume/12^3)*150) as string + " lbs" + " / " + (((volume/12^3)*150)/2000) as string + " Tons"
								)
							#Millimeters:
								(
								"Surface Area: " + (areatotal/1e6) as string +" M^2" + "\n" + 
								--"Price: " +"$" + (((areatotal/1e6)*807.3) as integer) as string + "\n" + 
								"Concrete Volume: " + (volume/1e9) as string + " M^3" + "\n" +
								"Concrete Weight: " + ((volume/1e9)*2400) as string + " kg" + " / " + (((volume/1e9)*2400)/1000) as string + " Metric Tons"
								)
							default: (MessageBox "Your System Units are Neither Inches or Millimeters\nYour Calculations will be Incorrect Therefore I cannot Continue" title:"Rockwork Estimation")
							)
						)
				MessageBox data title:"Rockwork Estimation"
				)
			
		Editable_Mesh:
			(
			facecount= meshop.getnumfaces $
			facearea = #()
				for i = 1 to facecount do
					(
					append facearea (meshop.getfacearea $ i)
					)
				for i = 1 to facearea.count do
					(
					areatotal = areatotal + facearea [i]
					volume = volume + (facearea [i]*thk)	
					)
			data = 
					(
					case (units.SystemType) of
						(
						#inches:
							(
							"Surface Area: " + (areatotal/144) as string +" ft^2" + "\n" +
							--"Price: " +"$" + (((areatotal/144)*75) as integer) as string + "\n" + 
							"Concrete Volume: " + (volume/12^3) as string + " ft^3" + "\n" +
							"Concrete Weight: " + ((volume/12^3)*150) as string + " lbs" + " / " + (((volume/12^3)*150)/2000) as string + " Tons"
							)
						#Millimeters:
							(
							"Surface Area: " + (areatotal/1e6) as string +" M^2" + "\n" +
							--"Price: " +"$" + (((areatotal/1e6)*807.3) as integer) as string + "\n" + 
							"Concrete Volume: " + (volume/1e9) as string + " M^3" + "\n" +
							"Concrete Weight: " + ((volume/1e9)*2400) as string + " kg" + " / " + (((volume/1e9)*2400)/1000) as string + " Metric Tons"
							)
						default: (MessageBox "Your System Units are Neither Inches or Millimeters\nYour Calculations will be Incorrect Therefore I cannot Continue" title:"Rockwork Estimation")
						)
					)
			MessageBox data title:"Rockwork Estimation"
			)
			
		default:
			(
			MessageBox "No Item Selected" title:"Rockwork Calculator"
			)
		)
	)
	else
		(
		MessageBox "You Must Select One Object" title:"Rockwork Calculator"
		)
)
