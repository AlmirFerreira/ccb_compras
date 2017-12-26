<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>

<jsp:useBean id="pedidoProduto" class="Pedidos.Pedido_Produto" scope="page"></jsp:useBean>

<jsp:useBean id="pedidoFornecedor" class="Pedidos.Pedido_Fornecedor" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo Statement para ajudar na query
Statement st01 = con.createStatement();
Statement st02 = con.createStatement();
Statement st03 = con.createStatement();
Statement st04 = con.createStatement();
%>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
ResultSet rs01;
ResultSet rs02;
ResultSet rs03;
ResultSet rs04;
%>



<%
//Pesquisa todos os produtos adicionados ao Pedido
pedidoProduto.pedido.pedidoID = Integer.parseInt(request.getParameter("pedidoID"));
rs = st.executeQuery(pedidoProduto.buscaProdutosPorPedidoID());
%>


<%
//Pesquisa todos os fornecedores adicionados ao Pedido
pedidoFornecedor.pedido.pedidoID = Integer.parseInt(request.getParameter("pedidoID"));
rs01 = st01.executeQuery(pedidoFornecedor.buscaFornecedorPorPedidoID());
%>


<%
//Pesquisa os Dados do Pedido
pedido.pedidoID = Integer.parseInt(request.getParameter("pedidoID"));
rs02 = st02.executeQuery(pedido.litaPedidoPorPedidoID());

//Variavel utilizada para verificar se ainda pode editar o pedido
boolean editavel = false;
//Variavel de Observaçoes da cotaçao / Utilizada como canal de comunicaçao entre o Administrador e os Compradores
String observacoes = "";

//Verifica se o pedido ainda pode ser alterado
if(rs02.next()){
	if(!rs02.getString("status").equals("O")){
		editavel = true;
	}
	
	//Atribui o valor da observaçao a variavel "observacoes"
	if(rs02.getString("observacoes") != null){
		observacoes = rs02.getString("observacoes");
	}
}
%>


<%
//Trata mensagens
//variaveis que serão utilizadas para verificação
String msg = "";
int numeroMsg;
//verifica se foi passado alguma mensagem via URL
if(request.getParameter("msg") != null){
	numeroMsg = Integer.parseInt(request.getParameter("msg"));
	msg = pedido.mensagem(numeroMsg);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-2" />
<title>FORTE SYSTEM</title>

<script type="text/javascript">
function verForm(){
	
}
</script>

<script type="text/javascript" src="js/jquery.js"></script>


<script type="text/javascript" src="js/jquery-1.4.3.min.js"></script>
    <script type="text/javascript" src="js/jquery.pstrength-min.1.2.js"></script>
        <script>
        	$(document).ready(function(){
				$('.password').pstrength();
			});
        </script>

<script type="text/javascript" src="js/interface.js"></script>

<!--[if lt IE 7]>
 <style type="text/css">
 .dock img { behavior: url(iepngfix.htc) }
 </style>
<![endif]-->   

<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/geral.css" rel="stylesheet" type="text/css" />


<script type="text/javascript">

//Funçao Criada para abrir página de adicioar produto
function addProduto(produtoID){
	window.open("sis_add_produto.jsp?pedidoID="+produtoID+" ", "Adicionar", "width=500px, height=250px");
}

//Funçao Criada para abrir página de adicionar Fornecedores
function addFornecedor(produtoID){
	window.open("sis_add_fornecedor.jsp?pedidoID="+produtoID+" ", "Adicionar", "width=500px, height=250px");
}

//Funçao Criada para Remover Fornecedor que está vinculado ao Pedido
function removerFornecedor(pedido_fornecedorID, pedidoID){
	if(confirm("Tem certeza que deseja remover esse fornecedor da lista?")){
		window.location.href='sis_delete_manager_pedido_fornecedor.jsp?pedido_fornecedorID='+pedido_fornecedorID+"&pedidoID="+pedidoID
	}
}

//Funçao criada para exluir produtos adiciodos ao pedido
function removerProduto(pedido_produtoID, pedidoID){
	if(confirm("Tem certeza que deseja remover esse produto da lista?")){
		window.location.href='sis_delete_manager_pedido_produto.jsp?pedido_produtoID='+pedido_produtoID+"&pedidoID="+pedidoID
	}
}

//Funçao que chamará a página para enviar o pedido de orçamento aos fornecedores
function enviarPedido(pedidoID){
	
	if(confirm("Tem certeza que deseja enviar o pedido\npara os fornecedores selecionados?")){
		alert("Pedido enviado com Sucesso!\nAguarde o Orçamento.");
		//window.location.href='sis_solita_orcamento_por_email.jsp?pedidoID='+pedidoID
		window.location.href='http://127.0.0.1:82/sis_CCB/envioEmailFornecedores.asp?pedidoID='+pedidoID
	}

}

//Envia para a página que solicita a apovaçao do Pedido
function solicitaAprovacao(pedidoID){
	
	if(confirm("Tem certeza que deseja solicitar \na aprovaçao do Administrador para esse Pedido?")){
		alert("Solicitaçao enviada!\nAguarde a aprovaçao.");
		window.location.href='sis_solita_aprovacao_pedido.jsp?pedidoID='+pedidoID
	}

}


//Finaliza o Pedido, faz ele virar um histórico de venda e debita o saldo da Coleta excluindo assim a reserva.
function finalizaPedido(pedidoID){
	
	if(confirm("Tem certeza que o Pedido foi Finalizado?")){
		alert("Pedido Encerrado!\nPara visualiza-lo acesse o modulo COMPRAS.");
		window.location.href='sis_finaliza_pedido.jsp?pedidoID='+pedidoID
	}
	
}

//Funçao Criada para editar valores passados pelos fornecedores
function editarValorProduto(pedido_produtoID){
	window.open("sis_update_pedido_produto.jsp?pedido_produtoID="+pedido_produtoID+" ", "Adicionar", "width=500px, height=300px");
}

//Funçao Criada para realizar upload de arquivos contendo orçamentos
function anexarArquivos(pedidoID){
	window.open("sis_anexar_orcamento.jsp?pedidoID="+pedidoID+" ", "Anexar", "width=460px, height=170px");
}

//Funçao Criada para realizar Download dos arquivos contendo orçamentos
function baixarArquivos(pedidoID){
	window.open("sis_download_orcamento.jsp?pedidoID="+pedidoID+" ", "Download", "width=400px, height=500px");
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
 <input type="button" onclick="javascript: window.history.back(-1)" class="botao" value="&lt;&lt; Voltar" />
 </td>
</tr>
<tr>
 <td height="25"></td>
</tr>
<tr>
 <td valign="top" align="center">
 <!--Corpo do Pedido-->
 
 <table align="center" width="1000" cellpadding="2" cellspacing="2" style="border:1px solid #333333">
  <tr>
   <td colspan="8"><strong>Produtos</strong> 
   <%if(editavel){%>
   <a href="javascript: addProduto(<%=request.getParameter("pedidoID")%>)" ><img src="ico/ico_add.png" width="18" height="18" border="0" title="+ Adicionar Serviço" align="absmiddle" /></a>
   <%}%>
   </td>
  </tr>
  <tr bgcolor="#CCCCCC">
   <td align="left"><strong>Produto</strong></td>
   <td align="left" width="80"><strong>Qtd</strong></td>
   <td align="left" width="130"><strong>Fornecedor 1</strong></td>
   <td align="left" width="130"><strong>Fornecedor 2</strong></td>
   <td align="left" width="130"><strong>Fornecedor 3</strong></td>
   <td align="left" width="130"><strong>Fornecedor 4</strong></td>
   <td align="left" width="40"><strong>Ed</strong></td>
   <td align="left" width="40"><strong>Ex</strong></td>
  </tr>
<%while (rs.next()){%>
  <tr>
   <td align="left"><%=rs.getString("nome")%></td>
   <td align="left" width="80"><%=rs.getString("quantidade").replace(".",",")%> - <%=rs.getString("unidade")%></td>
   <td align="left" width="130"><%=rs.getString("fornecedor1").replace(".",",")%></td>
   <td align="left" width="130"><%=rs.getString("fornecedor2").replace(".",",")%></td>
   <td align="left" width="130"><%=rs.getString("fornecedor3").replace(".",",")%></td>
   <td align="left" width="130"><%=rs.getString("fornecedor4").replace(".",",")%></td>
   <td align="left" width="40">
   <%if(editavel){%>
   <a href="javascript: editarValorProduto(<%=rs.getString("pedido_produtoID")%>)"><img src="ico/ico_editar.png" border="0" width="20" height="20" title="Incluir Valor dos Fornecedores" /></a>
   <%}%>
   </td>
   <td align="left" width="40">
   <%if(editavel){%>
   <a href="javascript: removerProduto(<%=rs.getString("pedido_produtoID")%>, <%=rs.getString("pedidoID")%>)"><img src="ico/ico_cancelar.png" border="0" width="20" height="20" title="Remover Produto" /></a>
   <%}%>
   </td>
  </tr>	
<%}%>
 </table>
 
 <br /><br />
 
 <table align="center" width="1000" cellpadding="2" cellspacing="2" style="border:1px solid #333333">
  <tr>
   <td colspan="4"><strong>Fornecedores</strong> 
   <%if(editavel){%>
   <a href="javascript: addFornecedor(<%=request.getParameter("pedidoID")%>)" ><img src="ico/ico_add.png" width="18" height="18" border="0" title="+ Adicionar Serviço" align="absmiddle" /></a>
   <%}%>
   </td>
  </tr>
  <tr bgcolor="#CCCCCC">
   <td align="left"><strong>Fornecedor 1</strong></td>
   <td align="left"><strong>Fornecedor 2</strong></td>
   <td align="left"><strong>Fornecedor 3</strong></td>
   <td align="left"><strong>Fornecedor 4</strong></td>
  </tr>
  <tr>
<%while (rs01.next()) {%>

   <td align="left"><%=rs01.getString("fornNomeFantasia")%> 
   <%if(editavel){%>
   <a href="javascript: removerFornecedor(<%=rs01.getString("pedido_fornecedorID")%>, <%=rs01.getString("pedidoID")%>)" title="Remover Fornecedor">[X]</a>
   <%}%>
   </td>

<%}%> 
  </tr>
 </table>
 
 
 <br /><br />
 
 <table align="left" width="500" height="100" cellpadding="2" cellspacing="2" style="border:1px solid #333333">
  <tr>
   <td height="15" colspan="2" align="left"><strong>Menu Geral</strong></td>
  </tr>
  <tr>
   <td align="left">
   <%if(editavel){%>
   <input type="button" name="EnviarForcenedores" value="Enviar Cotaçao para Fornecedores" onclick="javascript: enviarPedido(<%=request.getParameter("pedidoID")%>)" />
   <%}%>
   </td>
   <td align="left">
   <%if(editavel){%>
   <input type="button" name="AnexarOrcamentos" value="Anexar Orçamentos" onclick="javascript: anexarArquivos(<%=request.getParameter("pedidoID")%>)" />
   <%}%>
   </td>
  </tr>
  <tr>
   <td align="left"><input type="button" name="BaixarAnexos" value="Baixar Anexos"  onclick="javascript: baixarArquivos(<%=request.getParameter("pedidoID")%>)" /></td>
   <td align="left">
   <%if(editavel){%>
   <input type="button" name="SolicitarAprovacao" value="Solicitar Aprovaçao" onclick="javascript: solicitaAprovacao(<%=request.getParameter("pedidoID")%>)" />
   <%}else{%>
   <input type="button" name="FinalizarPedido" value="Finalizar Compra" onclick="javascript: finalizaPedido(<%=request.getParameter("pedidoID")%>)" />
   <%}%>
   </td>
  </tr>
 </table>
 
 <table align="right" width="500" height="100" cellpadding="2" cellspacing="2" style="border:1px solid #333333">
  <tr>
   <td height="15" colspan="2" align="left"><strong>Observa&ccedil;&otilde;es</strong></td>
  </tr>
  <tr>
   <td align="left" colspan="2" valign="top">
   <p style="white-space:inherit"><%=observacoes%></p>
   </td>
  </tr>
 </table>
 
 <!--Fim do Corpo do Pedido-->
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

</body>
</html>