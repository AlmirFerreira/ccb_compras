<%
Connection con = null;
Statement st = null;

//CONEXAO PARA HOSPEDAGEM
//Class.forName("org.gjt.mm.mysql.Driver");
//con = DriverManager.getConnection("jdbc:mysql://mysql.ccbcompras.org/ccbcompras", "ccbcompras", "100accb");
//st=con.createStatement();


//CONEXAO PARA PC-ALMIR
Class.forName("org.gjt.mm.mysql.Driver");
con=DriverManager.getConnection("jdbc:mysql://localhost/db_ccb","root","");
st=con.createStatement();

%>