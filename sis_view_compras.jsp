<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="pedido" class="Pedidos.Pedido" scope="page"></jsp:useBean>

<jsp:useBean id="data" class="formatar.Datas" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//verifica se o Usuario é Administrador
String nivel = String.valueOf(session.getAttribute("nivel"));
	
if(nivel.equals("1")){
	rs = st.executeQuery(pedido.listaPedidosFinalizados());
}else{
	//Pesquisa somente o Pedidos vinculados a o usuário Logado
	String usuID = String.valueOf(session.getAttribute("usuarioID"));
	pedido.usuario.usuarioID = Integer.parseInt(usuID);
	rs = st.executeQuery(pedido.listaPedidosFinalizadosPorId());
}

%>

<%
//Pesquisa todos os pedidos 
//rs = st.executeQuery(pedido.listaPedidos());
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
<link href="css/geral.css" rel="stylesheet" type="text/css" /></head>
<body>

<div id="container">

<div id="topo">
 <jsp:include page="inc/menu_superior.jsp" />
</div>


<div id="corpo">

<table width="1010" align="center" height="470">
<tr>
 <td height="25" bgcolor="#EEEEEE">
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_insert_pedido.jsp'" value="+ Novo Pedido" />
 &nbsp;&nbsp;</td>
</tr>
<tr>
 <td valign="top">
 <br />
  <table width="570" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td colspan="4" align="center"><strong>LISTA DE COMPRAS FINALIZADAS</strong></td>
   </tr>
   <tr>
     <td colspan="4" height="15"></td>
   </tr>
   <tr bgcolor="#EEEEEE">
    <td width="60" align="left"><strong>N°</strong></td>
    <td width="250" align="left"><strong>Servi&ccedil;o</strong></td>
    <td width="200" align="center"><strong>Status</strong></td>
    <td width="60" align="center"><strong>Data</strong></td>
   </tr>
   <tr>
    <td colspan="5">
     <table id="tb1" width="570" align="center" cellpadding="0" cellspacing="0">  
      <tr>
       <td colspan="4" height="5"></td>
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
    <td height="30" width="250" align="left"><%=rs.getString("titulo")%></td>
    <td height="30" width="200" align="center"><%=statusPedido%></td>
    <td height="30" width="60" align="center"><%=data.converteDeData(String.valueOf(rs.getDate("date")))%></td>
   </tr>
   <tr>
    <td colspan="4" align="center" style="height:1px"><hr style="border:1px solid #333333" /></td>
   </tr>

<%
}
%>
   </table>
   </td>
   </tr>
	
	<tr>
	 <td colspan="4" align="center"><font color="#ff0000"><%//=msg %></font></td>
	</tr>
    <tr>
     <td colspan="4" align="center">
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