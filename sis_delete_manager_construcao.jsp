<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="construcao" class="cadastro.Construcao" scope="page"></jsp:useBean>


<%
//Recupera o ID da Igreja
construcao.construcaoID = Integer.parseInt(request.getParameter("construcaoID"));
%>

<%
st.execute(construcao.excluiConstrucao());
response.sendRedirect("sis_view_construcoes.jsp?msg=3");
%>

<%
 //fecha a consulta
 st.close();
%>