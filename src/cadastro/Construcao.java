package cadastro;

public class Construcao {
	
	public int construcaoID;
	public Igreja igreja = new Igreja();
	public String titulo;
	public String descricao;
	
	
	//Seleciona todas as constru��es
	public String listaConstrucoes() {
		String consulta = "SELECT c.construcaoID, c.titulo, c.descricao, c.status, i.nome ";
		consulta += "FROM construcao c INNER JOIN igreja i ON i.igrejaID = c.igrejaID";
		
		return consulta;
	}
	
	//Seleciona todas as constru��es Ativas
	public String listaConstrucoesAtivas() {
		return "SELECT * FROM construcao WHERE status = 'S'";
	}
	
	//Pesquisa Constru��o/Servi�o por ID
	public String construcaoPorID() {
		String consulta = "SELECT c.construcaoID, c.igrejaID, c.titulo, i.nome ";
		consulta += "FROM construcao c INNER JOIN igreja i ON i.igrejaID = c.igrejaID ";
		consulta += "WHERE c.construcaoID = '"+construcaoID+"'";
		
		return consulta;
	}
	
	//Cadastra Constru��o
	public String cadastraConstrucao() {
		return "INSERT INTO construcao (igrejaID, titulo, descricao) VALUES ('"+igreja.igrejaID+"', '"+titulo+"', '"+descricao+"')";
	}
	
	//Altera os dados da Constru��o/Servi�o
	public String atualizaConstrucao() {
		return "UPDATE construcao SET igrejaID = '"+igreja.igrejaID+"', titulo = '"+titulo+"' WHERE construcaoID = '"+construcaoID+"'";
	}
	
	//Exclui uma Constru��o
	public String excluiConstrucao() {
		return "DELETE FROM construcao WHERE construcaoID = '"+construcaoID+"'";
	}
	
	
	//Muda Status da Constru��o para ATIVA(S) OU INATIVA(N)
	public String statusConstrucao(int numeroAcao){
		
		if(numeroAcao == 1){
			return "UPDATE construcao SET status = 'N' WHERE construcaoID = '"+construcaoID+"'";
		}else if(numeroAcao == 2){
			return "UPDATE construcao SET status = 'S' WHERE construcaoID = '"+construcaoID+"'";
		}
		
		return null;
	}
	
	
	//Metodo de tratamento de Mensagens
	public String mensagem(int numeroMsg){
		
		switch (numeroMsg) {
		case 1:
			return "Constru��o Cadastrada com Sucesso!";
			
		case 2:
			return "Constru��o Alterada com Sucesso!";
			
		case 3:
			return "Constru��o Excluida com Sucesso!";
			
		case 4:
			return "";
		
		case 5:
			return "";

		default:
			return "";
		}
	}

}
