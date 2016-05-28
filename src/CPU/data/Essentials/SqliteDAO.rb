#======================================================================#
class SqliteDAO
  #======================================================================#
  # Variaveis de classe:
  # @db - Conexao com o banco de dados sqlite
  #======================================================================#

  #======================================================================#
  # Abre uma conexao com o banco de dados sqlite
  # []
  # @param:
  #  Nenhum.
  # @return:
  #  Nenhum.
  # @end
  def open()
	
    @db = SQLite3::Database.open "./src/CPU/data/db/MemoryCPU.db"
  
  end
  #======================================================================#
    
  #======================================================================#
  # Fecha uma conexao com o banco de dados sqlite
  # []
  # @param:
  #  Nenhum.
  # @return:
  #  Nenhum.
  # @end
  def close()

    @db.close
  
  end
  #======================================================================#

  #======================================================================#
  # Cria um banco de dados
  # []
  # @param:
  #  Nenhum.
  # @return:
  #  Nenhum.
  # @end
  def createDB()
    
    begin
  
      @db.execute "CREATE TABLE IF NOT EXISTS contrato(comando TEXT PRIMARY KEY, parametros INT, descricao TEXT, state INT)"
  
    rescue
  
      puts "[Sys] Não foi possivel criar o banco de dados."
    
    end
  end
  #======================================================================#

  #======================================================================#
  # Salva um contrato no banco de dados
  # []
  # @param:
  #  contrato - Contrato a ser cadastrado no banco
  # @return:
  #  Nenhum.
  # @end
  def save(contrato)

    sql = "SELECT EXISTS(SELECT * FROM contrato WHERE comando = '#{contrato.comando}')"
    
    begin
       
      # buscando no banco          
      resp = @db.execute(sql)
      resp = resp[0]
        
      if(resp[0] == 1)
    
        puts "[Sys] O contrato #{contrato.comando} já foi inserido."        

      else
    
        sql = "INSERT INTO contrato VALUES('#{contrato.comando}',#{contrato.parametros},'#{contrato.descricao}',#{contrato.state})"
        @db.execute(sql) 
        puts "[Sys] O contrato da funcionalidade #{contrato.comando} foi inserido."
    
      end
       
    rescue
       
      puts "[Sys] Não foi possivel salvar o contrato."       
    
    end
  end
  #======================================================================#

  #======================================================================#
  # Exclui um contrato no banco de dados
  # []
  # @param:
  #  contrato - Contrato a ser removido do banco
  # @return:
  #  Nenhum.
  # @end
  def delete(contrato)

    sql = "SELECT EXISTS(SELECT * FROM contrato WHERE comando = '#{contrato.comando}')"
    
    begin
    
      # buscando no banco          
      resp = @db.execute(sql)
      resp = resp[0]
        
      if(resp[0] == 1)
    
        # removendo do banco
        sql = "DELETE FROM contrato WHERE comando = '#{contrato.comando}'"
        resp = @db.execute(sql)
        
        puts "[Sys] O contrato da funcionalidade #{contrato.comando} foi removido."
      else
            
        puts "[Sys] Não existe o contrato #{contrato.comando}."
    
      end

    rescue
      
      puts "[Sys] Não foi possivel remover o contrato #{contrato.comando}."
    
    end
  end
  #======================================================================#

  #======================================================================#
  # Remove todos o contratos do banco de dados
  # []
  # @param:
  #  Nenhum.
  # @return:
  #  Nenhum.
  # @end
  def delete_all()

    sql = "DELETE FROM contrato"
    
    begin
  
      # buscando no banco          
      resp = @db.execute(sql)
      puts "[Sys] Todos os contratos foram removidos."
       
    rescue
      
      puts "[Sys] Não foi possivel limpar os contratos."
    
    end
  end
  #======================================================================#

  #======================================================================#
  # Busca um contrato no banco de dados
  # []
  # @param:
  #  comando - Comando (identificador) do contrato cadastrado
  # @return:
  #  resp_h - Um hash contendo os dados do contrato obtido
  # @end
  def find(comando)

    sql = "SELECT * FROM contrato WHERE comando = '#{comando}'"
    resp_h = nil

    begin

      resp = @db.execute(sql)
      resp = resp[0]
      resp_h = Hash.new
      resp_h[:comando] = resp[0]
      resp_h[:parametros] = resp[1]
      resp_h[:descricao] = resp[2]
      resp_h[:state] = resp[3]
    
    rescue

      puts "[Sys] Não foi possivel resgatar o contrato."
    end
       
    return(resp_h)
  end
  #======================================================================#

end
#======================================================================#
