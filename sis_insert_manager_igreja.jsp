<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Recupera valores trazidos do Formulário de Cadastro de Setores
//Atrubui eles ao objeto igreja
igreja.nome 			= request.getParameter("nome");
igreja.setor.setorID 	= Integer.parseInt(request.getParameter("setorID"));
%>

<%
st.execute(igreja.insereIgreja());
response.sendRedirect("sis_view_igrejas.jsp?msg=1");
%>

<%
 //fecha a consulta
 st.close();
%>