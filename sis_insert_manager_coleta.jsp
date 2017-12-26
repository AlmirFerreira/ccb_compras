<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<jsp:useBean id="coleta" class="cadastro.Coleta" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Recupera valores trazidos do Formulário de Cadastro de Coleta
//Atrubui eles ao objeto coleta
coleta.igreja.igrejaID = Integer.parseInt(request.getParameter("igrejaID"));
coleta.valor	= Float.parseFloat(request.getParameter("valor").replace(",","."));
%>

<%
//Insere coleta para futura Consulta
st.execute(coleta.insereColeta());
%>

<%
//Pesquisa Saldo atual da igreja
igreja.igrejaID = coleta.igreja.igrejaID;
rs = st.executeQuery(igreja.igrejaPorID());

float saldo = 0;

if (rs.next()) {
	saldo = rs.getFloat("saldo");
}

//Atualiza o saldo da igreja
igreja.saldo = (coleta.valor + saldo);

st.execute(igreja.alteraSaldo());
%>

<%
//Direciona para a página de Coleta por Igreja
response.sendRedirect("sis_view_coletas.jsp?msg=1");
%>

<%
 //fecha a consulta
 rs.close();
 st.close();
%>