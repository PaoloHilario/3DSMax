macroScript ListStylesASCII
	ButtonText:"List Styles ASCII"
	Category:"DWG.Interop" 
	internalCategory:"DWG.Interop" 
	Tooltip:"List Styles in ASCII" 
(
-- constants
strIndent = "  "

function ListStyle aStyle aStyleIndent = 
(
	format "%%\n" aStyleIndent aStyle.name
	
	components = #()
	aStyle.getComponents &components
	for i=1 to components.count do 
	(
		ListStyle components[i] (aStyleIndent + strIndent)
	)
)

function ListStyles aCategory aStyleIndent = 
(
	styles = #()
	aCategory.getStyles &styles
	for i=1 to styles.count do 
	(
		ListStyle styles[i] aStyleIndent
	)
)

function ListCategories = 
(
	format "Categories = %\n" styleMgr.numCategories
	categories =#()
	styleMgr.GetCategories &categories
	for i=1 to categories.count do 
	(
		format "\n%\n" categories[i].name
		ListStyles categories[i] (strIndent + strIndent)
	)
)

function ListStyleMgr = 
(
	format "LIST OF STYLES: %\n" (maxFilePath + "\\" + maxFileName)
	ListCategories()
)
	
On Execute Do 
(
	ListStyleMgr()
)

)
