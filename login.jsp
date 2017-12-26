<%@page import="java.sql.*" %>
<%@ include file="inc/conexao.jsp" %>

<jsp:useBean id="usuario" class="cadastro.Usuario" scope="page"></jsp:useBean>
<jsp:useBean id="acesso" class="cadastro.Acesso" scope="page"></jsp:useBean>

<%
//Instancia um objeto do tipo ResultSet para receber resultado de uma Consulta
ResultSet rs = null;
%>

<%
//Verifica se os valores não vieram nullos
if(request.getParameter("usuario") != null || request.getParameter("senha") != null){

//Recupera valores que vem do formulário alimentando o objeto do Tipo Usuario
usuario.login = request.getParameter("usuario");
usuario.senha = request.getParameter("senha");

//chama o Metodo que irá passar a consulta à Base de Dados
rs = st.executeQuery(usuario.logar());

//verifica se a consulta trouxe algum registro
//se trouxe é porque existe um usuário, se não é porque não existe
	if(rs.next()){
		//Determina tempo da Sessão
		session.setMaxInactiveInterval(3600);
		//Salva o Nome do Usuario na Sessão
		session.setAttribute("usuario", usuario.login);
		//Salva o ID da Empresa na Sessão
		session.setAttribute("empresaID", "1");
		//Salva na Sessão o tipo de usuario
		session.setAttribute("nivel", rs.getString("usuarioNivel"));
		//Salva na Sessão o ID do usuário
		session.setAttribute("usuarioID", rs.getString("usuarioID"));
		//Salva na Sessão o Status LOGADO
		session.setAttribute("status", "LOGADO");
		//Registra o Acesso na tabela acesso na Base de Dados
		acesso.usuario = (String) session.getAttribute("usuario");
		acesso.retornaIP();
		//st.execute(acesso.registraAcesso(request.getRemoteAddr()));	
		//Redireciona para a pagina sis_menu
		response.sendRedirect("sis_menu.jsp");
	}else{
		response.sendRedirect("index.jsp?erro=2");
	}

}else{
	response.sendRedirect("index.jsp?erro=1");
}
%>

<%out.println(acesso.retornaIP());%>