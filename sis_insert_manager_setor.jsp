<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="setor" class="cadastro.Setor" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Recupera valores trazidos do Formulário de Cadastro de Setores
//Atrubui eles ao objeto cargo
setor.nome = request.getParameter("nome");
%>

<%
st.execute(setor.insereSetor());
response.sendRedirect("sis_view_setores.jsp?msg=1");
%>

<%
 //fecha a consulta
 st.close();
%>