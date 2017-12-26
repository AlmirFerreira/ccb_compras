package cadastro;

public class Igreja {
	
	public int igrejaID;
	public Setor setor = new Setor();
	public String nome;
	public float saldo;
	
	
	//Pesquisa todas as igrejas
	public String listaIgrejas() {
		String inserir = "SELECT i.igrejaID, i.nome, i.status, s.nome AS setorNome ";
		inserir += "FROM igreja i INNER JOIN setor s ON s.setorID = i.setorID";
		
		return inserir;
	}
	
	//Pesquisa todas as igrejas Ativas
	public String listaIgrejasAtivas() {
		return "SELECT * FROM igreja WHERE status = 'S'";
	}
	
	//Pesquisa todas as igrejas Ativas por Setor
	public String listaIgrejasAtivasPorSetor() {
		return "SELECT * FROM igreja WHERE status = 'S' AND setorID = '"+setor.setorID+"'";
	}
	
	//Lista as coletas por setor
	public String listaColetaPorIgreja() {
		String lista = "SELECT i.setorID, i.saldo, i.nome, s.nome AS setorNome ";
		lista += "FROM igreja i INNER JOIN setor s ON s.setorID = i.setorID ";
		lista += "ORDER BY i.setorID, i.nome";
		return lista;
	}
	
	//Lista as coletas por setor
	public String listaColetaPorSetor() {
		String lista = "SELECT SUM(i.saldo) AS saldo, i.setorID, s.nome AS setorNome ";
		lista += "FROM igreja i INNER JOIN setor s ON s.setorID = i.setorID ";
		lista += "WHERE i.setorID = '"+setor.setorID+"'";
		lista += "ORDER BY i.setorID, i.nome";
		return lista;
	}
	
	//Pesquisa igreja por ID
	public String igrejaPorID() {
		String pesquisa = "SELECT i.igrejaID, i.nome, i.saldo, i.status, s.setorID, s.nome AS setorNome ";
		pesquisa += "FROM igreja i INNER JOIN setor s ON s.setorID = i.setorID ";
		pesquisa += "WHERE igrejaID = '"+igrejaID+"'";
		
		return pesquisa;
	}
	
	
	//Insere Igreja
	public String insereIgreja() {
		return "INSERT INTO igreja (nome, setorID) VALUES ('"+nome+"', '"+setor.setorID+"')";
	}
	
	//Altera nome da Igreja
	public String alteraIgreja() {
		return "UPDATE igreja SET nome = '"+nome+"', setorID = '"+setor.setorID+"' WHERE igrejaID = '"+igrejaID+"'";
	}
	
	//Altera saldo de Coleta
	public String alteraSaldo() {
		return "UPDATE igreja SET saldo = '"+saldo+"' WHERE igrejaID = '"+igrejaID+"'";
	}
	
	//Exclui igreja
	public String excluiIgreja() {
		return "DELETE FROM igreja WHERE igrejaID = '"+igrejaID+"'";
	}
	
	//Muda Status da Igreja para ATIVO(S) OU INATIVO(N)
	public String statusIgreja(int numeroAcao){
		
		if(numeroAcao == 1){
			return "UPDATE igreja SET status = 'N' WHERE igrejaID = '"+igrejaID+"'";
		}else if(numeroAcao == 2){
			return "UPDATE igreja SET status = 'S' WHERE igrejaID = '"+igrejaID+"'";
		}
		
		return null;
	}
	
	//Metodo de tratamento de Mensagens
	public String mensagem(int numeroMsg){
		
		switch (numeroMsg) {
		case 1:
			return "Igreja Cadastrada com Sucesso!";
			
		case 2:
			return "Igreja Alterada com Sucesso!";
			
		case 3:
			return "Igreja Excluida com Sucesso!";
			
		case 4:
			return "";
		
		case 5:
			return "";

		default:
			return "";
		}
	}


}
