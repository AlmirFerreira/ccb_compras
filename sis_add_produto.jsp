<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@ include file="inc/seguranca.jsp" %>

<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="produto" class="cadastro.Produto" scope="page"></jsp:useBean>

<jsp:useBean id="pedidoProduto" class="Pedidos.Pedido_Produto" scope="page"></jsp:useBean>



<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Verifica se fois passado parametro via URL dando ordem para inclusão
if(request.getParameter("Salvar")!=null){
	
	//Recupera os valores trazidos do formulário e atribui ao objeto pedidoProduto
	pedidoProduto.pedido.pedidoID		= Integer.parseInt(request.getParameter("pedidoID"));
	pedidoProduto.produto.produtoID		= Integer.parseInt(request.getParameter("produtoID"));
	pedidoProduto.quantidade			= Float.parseFloat(request.getParameter("quantidade").replace(",","."));
	
	//Insere o produto na base de dados
	st.execute(pedidoProduto.insereProduto());
	
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
//Pesquisa os produtos ativos para carregar a combobox
rs = st.executeQuery(produto.listaProdutosAtivos());
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
	
	if(document.form1.produtoID.value == ""){
		alert('Escolha um produto!');
		document.form1.produtoID.focus();
		return false;
	}	
	
	if(document.form1.quantidade.value == ""){
		alert('Informe a quantidade!');
		document.form1.quantidade.focus();
		return false;
	}
	
}


//Verifica qual produto selecionado e apresenta unidade de medida
function mostrarUnidade(){
	
	var unidadeMedida = document.form1.produtoID.value;
	
	var unidade = document.getElementById(unidadeMedida).value;
	
	document.form1.unidade.value = unidade;
	
}


//Valida se o Campo é Numérico (COM VÍRGULA " , " )
function numeroVirgula(){
if (event.keyCode<48 && event.keyCode!=44 || event.keyCode>57 && event.keyCode!=44){return false;} 
}

</script>

</head>

<body onLoad="javascript: document.form1.produtoID.focus();">

<form name="form1" method="post" onSubmit="return verForm(this)">
<table align="center" cellpadding="2" cellspacing="2" style="border:1px solid #333333; width:450px; height:220px">
<tr bgcolor="#EEEEEE">
 <td align="center" colspan="2"><strong>ADICIONAR PRODUTO</strong></td>
</tr>
<tr>
 <td align="left">Produto</td>
 <td align="left">
  <select id="produtoID" name="produtoID" onChange="mostrarUnidade()">
   <option value="">Selecione</option>
   <%while (rs.next()){%>
    <option value="<%=rs.getString("produtoID")%>"><%=rs.getString("nome")%></option>
   <%}%>
  </select> 
  
<%
//Pesquisa Navamente os produtos ativos para carregar as suas respectivas Unidade de Medida
rs = st.executeQuery(produto.listaProdutosAtivos());

//Carrega as Unidades de Medida
while (rs.next()){%>
    <input type="hidden" id="<%=rs.getString("produtoID")%>" name="unidadeMedida" value="<%=rs.getString("unidade")%>" />
<%}%>

 </td>
</tr>
<tr>
 <td align="left">Quantidade</td>
 <td align="left">
 <input type="text" name="quantidade" id="quantidade" maxlength="10" size="20" onKeyPress="return numeroVirgula()" onBlur="document.form1.Salvar.focus()" />&nbsp;
 <input type="text" name="unidade" value="" style="border:0px" readonly="readonly" />
 </td>
</tr>
<tr>
  <td align="left" colspan="2">
   <input type="hidden" name="prodID" value="<%=request.getParameter("produtoID")%>" />
   <input type="submit" name="Salvar" value="Adicionar" />
  </td>
</tr>
</table>
</form>

</body>
</html>
