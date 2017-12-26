<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Verifica se foi clicado no botão "SALVAR" e salva a atualização
String recusar = request.getParameter("recusar");
if(recusar!="" && recusar!=null){
	
	//Recupera o valores do formulário
	pedido.observacoes 	= request.getParameter("observacoes");
	pedido.pedidoID		= Integer.parseInt(request.getParameter("pedidoID"));
	
	//Atualiza na base de dados
	st.execute(pedido.alteraObservacoes());
	
	//Altera o Status do Pedido para Rejeitado
	pedido.status = "R";
	st.execute(pedido.alteraStatus());
	
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
//Pesquisa alguma observação que já foi adicionada à esse pedido.
//Recupera o Id do Pedido
pedido.pedidoID		= Integer.parseInt(request.getParameter("pedidoID"));

//Pesquisa o Pedido pelo seu próprio ID
rs = st.executeQuery(pedido.litaPedidoPorPedidoID());

//Cria a variavel obs
String obs = "";

//Verifica se trouxe valor e preenche a variável obs
if(rs.next()){
	obs = rs.getString("observacoes");
}
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Recusar Pedido</title>

<link href="css/outros.css" rel="stylesheet" />


<script type="text/javascript">

function verForm(){
	if(document.form1.observacoes.value == ""){
		alert("Descreva o Motivo pelo qual o pedido foi rejeitado!");
		document.form1.observacoes.focus();
		return false;
	}
}

</script>

</head>

<body onload="javascript: document.form1.observacoes.focus();">

<form name="form1" onsubmit="return verForm(this)">
<table align="center" width="440" height="220">
 <tr>
  <td align="center" bgcolor="#EEEEEE"><strong>JUSTIFIQUE A RECUSA</strong></td>
 </tr>
 <tr>
  <td align="center">
   <textarea id="observ" name="observacoes"><%=obs%></textarea>
  </td>
 </tr>
 <tr>
  <td align="left">
  <input type="submit" name="SALVAR" value="Recusar" />
  <input type="hidden" name="pedidoID" value="<%=request.getParameter("pedidoID")%>" />
  <input type="hidden" name="recusar" value="OK" />
  </td>
 </tr>
</table>
</form>

</body>
</html>
