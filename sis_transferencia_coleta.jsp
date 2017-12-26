<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="usuario" class="cadastro.Usuario" scope="page"></jsp:useBean>

<jsp:useBean id="igreja" class="cadastro.Igreja" scope="page"></jsp:useBean>

<jsp:useBean id="coleta" class="cadastro.Coleta" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//Pesquisa as igrejas Ativas cadastradas no Sistema
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
	msg = coleta.mensagem(numeroMsg);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-2" />
<title>FORTE SYSTEM</title>

<script type="text/javascript">

//Verifica o preenchimento correto dos campos
function verForm(){

	if(document.form1.origemID.value == ""){
		alert("Informe a Igreja de onde sairá o dinheiro.");
		document.form1.origemID.focus();
		return false;
	}
	
	if(document.form1.destinoID.value == ""){
		alert("Informe para qual Igreja o dinheiro irá.");
		document.form1.destinoID.focus();
		return false;
	}
	
	if(document.form1.origemValor.value == ""){
		alert("Informe o valor a ser trasferido.");
		document.form1.origemValor.focus();
		return false;
	}
	
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

//Valida se o Campo é Numérico (COM VÍRGULA " , " )
function numero()	{
if (event.keyCode<48 && event.keyCode!=44 || event.keyCode>57 && event.keyCode!=44){return false;} 
}

function apenasNumero()	{
if (event.keyCode<48 || event.keyCode>57){return false;} 
}

</script>

</head>

<body onload="document.form1.origemID.focus()">

<div id="container">

<div id="topo">
 <jsp:include page="inc/menu_superior.jsp" />
</div>


<div id="corpo">
<table width="1010" align="center" height="470">
<tr>
 <td height="25" bgcolor="#EEEEEE">
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_view_coletas.jsp'" value="Coletas" />
 &nbsp;&nbsp;
 </td>
</tr>
<tr>
 <td height="25"></td>
</tr>
<tr>
 <td valign="top" align="center">
 
 <form name="form1" method="post" action="sis_manager_trasferencia_coleta.jsp" onsubmit="return verForm(this)">
  <table align="center" cellpadding="2" cellspacing="2" style="border:1px solid #333333; width:600px; height:200px">
    <tr>
     <td align="center" colspan="2" bgcolor="#DDDDDD"><strong>TRASFER&Ecirc;NCIA DE COLETA</strong></td>
    </tr>
    <tr>
     <td align="left">
     Origem &nbsp;
     <select name="origemID">
      <option value="">Selecione...</option>
      <%while(rs.next()){%>
      <option value="<%=rs.getInt("igrejaID")%>"><%=rs.getString("nome")%></option>
      <%}%>
     </select>
     </td>
     <td align="left">
     Valor &nbsp;
     <input type="text" name="origemValor" maxlength="10" size="20" onkeypress="return numero()" />
     </td>
    </tr>
    <tr>
     <td align="left">
     <%
	//Pesquisa as igrejas Ativas cadastradas no Sistema
	rs = st.executeQuery(igreja.listaIgrejasAtivas());
	%>
     Destino &nbsp;
     <select name="destinoID">
      <option value="">Selecione...</option>
      <%while(rs.next()){%>
      <option value="<%=rs.getInt("igrejaID")%>"><%=rs.getString("nome")%></option>
      <%}%>
     </select>
     </td>
     <td align="left"></td>
    </tr>
    <tr>
     <td align="left"><input type="submit" name="SALVAR" value="Trasferir" /></td>
     <td align="left"></td>
    </tr>
    <tr>
	 <td colspan="2" align="center"><font color="#ff0000"><%=msg %></font></td>
	</tr>
  </table>
 </form>
  
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