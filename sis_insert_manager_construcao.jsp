<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="construcao" class="cadastro.Construcao" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Recupera valores trazidos do Formulário de Cadastro de Construção
//Atrubui eles ao objeto construcao
construcao.titulo			= request.getParameter("titulo");
construcao.igreja.igrejaID 	= Integer.parseInt(request.getParameter("igrejaID"));
%>

<%
st.execute(construcao.cadastraConstrucao());
response.sendRedirect("sis_view_construcoes.jsp?msg=1");
%>

<%
 //fecha a consulta
 st.close();
%>