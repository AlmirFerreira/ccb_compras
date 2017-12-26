<%@LANGUAGE="VBSCRIPT"%>

<!--#include file="inc/inc_conexao.inc" -->

<%

 Call abreConexao()

%>

<%
'Criar RecordSets aqui
Dim rs01
Dim rs02
Dim rs03
Dim rs04

Dim sql01
Dim sql02
Dim sql03
Dim sql04


'Consulta o email dos Fornecedores relacionados ao pedido
set rs01 = Server.CreateObject("ADODB.Recordset")
sql01 = "SELECT f.fornEmail FROM fornecedor f INNER JOIN pedido_fornecedor p ON p.fornecedorID = f.fornecedorID WHERE p.pedidoID = '"&request.QueryString("pedidoID")&"' AND f.fornEmail <> ''"
set rs01 = conn.execute(sql01)


'Consulta a lista de produtos relacionados ao pedido
set rs02 = Server.CreateObject("ADODB.Recordset")
sql02 = "SELECT p.quantidade, pro.nome, pro.codigo FROM produto pro INNER JOIN pedido_produto p ON p.produtoID = pro.produtoID WHERE p.pedidoID = '"&request.QueryString("pedidoID")&"'"
set rs02 = conn.execute(sql02)

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">


<title>Envia Email Fornecedor</title>
</head>

<body>
	Bom dia<br />
    Venho através desse email solicitar um orçamento com o valor dos seguintes produtos<br />
	LISTA DE PRODUTOS<br /><br />
    <%
	 While Not rs02.EoF
	%>
		Produto <%=rs02.Fields.item("codigo").value%>-<%=rs02.Fields.item("nome").value%>  - Quantidade <%=rs02.Fields.item("quantidade").value%> <br />
    <%
	 rs02.MoveNext 	 
	Wend
	%>

	<br /><br />

    LISTA DE EMAILS <br /><br />
    <%
	 While Not rs01.EoF
	%>
		Enviando email para <%=rs01.Fields.item("fornEmail").value%> <br />
    <%
	 rs01.MoveNext 	 
	Wend
	%>
    

</body>
</html>

<%

 Call fechaConexao()

%>
