<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@ include file="inc/seguranca.jsp" %>

<%@ include file="inc/conexao.jsp" %>


<jsp:useBean id="pedidoProduto" class="Pedidos.Pedido_Produto" scope="page"></jsp:useBean>



<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//Verifica se fois passado parametro via URL dando ordem para inclusão
if(request.getParameter("Salvar")!=null){
	
	//Recupera os valores trazidos do formulário e atribui ao objeto pedidoProduto
	pedidoProduto.pedido_produtoID 		= Integer.parseInt(request.getParameter("pedido_produtoID"));
	pedidoProduto.fornecedor1			= Float.parseFloat(request.getParameter("fornecedor1").replace(",","."));
	pedidoProduto.fornecedor2			= Float.parseFloat(request.getParameter("fornecedor2").replace(",","."));
	pedidoProduto.fornecedor3			= Float.parseFloat(request.getParameter("fornecedor3").replace(",","."));
	pedidoProduto.fornecedor4			= Float.parseFloat(request.getParameter("fornecedor4").replace(",","."));
	
	//Altera as cotações por fornecedores na base de dados
	st.execute(pedidoProduto.alteraValorFornecedor());
	
 	boolean alterado = true;
	
		
	//Após alterado fecha a página e atualiza a página de pai
	if(alterado){%>
		
		<script type="text/javascript">
		 window.close();  
		 window.opener.location.reload();
		</script>
		
	<%}
	
}
%>



<%
//Recupera o produto ID passado via URL
pedidoProduto.pedido_produtoID = Integer.parseInt(request.getParameter("pedido_produtoID"));

//Pesquisa os dados do Produto Cadastrado ao pedido
rs = st.executeQuery(pedidoProduto.buscaProdutosPorPedido_ProdutoID());

//inicializa as variaveis com seus valores Defaults
String quantidade 	= "";
String unidade 		= "";
String produtoNome	= "";
String fornecedor1 	= "0,00";
String fornecedor2 	= "0,00";
String fornecedor3 	= "0,00";
String fornecedor4 	= "0,00";

//Após realizada a consulta, verifica se trouxe valores e alimenta as variaveis instanciadas acima
if(rs.next()){
	quantidade 	= rs.getString("quantidade").replace(".",",");
	unidade		= rs.getString("unidade");
	produtoNome	= rs.getString("nome");
	fornecedor1	= rs.getString("fornecedor1").replace(".",",");
	fornecedor2	= rs.getString("fornecedor2").replace(".",",");
	fornecedor3	= rs.getString("fornecedor3").replace(".",",");
	fornecedor4	= rs.getString("fornecedor4").replace(".",",");
}

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Adicionar Produtos</title>

<link href="css/outros.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

//Valida preenchimento do Formulário
function verForm(form1){
	
	if(document.form1.fornecedor1.value == ""){
		document.form1.fornecedor1.value = "0,00";
	}	
	
	if(document.form1.fornecedor2.value == ""){
		document.form1.fornecedor2.value = "0,00";
	}
	
	if(document.form1.fornecedor3.value == ""){
		document.form1.fornecedor3.value = "0,00";
	}
	
	if(document.form1.fornecedor4.value == ""){
		document.form1.fornecedor4.value = "0,00";
	}
	
	
}



//Valida se o Campo é Numérico (COM VÍRGULA " , " )
function numeroVirgula(){
if (event.keyCode<48 && event.keyCode!=44 || event.keyCode>57 && event.keyCode!=44){return false;} 
}

</script>

</head>

<body onLoad="javascript: document.form1.fornecedor1.focus();">

<form name="form1" method="post" onSubmit="return verForm(this)">
<table align="center" cellpadding="2" cellspacing="2" style="border:1px solid #333333; width:445px; height:260px">
<tr bgcolor="#EEEEEE">
 <td align="center" colspan="2"><strong>ADICIONAR COTA&Ccedil;&Atilde;O POR FORNECEDOR</strong></td>
</tr>
<tr>
 <td align="left">Produto</td>
 <td align="left">
  <font color="#000033" size="4"><%=quantidade%>  <%=unidade%> de <strong><%=produtoNome%></strong></font>
   
  <input type="hidden" name="prodID" id="prodID" value="<%=request.getParameter("produtoID")%>" /> </td>
</tr>
<tr>
 <td colspan="2" align="left">&nbsp;</td>
 </tr>
<tr>
 <td align="left">Forecedor 1</td>
 <td align="left">
 <input name="fornecedor1" type="text" id="fornecedor1" onKeyPress="return numeroVirgula()" value="<%=fornecedor1%>" size="20" maxlength="10" /> </td>
</tr>
<tr>
 <td align="left">Forecedor 2</td>
 <td align="left">
 <input name="fornecedor2" type="text" id="fornecedor2s" onKeyPress="return numeroVirgula()" value="<%=fornecedor2%>" size="20" maxlength="10" /> </td>
</tr>
<tr>
 <td align="left">Forecedor 3</td>
 <td align="left">
 <input name="fornecedor3" type="text" id="fornecedor3" onKeyPress="return numeroVirgula()" value="<%=fornecedor3%>" size="20" maxlength="10" /> </td>
</tr>
<tr>
 <td align="left">Forecedor 4</td>
 <td align="left">
 <input name="fornecedor4" type="text" id="fornecedor4" onKeyPress="return numeroVirgula()" value="<%=fornecedor4%>" size="20" maxlength="10" /> </td>
</tr>
<tr>
  <td align="left" colspan="2">
   <input type="hidden" name="prodID" value="<%=request.getParameter("produtoID")%>" />
   <input type="submit" name="Salvar" value="Adicionar Cota&ccedil;&atilde;o" />  </td>
</tr>
</table>
</form>

</body>
</html>
