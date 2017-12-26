<%//@ page errorPage="index.jsp?erro=3" %>
<%@ page import="java.sql.*" %>
<%@ include file="inc/seguranca.jsp" %>
<%@ include file="inc/conexao.jsp" %>


<%@ page language="java" import="javazoom.upload.*,java.util.*" %>

<jsp:useBean id="upBean" scope="page" class="javazoom.upload.UploadBean" >
  <!--<jsp:setProperty name="upBean" property="folderstore" value="/home/fortesystem/webapps/engmarcia/download" />-->
  <jsp:setProperty name="upBean" property="folderstore" value="C:\xampp\tomcat\webapps\sis_CCB\Download" />
</jsp:useBean>

<jsp:useBean id="anexos" class="Pedidos.Anexos" scope="page"></jsp:useBean>


<%
	String msg = "";

      if (MultipartFormDataRequest.isMultipartFormData(request))
      {
         // Usa MultipartFormDataRequest para Converter o HTTP request.
         MultipartFormDataRequest mrequest = new MultipartFormDataRequest(request);
         String todo = null;
         if (mrequest != null) todo = mrequest.getParameter("todo");
	     if ( (todo != null) && (todo.equalsIgnoreCase("upload")) )
	     {
                Hashtable files = mrequest.getFiles();
                if ( (files != null) && (!files.isEmpty()) )
                {
                    UploadFile file = (UploadFile) files.get("arquivo");
                    
                    //if (file != null) out.println("<li>Form field : uploadfile"+"<BR> Uploaded file : "+file.getFileName()+" ("+file.getFileSize()+" bytes)"+"<BR> Content Type : "+file.getContentType());
                    
                    // Usa o bean para alocar os dados no diretorio especificado em jsp:setProperty que está no topo.
                    upBean.store(mrequest, "arquivo");
					
					
					//Imprime a mensagem na tela
					msg = "Arquivo "+file.getFileName()+" Salvo com Sucesso!";
					
					anexos.pedido.pedidoID 	= Integer.parseInt(mrequest.getParameter("pedidoID"));
					anexos.titulo			= mrequest.getParameter("titulo");
					anexos.nome_arquivo		= file.getFileName();
	
					//Salva na base de dados as informaçőes do arquivo que foi feito o Upload
					st.execute(anexos.cadastraAnexo());
                }
                else
                {
                  out.println("Erro ao tentar Salvar o arquivo!");
                }
	     }
         else out.println("<BR> todo="+todo);
      }
%>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Anexar Arquivos</title>

<link href="css/outros.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">

function verForm(){
	
		
	if(document.upform.arquivo.value==""){
		alert("Favor selecionar um arquivo para fazer UPLOAD!");
		document.upform.arquivo.focus();
		return false;
	}
	
	if(document.upform.titulo.value==""){
		alert("Informe um Titulo \npara facilitar a busca futuramente.");
		document.upform.titulo.focus();
		return false;
	}
	
}

</script>

</head>

<body>

<form method="post" action="sis_anexar_orcamento.jsp" name="upform" enctype="multipart/form-data" onsubmit="return verForm(this)" >
 <table width="400" align="center" cellpadding="4" cellspacing="4" style="border:1px solid #444444">
  <tr bgcolor="#EEEEEE">
   <td colspan="2" align="center"><strong>UPLOAD DE ARQUIVOS</strong></td>
  </tr>
  <tr>
   <td align="left">Arquivo</td>
   <td align="left"><input id="arquivo" name="arquivo" type="file" size="26" maxlength="50" /></td>
  </tr>
  <tr>
    <td align="left">T&iacute;tulo do Arquivo</td>
    <td align="left"><input type="text" id="titulo" name="titulo" size="40" maxlength="50" /></td>
  </tr>
  <tr>
    <td align="left"><input name="Submit" type="submit" class="botao" value="Enviar" /></td>
    <td align="left">
    <input type="hidden" name="todo" value="upload" />
    <input type="hidden" name="pedidoID" value="<%=request.getParameter("pedidoID")%>" />
    </td>
  </tr>
  <tr>
    <td colspan="2" align="center"><font color="#FF0000"><strong><%=msg%></strong></font></td>
    </tr>
 </table>
 </form>

</body>
</html>
