package cadastro;

public class Construcao {
	
	public int construcaoID;
	public Igreja igreja = new Igreja();
	public String titulo;
	public String descricao;
	
	
	//Seleciona todas as construções
	public String listaConstrucoes() {
		String consulta = "SELECT c.construcaoID, c.titulo, c.descricao, c.status, i.nome ";
		consulta += "FROM construcao c INNER JOIN igreja i ON i.igrejaID = c.igrejaID";
		
		return consulta;
	}
	
	//Seleciona todas as construções Ativas
	public String listaConstrucoesAtivas() {
		return "SELECT * FROM construcao WHERE status = 'S'";
	}
	
	//Pesquisa Construção/Serviço por ID
	public String construcaoPorID() {
		String consulta = "SELECT c.construcaoID, c.igrejaID, c.titulo, i.nome ";
		consulta += "FROM construcao c INNER JOIN igreja i ON i.igrejaID = c.igrejaID ";
		consulta += "WHERE c.construcaoID = '"+construcaoID+"'";
		
		return consulta;
	}
	
	//Cadastra Construção
	public String cadastraConstrucao() {
		return "INSERT INTO construcao (igrejaID, titulo, descricao) VALUES ('"+igreja.igrejaID+"', '"+titulo+"', '"+descricao+"')";
	}
	
	//Altera os dados da Construção/Serviço
	public String atualizaConstrucao() {
		return "UPDATE construcao SET igrejaID = '"+igreja.igrejaID+"', titulo = '"+titulo+"' WHERE construcaoID = '"+construcaoID+"'";
	}
	
	//Exclui uma Construção
	public String excluiConstrucao() {
		return "DELETE FROM construcao WHERE construcaoID = '"+construcaoID+"'";
	}
	
	
	//Muda Status da Construção para ATIVA(S) OU INATIVA(N)
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
			return "Construção Cadastrada com Sucesso!";
			
		case 2:
			return "Construção Alterada com Sucesso!";
			
		case 3:
			return "Construção Excluida com Sucesso!";
			
		case 4:
			return "";
		
		case 5:
			return "";

		default:
			return "";
		}
	}

}
