(
	if queryBox "3DS Max needs to restart to complete the installation!\r\nWould you like to save your file and restart 3DS Max Now?" title:"Install Complete" then
		(
			MessageBox "Once Max Restarts, CGsoldier Tools will be\r\navailable through the Customize User Interface\r\nDialog under the CGsoldier Tools Category"
			quitMAX()
		)
		else
		(
			MessageBox "Once Max Restarts, CGsoldier Tools will be\r\navailable through the Customize User Interface\r\nDialog under the CGsoldier Tools Category"
		)
)