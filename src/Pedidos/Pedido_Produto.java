package Pedidos;

import cadastro.Produto;

public class Pedido_Produto {
	
	public int pedido_produtoID;
	public Pedido pedido = new Pedido();
	public Produto produto = new Produto();
	public float quantidade;
	public float fornecedor1;
	public float fornecedor2;
	public float fornecedor3;
	public float fornecedor4;
	
	
	//Pesquisa produtos adicionados a um determinado Pedido através do ID do Pedido
	public String buscaProdutosPorPedidoID() {
		String buscar = "SELECT p.produtoID, p.nome, p.unidade, pp.pedido_produtoID, pp.pedidoID, pp.quantidade, pp.fornecedor1, pp.fornecedor2, pp.fornecedor3, pp.fornecedor4 ";
		buscar += "FROM pedido_produto pp INNER JOIN produto p ON p.produtoID = pp.produtoID ";
		buscar += "WHERE pp.pedidoID = '"+pedido.pedidoID+"' ORDER BY pp.data ASC";
		
		return buscar;
	}
	
	//Pesquisa produtos adicionados a um determinado Pedido através do ID do Pedido
	public String buscaProdutosPorPedido_ProdutoID() {
		String buscar = "SELECT p.produtoID, p.nome, p.unidade, pp.pedido_produtoID, pp.pedidoID, pp.quantidade, pp.fornecedor1, pp.fornecedor2, pp.fornecedor3, pp.fornecedor4 ";
		buscar += "FROM pedido_produto pp INNER JOIN produto p ON p.produtoID = pp.produtoID ";
		buscar += "WHERE pp.pedido_produtoID = '"+pedido_produtoID+"' ORDER BY pp.data ASC";
		
		return buscar;
	}
	
	
	//Pesquisa as somas dos fornecedores por Pedido
	public String buscaTotalFornecedorPorPedidoID() {
		String buscar = "SELECT SUM(fornecedor1) AS f1, SUM(fornecedor2) AS f2, SUM(fornecedor3) AS f3, SUM(fornecedor4) AS f4 ";
		buscar += "FROM pedido_produto ";
		buscar += "WHERE pedidoID = '"+pedido.pedidoID+"'";
		
		return buscar;
	}
	
	//Cadastra um novo produto no pedido
	public String insereProduto() {
		return "INSERT INTO pedido_produto (pedidoID, produtoID, quantidade) VALUES ('"+pedido.pedidoID+"', '"+produto.produtoID+"', '"+quantidade+"')";
	}
	
	//Exclui um produto do pedido
	public String excluiProduto() {
		return "DELETE FROM pedido_produto WHERE pedido_produtoID = '"+pedido_produtoID+"'";
	}
	
	
	//Edita valor Fornecedor
	public String alteraValorFornecedor() {
		String altera =  "UPDATE pedido_produto SET fornecedor1 = '"+fornecedor1+"', fornecedor2 = '"+fornecedor2+"', ";
		altera += "fornecedor3 = '"+fornecedor3+"', fornecedor4 = '"+fornecedor4+"' ";
		altera += "WHERE pedido_produtoID = '"+pedido_produtoID+"'";
		
		return altera;
	}
	
	
	//Metodo de tratamento de Mensagens
	public String mensagem(int numeroMsg){
		
		switch (numeroMsg) {
		case 1:
			return "Produto Adicionado ao Pedido com Sucesso!";
			
		case 2:
			return "";
			
		case 3:
			return "Produto Excluido do Pedido com Sucesso!";
			
		case 4:
			return "";
		
		case 5:
			return "";

		default:
			return "";
		}
	}

}
