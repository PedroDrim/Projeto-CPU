#======================================================================#
module sqliteDAO

    db = SQLite3::Database.open "MemoryCPU.db"

    #======================================================================#
    def createDB()
    
       begin
          db.execute "CREATE TABLE IF NOT EXISTS contrato(comando TEXT PRIMARY KEY, parametros TEXT, descricao TEXT, state INT)"
       rescue
          puts "[Sys] Não foi possivel criar o banco de dados."
       end

    end
    #======================================================================#

    #======================================================================#
    def save(contrato)

       begin
          db.execute "INSERT INTO contrato VALUES(#{contrato[:comando]},#{contrato[:param]},#{contrato[:descricao]},#{contrato[:state]})"
       rescue
          puts "[Sys] Não foi possivel salvar o contrato no banco de dados."
       end

    end
    #======================================================================#

    #======================================================================#
    def delete(comando)

    end
    #======================================================================#

    #======================================================================#
    def find(comando)

    end
    #======================================================================#

end
#======================================================================#
