#======================================================================#
class SqliteDAO

    #======================================================================#
    def open()
	
        @db = SQLite3::Database.open "./src/CPU/data/db/MemoryCPU.db"
    end
    #======================================================================#
    
    #======================================================================#
    def close()

        @db.close
    end
    #======================================================================#

    #======================================================================#
    def createDB()
    
       begin
          @db.execute "CREATE TABLE IF NOT EXISTS contrato(comando TEXT PRIMARY KEY, parametros INT, descricao TEXT, state INT)"
       rescue
          puts "[Sys] Não foi possivel criar o banco de dados."
       end

    end
    #======================================================================#

    #======================================================================#
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
    def find(comando)

       sql = "SELECT * FROM contrato WHERE comando = '#{comando}'"
       begin
          resp = @db.execute(sql)
          resp = resp[0]
          resp_h = Hash.new
          resp_h[:comando] = resp[0]
          resp_h[:parametros] = resp[1]
          resp_h[:descricao] = resp[2]
          resp_h[:state] = resp[3]

          return(resp_h)
       rescue
          puts "[Sys] Não foi possivel resgatar o contrato."
       end

    end
    #======================================================================#

end
#======================================================================#
