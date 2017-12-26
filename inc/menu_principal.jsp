
<jsp:useBean id="mensagens" class="acesso.Mensagens" scope="page"></jsp:useBean>

<%
//Trata mensagens
//variaveis que serão utilizadas para verificação
String msg = "";
int numeroMsg;
//verifica se foi passado alguma mensagem via URL
if(request.getParameter("msg") != null){
	numeroMsg = Integer.parseInt(request.getParameter("msg"));
	msg = mensagens.mensagem(numeroMsg);
}
%>

<table width="1010" align="center" height="470">

<tr>
 <td height="15" align="center" bgcolor="#000066"><font color="#FFFFFF">MENU PRINCIPAL DO SISTEMA</font></td>
<tr>
  <td align="center">
  
  <!--Menu Principal -->
  <table width="1000" align="center">
   <tr>
    <td width="160" align="center"><a href="sis_view_usuarios.jsp"><img src="ico/ico_usuarios.png" width="60" height="60" border="0" title="Usuários do Sistema" /></a></td>
    <td width="160" align="center"><a href="sis_view_fornecedores.jsp"><img src="ico/ico_fornecedores.png" alt="" width="60" height="60" border="0" title="Fornecedores" /></a></td>
    <td width="160" align="center"><a href="sis_view_setores.jsp"><img src="ico/ico_setores.png" alt="" width="60" height="60" border="0" title="Setores" /></a></td>
    <td width="160" align="center"><a href="sis_view_igrejas.jsp"><img src="ico/ico_ccb.png" alt="" width="60" height="60" border="0" title="Igrejas" /></a></td>
    <td width="160" align="center"><a href="sis_view_coletas.jsp"><img src="ico/ico_coleta.png" alt="" width="60" height="60" border="0" title="Coleta" /></a></td>
    <td width="160" align="center"><a href="sis_view_construcoes.jsp"><img src="ico/ico_construcao.png" alt="" width="60" height="60" border="0" title="Construções" /></a></td>
    </tr>
   <tr>
    <td align="center">Usu&aacute;rios</td>
    <td align="center">Fornecedores</td>
    <td align="center">Setor</td>
    <td align="center">Igreja</td>
    <td align="center">Coleta</td>
    <td align="center">Servi&ccedil;os</td>
    </tr>
   <tr>
    <td height="15"></td>
   </tr>
   <tr>
    <td width="160" align="center"><a href="sis_view_pedidos.jsp"><img src="ico/ico_orcamento.png" alt="" width="60" height="60" border="0" title="Pedido de Compra" /></a><a href="#"></a></td>
    <td width="160" align="center"><a href="sis_view_pedidos_pendentes.jsp"><img src="ico/ico_pedido_p.png" alt="" width="60" height="60" border="0" title="Pedidos Pendentes" /></a></td>
    <td width="160" align="center"><a href="sis_view_compras.jsp"><img src="ico/ico_caixa.png" alt="" width="60" height="60" border="0" title="Compras" /></a></td>
    <td width="160" align="center"><a href="sis_view_produtos.jsp"><img src="ico/ico_produto.png" alt="" width="60" height="60" border="0" title="Cadastrar Produtos" /></a></td>
    <td width="160" align="center"><a href="#"><img src="ico/ico_relatorios.png" alt="" width="60" height="60" border="0" title="Relat&oacute;rios" /></a></td>
    <td width="160" align="center"><a href="sis_menu.jsp?sair=ok"><img src="ico/ico_sair.png" alt="" width="60" height="60" border="0" title="Sair do Sistema" /></a><a href="sis_view_fornecedores.jsp"></a></td>
    </tr>
   <tr>
    <td align="center">Pedido de Compra</td>
    <td align="center">Pedidos Pendentes</td>
    <td align="center"><p>Compras</p>
      </td>
    <td align="center">Produtos</td>
    <td align="center">Relat&oacute;rios</td>
    <td align="center">Sair</td>
    </tr>
   <tr>
     <td height="5" align="center">&nbsp;</td>
   </tr>
    <tr>
    <td width="160" align="center">&nbsp;</td>
    <td width="160" align="center"><a href="#"></a></td>
    <td width="160" align="center">&nbsp;</td>
    <td width="160" align="center">&nbsp;</td>
    <td width="160" align="center">&nbsp;</td>
    <td width="160" align="center"><a href="sis_view_produtos.jsp"></a></td>
    </tr>
   <tr>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    </tr>
   <tr>
    <td height="15"></td>
   </tr>
   <tr>
    <td align="center"><a href="sis_vendas_fechadas.jsp"></a></td>
    <td align="center"><a href="sis_view_orcamentos.jsp"></a></td>
    <td align="center"><a href="sis_view_relatorios.jsp"></a></td>
    <td align="center">&nbsp;</td>
    <td align="center">&nbsp;</td>
    <td align="center"><a href="sis_menu.jsp?sair=ok"></a><a href="#"></a></td>
    </tr>
   <tr>
     <td align="center">&nbsp;</td>
     <td align="center">&nbsp;</td>
     <td align="center">&nbsp;</td>
     <td align="center">&nbsp;</td>
     <td align="center">&nbsp;</td>
     <td align="center">&nbsp;</td>
     </tr>
   <tr>
     <td height="5" align="center">&nbsp;</td>
   </tr>
   
   <%if(request.getParameter("msg") != null){%>
   <tr bgcolor="#FFFFCC">
    <td height="25" colspan="6" align="center" valign="middle"><strong><font color="#FF0000"><%=msg %></font></strong></td>
   </tr>
   <%} %>
  </table>
  <!--Fim Menu Principal-->
    
  </td>
</tr>
</table>