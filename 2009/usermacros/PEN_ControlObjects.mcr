/*
Name:

Created By: Paul Neale
Company: PEN Productions Inc.
E-Mail: pen_productions@yahoo.com
Start Date: Nov 24 2002
Purpose:
Max version 5x

Disclaimer:
This script has not been fully tested. Use at your own risk.
Any damage caused by this script is not the responsibility of the author.

Usage:
 
Updated:

Bugs:

ToDo:

*/

macroScript sphereControl
	category:"PEN Control Objects"
	buttonText:"Sphere Control"
	toolTip:"Creates a Spherical spline control object."
(
	on execute do
	(
		st=penCNT()
		st.sphere()
	)	
)

macroScript pinControl
	category:"PEN Control Objects"
	buttonText:"Pin Control"
	toolTip:"Creates a pin shaped spline control object."
(
	on execute do
	(
		st=penCNT()
		st.pin()
	)		
)

macroScript arrowControl
	category:"PEN Control Objects"
	buttonText:"Arrow Control"
	toolTip:"Creates a Arrow shaped spline control object."
( 
	on execute do
	(
		st=penCNT()
		st.dArrow()
	)
) 

macroScript coinCNT \
	category:"PEN Control Objects"
	buttonText:"Coin"
	toolTip:"Creates a Coin control object."
(
	on execute do
	(
		st=penCNT()
		st.coin()
	)
)
	
macroScript handCNT \
	category:"PEN Control Objects"
	buttonText:"Hand"
	toolTip:"Creates a Hand control object."
(
	on execute do
	(
		st=penCNT()
		st.splineHand()
	)
)

macroScript boxCNT \
	category:"PEN Control Objects"
	buttonText:"Box Control"
	toolTip:"Creates a Box control object."
(
	on execute do
	(
		st=penCNT()
		st.boxCNT()
	)
)

macroScript circleArrowsCNT \
	category:"PEN Control Objects"
	buttonText:"Circle Arrow Control"
	toolTip:"Creates a circle w 4 arrows control object."
(
	on execute do
	(
		st=penCNT()
		st.circleArrows()
	)
)	

macroScript footCNT \
	category:"PEN Control Objects"
	buttonText:"Foot Control"
	toolTip:"Foot control object."
(
	on execute do
	(
		st=penCNT()
		st.foot()
	)
)	

macroScript CharacterNodeCNT \
	category:"PEN Control Objects"
	buttonText:"Character Node"
	toolTip:"Character Node Control object."
(
	on execute do
	(
		st=penCNT()
		st.characterNode()
	)
)

macroScript eyeControls \
	category:"PEN Control Objects"
	buttonText:"Eye Controls"
	toolTip:"Eye Controls"
(
	on execute do
	(
		st=penCNT()
		st.eyeControls()
	)
)	

macroScript circleArrowsCurved \
	category:"PEN Control Objects"
	buttonText:"Circle Arrow Curved"
	toolTip:"Circle Arrow Curved"
(
	on execute do
	(
		st=penCNT()
		st.circleArrowsCurved()
	)
)	

macroScript rotateCNT \
	category:"PEN Control Objects"
	buttonText:"Rotate Control"
	toolTip:"Rotate Control"
(
	on execute do
	(
		st=penCNT()
		st.rotateCNT()
	)
)	

macroScript positionCNT \
	category:"PEN Control Objects"
	buttonText:"Position Control"
	toolTip:"Position Control"
(
	on execute do
	(
		st=penCNT()
		st.positionCNT()
	)
)	

/*
macroScript RankinCNT \
	category:"PEN Control Objects"
	buttonText:"Rankin Control"
	toolTip:"Rankin Control Object."
(
	on execute do
	(
		st=penCNT()
		st.RankinObj()
	)
)	
*/




