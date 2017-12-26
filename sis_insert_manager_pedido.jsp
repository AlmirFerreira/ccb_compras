<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Recupera valores trazidos do Formulário
//Atrubui eles ao objeto pedido
pedido.servico.construcaoID 	= Integer.parseInt(request.getParameter("servicoID"));
String usuID 					= String.valueOf(session.getAttribute("usuarioID"));
pedido.usuario.usuarioID 		= Integer.parseInt(usuID);
%>

<%
st.execute(pedido.cadastraPedido());
response.sendRedirect("sis_view_pedidos.jsp?msg=1");
%>

<%
 //fecha a consulta
 st.close();
%>