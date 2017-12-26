<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Trata Ações
//variaveis que serão utilizadas para verificação
String acao = "";
int numeroAcao;
//verifica se passado alguma acao via URL
if(request.getParameter("acao") != null){
	igreja.igrejaID = Integer.parseInt(request.getParameter("igrejaID"));
	numeroAcao = Integer.parseInt(request.getParameter("acao"));
	st.execute(igreja.statusIgreja(numeroAcao));
	response.sendRedirect("sis_view_igrejas.jsp");
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
	msg = igreja.mensagem(numeroMsg);
}
%>

<%
//Usado para Formatar o Valor para Moeda
Currency currency = Currency.getInstance("BRL");

DecimalFormat formato = new DecimalFormat("R$ #,##0.00");
%>

<%
//Pesquisa todos os Setores
rs = st.executeQuery(igreja.listaColetaPorIgreja());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Currency"%>
<%@page import="java.text.DecimalFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>CCB</title>

<script type="text/javascript">
 function excluir(igrejaID){
	if(confirm("Tem certeza que deseja Excluir essa Igreja?")){
		window.location.href="sis_delete_manager_igreja.jsp?igrejaID="+igrejaID;
	}
 }
</script>

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
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_insert_coleta.jsp'" value="+ Inserir Coleta" />
 &nbsp;&nbsp;
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_view_coleta_setor.jsp'" value="Ver Coleta por Setor" /> &nbsp;&nbsp;
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_transferencia_coleta.jsp'" value="Transferir Coleta" /> &nbsp;&nbsp;
 </td>
</tr>
<tr>
 <td valign="top">
 <br />
  <table width="470" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td colspan="4" align="center"><strong>LISTA DE COLETA POR SETOR / IGREJA</strong></td>
   </tr>
   <tr>
     <td colspan="4" height="15"></td>
   </tr>
   <tr bgcolor="#EEEEEE">
    <td width="250" align="left"><strong>Setor&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;Igreja</strong></td>
    <td width="100" align="center"><strong>Saldo</strong></td>
   </tr>
   <tr>
    <td colspan="2">
     <table id="tb1" width="470" align="center" cellpadding="0" cellspacing="0">  
      <tr>
       <td colspan="2" height="5"></td>
      </tr> 
<%
//Enquanto a Consulta retonar um resultada, Liste os Setores do Sistema
while (rs.next()){
%>

	<%
    String saldoColeta = "0";
    saldoColeta = formato.format(rs.getDouble("saldo"));
    %>
   
   <tr>
    <td height="30" width="250" align="left"><%=rs.getString("setorNome")%>&nbsp;&nbsp;&nbsp;/&nbsp;&nbsp;&nbsp;<%=rs.getString("nome")%></td>
    <td height="30" width="100" align="center"><%=saldoColeta%></td>
    
   </tr>
   <tr>
    <td colspan="2" align="center" style="height:1px"><hr style="border:1px solid #333333" /></td>
   </tr>

<%
}
%>
   </table>
   </td>
   </tr>
	
	<tr>
	 <td colspan="4" align="center"><font color="#ff0000"><%=msg %></font></td>
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
 //fecha a consulta
 st.close();
 rs.close();
%>