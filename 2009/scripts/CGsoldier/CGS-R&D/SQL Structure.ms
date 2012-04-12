global CSskunk = "Driver={SQL Native Client};Server=VPD-Skunkwerks\VPD;Trusted_Connection=No;Database=VPD;UID=sa;PWD=q7w8e9r"
global CSlocal = "Driver={SQL Native Client};Server=.\SQLExpress;AttachDbFilename=Z:\PROGRAMMING\Scenario VPD\Scenario VPD Manager\Scenario VPD Manager\VPD_DB.mdf; Database=dbname; Trusted_Connection=Yes;"

struct SQL 
	(

	
	fn OdbcCommand = dotNetObject "System.Data.odbc.OdbcCommand",
		
	fn OdbcConnection CS = 
		(
		SQLconnect = dotNetObject "System.Data.odbc.OdbcConnection"
		SQLconnect.ConnectionString = CS
		SQLconnect.Open()
		if SQLconnect.state.tostring() == "Open" then (messagebox ("SQL Connection Established:\n" + (SQLconnect.datasource)))	else (messagebox "Unable to Establish Connection To Database")
		),
		
	fn OdbcDataAdpater = dotNetObject "System.Data.odbc.OdbcDataAdapter",
		
	fn OdbcDataReader = dotNetObject "System.Data.odbc.OdbcDataReader"
	
	)