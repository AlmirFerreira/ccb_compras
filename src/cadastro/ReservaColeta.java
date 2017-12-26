package cadastro;

public class ReservaColeta {
	
	public int reserva_coletaID;
	public Setor setor = new Setor();
	public Pedidos.Pedido pedido = new Pedidos.Pedido();
	public float valor_reserva;
	public String status;
	
	
	//Pequisa valor reservado de determinado Setor
	public String buscaReservaPorSetor() {
		String busca = "SELECT SUM(valor_reserva) AS valorReserva ";
		busca += "FROM reserva_coleta ";
		busca += "WHERE setorID = '"+setor.setorID+"' AND status = 'R'";
		
		return busca;
	}
	
	
	//Busca reserva que ainda está ativa, pelo ID do Pedido
	public String buscaReservaAtivaPorPedidoID() {
		return "SELECT * FROM reserva_coleta WHERE pedidoID = '"+pedido.pedidoID+"' AND status = 'R'";
	}
	
	
	//Realiza uma Reserva
	public String cadastraReserva() {
		String cadastra = "INSERT INTO reserva_coleta ";
		cadastra += "(setorId, pedidoID, valor_reserva) VALUES ";
		cadastra += "('"+setor.setorID+"', '"+pedido.pedidoID+"', '"+valor_reserva+"')";
		
		return cadastra;
	}

	//Altera Status da reserva para 'Finalizado'
	public String alteraStatus() {
		return "UPDATE reserva_coleta SET status = 'F' WHERE reserva_coletaID = '"+reserva_coletaID+"'";
	}
	
}
