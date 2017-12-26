<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//Recupera valores trazidos do Formulário de Cadastro de Igreja
//Atrubui eles ao objeto igreja
igreja.nome = request.getParameter("nome");
igreja.setor.setorID = Integer.parseInt(request.getParameter("setorID"));
igreja.igrejaID = Integer.parseInt(request.getParameter("igrejaID"));
%>

<%
//Executa a Função que irá Alterar os dados na Base de Dados
st.execute(igreja.alteraIgreja());
response.sendRedirect("sis_view_igrejas.jsp?msg=2");
%>


<%
 //fecha a consulta
 st.close();
%>