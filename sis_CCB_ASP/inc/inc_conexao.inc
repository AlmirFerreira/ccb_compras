<%



Dim string

Dim conn



'string = "Driver={mySQL ODBC 5.1 Driver}; Server=mysql.ccbclp.org.br; pwd=100accb; uid=ccbclp; database=ccbclp"

string = "Driver={MySQL ODBC 3.51 Driver};SERVER=127.0.0.1;DATABASE=sis_ccb;Uid=root; Pwd= "


sub abreConexao

set conn = Server.CreateObject("ADODB.Connection")

conn.Open string

end sub





sub fechaConexao

conn.Close

set conn = Nothing

end sub



%>