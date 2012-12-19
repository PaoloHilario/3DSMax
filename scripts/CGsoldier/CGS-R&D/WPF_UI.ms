

(
	
	--( Create the UI
	the_xaml = "<Window 
    xmlns=\"http://schemas.microsoft.com/winfx/2006/xaml/presentation\"
    xmlns:x=\"http://schemas.microsoft.com/winfx/2006/xaml\"
    Title=\"Window1\" Height=\"437\" Width=\"694\" Topmost=\"True\">
    <Grid Name=\"FullGrid\">
        <Menu Height=\"22\" Name=\"TopMenu\" VerticalAlignment=\"Top\">
            <MenuItem Name=\"MainMenu\" Header=\"Menu\">
                <MenuItem Name=\"CreateItem\" Header=\"Create\">
                    <MenuItem Name=\"TestItem\" Header=\"Point\" />
                </MenuItem>
            </MenuItem>
        </Menu>
        <Grid Margin=\"0,20,0,0\" Name=\"MainGrid\" >
            <ComboBox Height=\"23\" Margin=\"6,8,0,0\" Name=\"Combo\" VerticalAlignment=\"Top\" HorizontalAlignment=\"Left\" Width=\"120\">
            </ComboBox>
            <TextBox HorizontalAlignment=\"Left\" Margin=\"6,66,0,17\" Name=\"Info\" Width=\"120\" IsReadOnly=\"False\" TextWrapping=\"Wrap\" AllowDrop=\"False\">Information about the character</TextBox>
            <TextBox Height=\"23\" HorizontalAlignment=\"Left\" Margin=\"6,37,0,0\" Name=\"Name\" VerticalAlignment=\"Top\" Width=\"120\">Character Name</TextBox>
            <TabControl Margin=\"132,28,12,12\" Name=\"MainTabControl\">
                <TabItem Header=\"Models\" Name=\"ModelsTab\" Padding=\"5\">
                    <Grid Name=\"ModelsGrid\">
                        <ListBox HorizontalAlignment=\"Left\" Margin=\"43,31,0,73\" Name=\"ModelList\" Width=\"171\">
                        </ListBox>
                        <TextBox Height=\"23\" Margin=\"220,31,39,0\" Name=\"ModelFileName\" VerticalAlignment=\"Top\">model Filename</TextBox>
                        <TextBox Margin=\"220,60,6,73\" Name=\"ModelInfo\">Model information</TextBox>
                        <Button Height=\"23\" HorizontalAlignment=\"Left\" Margin=\"139,0,0,44\" Name=\"DeleteModel\" VerticalAlignment=\"Bottom\" Width=\"75\">Delete Model</Button>
                        <Button Height=\"23\" HorizontalAlignment=\"Left\" Margin=\"43,0,0,44\" Name=\"AddModel\" VerticalAlignment=\"Bottom\" Width=\"75\">Add Model</Button>
                        <Button Height=\"23\" HorizontalAlignment=\"Right\" Margin=\"0,31,6,0\" Name=\"BrowseFilename\" VerticalAlignment=\"Top\" Width=\"27\">...</Button>
                    </Grid>
                </TabItem>
                <TabItem Name=\"SkeletonTab\" Header=\"Skeleton\" Padding=\"5\">
                    <Grid Name=\"SkeletonGrid\" Height=\"Auto\"  Width=\"Auto\">
									<TreeView HorizontalAlignment=\"Left\" Margin=\"6,6.28,0,6\" Name=\"SkeletonTree\" Width=\"176\"> 
										<TreeView.Resources>
											<ContextMenu x:Key = \"SkeletonContext\" Name=\"SkelContext\">
												<MenuItem Name=\"contextAddChild\" Header=\"Add Child\" />
												<MenuItem Name=\"contextDeleteBone\" Header=\"Delete Bone\" />
											</ContextMenu>
										</TreeView.Resources>
										<TreeView.ItemContainerStyle>
                                <Style TargetType=\"TreeViewItem\">
                                    <Setter Property=\"ContextMenu\" Value=\"{StaticResource SkeletonContext}\" />
                                </Style>
										</TreeView.ItemContainerStyle>
											<TreeViewItem Header=\"Test\">
											</TreeViewItem>
									</TreeView>
                    </Grid>
                </TabItem>
            </TabControl>
        </Grid>
    </Grid>
</Window>
"

--)
	--Create the window
	--We are using the XAML parser to parse the above XAML into usable .NET controls
	Xaml = dotnetclass "System.Windows.Markup.XamlReader"
	global the_window = Xaml.Parse the_xaml 

	
	--(Define the Functions

		--Function to Create a Point Helper
		--(
			fn create sender eventargs = (
				Point()
				redrawviews()
			)
						
			
			---Used to maintain Focus on the .Net Window
			--Because we have a new window we have to tell Max when we want to collect keyboard strokes and return control when we are done
			fn disable_accelerators = (
				enableAccelerators = false
			)
			
			fn enable_accelerators = (
				enableAccelerators = true
			)
			
		--)
			
	--)End Function Definintions
	
	
	--(Assign the Events

			--Setting the Focus od the window to capture all Keyboard events while the window is "Active" or focused
			dotNet.addEventHandler the_window "Activated" disable_accelerators
			
			--Make sure we return control when we are done
			dotNet.addEventHandler the_window "Deactivated" enable_accelerators
			
			--We are going to assign the Function to create a point helper to the Menu Item. FindName is a ,Net method for dealing with Large UI's, it will return the control with the matching name.
			dotNet.addEventHandler (the_window.FindName "TestItem") "Click" create

			--New to Max 2010, we use this to make sure Maxscript Garbage collection does not destory our Functions and events before we are done with them
			dotNet.setLifetimeControl the_window #dotnet
	--)
	
		
	--Show what we got
	the_window.show()
	

)