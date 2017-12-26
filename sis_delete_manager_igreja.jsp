<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>


<%
//Recupera o ID da Igreja
igreja.igrejaID = Integer.parseInt(request.getParameter("igrejaID"));
%>

<%
st.execute(igreja.excluiIgreja());
response.sendRedirect("sis_view_igrejas.jsp?msg=3");
%>

<%
 //fecha a consulta
 st.close();
%>