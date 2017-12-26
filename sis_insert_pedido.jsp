<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="servico" class="cadastro.Construcao" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>


<%
//Pesquisa todos serviços
rs = st.executeQuery(servico.listaConstrucoesAtivas());
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
 <input type="button" class="botao" onclick="javascript:window.location.href='sis_view_pedidos.jsp'" value="Pedidos" />
 </td>
</tr>
<tr>
 <td height="25"></td>
</tr>
<tr>
 <td valign="top" align="center">
 <form name="form1" action="sis_insert_manager_pedido.jsp">
 <table align="center" cellpadding="2" cellspacing="2" style="border:1px solid #000000">
  <tr>
   <td align="center" colspan="2"><strong>CADASTRAR NOVO PEDIDO</strong></td>
  </tr>
  <tr>
   <td align="left">Serviço Relacionado ao Pedido</td>
   <td align="left">
   <select name="servicoID">
    <option value="0">Selecione...</option>
    <%
	 //Enquanto a Consulta retonar um resultada, Liste os Setores do Sistema
	 while (rs.next()){
	 %>
      <option value="<%=rs.getInt("construcaoID")%>"><%=rs.getString("titulo")%></option>
    <%}%>
   </select>
   </td>
  </tr>
  <tr>
   <td align="center" colspan="2"><input type="submit" name="CADASTRAR" value="Cadastrar" /></td>
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