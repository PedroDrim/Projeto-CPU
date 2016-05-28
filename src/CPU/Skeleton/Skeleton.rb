#======================================================================#
class Skeleton < SkeletonTemplate

  #======================================================================#
  # Variaveis de classe:
  # @connection - Conexao com o banco de dados
  # @brain - O "brain" que esta acoplado ao "Skeleton"
  #======================================================================#

  #======================================================================#
  # Inicializando objeto
  # [SK_1] [SK_4]
  # @param:
  #  arguments (valor pardao: nil) - objetos a serem acoplados inicialmente no "skeleton"
  # @return:
  #  Nenhum.
  # @end
  def initialize(arguments = nil)
     
     # Criando objeto de acesso ao banco de dados
    @connection = SqliteDAO.new
    @connection.open # Abrindo coneccao
    @connection.createDB # Criando Banco de dados

    # Verificando se o objeto não é nulo
    unless(arguments.nil?)
    
      arguments.each{ |object| attach(object) } # Acoplando objetos ao esqueleto [SK_1]
    
    else

      puts "[Sys] Criando um esqueleto vazio."
    
    end
  end
  #======================================================================#

  #======================================================================#
  # Converte a string em uma lista de acoes
  # @param:
  #  frase - A instrucao dada pelo usuario ao programa
  # @return:
  #  actionList - uma lista contendo de forma tratada as acoes continas na frase
  # @end
  def process(frase)
     
    lista = ActionList.new(frase)
    actionList = lista.getActionList

    processor = ActionProcessor.new(actionList[:action], @connection)
    resultado = processor.getMemoryBuffer

    configuration = actionList[:config]

    projetoCPU_output = Hash.new
    projetoCPU_output[:projetoCPU] = resultado

    if(configuration[:ext] == "export")
      export(projetoCPU_output)
    end

    return(projetoCPU_output)
  end
  #======================================================================#  

  #======================================================================#
  # Encerrando conexao por meio do esqueleto
  # @param:
  #  Nenhum.
  # @return:
  #  Nenhum.
  # @end
  def close()
      @connection.close
  end
  #======================================================================#
  
  #======================================================================#
  # Insere uma nova funcionalidade ao "brain" OU insere um novo "brain" 
  # [SK_1] [SK_2] [SK_4]
  # @param:
  #  objeto - Objeto a ser acoplado no "skeleton"
  # @return:
  #  Nenhum.
  # @end
  def attach(objeto)
        
    # Verificando o tipo do objeto
    if(objeto.is_a? ArmTemplate) # Objeto do tipo "TemplateArm"
     
      # Obtem o contrato
      contract = objeto.contract()
      puts "[Sys] Contrato da funcionalidade '#{objeto.nome}' realizado."      
      
      # Adiciona funcionalidade
      @connection.save(contract)
      nome = "./src/CPU/data/serialization/Module_#{contract.comando}.mem"
      save(objeto,nome) # Salva o "module" serializado
      
    elsif(objeto.is_a? BrainTemplate) # Objeto do tipo "TemplateBrain"
            
      # Verificando se já existe um "Brain" acoplado
      if(@brain.nil?)

        puts "[Sys] Novo cerebro '#{objeto.nome}' acoplado."

      else
        
        puts "[Sys] Cerebro '#{objeto.nome}' substituiu o cerebro antigo."

      end

      @brain = objeto # Acoplando o "brain" ao "skeleton"
      nome = "./src/CPU/data/serialization/Brain_#{objeto.nome}.mem"
      save(objeto,nome) # Salva o "brain" serializado
  
    else
      
      # Caso o objeto de entrada não seja dos tipos. 
      puts "[Sys] Objeto do tipo incorreto."

    end
  end
  #======================================================================#  
  
  #======================================================================#
  # Remove uma nova funcionalidade ao "brain" OU insere um novo "brain" 
  # [SK_3] [SK_2]
  # @param:
  #  objeto - Objeto a ser desacoplado do "skeleton"
  # @return:
  #  Nenhum.
  # @end
  def detach(objeto)
        
    # Verificando se a entrada e um objeto do tipo "TemplateArm"
    if(objeto.is_a? ArmTemplate)
            
      # Obtem o contrato
      contract = objeto.contract()
      puts "[Sys] Contrato cancelado."      
      
      # Remove funcionalidade      
      @connection.delete(contract)
      nome = "./src/CPU/data/serialization/Module_#{contract.comando}.mem"
      File.delete(nome) # Exclui "module" serializado

    elsif(objeto.is_a? BrainTemplate) # Objeto do tipo "TemplateBrain"
            
      # Verificando se já existe um "Brain" acoplado
      if(@brain.nil?)
    
        puts "[Sys] Não há um cerebro acoplado."

      else
    
        puts "[Sys] Removendo cerebro '#{objeto.nome}'."

      end
      
      @brain = nil
      nome = "./src/CPU/data/serialization/Brain_#{objeto.nome}.mem"
      File.delete(nome) # Exclui o "brain" serializado
    
    else
      
      # Caso o objeto de entrada não seja dos tipos esperados. 
      puts "[Sys] Objeto do tipo incorreto."
    end
  end
  #======================================================================#
  
  #======================================================================#
  # Exclui todos os objetos acoplados
  # [SK_3] [SK_4] [SK_5]
  # @param:
  #  Nenhum.
  # @return:
  #  Nenhum.
  # @end
  def detach_all()

    # Limpando tabela de contrato do banco
    @connection.delete_all

    # Excluindo todos os objetos serializados
    arquivos =  Dir["./src/CPU/data/serialization/*"]
    arquivos.each{ |arquivo| File.delete(arquivo)}

    # Exibindo mensagem de exclusao
    puts "[Sys] Todos os objetos foram desacoplados."
  end
  #======================================================================#
  
  #======================================================================#
  # Serializacao de objeto
  # @param:
  #  objeto - Objeto a ser serializado
  #  nome_arquivo - O nome do arquivo do objeto serializado
  # @return:
  #  Nenhum.
  # @end
  private
  def save(objeto,nome_arquivo)
    
    File.open(nome_arquivo,'w') do |f|
      Marshal.dump(objeto, f)
    end
  end
  #======================================================================#
 
  #======================================================================#
  # Desserializacao de objeto
  # @param:
  #  nome_arquivo - O nome do arquivo do objeto serializado
  # @return:
  #  objeto - O objeto deserializado  
  # @end
  private
  def load(nome_arquivo)
    
    objeto = File.open(nome_arquivo) do |file|
      Marshal.load(file)
    end
    
    return(objeto)
  end
  #======================================================================#
   
  #======================================================================#
  # Converte o buffer de uma instrução em um arquivo .json
  # @param:
  #  buffer - Buffer contendo as instrucoes 
  # @return:
  #  Nenhum.
  # @end
  private
  def export(buffer)
    
    nome = Time.now
    nome = nome.strftime("export_%Y%m%d_%H%M%S.json")
    arquivo = "./src/CPU/data/output/#{nome}"

    arquivo = File.open(arquivo,"w")
    arquivo.puts(buffer.to_json)
    arquivo.close
    
    puts "[Sys] Resultados exportados."
  end
  #======================================================================#  
    
end
#======================================================================#
