<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="setor" class="cadastro.Setor" scope="page"></jsp:useBean>


<%
//Recupera o ID do Setor
setor.setorID = Integer.parseInt(request.getParameter("setorID"));
%>

<%
st.execute(setor.excluiSetor());
response.sendRedirect("sis_view_setores.jsp?msg=3");
%>

<%
 //fecha a consulta
 st.close();
%>