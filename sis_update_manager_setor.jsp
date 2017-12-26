<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="setor" class="cadastro.Setor" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//Recupera valores trazidos do Formulário de Cadastro de Setores
//Atrubui eles ao objeto setor
setor.setorID = Integer.parseInt(request.getParameter("setorID"));
setor.nome = request.getParameter("nome");
%>

<%
//Executa a Função que irá Alterar os dados na Base de Dados
st.execute(setor.alteraSetor());
response.sendRedirect("sis_view_setores.jsp?msg=2");
%>


<%
 //fecha a consulta
 st.close();
%>