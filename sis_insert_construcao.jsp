<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<jsp:useBean id="construcao" class="cadastro.Construcao" scope="page"></jsp:useBean>


<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Pesquisa todas as Igrejas Ativas Cadastradas
rs = st.executeQuery(igreja.listaIgrejasAtivas());
%>


<%
//Trata mensagens
//variaveis que serão utilizadas para verificação
String msg = "";
int numeroMsg;
//verifica se foi passado alguma mensagem via URL
if(request.getParameter("msg") != null){
	numeroMsg = Integer.parseInt(request.getParameter("msg"));
	msg = construcao.mensagem(numeroMsg);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-2" />
<title>CCB</title>

<script type="text/javascript">
function verForm(){
	
	if(document.form1.igrejaID.value == ""){
		alert("Escolha uma Igreja!");
		document.form1.igrejaID.focus();
		return false;
	}
	
	if(document.form1.titulo.value == ""){
		alert("O Titulo da Construçao é Obrigatório!");
		document.form1.titulo.focus();
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

<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/geral.css" rel="stylesheet" type="text/css" />

</head>

<body onload="javascript:document.form1.igrejaID.focus()">

<div id="container">

<div id="topo">
 <jsp:include page="inc/menu_superior.jsp" />
</div>


<div id="corpo">
<table width="1010" align="center" height="470">
<tr>
 <td height="25" bgcolor="#EEEEEE">
 
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_view_construcoes.jsp'" value="Lista Serviços" />
 &nbsp;&nbsp;</td>
</tr>
<tr>
 <td height="25"></td>
</tr>
<tr>
 <td valign="top" align="center">
<table align="center" style="width:450px; height:200px; border:1px solid #333">
 <tr>
 <td>
 
 <form name="form1" method="post" action="sis_insert_manager_construcao.jsp" onsubmit="return verForm(this)">
 <table width="400" align="center">
 <%if(request.getParameter("msg") != null){ %>
  <tr>
   <td colspan="2" align="center" bgcolor="#ff0000"><font color="#ffffff"><strong><%=msg %></strong></font></td>
  </tr>
 <%} %>
  <tr>
   <td colspan="2" align="center"><strong>CADASTRO DE SERVI&Ccedil;O</strong></td>
  </tr>
  <tr>
    <td width="127" align="left">Igreja:</td>
    <td width="261" align="left">
    <select name="igrejaID">
     <option value="">Selecione uma Igreja...</option>
     <%
	 //Enquanto a Consulta retonar um resultada, Liste os Setores do Sistema
	 while (rs.next()){
	 %>
      <option value="<%=rs.getInt("igrejaID")%>"><%=rs.getString("nome")%></option>
     <%}%>
    </select>
    </td>
  </tr>
  <tr>
    <td width="127" align="left">Titulo do Servi&ccedil;o:</td>
    <td width="261" align="left"><input name="titulo" type="text" id="titulo" size="50" maxlength="30" /></td>
  </tr>
  <tr>
    <td align="left">&nbsp;</td>
    <td align="left">&nbsp;</td>
  </tr>
  <tr>
   <td align="left"><input name="CADASTRAR" type="submit" class="botao" value="Cadastrar" /></td>
   <td align="left"></td>
  </tr>
 </table>
 </form>
 
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