<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>


<jsp:useBean id="anexos" class="Pedidos.Anexos" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//Recupera o ID do Pedido
anexos.pedido.pedidoID = Integer.parseInt(request.getParameter("pedidoID"));

//Pesquisa todos os Anexos amarrados a esse pedido	
rs = st.executeQuery(anexos.pesquisaAnexoPorPedidoID());
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Anexar Arquivos</title>

<link href="css/outros.css" rel="stylesheet" type="text/css" />

</head>

<body>

<table width="350" align="center" cellpadding="4" cellspacing="4">
  <tr bgcolor="#EEEEEE">
   <td colspan="2" align="center"><strong>DOWNLOAD DE ARQUIVOS</strong></td>
  </tr>
  <%while(rs.next()){%>
  <tr>
   <td align="left"><a href="Download/<%=rs.getString("nome_arquivo")%>" title="Download"><%=rs.getString("titulo")%></a></td>
   <td align="left"><a href="Download/<%=rs.getString("nome_arquivo")%>" title="Download"><img src="ico/ico_baixa.png" width="20" height="20" border="0" /></a></td>
  </tr>
  <%}%>
</table>


</body>
</html>
