<%@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="construcao" class="cadastro.Construcao" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Trata A��es
//variaveis que ser�o utilizadas para verifica��o
String acao = "";
int numeroAcao;
//verifica se passado alguma acao via URL
if(request.getParameter("acao") != null){
	construcao.construcaoID = Integer.parseInt(request.getParameter("construcaoID"));
	numeroAcao = Integer.parseInt(request.getParameter("acao"));
	st.execute(construcao.statusConstrucao(numeroAcao));
	response.sendRedirect("sis_view_construcoes.jsp");
}
%>

<%
//Trata mensagens
//variaveis que ser�o utilizadas para verifica��o
String msg = "";
int numeroMsg;
//verifica se foi passado alguma mensagem via URL
if(request.getParameter("msg") != null){
	numeroMsg = Integer.parseInt(request.getParameter("msg"));
	msg = construcao.mensagem(numeroMsg);
}
%>


<%
//Pesquisa todos os Setores
rs = st.executeQuery(construcao.listaConstrucoes());
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>CCB</title>

<script type="text/javascript">
 function excluir(construcaoID){
	if(confirm("Tem certeza que deseja Excluir essa Constru��o?")){
		window.location.href="sis_delete_manager_construcao.jsp?construcaoID="+construcaoID;
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
 <input type="button" class="botao" onclick="javascript: window.location.href='sis_insert_construcao.jsp'" value="+ Novo Servi&ccedil;o" />
 &nbsp;&nbsp;</td>
</tr>
<tr>
 <td valign="top">
 <br />
  <table width="670" align="center" cellpadding="0" cellspacing="0">
   <tr>
    <td colspan="5" align="center"><strong>LISTA DE SERVI&Ccedil;OS</strong></td>
   </tr>
   <tr>
     <td colspan="5" height="15"></td>
   </tr>
   <tr bgcolor="#EEEEEE">
    <td width="250" align="left"><strong>Servi&ccedil;o</strong></td>
    <td width="200" align="left"><strong>Igreja</strong></td>
    <td width="60" align="left"><strong>Ed</strong></td>
    <td width="60" align="center"><strong>At</strong></td>
    <td width="60" align="center"><strong>Ex</strong></td>
   </tr>
   <tr>
    <td colspan="5">
     <table id="tb1" width="670" align="center" cellpadding="0" cellspacing="0">  
      <tr>
       <td colspan="5" height="5"></td>
      </tr> 
<%
//Enquanto a Consulta retonar um resultada, Liste os Setores do Sistema
while (rs.next()){
%>
   
   <tr>
    <td height="30" width="250" align="left"><%=rs.getString("titulo")%></td>
    <td height="30" width="200" align="left"><%=rs.getString("nome")%></td>
    <td height="30" width="60" align="left"><a href="sis_update_construcao.jsp?construcaoID=<%=rs.getString("construcaoID")%>"><img src="ico/ico_editar.png" width="20" height="20" title="Editar Servi�o" border="0" /></a></td>
    <%
	//Verifica o status se est� ativo ou n�o
	String status = rs.getString("status");
	if(status.equals("S")){
	%>
    <td height="30" width="60" align="center"><a href="sis_view_construcoes.jsp?acao=1&construcaoID=<%=rs.getString("construcaoID")%>"><img src="ico/ico_ativo.png" width="20" height="20" border="0" title="Desativar <%=rs.getString("titulo")%>" /></a></td>
    <%}else if(status.equals("N")){%>
    <td height="30" width="60" align="center"><a href="sis_view_construcoes.jsp?acao=2&construcaoID=<%=rs.getString("construcaoID")%>"><img src="ico/ico_inativo.png" width="20" height="20" border="0" title="Ativar <%=rs.getString("nome")%>" /></a></td>
    <%}%>
    
    <td height="30" width="60" align="center"><a href="javascript:excluir(<%=rs.getString("construcaoID")%>)"><img src="ico/ico_excluir.png" width="20" height="20" border="0" title="Excluir <%=rs.getString("titulo")%>" /></a></td>
   </tr>
   <tr>
    <td colspan="5" align="center" style="height:1px"><hr style="border:1px solid #333333" /></td>
   </tr>

<%
}
%>
   </table>
   </td>
   </tr>
	
	<tr>
	 <td colspan="5" align="center"><font color="#ff0000"><%=msg %></font></td>
	</tr>
    <tr>
     <td colspan="5" align="center">
      <!-- div onde ser� criados os links da pagina�ao -->
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