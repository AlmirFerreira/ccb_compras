<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<jsp:useBean id="setor" class="cadastro.Setor" scope="page"></jsp:useBean>

<jsp:useBean id="reserva" class="cadastro.ReservaColeta" scope="page">
</jsp:useBean>

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
//Usado para Formatar o Valor para Moeda
Currency currency = Currency.getInstance("BRL");

DecimalFormat formato = new DecimalFormat("R$ #,##0.00");
%>

<%
//Pesquisa todos os Setores
rs = st.executeQuery(setor.listaSetoresAtivos());
%>


<%
//Caso seja feita uma pesquisa por setor, buscar dados da coleta por setor
if(request.getParameter("setorID")!= null){
	//Recupera ID do Setor
	igreja.setor.setorID = Integer.parseInt(request.getParameter("setorID"));
	
	//Realiza a consulta
	rs01 = st01.executeQuery(igreja.listaColetaPorSetor());
}
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
 
 
 function verForm(){
 	 if(document.form1.setorID.value == ""){
 	 	alert("Escolha um Setor.");
 	 	document.form1.setorID.focus();
 	 	return false;
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
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_view_coletas.jsp'" value="Ver Coleta por Igreja" /> &nbsp;&nbsp;
 </td>
</tr>
<tr>
 <td valign="top">
 
 <form name="form1" action="sis_view_coleta_setor.jsp" onSubmit="return verForm(this)">
 <table width="350" align="center" cellpadding="4" cellspacing="4" style="border:1px solid #333333">
  <tr>
   <td align="left">
    <select name="setorID">
     <option value="">Selecione um Setor...</option>
<%
//Enquanto a Consulta retonar um resultada, Liste os Setores do Sistema
while (rs.next()){
%>
	<option value="<%=rs.getString("setorID")%>"><%=rs.getString("nome")%></option>
<%
}
%>
    </select>
   </td>
   <td align="right"><input type="submit" name="BUSCAR" value="Pesquisar" />
  </tr>
 </table>
 </form>
 
 <br />
  <table width="550" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td colspan="4" align="center"><strong>APRESENTA COLETA POR SETOR</strong></td>
   </tr>
   <tr>
     <td colspan="4" height="15"></td>
   </tr>
   <tr bgcolor="#EEEEEE">
    <td width="190" align="left"><strong>Setor</strong></td>
    <td width="120" align="center"><strong>Saldo em Caixa</strong></td>
    <td width="120" align="center"><strong>Saldo Reservado</strong></td>
    <td width="120" align="center"><strong>Saldo Disponivel</strong></td>
   </tr>
   <tr>
    <td colspan="4">
     <table id="tb1" width="550" align="center" cellpadding="0" cellspacing="0">  
      <tr>
       <td colspan="4" height="5"></td>
      </tr> 
<%
//Enquanto a Consulta retonar um resultada, Liste os Setores do Sistema
if(rs01!=null){
 while (rs01.next()){
%>

	   
    <%
	//Verifica quanto tem reservado de cada setor
	//Recupera o Id do Setor
	reserva.setor.setorID = rs01.getInt("setorID");
	//Faz a consulta
	rs02 = st02.executeQuery(reserva.buscaReservaPorSetor());
	
	Double dbl_saldoReserva = 0.0;
	Double dbl_saldoDisponivel = 0.0;
	
	//Se trouxe algum resultado Alimenta as variaveis
	if(rs02.next()){
		dbl_saldoReserva = rs02.getDouble("valorReserva");
	}
	
	dbl_saldoDisponivel = rs01.getDouble("saldo") - dbl_saldoReserva;
	%>
   
   
    <%
    //Converte os valores para moeda
    String saldoColeta 		= "0";
    String saldoReserva 	= "0";
    String saldoDisponivel 	= "0";
    
    saldoColeta 	= formato.format(rs01.getDouble("saldo"));
    saldoReserva 	= formato.format(dbl_saldoReserva);
	saldoDisponivel = formato.format(dbl_saldoDisponivel);
    %> 
   
   <tr>
    <td height="30" width="190" align="left"><%=rs01.getString("setorNome")%></td>
    <td height="30" width="120" align="center"><%=saldoColeta%></td>
    <td height="30" width="120" align="center"><font color="#FF0000"><%=saldoReserva%></font></td>
    <td height="30" width="120" align="center"><font color="#009900"><%=saldoDisponivel%></font></td>
    
   </tr>
   <tr>
    <td colspan="4" align="center" style="height:1px"><hr style="border:1px solid #333333" /></td>
   </tr>

<%
 }
}
%>
   </table>
   </td>
   </tr>
	
	<tr>
	 <td colspan="4" align="center"></td>
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

</body>
</html>

<%
 //fecha a consulta
 st.close();
 rs.close();
%>