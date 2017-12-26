package cadastro;

public class Coleta {
	
	public int coletaID;
	public Igreja igreja = new Igreja();
	public float valor;
	
	
	//Insere nova Coleta
	public String insereColeta() {
		return "INSERT INTO coleta (igrejaID, valor) VALUES ('"+igreja.igrejaID+"', '"+valor+"')";
	}
	
	
	
	//Metodo de tratamento de Mensagens
	public String mensagem(int numeroMsg){
		
		switch (numeroMsg) {
		case 1:
			return "Valor de Coleta Cadastrado com Sucesso!";
			
		case 2:
			return "Valor Transferido com Sucesso!";
			
		case 3:
			return "Impossivel Trasferir! Saldo insuficiente para a Operação.";
			
		case 4:
			return "";
		
		case 5:
			return "";

		default:
			return "";
		}
	}

}
