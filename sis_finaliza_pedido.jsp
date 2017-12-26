<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>

<jsp:useBean id="pedido_produto" class="Pedidos.Pedido_Produto" scope="page"></jsp:useBean>

<jsp:useBean id="reserva" class="cadastro.ReservaColeta" scope="page"></jsp:useBean>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo Statement
Statement st01 = con.createStatement();
Statement st02 = con.createStatement();
Statement st03 = con.createStatement();
Statement st04 = con.createStatement();
%>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs01 = null;
ResultSet rs02 = null;
ResultSet rs03 = null;
ResultSet rs04 = null;
%>

<%
//Recupera o ID do Pedido
pedido.pedidoID = Integer.parseInt(request.getParameter("pedidoID"));
%>


<%
//Pequisa o valor reservado para esse pedido
//Declara variaveis que serão usadas para verificação e para assumirem os valores dos Fornecedores
Float forn01;
Float forn02;
Float forn03;
Float forn04;
Float Forn_Val_Ganhador;
String Fornecedor_Ganhador = "";

//Pesquisa a soma de todos os fornecedores relacionados a esse pedido
pedido_produto.pedido.pedidoID = pedido.pedidoID;
rs01 = st01.executeQuery(pedido_produto.buscaTotalFornecedorPorPedidoID());

//Alimenta as variaveis com os valores
if(rs01.next()){
	forn01 = rs01.getFloat("f1");
	forn02 = rs01.getFloat("f2");
	forn03 = rs01.getFloat("f3");
	forn04 = rs01.getFloat("f4");
}
	
	//Verifica quem foi o fornecedor Ganhador
	Forn_Val_Ganhador = rs01.getFloat("f1");
	Fornecedor_Ganhador = "F1";
	//Verifica se o segundo fornecedor é menor
	if(rs01.getFloat("f2") < Forn_Val_Ganhador && rs01.getFloat("f2") > 0){
		Forn_Val_Ganhador = rs01.getFloat("f2");
		Fornecedor_Ganhador = "F2";
	}
	//Verifica se o terceiro fornecedor é menor
	if(rs01.getFloat("f3") < Forn_Val_Ganhador && rs01.getFloat("f3") > 0){
		Forn_Val_Ganhador = rs01.getFloat("f3");
		Fornecedor_Ganhador = "F3";
	}
	//Verifica se o quarto fornecedor é menor
	if(rs01.getFloat("f4") < Forn_Val_Ganhador && rs01.getFloat("f4") > 0){
		Forn_Val_Ganhador = rs01.getFloat("f4");
		Fornecedor_Ganhador = "F4";
	}
	
	out.println("Fornecedor Ganhador: "+Forn_Val_Ganhador+"<br>");

%>

<%
//Pesquisa o valor atual em caixa da Igreja que está relacionada ao pedido
rs02 = st02.executeQuery(pedido.buscaIgrejaPorPedidoID());
if(rs02.next()){
	igreja.igrejaID = rs02.getInt("igrejaID");
}
rs03 = st03.executeQuery(igreja.igrejaPorID());
if(rs03.next()){
	igreja.saldo = rs03.getFloat("saldo");
}

	out.println("Saldo em Caixa: "+igreja.saldo+"<br>");
%>

<%
//Debita o valor reservado do valor atual em caixa
float saldo_atualizado = (igreja.saldo - Forn_Val_Ganhador);

	out.println("Saldo Atualizado: "+saldo_atualizado+"<br>");
%>

<%
//Atualiza o Saldo da Coleta da Igreja
igreja.saldo = saldo_atualizado;
st.execute(igreja.alteraSaldo());
%>

<%
//Muda o Status da Reserva_Coleta para 'F' Finalizado
//Recupera o ID da Reserva
reserva.pedido.pedidoID = pedido.pedidoID;
rs04 = st04.executeQuery(reserva.buscaReservaAtivaPorPedidoID());
if(rs04.next()){
	reserva.reserva_coletaID = rs04.getInt("reserva_coletaID");
}
st.execute(reserva.alteraStatus());
%>

<%
//Muda o Status do Pedido para 'F' Finalizado
pedido.status = "F";
st.execute(pedido.alteraStatus());
%>


<%
//Direciona para a página de Pedidos
response.sendRedirect("sis_view_pedidos.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Solicitacao Aprovacao</title>
</head>

<body>
</body>
</html>
