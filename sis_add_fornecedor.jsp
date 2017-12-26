<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import = "java.util.Date,java.text.SimpleDateFormat,java.text.ParseException"%>
<%@ include file="inc/seguranca.jsp" %>

<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="fornecedor" class="cadastro.Fornecedor" scope="page"></jsp:useBean>

<jsp:useBean id="pedidoFornecedor" class="Pedidos.Pedido_Fornecedor" scope="page"></jsp:useBean>



<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Verifica se fois passado parametro via URL dando ordem para inclusão
if(request.getParameter("Salvar")!=null){
	
	//Recupera os valores trazidos do formulário e atribui ao objeto pedidoFornecedor
	pedidoFornecedor.pedido.pedidoID			= Integer.parseInt(request.getParameter("pedidoID"));
	pedidoFornecedor.fornecedor.fornecedorID	= Integer.parseInt(request.getParameter("fornecedorID"));
	
	//Insere o produto na base de dados
	st.execute(pedidoFornecedor.insereFornecedor());
	
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
//Pesquisa os fornecedores ativos para carregar a combobox
rs = st.executeQuery(fornecedor.listaFornecedoresAtivos());
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Adicionar Fornecedores</title>

<link href="css/outros.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

//Valida preenchimento do Formulário
function verForm(form1){
	
	if(document.form1.fornecedorID.value == ""){
		alert('Escolha um fornecedor!');
		document.form1.fornecedorID.focus();
		return false;
	}	
	
}


</script>

</head>

<body onLoad="javascript: document.form1.fornecedorID.focus();">

<form name="form1" method="post" onSubmit="return verForm(this)">
<table align="center" cellpadding="2" cellspacing="2" style="border:1px solid #333333; width:450px; height:220px">
<tr bgcolor="#EEEEEE">
 <td align="center" colspan="2"><strong>ADICIONAR FORNECEDOR</strong></td>
</tr>
<tr>
 <td align="left">Fornecedor</td>
 <td align="left">
  <select id="fornecedorID" name="fornecedorID">
   <option value="">Selecione</option>
   <%while (rs.next()){%>
    <option value="<%=rs.getString("fornecedorID")%>"><%=rs.getString("fornNomeFantasia")%></option>
   <%}%>
  </select> 
 </td>
</tr>
<tr>
  <td align="left" colspan="2">
  	<input type="submit" name="Salvar" value="Adicionar" />
  </td>
</tr>
</table>
</form>

</body>
</html>
