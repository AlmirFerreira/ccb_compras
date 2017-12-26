<%@page import="javax.mail.*"%>
<%@page import="org.apache.commons.mail.DefaultAuthenticator"%>
<%@page import="org.apache.commons.mail.Email"%>
<%@page import="org.apache.commons.mail.SimpleEmail"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.mail.HtmlEmail"%>


    
    <%
    SimpleEmail email = new SimpleEmail();
    email.setHostName("smtp.googlemail.com");
    email.setSmtpPort(465);
    email.setAuthenticator(new DefaultAuthenticator("midianaweb89@gmail.com", "fernando89"));
    email.setSSLOnConnect(true);
    email.setFrom("midianaweb@gmail.com");
    email.setSubject("CCB");
    email.setMsg("Testando envio de email sistma CCB ...");
    email.addTo("almirfferreira@hotmail.com");
    email.send();
    %>