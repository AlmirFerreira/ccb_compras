package cadastro;

public class Setor {
	
	public int setorID;
	public String nome;
	
	
	//Pesquisa todos os setores Ativos
	public String listaSetores() {
		return "SELECT * FROM setor";
	}
	
	//Pesquisa todos os setores Ativos
	public String listaSetoresAtivos() {
		return "SELECT * FROM setor WHERE status = 'S'";
	}
	
	
	//Pesquisa setor por ID
	public String setorPorID() {
		return "SELECT * FROM setor WHERE setorID = '"+setorID+"'";
	}
	
	
	//Insere Setor
	public String insereSetor() {
		return "INSERT INTO setor (nome) VALUES ('"+nome+"')";
	}
	
	//Altera nome do Setor
	public String alteraSetor() {
		return "UPDATE setor SET nome = '"+nome+"' WHERE setorID = '"+setorID+"'";
	}
	
	//Exclui setor
	public String excluiSetor() {
		return "DELETE FROM setor WHERE setorID = '"+setorID+"'";
	}
	
	//Muda Status do Setor para ATIVO(S) OU INATIVO(N)
	public String statusSetor(int numeroAcao){
		
		if(numeroAcao == 1){
			return "UPDATE setor SET status = 'N' WHERE setorID = '"+setorID+"'";
		}else if(numeroAcao == 2){
			return "UPDATE setor SET status = 'S' WHERE setorID = '"+setorID+"'";
		}
		
		return null;
	}
	
	//Metodo de tratamento de Mensagens
	public String mensagem(int numeroMsg){
		
		switch (numeroMsg) {
		case 1:
			return "Setor Cadastrado com Sucesso!";
			
		case 2:
			return "Setor Alterado com Sucesso!";
			
		case 3:
			return "Setor Excluido com Sucesso!";
			
		case 4:
			return "";
		
		case 5:
			return "";

		default:
			return "";
		}
	}

}
