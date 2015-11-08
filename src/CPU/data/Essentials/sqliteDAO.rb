#======================================================================#
class SqliteDAO

    #======================================================================#
    def open()

        @db = SQLite3::Database.open "./CPU/data/db/MemoryCPU.db"
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

       sql = "INSERT INTO contrato VALUES('#{contrato.comando}',#{contrato.parametros},'#{contrato.descricao}',#{contrato.state})"
       begin
          @db.execute(sql) 
       rescue
          puts "[Sys] Não foi possivel salvar o contrato."
       end

    end
    #======================================================================#

    #======================================================================#
    def delete(comando)

       sql = "SELECT * FROM contrato WHERE comando = '#{comando}'"
       begin
	# buscando no banco          
	resp = @db.execute(sql)
          
        # removendo do banco
        sql = "DELETE FROM contrato WHERE comando = '#{comando}'"
        resp = @db.execute(sql)
       rescue
          puts "[Sys] Não foi possivel remover o contrato."
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
