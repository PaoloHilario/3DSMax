-------------------------------------------------------------------------------
-- CGS-Tabbed Interface Test
-- By Paolo Hilario (cgsoldier@gmail.com)
-- v 1.0
-- Created On: 09/10/2012
-- tested using Max 2011
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Required Files:
-- CGS_func.mse
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Release Notes:
/*
03.19.2011: Modified for General Release, Updated tools for Max 2011
*/
-------------------------------------------------------------------------------

(
-------------------------------------------------------------------------------
-- Includes
-------------------------------------------------------------------------------

include "$userscripts\\CGsoldier\\functions\\CGS_func.mse"

-------------------------------------------------------------------------------
-- Global Variables
-------------------------------------------------------------------------------
	
--Create scroll bars (for later use in the textbox)
ScrollBars = dotNetClass "System.Windows.Forms.ScrollBars"
--Create the first tab 
newTab = dotnetobject "System.Windows.Forms.TabPage"
newTab.text = "hello"
--Create a textbox and set properties
TB1TextBox = dotNetObject "System.Windows.Forms.TextBox"
TB1TextBox.Location = dotNetObject "System.Drawing.Point" 10 10
TB1TextBox.Width = 365
TB1TextBox.Height = 120
TB1TextBox.Visible = true
TB1TextBox.MultiLine = true
TB1TextBox.ScrollBars = ScrollBars.Vertical
TB1TextBox.AcceptsReturn = true
TB1TextBox.AcceptsTab = true
TB1TextBox.WordWrap = true
--Create a button and set properties 
button01 = dotnetobject "System.Windows.Forms.button"
button01.text = "Click me"
button01.Location = dotNetObject "System.Drawing.Point" 300 138
--Add textbox and button to first tab
newTab.controls.add TB1TextBox
newTab.controls.add button01

--Create second tab
newTab2 = dotnetobject "System.Windows.Forms.TabPage"
newTab2.text = "goodbye"
--Create a tab control object and set properties
TabControl = dotnetobject "System.Windows.Forms.TabControl" 
tabControl.size = dotnetobject "system.drawing.size" 400 225
tabControl.Location = dotnetobject "System.Drawing.Point" 0 0 
--Add the tabs to the tab control
TabControl.controls.add newTab
TabControl.controls.add newTab2	
-- Create Form (this is sort of like the rollout creation in maxscript) and set properties
TabForm = dotNetObject "System.Windows.Forms.Form"
TabForm.Size = dotNetObject "System.Drawing.Size" 400 225
TabForm.AutoSize = true
TabForm.Text = "Title"
TabForm.TopMost = true
FormBorderStyle = dotNetClass "System.Windows.Forms.FormBorderStyle"
TabForm.FormBorderStyle = FormBorderStyle.FixedDialog
TabForm.ShowInTaskbar = false
TabForm.MinimizeBox = true
TabForm.MaximizeBox = false
Tabform.helpbutton = true
--Add the tab control to the form
TabForm.Controls.Add(tabcontrol)
TabForm.Name = "Hi Bitches"
--Show the form (sort of like createDialog)
TabForm.showdialog()
 
)