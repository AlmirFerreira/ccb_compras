package Pedidos;

import cadastro.Fornecedor;

public class Pedido_Fornecedor {
	
	public int pedido_fornecedorID;
	public Pedido pedido = new Pedido();
	public Fornecedor fornecedor = new Fornecedor();
	
	
	//Pesquisa todos os fornecedores adiciodos a um determinado pedido pelo ID do pedido
	public String buscaFornecedorPorPedidoID() {
		String busca = "SELECT f.fornecedorID, f.fornNomeFantasia, pf.pedido_fornecedorID, pf.fornecedorID, pf.pedidoID, pf.data ";
		busca += "FROM pedido_fornecedor pf INNER JOIN fornecedor f ON f.fornecedorID = pf.fornecedorID ";
		busca += "WHERE pf.pedidoID = '"+pedido.pedidoID+"' ORDER BY pf.data ASC LIMIT 4";
		
		return busca;
	}
	
	
	//Adiciona fornecedores ao pedido
	public String insereFornecedor() {
		return "INSERT INTO pedido_fornecedor (pedidoID, fornecedorID) VALUES ('"+pedido.pedidoID+"', '"+fornecedor.fornecedorID+"')";
	}
	
	
	//Exclui fornecedor do pedido
	public String excluiFornecedor() {
		return "DELETE FROM pedido_fornecedor WHERE pedido_fornecedorID = '"+pedido_fornecedorID+"'";
	}
	
	
	
	
	//Metodo de tratamento de Mensagens
	public String mensagem(int numeroMsg){
		
		switch (numeroMsg) {
		case 1:
			return "Fornecedor Adionado ao Pedido com Sucesso!";
			
		case 2:
			return "";
			
		case 3:
			return "Fornecedor Excluido do Pedido com Sucesso!";
			
		case 4:
			return "";
		
		case 5:
			return "";

		default:
			return "";
		}
	}
	

}
