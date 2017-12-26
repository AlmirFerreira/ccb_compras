<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<jsp:useBean id="transferencia" class="cadastro.Transferencia" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo Statement
Statement st01 = con.createStatement();
Statement st02 = con.createStatement();
%>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
ResultSet rs01 = null;
ResultSet rs02 = null;
%>

<%
//Recupera valores trazidos do Formulário de Transferencia de Coleta
//Atrubui eles ao objeto transferencia
transferencia.origemID 	= Integer.parseInt(request.getParameter("origemID"));
transferencia.destinoID = Integer.parseInt(request.getParameter("destinoID"));
transferencia.valor		= Float.parseFloat(request.getParameter("origemValor").replace(",","."));
%>


<%
//URL's de redirecionamento
int URL;
String simTransf = "sis_transferencia_coleta.jsp?msg=2";
String naoTransf = "sis_transferencia_coleta.jsp?msg=3";
%>


<%
//Pesquisa Saldo atual da igreja a ser debitado o valor
igreja.igrejaID = transferencia.origemID;
rs01 = st.executeQuery(igreja.igrejaPorID());

float saldoOrigem = 0;

if (rs01.next()) {
	saldoOrigem = rs01.getFloat("saldo");
}

//Verifica se tem disponivel o valor
if(saldoOrigem < transferencia.valor){

	//Informa que não foi possivel realizar a trasferencia por falta de saldo na igreja de origem
	URL = 2;

}else{

	//Atualiza o saldo da igreja Origem
	igreja.saldo = (saldoOrigem - transferencia.valor);
	st.execute(igreja.alteraSaldo());
	
	//Pesquisa o Saldo da igreja Destino
	igreja.igrejaID = transferencia.destinoID;
	rs02 = st.executeQuery(igreja.igrejaPorID());
	
	float saldoDestino = 0;

	if (rs02.next()) {
		saldoDestino = rs02.getFloat("saldo");
	}
	
	//Atualiza o saldo da igreja Origem
	igreja.saldo = (saldoDestino + transferencia.valor);
	st.execute(igreja.alteraSaldo());
	
	//Informa que foi realizado a transferencia com Sucesso
	URL = 1;

	//Insere transferencia para futura Consulta
	st.execute(transferencia.insereTransferencia());
}
%>


<%
//Direciona para a página de Trasferencia de Coleta
if(URL == 1){
	response.sendRedirect(simTransf);
}else{
	response.sendRedirect(naoTransf);
}
%>

<%
 //fecha a consulta
 st.close();
%>