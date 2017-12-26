package Pedidos;

import cadastro.Construcao;
import cadastro.Usuario;

public class Pedido {
	
	public int pedidoID;
	public Construcao servico = new Construcao();
	public Usuario usuario = new Usuario();
	public String observacoes;
	public String status;
	
	
	//Pesquisa os Pedidos cadastrados
	public String listaPedidos() {
		String consulta = "SELECT p.pedidoID, p.status ,p.date, c.titulo ";
		consulta += "FROM pedido p INNER JOIN construcao c ON c.construcaoID = p.servicoID ";
		consulta += "WHERE p.status <> 'F' ORDER BY p.date ASC";
		return consulta;
	}
	
	//Pesquisa os Pedidos Por Id de usuário Logado
	public String listaPedidosPorId() {
		String consulta = "SELECT p.pedidoID, p.status ,p.date, c.titulo ";
		consulta += "FROM pedido p INNER JOIN construcao c ON c.construcaoID = p.servicoID ";
		consulta += "WHERE p.status <> 'F' AND usuarioID = '"+usuario.usuarioID+"' ORDER BY p.date ASC";
		return consulta;
	}
	
	
	//Pesquisa os Pedidos Finalizados (COMPRAS)
	public String listaPedidosFinalizados() {
		String consulta = "SELECT p.pedidoID, p.status ,p.date, c.titulo ";
		consulta += "FROM pedido p INNER JOIN construcao c ON c.construcaoID = p.servicoID ";
		consulta += "WHERE p.status = 'F' ORDER BY p.date ASC";
		return consulta;
	}
	
	//Pesquisa os Pedidos Finalizados (COMPRAS), Por Id de usuário Logado
	public String listaPedidosFinalizadosPorId() {
		String consulta = "SELECT p.pedidoID, p.status ,p.date, c.titulo ";
		consulta += "FROM pedido p INNER JOIN construcao c ON c.construcaoID = p.servicoID ";
		consulta += "WHERE p.status = 'F' AND usuarioID = '"+usuario.usuarioID+"' ORDER BY p.date ASC";
		return consulta;
	}
	
	//Pesquisa o Pedido por pedidoID
	public String litaPedidoPorPedidoID() {
		return "SELECT * FROM pedido WHERE pedidoID = '"+pedidoID+"'";
	}
	
	//Pesquisa os Pedidos Pendentes
	public String listaPedidosPendentes() {
		String consulta = "SELECT p.pedidoID, p.status ,p.date, c.titulo, u.usuarioNome AS responsavel ";
		consulta += "FROM pedido p INNER JOIN construcao c ON c.construcaoID = p.servicoID ";
		consulta += "INNER JOIN usuario u ON u.usuarioID = p.usuarioID ";
		consulta += "WHERE p.status = 'P' ORDER BY p.date ASC";
		return consulta;
	}
	
	
	//Busca qual é o setor vinculado ao pedido por pedidoID
	public String buscaSetorPorPedidoID() {
		String busca = "SELECT s.setorID ";
		busca += "FROM pedido p ";
		busca += "INNER JOIN construcao c ON c.construcaoID = p.servicoID ";
		busca += "INNER JOIN igreja i ON i.igrejaID = c.igrejaID ";
		busca += "INNER JOIN setor s ON s.setorID = i.setorID ";
		busca += "WHERE p.pedidoID = '"+pedidoID+"'";
		
		return busca;
	}
	
	
	//Busca qual é o setor vinculado ao pedido por pedidoID
	public String buscaIgrejaPorPedidoID() {
		String busca = "SELECT i.igrejaID ";
		busca += "FROM pedido p ";
		busca += "INNER JOIN construcao c ON c.construcaoID = p.servicoID ";
		busca += "INNER JOIN igreja i ON i.igrejaID = c.igrejaID ";
		busca += "WHERE p.pedidoID = '"+pedidoID+"'";
		
		return busca;
	}
	
	
	//Cadastra um novo pedido
	public String cadastraPedido() {
		return "INSERT INTO pedido (servicoID, usuarioID) VALUES ('"+servico.construcaoID+"', '"+usuario.usuarioID+"')";
	}
	
	
	//Altera o Status do Pedido
	public String alteraStatus() {
		return "UPDATE pedido SET status = '"+status+"' WHERE pedidoID = '"+pedidoID+"'";
	}
	
	
	//Altera Observações do Pedido
	public String alteraObservacoes() {
		return "UPDATE pedido SET observacoes = '"+observacoes+"' WHERE pedidoID = '"+pedidoID+"'";
	}
	
	
	//Exclui um pedido
	public String excluiPedido() {
		return "DELETE FROM pedido WHERE pedidoID = '"+pedidoID+"'";
	}
	
	
	//Metodo de tratamento de Mensagens
	public String mensagem(int numeroMsg){
		
		switch (numeroMsg) {
		case 1:
			return "Pedido Cadastrado com Sucesso!";
			
		case 2:
			return "Pedido Alterado com Sucesso!";
			
		case 3:
			return "Pedido Excluido com Sucesso!";
			
		case 4:
			return "Pedido enviado, aguarde o orçamento!";
		
		case 5:
			return "";

		default:
			return "";
		}
	}

}
