<%@ page import="java.util.Calendar" %>

<%
int year = Calendar.getInstance().get(Calendar.YEAR);
%>

<table width="980" height="65" align="center">
 <tr>
  <td valign="middle" align="center">
  Sistema para Controle de Cota&ccedil;&otilde;es e Compras - Usu&aacute;rio: <%=session.getAttribute("usuario")%><br />
  Copyright&copy; <%=year%> - Congrega&ccedil;&atilde;o Crist&atilde; no Brasil - Todos os direitos reservados
  </td>
 </tr>
</table>
