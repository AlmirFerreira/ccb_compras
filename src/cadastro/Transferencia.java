package cadastro;

public class Transferencia {
	
	public int origemID;
	public int destinoID;
	public float valor;
	
	
	
	//Registra a transfer�ncia na base de dados
	public String insereTransferencia() {
		String salvar = "INSERT INTO trasferencias ";
		salvar += "(origemID, destinoID, valor) VALUES ";
		salvar += "('"+origemID+"', '"+destinoID+"', '"+valor+"')";
		
		return salvar;
	}

}
