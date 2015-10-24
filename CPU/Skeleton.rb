load("Template/SkeletonTemplate.rb")
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
  def command(action)
    
    action = action.downcase
    expressao = /(\w+)\s+(.+)/
    
    expressao = expressao.match(action)  

    if(expressao.nil?)
      
      puts "[Sys] Acao '#{action}' desconhecida." 
    else
    
        # buscando comandos conhecidos
        if(expressao[1].downcase == "aprender")
          
          # aprender nova funcionalidade

        elsif(expressao[1].downcase == "relatorio")

          # exibe o relatorio das funcionalidades acopladas no sistema
          state()

        else
          
          # buscar no banco a existencia da funcionalidade
            sql = "select * from contrato where comando = '#{expressao[1].downcase}'"
            
            funcionalidade = @connection.query(sql)
            
            unless(funcionalidade.to_a.empty?)
              parametros = expressao[2].split(%r{\s+})
            
              funcionalidade.each do |row|
                if( (parametros.length) == row['parametros'].to_i)
    
                  trigger = @add_functions[ row['comando'].to_sym ]
                  trigger.make(parametros)
                  
                  puts "[Sys Call] #{trigger.get}"   
                  
                else
                
                  puts "[Sys] Quantidade de parametros incorreta."  
                end
              
              end
            
            else
                puts "[Sys] Acao '#{action}' desconhecida." 
            end
           
        end
    end

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
        sql = "insert into contrato values ('#{contract[:comando]}',#{contract[:param]},'#{contract[:descricao]}')"
     
        @connection.query(sql)
        @add_functions[contract[:comando].to_sym] = objeto
        save(@add_functions,"data_memory//module_Hash.mem") 
        
        puts "Funcionalidade '#{objeto.nome}' acoplada."
        
      rescue
        puts "Esta funcionalidade já está acoplada."
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
          puts "Quantidade de parametros: #{row['parametros']}"
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
   
end
#======================================================================#
