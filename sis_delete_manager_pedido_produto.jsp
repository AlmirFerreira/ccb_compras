<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>


<jsp:useBean id="pedidoProduto" class="Pedidos.Pedido_Produto" scope="page"></jsp:useBean>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>


<%
//Recupera o ID do pedido_produtoID
pedidoProduto.pedido_produtoID 	= Integer.parseInt(request.getParameter("pedido_produtoID"));
//Recupera o ID do pedido
pedido.pedidoID							= Integer.parseInt(request.getParameter("pedidoID"));
%>

<%
st.execute(pedidoProduto.excluiProduto());
response.sendRedirect("sis_view_cotacao.jsp?pedidoID="+pedido.pedidoID);
%>


<%
 //fecha a consulta
 st.close();
%>