<%@page import="javax.mail.*"%>
<%@page import="org.apache.commons.mail.DefaultAuthenticator"%>
<%@page import="org.apache.commons.mail.Email"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.mail.HtmlEmail"%>
  
  
<%
out.println("INICIO ENVIO");
try{
      HtmlEmail email = new HtmlEmail();
    email.setPopBeforeSmtp(false, "pop3.live.com", "almirfferreira@hotmail.com", "fernando89"); //Troque pelos seus dados
      email.setSmtpPort(25); //Porta do servidor smtp
      email.setAuthenticator(new DefaultAuthenticator("almirfferreira@hotmail.com", "fernando89")); //troque por seus dados
      email.setDebug(false);
      email.setHostName("smtp.live.com"); //troque pelo endereco de seu servidor smtp
      email.setFrom("almirfferreira@hotmail.com"); //Coloque aqui o endereco do remetende do email
      email.setSubject("Sistema CCB"); //Substitua aqui o Assunto da mensagem
      email.addTo("midianaweb89@gmail.com"); //Troque o para pelo email que recebera a mensagem
    //email.addCc("Com Copia"); //Aqui eh adicionado um email que sera copiado
    //email.addCc("Com Copia"); //Para adicionar mais copias basta copiar varias vezes esta linha sempre trocando o "Com Copia" pelo endereco e recebimento
      email.setTLS(false);
     
     email.setHtmlMsg("<html><head></head><body><h1>Título</h1><h2>Subtítulo</h2><p>Texto Aqui</p><img src='http://www.google.com.br/intl/en_com/images/srpr/logo1w.png' alt='alternativo'/><p>Mais Texto</p></body></html>"); //Aqui eh definido o email no formato HTML
       email.setTextMsg("Your email client does not support HTML messages"); //Esta mensagem aparece caso o email de recebimento nao suporte HTML 
 
      email.send();  //Envia a mensagem
    out.println("FIM");
    email = null;
     
}catch(Exception e){
  out.println("Exceção");
  out.println(e.getMessage());
  e.printStackTrace();
}
 
out.println("FIM");
 
%>