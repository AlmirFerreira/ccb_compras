<%@ page errorPage="index.jsp?erro=3" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/acesso_nivel.jsp" %>

<jsp:useBean id="fornecedor" class="cadastro.Fornecedor" scope="page"></jsp:useBean>

<%
//Trata mensagens
//variaveis que serao utilizadas para verifica�ao
String msg = "";
int numeroMsg;
//verifica se foi passado alguma mensagem via URL
if(request.getParameter("msg") != null){
	numeroMsg = Integer.parseInt(request.getParameter("msg"));
	msg = fornecedor.mensagem(numeroMsg);
}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="java.text.SimpleDateFormat"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>CCB</title>

<!-- Fa�a o include da lib do jQuery -->
<script type="text/javascript" src="js/cep.js"></script>
<script type="text/javascript" src="js/interface.js"></script>
<script type="text/javascript" src="js/MascaraValidacao.js"></script> 

<script type="text/javascript">
	// Fun��o �nica que far� a transa��o
	function getEndereco() {
			// Se o campo CEP n�o estiver vazio
			if($.trim($("#cep").val()) != ""){
				/* 
					Para conectar no servi�o e executar o json, precisamos usar a fun��o
					getScript do jQuery, o getScript e o dataType:"jsonp" conseguem fazer o cross-domain, os outros
					dataTypes n�o possibilitam esta intera��o entre dom�nios diferentes
					Estou chamando a url do servi�o passando o par�metro "formato=javascript" e o CEP digitado no formul�rio
					http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cep").val()
				*/
				$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+$("#cep").val(), function(){
					// o getScript d� um eval no script, ent�o � s� ler!
					//Se o resultado for igual a 1
			  		if(resultadoCEP["resultado"]){
						// troca o valor dos elementos
						$("#rua").val(unescape(resultadoCEP["tipo_logradouro"])+": "+unescape(resultadoCEP["logradouro"]));
						$("#bairro").val(unescape(resultadoCEP["bairro"]));
						$("#cidade").val(unescape(resultadoCEP["cidade"]));
						$("#estado").val(unescape(resultadoCEP["uf"]));
					}else{
						alert("Endere�o n�o encontrado");
					}
				});				
			}			
	}
</script>

<!--[if lt IE 7]>
 <style type="text/css">
 .dock img { behavior: url(iepngfix.htc) }
 </style>
<![endif]-->

<script type="text/javascript">

//Verificar e Formul�rio
function verForm(){

	if(document.form1.fornNomeFantasia.value == ""){
	alert("Favor informar o nome Fantasia!");
	document.form1.fornNomeFantasia.focus();
	return false;
	}
	

	if(document.form1.fornCnpj.value.length < 11){
	alert("Favor informar o CNPJ!");
	document.form1.fornCnpj.focus();
	return false;
	}
	
	if(document.form1.cep.value.lenght < 8){
	alert("Favor informar o Cep!");
	document.form1.cep.focus();
	return false;
	}

	if(document.form1.rua.value == ""){
	alert("Favor informar o Endere�o!");
	document.form1.rua.focus();
	return false;
	}

	if(document.form1.fornNumero.value == ""){
	alert("Favor informar o N�mero!");
	document.form1.fornNumero.focus();
	return false;
	}	

	if(document.form1.bairro.value == ""){
	alert("Favor informar o Bairro!");
	document.form1.bairro.focus();
	return false;
	}

	if(document.form1.cidade.value == ""){
	alert("Favor informar o Cidade!");
	document.form1.cidade.focus();
	return false;
	}	
	
	if(document.form1.fornUf.value == ""){
	alert("Favor informar o Estado (UF)!");
	document.form1.fornUf.focus();
	return false;
	}

	if(document.form1.fornContato.value == ""){
	alert("Favor informar o nome do Contato (Representante)!");
	document.form1.fornContato.focus();
	return false;
	}
	
	if(document.form1.fornTelefone.value.length < 8){
	alert("Favor informar o n�mero de telefone!");
	document.form1.fornTelefone.value = "";
	document.form1.fornTelefone.focus();
	return false;
	}		
	
			
}

//Valida se o Campo � Num�rico
function numero()	{
if (event.keyCode<48 || event.keyCode>57){return false;} 
}

</script>

<link href="css/menu.css" rel="stylesheet" type="text/css" />
<link href="css/geral.css" rel="stylesheet" type="text/css" />

</head>
<body onload="javascript: document.form1.fornNomeFantasia.focus()">

<div id="container">

<div id="topo">
 <jsp:include page="inc/menu_superior.jsp" />
</div>


<div id="corpo">

<!--INICIO DO FORMUL�RIO DE CADASTRO-->
 <form name="form1" method="post" action="sis_insert_manager_fornecedor.jsp" id="form1" onSubmit="return verForm(this)">
   <table width="1010" align="center" height="470">
    <tr>
    <td height="25" bgcolor="#EEEEEE" colspan="2">
      <input type="button" class="botao" onclick="javascript: window.location.href='sis_view_fornecedores.jsp'" value="Lista Fornecedores" />
    </td>
    </tr>
    <tr>
     <td height="20" colspan="2" align="center"><strong>CADASTRAR FORNECEDOR</strong></td>
    </tr>
    <%if(request.getParameter("msg") != null){ %>
     <tr>
      <td align="center" colspan="2" bgcolor="#ff0000"><font color="#ffffff"><strong><%=msg %></strong></font></td>
     </tr>
    <%}%>
    <tr>
    <!--PRIMEIRA COLUNA-->
     <td valign="top">
     
      <table align="center">
       <tr>
         <td align="left">Nome Fantasia</td>
       </tr>
       <tr>
        <td colspan="3" align="left"><input type="text" name="fornNomeFantasia" id="fornNomeFantasia" size="70" maxlength="40"/></td>
       </tr>
       <tr>
        <td align="left">Razao Social</td>
       </tr>
       <tr>
        <td colspan="3" align="left"><input type="text" name="fornRazaoSocial" id="fornRazaoSocial" size="70" maxlength="40"/></td>
       </tr>
       <tr align="left">
        <td>CNPJ</td>
        <td>Inscri�ao Estadual</td>
        <td>Inscri�ao Municipal</td>
       </tr>
       <tr>
        <td align="left"><input type="text" name="fornCnpj" id="cnpj" size="14" maxlength="18" style="width:120px" onblur="ValidarCNPJ(form1.fornCnpj)" onKeyPress="MascaraCNPJ(form1.fornCnpj);" ></td>
        <td align="left"><input type="text" name="fornInscEstadual" id="inscEst" size="14" maxlength="15" style="width:120px" onKeyPress="MascaraInscEst(form1.inscEst)"></td>
        <td align="left"><input type="text" name="fornInscMunicipal" id="fornInscMunicipal" size="14" maxlength="14" style="width:120px" onKeyPress="return numero(this)"></td>
       </tr>
       <tr valign="middle" bgcolor="#CCCCCC">
         <td colspan="3" align="center" height="30">Busque o Endere&ccedil;o pelo CEP:           <input name="cep" id="cep" type="text" style="width:120px" onKeyPress="return numero(this)" maxlength="8" onBlur="getEndereco()" size="14" /></td>
         </tr>
       <tr>
        <td colspan="2" align="left">Endere�o</td>
        <td align="left">N�mero</td>
       </tr>
       <tr>
        <td colspan="2" align="left"><input name="rua" id="rua" type="text" size="45" maxlength="40"/></td>
        <td align="left"><input name="fornNumero" type="text" id="fornNumero" style="width:120px" onKeyPress="return numero(this)" size="14" maxlength="6"/></td>
       </tr>
       <tr>
        <td colspan="2" align="left">Bairro</td>
        <td align="left">&nbsp;</td>
       </tr>
       <tr>
        <td colspan="2" align="left"><input name="bairro" id="bairro" type="text" size="45" maxlength="40" /></td>
        <td align="left">&nbsp;</td>
       </tr>
       <tr>
        <td colspan="2" align="left">Cidade</td>
        <td align="left">UF</td>
       </tr>
       <tr>
        <td colspan="2" align="left"><input name="cidade" id="cidade" type="text" size="45" maxlength="40" /></td>
        <td align="left">
        <select name="fornUf" id="fornUf" style="width:48px">
          <option value="AC">AC</option>
          <option value="AL">AL</option>
          <option value="AP">AP</option>
          <option value="AM">AM</option>
          <option value="BA">BA</option>
          <option value="CE">CE</option>
          <option value="DF">DF</option>
          <option value="ES">ES</option>
          <option value="GO">GO</option>
          <option value="MA">MA</option>
          <option value="MT">MT</option>
          <option value="MS">MS</option>
          <option value="MG">MG</option>
          <option value="PA">PA</option>
          <option value="PB">PB</option>
          <option value="PR">PR</option>
          <option value="PE">PE</option>
          <option value="PI">PI</option>
          <option value="SC">SC</option>
          <option value="SE">SE</option>
          <option value="SP" selected="selected">SP</option>
          <option value="RJ">RJ</option>
          <option value="RN">RN</option>
          <option value="RS">RS</option>
          <option value="RO">RO</option>
          <option value="RR">RR</option>
          <option value="TO">TO</option>                        
          </select>
        </td>
       </tr>
      </table>
         
        </td>
        
        <!--SEGUNDA COLUNA--> 
        <td valign="top">
         
         <table align="center">
          <tr align="left">
            <td>Complemento</td>
          </tr>
          <tr align="left">
            <td colspan="3" align="left"><input type="text" name="fornComplemento" id="fornComplemento" size="70" maxlength="200"/></td>
          </tr>
          <tr align="left">
            <td width="131">Contato</td>
          </tr>
          <tr align="left">
            <td colspan="3"><input type="text" name="fornContato" id="fornContato" size="70" maxlength="30"/></td>
          </tr>
          <tr align="left">
            <td width="131">Telefone</td>
            <td width="131">Fax</td>
            <!--<td width="133">Radio</td>-->
          </tr>
          <tr align="left">
           <td><input type="text" name="fornTelefone" id="fornTelefone" size="14" onKeyPress="MascaraTelefone(form1.fornTelefone);" maxlength="14"  onBlur="ValidaTelefone(form1.fornTelefone);" style="width:120px"></td>
           <td><input type="text" name="fornFax" id="fornFax" size="14" maxlength="14" style="width:120px"></td>
           <td><input type="hidden" name="fornRadio" id="fornRadio" size="14" maxlength="14" style="width:120px"></td
           ></tr>
           <tr align="left">
            <td width="131" align="left">Celular</td>
            <td align="left"></td>
            <td width="133"></td>
          </tr>
          <tr align="left">
          <td align="left"><input type="text" name="fornCelular" id="fornCelular" size="14" onKeyPress="MascaraTelefone(form1.fornCelular);" maxlength="15"  onBlur="ValidaTelefone(form1.fornCelular);" style="width:120px">
            
          <td align="left">
          <select name="operadoraCelular" id="operadoraCelular" style="width:48px">
          <option value="" selected></option>
          <option value="TIM">TIM</option>
          <option value="OI">OI</option>
          <option value="VIVO">VIVO</option>
          <option value="CLARO">CLARO</option>
          <option value="Brasil Telecom">Brasil Telecom</option>
          <option value="CTBC">CTBC</option>                      
          </select>
          </td> 
           <td></td>
          </tr>
          <tr align="left">
            <td width="131">E-mail</td>
          </tr>
          <tr align="left">
            <td colspan="3"><input type="text" name="fornEmail" id="fornEmail" style="text-transform:lowercase;" size="70" maxlength="100"/></td>
          </tr>
          <tr align="left">
            <td width="131">Site</td>
          </tr>
          <tr align="left">
            <td colspan="3"><input type="text" name="fornSite" id="fornSite" style="text-transform:lowercase;" value="http://" size="70" maxlength="100"></td>
          </tr>
          <tr align="left">
           <td>
            <input type="hidden" name="fornUsuario" id="fornUsuario" value="<%=session.getAttribute("usuario")%>">
           </td>
          </tr>
          <tr align="left">
           <td colspan="2"><input type="submit" name="Cadastrar" class="botao" value="Cadastrar" />             <input type="reset" class="botao" value="Apagar" /></td>
           </tr>
          <tr align="left">
           <td>&nbsp;</td>
          </tr>
          <tr align="left">
           <td colspan="2"><font color="#FF0000"><b></b></font></td>
          </tr>
         </table>
         
        </td>
       </tr>
      </table>
     
     </td>
    </tr>
   </table>
  </form>
  <!--FIM DO FORMUL�RIO-->

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