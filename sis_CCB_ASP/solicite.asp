<%@LANGUAGE="VBSCRIPT"%>

<!--#include file="Connections/conexao.asp" -->

<!--#include file="inc/inc_conexao.inc" -->

<%

 Call abreConexao()

%>



<%

if not isEmpty(request.form("enviar")) then



Dim mail

Dim nome

Dim email

Dim telefone

Dim tipoimovel

Dim bairro

Dim cidade

Dim estado

Dim valor

Dim descricao



nome = request.Form("nome")

email = request.Form("email")

telefone = request.Form("telefone")

tipoimovel = request.Form("tipoimovel")

bairro = request.Form("bairro")

cidade = request.Form("cidade")

estado = request.Form("estado")

valor = request.Form("valor")

descricao = request.Form("descricao")





conteudo =  "Nome: "& nome & vbcrlf

conteudo =  conteudo & "E-mail :"& email & vbcrlf

conteudo =  conteudo & "Telefone: "& telefone & vbcrlf

conteudo =  conteudo & "Tipo de Imovel: "& tipoimovel & vbcrlf

conteudo =  conteudo & "Bairro: "& bairro & vbcrlf

conteudo =  conteudo & "Cidade :"& cidade & vbcrlf

conteudo =  conteudo & "Estado: "& estado & vbcrlf

conteudo =  conteudo & "Valor: "& valor & vbcrlf

conteudo =  conteudo & "Descricao: "& descricao & vbcrlf



set mail = server.createobject("cdonts.newmail")

mail.from = "contato@kumimoveis.com.br" 'Este email deve ser vÃ¡lido e existir como conta de email para o domÃ­nio

mail.to = "contato@kumimoveis.com.br"

mail.subject = "Solicitacao de Imovel"

mail.body = conteudo

mail.send

    Set mail = nothing

	

	

	DIM MSG

MSG = "MENSAGEM ENVIADA COM SUCESSO!"



end if

%>



<%
'Criar RecordSets aqui
Dim rs01
Dim rs02
Dim rs03


Dim sql01
Dim sql02
Dim sql03


'Consulta tipo de ImÃ³vel
set rs01 = Server.CreateObject("ADODB.Recordset")
sql01 = "SELECT * FROM tipoimovel WHERE tipoimovelAtivo = 'S'"
set rs01 = conn.execute(sql01)


'Consulta Cidades Cadastradas
set rs02 = Server.CreateObject("ADODB.Recordset")
sql02 = "SELECT * FROM cidade WHERE cidadeAtivo = 'S'"
set rs02 = conn.execute(sql02)


'Consulta ImÃ³veis em Destaque
set rs03 = Server.CreateObject("ADODB.Recordset")
sql03 = "SELECT *, cidade.cidade, bairro.bairro, imagem.imagemNome, tipoimovel.tipoimovel FROM anuncio INNER JOIN cidade ON cidade.cidadeID = anuncio.cidadeID INNER JOIN bairro ON bairro.bairroID = anuncio.bairroID INNER JOIN imagem ON imagem.anuncioID = anuncio.anuncioID INNER JOIN tipoimovel ON tipoimovel.tipoimovelID = anuncio.tipoimovelID WHERE anuncio.anuncioAtivo = 'S' AND anuncio.anuncioClassificacao = 1 GROUP BY anuncio.anuncioID ORDER BY anuncio.anuncioDataCadastro DESC"
set rs03 = conn.execute(sql03)

%>


<%

Dim rs08

Dim rs08_cmd

Dim rs08_numRows



Set rs08_cmd = Server.CreateObject ("ADODB.Command")

rs08_cmd.ActiveConnection = MM_conexao_STRING

rs08_cmd.CommandText = "SELECT * FROM pagempresa WHERE pagEmpresaAtivo = 'S'" 

rs08_cmd.Prepared = true



Set rs08 = rs08_cmd.Execute

rs08_numRows = 0

%>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html;" />

<link rel="stylesheet" href="css/estilo.css" />
<link rel="stylesheet" href="css/style.css" type="text/css" media="screen" />
<script type="text/javascript">var _siteRoot='default.asp',_root='default.asp';</script>
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="js/scripts.js"></script>
<script type="text/javascript" src="js/MascaraValidacao.js"></script> 

<title>Solicite seu Im&oacute;vel</title>


<script language="JavaScript" type="text/javascript">

	function Valida(){

		

		if(form2.nome.value == ""){

			alert("Informe seu Nome por gentileza.");

			form2.nome.focus();return false;

			}

		

		if(form2.telefone.value == ""){

			alert("Informe o seu Telefone por gentileza.");

			form2.telefone.focus();return false;

			}

			

		if(form2.email.value == ""){

			alert("Informe seu e-mail por gentileza.");

			form2.email.focus();return false;

			}

			

		if(form2.tipoimovel.value == ""){

			alert("Informe o Tipo de Imóvel.");

			form2.tipoimovel.focus();return false;

			}

			

		if(form2.bairro.value == ""){

			alert("Informe o bairro.");

			form2.bairro.focus();return false;

			}

		

		if(form2.cidade.value == ""){

			alert("Informe a cidade.");

			form2.cidade.focus();return false;

			}

		

		if(form2.estado.value == ""){

			alert("Informe o estado.");

			form2.estado.focus();return false;

			}

			

		if(form2.valor.value == ""){

			alert("Informe o valor estimado.");

			form2.valor.focus();return false;

			}

			

		if(form2.descricao.value == ""){

			alert("Informe todas as informações que julgar necessárias.");

			form2.descricao.focus();return false;

			}

	

	}



</script>

</head>

<body>

<div id="cabecalho">
	<!--#include file="inc/cabecalho.inc" --> 
</div>

<div id="corpo">

<table align="center">
 <tr>
  <td>
 <div id="header">
 <div class="wrap">
  <div id="slide-holder">
	<div id="slide-runner">
    <%
	 Dim contador
	 contador = 1
	 
	 While Not rs03.EoF
	%>
    	<%if contador < 8 Then%>
        <a href="anuncio.asp?anuncioID=<%=rs03.Fields.item("anuncioID").value%>"><img id="slide-img-<%=contador%>" src="sistema/upload/<%=rs03.Fields.item("imagemNome").value%>" class="slide" alt="" width="490" height="370" border="0" /></a>
        <%end if%>
    <%
	 contador = contador + 1
	 rs03.MoveNext
	 
	 if(rs03.EoF AND contador <= 7)Then
	 	rs03.MoveFirst
	 End if
	 
	Wend
	%>
    <div id="slide-controls">
     <p id="slide-client" class="text"><strong>Imv&oacute;veis em Destaque</strong><span></span></p>
     <p id="slide-desc" class="text"></p>
     <p id="slide-nav"></p>
    </div>
    </div>
    
    <div id="slide-runner2">
        <!--#include file="inc/buscar.inc" --> 
    </div>
	<!--content featured gallery here -->
  </div>
  
  
   <script type="text/javascript">
    if(!window.slider) var slider={};slider.data=[{"id":"slide-img-1","client":"","desc":""},{"id":"slide-img-2","client":"","desc":""},{"id":"slide-img-3","client":"","desc":""},{"id":"slide-img-4","client":"","desc":""},{"id":"slide-img-5","client":"","desc":""},{"id":"slide-img-6","client":"","desc":""},{"id":"slide-img-7","client":"","desc":""}];
   </script>
 </div>
 </div> 
  </td>
 </tr>
</table>


<table style="width:100%" border="0" align="center" cellpadding="2" cellspacing="2">

    <tr>

      <td height="27" colspan="2" align="center" bgcolor="#dddddd"><font size="4" color="#002046">Solicite seu Im&oacute;vel</font></td>

      </tr>

    <tr>

      <td height="219" align="center" valign="top"><br><form name="form2" method="post" action="solicite.asp" onSubmit="return Valida();">

        <table style="width:100%" border="0" cellspacing="3" cellpadding="3">

          <tr>

            <td colspan="2" align="center"><p><font size="2" color="#666666">Entre em contato conosco atrav&eacute;s do formul&aacute;rio abaixo, e solicite um im&oacute;vel de acordo &agrave; sua vontade.</font>

              </p>

              <p><font size="2" color="#666666">Faremos o poss&iacute;vel para encontrar o im&oacute;vel desejado!!</font></td>

            </tr>

          <tr>

            <td width="464" valign="top"><table width="464" border="0" cellspacing="3" cellpadding="3">

  <tr>

    <td colspan="3" align="left"><%=MSG%></td>

    </tr>

  <tr>

    <td width="86" align="right"><span class="contato">Nome:</span></td>

    <td colspan="2" align="left">      <span class="contato">

      <input type="text" class="text" name="nome" id="nome" size="50" />    

      </span></td>

  </tr>

  <tr>

    <td align="right"><span class="contato">E-mail:</span></td>

    <td colspan="2" align="left">      <span class="contato">

      <input type="text" class="text" name="email" id="email" size="40" maxlength="100" />    

      </span></td>

  </tr>

  <tr>

    <td align="right"><span class="contato">Telefone:</span></td>

    <td colspan="2" align="left">      <span class="contato">

      <input type="text" class="text" name="telefone" id="telefone" size="40" onKeyPress="MascaraTelefone(form2.telefone);" maxlength="15"  onBlur="ValidaTelefone(form1.clienteCelular);" />    

      </span></td>

  </tr>

  <tr>

    <td align="right"><span class="contato">Tipo de Im&oacute;vel:</span></td>

    <td colspan="2" align="left">

      <span class="contato">

      <select name="tipoimovel" size="1" class="text" id="tipoimovel">

        <option value="" selected>-- escolha --</option>

        <option value="APARTAMENTO">APARTAMENTO</option>

        <option value="CASA">CASA</option>

        <option value="CHACARA">CH&Aacute;CARA</option>

        <option value="EDIFIÂCIO">EDIF&Iacute;CIO</option>

        <option value="FAZENDA">FAZENDA</option>

        <option value="GALPAO">GALP&Atilde;O</option>

        <option value="POUSADA">POUSADA</option>

        <option value="PREDIO RESIDENCIAL">PR&Eacute;DIO RESID&Ecirc;NCIAL</option>

        <option value="PREDIO COMERCIAL">PR&Eacute;DIO COMERCIAL</option>

        <option value="SALA COMERCIAL">SALA COMERCIAL</option>

        <option value="SALAO">SAL&Atilde;O</option>

        <option value="SIÂTIO">S&Iacute;TIO</option>

        <option value="SOBRADO">SOBRADO</option>

        <option value="TERRENO">TERRENO</option>

        <option value="COBERTURA">COBERTURA</option>

        <option value="CASA EM CONDOMINIO">CASA EM CONDOM&Iacute;NIO</option>

      </select>

      </span></td>

  </tr>

  <tr>

    <td align="right"><span class="contato">Bairro:</span></td>

    <td colspan="2" align="left">      <span class="contato">

      <input type="text" class="text" name="bairro" id="bairro" size="40" />    

      </span></td>

  </tr>

  <tr>

    <td align="right"><span class="contato">Cidade:</span></td>

    <td colspan="2" align="left">      <span class="contato">

      <input type="text" class="text" name="cidade" id="cidade" size="40" />    

      </span></td>

    </tr>

  <tr>

    <td align="right"><span class="contato">Estado:</span></td>

    <td colspan="2" align="left">

      <span class="contato">

      <select name="estado" class="text" id="estado">

        <option value="" selected>-- escolha --</option>

        <option value="AC">AC</option>

        <option value="AL">AL</option>

        <option value="AM">AM</option>

        <option value="AP">AP</option>

        <option value="BA">BA</option>

        <option value="CE">CE</option>

        <option value="DF">DF</option>

        <option value="ES">ES</option>

        <option value="GO">GO</option>

        <option value="MA">MA</option>

        <option value="MG">MG</option>

        <option value="MS">MS</option>

        <option value="MT">MT</option>

        <option value="PA">PA</option>

        <option value="PB">PB</option>

        <option value="PE">PE</option>

        <option value="PI">PI</option>

        <option value="PR">PR</option>

        <option value="RJ">RJ</option>

        <option value="RN">RN</option>

        <option value="RO">RO</option>

        <option value="RR">RR</option>

        <option value="RS">RS</option>

        <option value="SC">SC</option>

        <option value="SE">SE</option>

        <option value="SP">SP</option>

        <option value="TO">TO</option>

      </select>

      </span></td>

  </tr>

  <tr>  <td align="right"><span class="contato">Valor:</span></td>

    <td colspan="2" align="left">      <span class="contato">

      <input type="text" class="text" name="valor" id="valor" size="40" />    

      </span></td>

    </tr>

    <tr>

    <td colspan="3" align="center"><span class="contato">Outras Informa&ccedil;&otilde;es</span></td>

  </tr>

  <tr>

    <td colspan="3" align="center"><label for="descricao"></label>

      <textarea name="descricao" class="text" id="descricao" cols="50" rows="5"></textarea></td>

  </tr>

  <tr>

    <td colspan="3" align="center">

      <input name="enviar" type="submit" class="btn_submit" id="enviar"  value="Enviar" /></td>

    </tr>

    </table></td>

            <td width="474" align="right" valign="top"><img src="images/solicite.jpg"></td>

          </tr>

          <tr>

            <td valign="top">&nbsp;</td>

            <td align="center" valign="top">&nbsp;</td>

          </tr>

        </table>

      </form></td>

      </tr>

    <tr>

      <td height="19" align="center" valign="top">&nbsp;</td>

    </tr>

    <tr>

      <td  align="center" valign="top"> 

</td>

    </tr>

  </table>
<br />
</div>


<div id="rodape">
	<!--#include file="inc/rodape.inc" --> 
</div>

</body>
</html>

<%

 Call fechaConexao()

%>
