<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="pedidoFornecedor" class="Pedidos.Pedido_Fornecedor" scope="page"></jsp:useBean>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>


<%
//Recupera o ID do pedido_fornecedor
pedidoFornecedor.pedido_fornecedorID 	= Integer.parseInt(request.getParameter("pedido_fornecedorID"));
//Recupera o ID do pedido
pedido.pedidoID							= Integer.parseInt(request.getParameter("pedidoID"));
%>

<%
st.execute(pedidoFornecedor.excluiFornecedor());
response.sendRedirect("sis_view_cotacao.jsp?pedidoID="+pedido.pedidoID);
%>


<%
 //fecha a consulta
 st.close();
%>