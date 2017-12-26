<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>

<jsp:useBean id="data" class="formatar.Datas" scope="page"></jsp:useBean>

<jsp:useBean id="pedido_produto" class="Pedidos.Pedido_Produto" scope="page"></jsp:useBean>

<jsp:useBean id="reserva_coleta" class="cadastro.ReservaColeta" scope="page"></jsp:useBean>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<jsp:useBean id="setor" class="cadastro.Setor" scope="page"></jsp:useBean>

<jsp:useBean id="reserva" class="cadastro.ReservaColeta" scope="page"></jsp:useBean>




<%
//Instancia um objeto do tipo Statement
Statement st01 = con.createStatement();
Statement st02 = con.createStatement();
Statement st03 = con.createStatement();
Statement st04 = con.createStatement();
Statement st05 = con.createStatement();
%>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
ResultSet rs01 = null;
ResultSet rs02 = null;
ResultSet rs03 = null;
ResultSet rs04 = null;
ResultSet rs05 = null;
%>



<%
//Verifica se foi passada alguma ação e executa o solicitado
String acao = "";
if(request.getParameter("acao")!= null){
	acao = request.getParameter("acao");
}

if(acao.equals("1")){
	pedido.pedidoID = Integer.parseInt(request.getParameter("pedidoID"));
	pedido.status = "O";
	
	
//########  Como o pedido foi aprovado Inclui uma reserva para a coleta do Setor ########

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
	
	
	//out.println(Forn_Val_Ganhador + "<br>");
	//out.println(Fornecedor_Ganhador);
	
	//Busca o ID do Setor através do númedo do Pedido
	rs02 = st02.executeQuery(pedido.buscaSetorPorPedidoID());
	
	//Se trouxer resultado alimenta o objeto 'reserva_coleta'
	if(rs02.next()){
		reserva_coleta.setor.setorID 	= rs02.getInt("setorID");
		reserva_coleta.pedido.pedidoID 	= pedido.pedidoID;
		reserva_coleta.valor_reserva	= Forn_Val_Ganhador;
		
		
			//#### Consulta o valor que tem disponivel no Setor para verificar se será possivel a compra nesse valor ####
			//Recupera ID do Setor e cria variavel para receber valor em caixa
			igreja.setor.setorID = reserva_coleta.setor.setorID;
			Double dbl_saldoEmCaixa = 0.0;
			
			//Realiza a consulta
			rs03 = st03.executeQuery(igreja.listaColetaPorSetor());
			
			//Verifica se trouxe resultado e alimenta a variavel com o valor em caixa.
			if(rs03.next()){
				dbl_saldoEmCaixa = rs03.getDouble("saldo");
			}

			//#### Consulta qual o valor que tem em Reserva para esse setor ####
			//Recupera ID do Setor e cria variaveis para receber valores
			reserva.setor.setorID = igreja.setor.setorID;
			Double dbl_saldoReserva = 0.0;
			Double dbl_saldoDisponivel = 0.0;
			
			//Realiza a consulta
			rs04 = st04.executeQuery(reserva.buscaReservaPorSetor());
			
			//Se trouxe algum resultado Alimenta as variaveis
			if(rs04.next()){
				dbl_saldoReserva = rs04.getDouble("valorReserva");
			}
			
			//Faz o calculo para verificar se há saldo disponivel para realizar a compra
			//Saldo Disponivel = ( Saldo existente em Caixa - Valor Reservado para outras Compras - Valor da Compra )
			dbl_saldoDisponivel = ( dbl_saldoEmCaixa - dbl_saldoReserva - Forn_Val_Ganhador );
			
		    
			//Verifica se o Saldo Disponivel é maior ou igual a Zero para ter certeza que é possivel realizar a compra
			if(dbl_saldoDisponivel < 0.0){
			%>
            <script type="text/javascript">
			 alert("Saldo Indisponivel no Setor para realizar a compra.\nVerifique na coleta por setor.");
			 window.location.href="sis_view_pedidos_pendentes.jsp";
			</script>            
            <%	
			}else{
			 
			  	//Insere a Reserva de Coleta para a compra desse pedido na Base de Dados
				st05.execute(reserva_coleta.cadastraReserva());
				
				
				//Envia email para o fornecedor Ganhador
				
				
				//Altera o Statuso do Pedido
				st.execute(pedido.alteraStatus());
			
			}
			
		
		
	}

}
%>



<%
//Pesquisa todos os pedidos 
rs = st.executeQuery(pedido.listaPedidosPendentes());
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>CCB</title>


<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/interface.js"></script>

<!--[if lt IE 7]>
 <style type="text/css">
 .dock img { behavior: url(iepngfix.htc) }
 </style>
<![endif]-->

<link type="text/css" href="css/paging.css" rel="stylesheet" />	
<script type="text/javascript" src="js/paging.js"></script>

<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/geral.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">

//Aprova o Pedido
function aprovar(pedidoID){
	if(confirm("Tem certeza que deseja Aprovar esse pedido?")){
		window.location.href='sis_view_pedidos_pendentes.jsp?acao=1&pedidoID='+pedidoID;
	}
}

//Recusa o Pedido
function recusar(pedidoID){
	if(confirm("Tem certeza que deseja Recusar esse pedido?")){
		window.open("sis_recusa_pedido.jsp?pedidoID="+pedidoID+" ", "Recusar", "width=500px, height=250px");
		//window.location.href='sis_view_pedidos_pendentes.jsp?acao=2&pedidoID='+pedidoID;
	}
}

</script>


</head>
<body>

<div id="container">

<div id="topo">
 <jsp:include page="inc/menu_superior.jsp" />
</div>


<div id="corpo">

<table width="1010" align="center" height="470">
<tr>
 <td height="25" bgcolor="#EEEEEE">
 <input type="button" class="botao" onClick="javascript: window.location.href='sis_view_pedidos.jsp'" value="Lista Todos os Pedidos" />
 &nbsp;&nbsp;</td>
</tr>
<tr>
 <td valign="top">
 <br />
  <table width="930" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td colspan="7" align="center"><strong>LISTA DE PEDIDOS PENDENTES</strong></td>
   </tr>
   <tr>
     <td colspan="7" height="15"></td>
   </tr>
   <tr bgcolor="#EEEEEE">
    <td width="60" align="left"><strong>N°</strong></td>
    <td width="200" align="left"><strong>Respons&aacute;vel</strong></td>
    <td width="250" align="left"><strong>Constru&ccedil;&atilde;o</strong></td>
    <td width="60" align="center"><strong>Cota&ccedil;&otilde;es</strong></td>
    <td width="200" align="center"><strong>Status</strong></td>
    <td width="60" align="center"><strong>Aprovar</strong></td>
    <td width="60" align="center"><strong>Data</strong></td>
   </tr>
   <tr>
    <td colspan="7">
     <table id="tb1" width="930" align="center" cellpadding="0" cellspacing="0">  
      <tr>
       <td colspan="7" height="5"></td>
      </tr> 
<%
//Enquanto a Consulta retonar um resultada, Liste os Pedidos
while (rs.next()){

//Tratamento para legenda de Status
String statusPedido = "";

if (rs.getString("status").equals("A")){

	statusPedido = "Em Andamento";

}else if(rs.getString("status").equals("E")){

	statusPedido = "Aguardando Orçamentos";
		
}else if(rs.getString("status").equals("P")){

	statusPedido = "Pendende de Aprovação";
	
}else if(rs.getString("status").equals("R")){

	statusPedido = "<b><font color='#FF0000'>Recusado</font></b>";
	
}else if(rs.getString("status").equals("O")){

	statusPedido = "<b><font color='#00EE00'>Aprovado!</font></b>";
	
}else if(rs.getString("status").equals("F")){

	statusPedido = "Finalizado";
	
}

%>
   
   <tr>
    <td height="30" width="60" align="left"><%=rs.getString("pedidoID")%></td>
    <td height="30" width="200" align="left"><%=rs.getString("responsavel")%></td>
    <td height="30" width="250" align="left"><%=rs.getString("titulo")%></td>
    <td height="30" width="60" align="center"><a href="sis_view_cotacao.jsp?pedidoID=<%=rs.getString("pedidoID")%>"><img src="ico/ico_calculadora.png" width="20" height="20" title="Incluir Cotação" border="0" /></a></td>
    <td height="30" width="200" align="center"><%=statusPedido%></td>
    <td height="30" width="60" align="center">
    <a href="javascript: aprovar(<%=rs.getString("pedidoID")%>);"><img src="ico/ico_joinha.png" border="0" width="20" height="20" title="Aprovar Pedido" /></a>
    &nbsp;
    <a href="javascript: recusar(<%=rs.getString("pedidoID")%>);"><img src="ico/ico_cancelar.png" border="0" width="20" height="20" title="Recusar Pedido" /></a>
    </td> 
    <td height="30" width="60" align="center"><%=data.converteDeData(String.valueOf(rs.getDate("date")))%></td>
   </tr>
   <tr>
    <td colspan="7" align="center" style="height:1px"><hr style="border:1px solid #333333" /></td>
   </tr>

<%
}
%>
   </table>
   </td>
   </tr>
	
	<tr>
	 <td colspan="5" align="center"><font color="#ff0000"><%//=msg %></font></td>
	</tr>
    <tr>
     <td colspan="5" align="center">
      <!-- div onde será criados os links da paginaçao -->
	  <div id="pageNav"></div>
     </td>
    </tr>

  </table>
 
 </td>
</tr>
</table>

</div>


<div id="rodape"><jsp:include page="inc/rodape.jsp" /></div>

</div>


<script type="text/javascript">
	
	$(document).ready(
		function()
		{
			$('#dock').Fisheye(
				{
					maxWidth: 50,
					items: 'a',
					itemsText: 'span',
					container: '.dock-container',
					itemWidth: 40,
					proximity: 50,
					halign : 'center'
				}
			)
		}
	);

</script>

	<script>
        var pager = new Pager('tb1', 12); 
        pager.init(); 
        pager.showPageNav('pager', 'pageNav'); 
        pager.showPage(1);
    </script>

</body>
</html>

<%
// //fecha a consulta
// st.close();
// rs.close();
%>