package Pedidos;

public class Anexos {
	
	public int anexoID;
	public Pedido pedido = new Pedido();
	public String titulo;
	public String nome_arquivo;
		
	
	//Cadastra na base de dados os dados do anexo
	public String cadastraAnexo() {
		String salva = "INSERT INTO anexos ";
		salva += "(pedidoID, titulo, nome_arquivo) ";
		salva += "VALUES ";
		salva += "('"+pedido.pedidoID+"', '"+titulo+"', '"+nome_arquivo+"')";
		
		return salva;
	}
	
	
	//Consulta lista de anexos amarradas a um pedido
	public String pesquisaAnexoPorPedidoID() {
		return "SELECT * FROM anexos WHERE pedidoID = '"+pedido.pedidoID+"'";
	}

}
