<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="construcao" class="cadastro.Construcao" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//Recupera valores trazidos do Formulário de Cadastro de Construçao/Serviço
//Atrubui eles ao objeto setor
construcao.construcaoID 	= Integer.parseInt(request.getParameter("construcaoID"));
construcao.igreja.igrejaID	= Integer.parseInt(request.getParameter("igrejaID"));
construcao.titulo			= request.getParameter("titulo");
%>

<%
//Executa a Função que irá Alterar os dados na Base de Dados
st.execute(construcao.atualizaConstrucao());
response.sendRedirect("sis_view_construcoes.jsp?msg=2");
%>


<%
 //fecha a consulta
 st.close();
%>