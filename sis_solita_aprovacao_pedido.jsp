<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Recupera o ID do Pedido
pedido.pedidoID = Integer.parseInt(request.getParameter("pedidoID"));
%>


<%
//Envia um email ao Administrador solicitando a aprovação
%>


<%
//Muda o Status do Pedido para 'P' Pendente de Aprovação
pedido.status = "P";
st.execute(pedido.alteraStatus());
%>


<%
//Direciona para a página de Pedidos
response.sendRedirect("sis_view_pedidos.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Solicitação de Aprovação</title>
</head>

<body>
</body>
</html>
