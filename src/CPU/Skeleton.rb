load("./Template/SkeletonTemplate.rb")
#======================================================================#
class Skeleton < SkeletonTemplate

  #======================================================================#
  # Inicializando objeto
  def initialize(brain = nil)
     
    @connection = Mysql2::Client.new(
          :host => "127.0.0.1",
          :username =>"root",
          :password => "toor",
          :database =>"MemoryCPU")
    
    # Verificando se o sistema já foi iniciado anteriormente
    if(File.exist?("data_memory//module_Hash.mem"))

      @add_functions = load("data_memory//module_Hash.mem")      
    else

      @add_functions = Hash.new
      save(@add_functions,"data_memory//module_Hash.mem") 
    end

    # Verificando se o objeto não é nulo
    unless(brain.nil?)
     
      # Verificando se a entrada é um objeto do tipo "BrainTemplate"
      if(brain.is_a? BrainTemplate)
        @brain = brain
            
        puts "[Sys] Cerebro '#{brain.nome}' acoplado."
      else
        puts "[Sys] Objeto nao reconhecido."
        puts "[Sys] Criando um esqueleto vazio."
      end
    
    else
      puts "[Sys] Criando um esqueleto vazio."
    end
  end
  #======================================================================#

  #======================================================================#
  # Envia uma ação para o cerebro "brain" executar
  def command(actions)
    
    # criando um "buffer" para armazenar o resultado dos comandos
    memory_buffer = Hash.new
    
    actions.downcase!
    
    export = /\-export/.match(actions)
    export = !export.nil? 
    
    actions = actions.split("|")
    
    id = 1
    #============================#
    actions.each do |action|
      
      padrao = /(\w+)\s+(.+)/
      expressao = padrao.match(action)  
      
      #============================#
      if(expressao.nil?)
        
        puts "[Sys] Acao '#{action}' desconhecida." 
        
        memory_buffer[id.to_s.to_sym] = jhash("SystemException",nil)
        id += 1
      else
      
          # buscando comandos conhecidos do sistema ou banco
          if(expressao[1].downcase == "system")
             
                # iniciando comandos de sistema
                system_commands(expressao[2])
                
                memory_buffer[id.to_s.to_sym] = jhash("Systemcommand",nil)
                id += 1
                
          else
            
            # buscar no banco a existencia da funcionalidade
              sql = "select * from contrato where comando = '#{expressao[1].downcase}'"
              
              funcionalidade = @connection.query(sql)
              
              unless(funcionalidade.to_a.empty?)
                parametros = expressao[2].split(%r{\s+})
              
                funcionalidade.each do |row|
                  
                  state = row['state'].to_i
                  #============================#
                  case(state)
                    
                    #============================#
                    # menor que
                    when -1 
                        if( (parametros.length) < row['parametros'].to_i)
      
                        trigger = @add_functions[ row['comando'].to_sym ]
                        trigger.make(parametros)
                    
                        memory_buffer[id.to_s.to_sym] = jhash(row['comando'],trigger.get)
                    
                        else
                  
                        puts "[Sys] Quantidade de parametros em '#{row['comando']}' incorreta." 
                        memory_buffer[id.to_s.to_sym] = jhash("SystemException",nil)
                        end
                     #============================#
                     
                     #============================#
                     # igual a
                     when 0 
                        if( (parametros.length) == row['parametros'].to_i)
      
                        trigger = @add_functions[ row['comando'].to_sym ]
                        trigger.make(parametros)
                    
                        memory_buffer[id.to_s.to_sym] = jhash(row['comando'],trigger.get)

                        else
                  
                        puts "[Sys] Quantidade de parametros em '#{row['comando']}' incorreta."  
                        memory_buffer[id.to_s.to_sym] = jhash("SystemException",nil)
                        end
                     #============================#
                     
                     #============================#   
                     # maior que
                     when 1 
                        if( (parametros.length) > row['parametros'].to_i)
      
                        trigger = @add_functions[ row['comando'].to_sym ]
                        trigger.make(parametros)
                    
                        memory_buffer[id.to_s.to_sym] = jhash(row['comando'],trigger.get)

                        else
                  
                        puts "[Sys] Quantidade de parametros em '#{row['comando']}' incorreta."  
                        memory_buffer[id.to_s.to_sym] = jhash("SystemException",nil)
                        end
                     #============================#
                     
                     #============================#   
                     # erro
                     else
                        "[Sys] Quantidade de parametros em '#{row['comando']}' não reconhecida."
                        memory_buffer[id.to_s.to_sym] = jhash("SystemException",nil)
                     #============================#
                     
                  end
                  #============================#
                  
                  id += 1
                end
              
              else
                  puts "[Sys] Acao '#{action}' desconhecida." 
                  memory_buffer[id.to_s.to_sym] = jhash("SystemException",nil)
                  id += 1
              end
             
          end
      end
      #============================#
    end
    #============================#
 
    # imprimindo resultados
    memory_buffer.each do |key,value|
      
      value[:resposta] = "nil" if(value[:resposta].nil?)
      puts "[Sys Call #{key}] #{value[:resposta]}"    
    end
    
    # exportando dado
    export(memory_buffer) if(export)
    
  end
  #======================================================================#
  
  #======================================================================#
  # Insere uma nova funcionalidade ao "brain" OU insere um novo "brain" 
  def attach(objeto)
        
    # Verificando o tipo do objeto
    if(objeto.is_a? ArmTemplate) # Objeto do tipo "TemplateArm"
     
      # Valida contrato
      contract = objeto.contract()
      puts "[Sys] Contrato da funcionalidade '#{objeto.nome}' realizado."      
      
      # Conectando com o banco
      begin
      
        # Adiciona funcionalidade
        sql = "insert into contrato values ('#{contract[:comando]}',
          #{contract[:param]},#{contract[:state]},'#{contract[:descricao]}')"
     
        @connection.query(sql)
        @add_functions[contract[:comando].to_sym] = objeto
        save(@add_functions,"data_memory//module_Hash.mem") 
        
        puts "Funcionalidade '#{objeto.nome}' acoplada."
        
      rescue
        puts "Esta funcionalidade já está acoplada."
        @add_functions[contract[:comando].to_sym] = objeto
        save(@add_functions,"data_memory//module_Hash.mem") 
      end
      
    elsif(objeto.is_a? BrainTemplate) # Objeto do tipo "TemplateBrain"
            
      # Verificando se já existe um "Brain" acoplado
      if(@brain.nil?)
          
        # Inserindo novo Brain
        @brain = objeto
        puts "[Sys] Novo cerebro '#{objeto.nome}' acoplado."
      else
          
        # Inserindo novo Brain
        @brain = objeto
        puts "[Sys] Cerebro '#{objeto.nome}' substituiu o cerebro antigo."
        
      end
        
    else
      
      # Caso o objeto de entrada não seja dos tipos. 
      puts "[Sys] Objeto do tipo incorreto."
    end
  end
  #======================================================================#  
  
  #======================================================================#
  def detach(objeto)
        
    # Verificando se a entrada e um objeto do tipo "TemplateArm"
    if(objeto.is_a? ArmTemplate)
            
      # Remove contrato
      contract = objeto.contract()
      puts "[Sys] Contrato cancelado."      
      
      # Conectando com o banco
      begin
        
        sql = "select * from contrato where comando = '#{contract[:comando]}'"
        
        unless(@connection.query(sql).to_a.empty?)
        
          # Remove funcionalidade      
          sql = "delete from contrato where comando= '#{contract[:comando]}'"
          @connection.query(sql) 
          @add_functions.delete(contract[:comando].to_sym)
          save(@add_functions,"data_memory//module_Hash.mem") 
            
          puts "[Sys] Funcionalidade '#{objeto.nome}' removida."  
        
        else
          puts "[Sys] A funcionalidade '#{objeto.nome}' não foi encontrada." 
        end
        
      rescue
        puts "[Sys] A funcionalidade '#{objeto.nome}' não foi encontrada." 
      end
      
    else
      puts "[Sys] Objeto do tipo incorreto."
    end
  end
  #======================================================================#
  
  #======================================================================#
  def detach_all()
    # Limpando tabela de contrato
    puts "[Sys] Removendo todas as funcionalidades acopladas."
    
    begin
        
      # Pesquisa funcionalidade      
      sql = "delete from contrato"
      
      @connection.query(sql)
      @add_functions = Hash.new
      save(@add_functions,"data_memory//module_Hash.mem") 
      
      puts "[Sys] Remoção concluída."
      
    rescue
      puts "[Sys] Não foi possivel excluir as funcionalidades." 
    end
  end
  #======================================================================#

  #======================================================================#  
  private
  def state()
    # Exibe o status dos objetos acoplados no esqueleto.
    puts "[Sys] Exibindo o status das funcionaliadades acopladas no esqueleto (incluindo o cerebro)."
    
    begin
        
      # Pesquisa funcionalidade      
      sql = "select * from contrato"
      
      # Exibindo cerebro
      puts ""
      puts "Cérebro:"
      puts "Nome: #{@brain.nome} (#{@brain.id})"
      puts ""
      
      resposta = @connection.query(sql)
      
      unless(resposta.to_a.empty?)
        resposta.each do |row|
        
          # Exibindo funcionalidades
          puts "Funcionalidade:"
          puts "Comando: #{row['comando']}"
          puts "Descricao: #{row['descricao']}"
          
          state = row['state']
          
          puts case(state)
            when -1 
            "Quantidade de parametros: menor que #{row['parametros']}."            
            when 0 
            "Quantidade de parametros: igual a #{row['parametros']}."
            when 1 
            "Quantidade de parametros: maior que #{row['parametros']}."
            else
            "Quantidade de parametros não reconhecida."
          end
           
          puts ""
        end
      
      else
        puts "[Sys] Não há funcionalidades cadastradas."
      end
      
    rescue
      puts "[Sys] Não foi possivel obter as funcionalidades." 
    end

      
  end
  #======================================================================#
  
  #======================================================================#
  private
  def save(objeto,nome_arquivo)
    
    File.open(nome_arquivo,'w') do |f|
      Marshal.dump(objeto, f)
    end
    
  end
  #======================================================================#
 
  #======================================================================#
  private
  def load(nome_arquivo)
    
    objeto = File.open(nome_arquivo) do |file|
      Marshal.load(file)
    end
    
    return(objeto)
  end
  #======================================================================#
   
  #======================================================================#
  private
  def export(buffer)
    
    nome = Time.now
    nome = nome.strftime("export_%Y%m%d_%H%M%S.json")
    File.open("data_output/#{nome}","w") do |f|
      f.write(buffer.to_json)
    end
    
    puts "[Sys] Resultados exportados."

  end
  #======================================================================#
  
  #======================================================================#
  private
  def system_commands(expressao)
  
    case(expressao)
    when "aprender"
    # aprender novas funcionalidades
    puts "[Sys] Funcionalidade não implementada."
                  
    when "relatorio"
    # exibe o relatorio das funcionalidades acopladas no sistema
    state()
                  
    when "limpar"
    # limpa a memória, removendo arquivos gerados
    puts "[Sys] Funcionalidade não implementada."
    
    when "sair"
    # encerra o programa
    puts "[Sys] Encerrando programa."
    $ciclo = false
                      
    else
    # outra funcionalidade
    puts "[Sys] Funcionalidade '#{expressao}' não reconhecida."
                  
    end
  end
  #======================================================================#
  
  #======================================================================#
  private
  def jhash(comando,valor)
    
     object_class = Hash.new
     object_class[:comando] = comando
     object_class[:resposta] = valor
     
     return(object_class)
  end
  #======================================================================#
    
end
#======================================================================#
