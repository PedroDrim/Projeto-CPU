#======================================================================#
class ActionProcessor

	#======================================================================#
	# Gera um objeto de ações para o comando inserido
	def initialize(actions, connections)
		
		@connection = connections
		@memory_buffer = Hash.new
		@idp = 1
    
		actions.each do |sId,comando| 
      processor(comando) 
    end
	end
	#======================================================================#

  #======================================================================#
  def getMemoryBuffer()
    return(@memory_buffer)
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
  def processor(action)

    # buscar no banco a existencia da funcionalidade
    comando = action[:key]
    funcionalidade = @connection.find(comando)

    unless(funcionalidade.to_a.empty?)
     	parametros = action[:param].map{ |p| p.to_i}
     		
      stateVerification(funcionalidade, parametros)
    else
             	
      comando = "*Desconhecido*"
      @memory_buffer["ID#{@idp}".to_sym] = jhash(comando,"SystemException")
    end

    @idp += 1
  end
  #======================================================================#

  #======================================================================#
  private
  def stateVerification(row, parametros)

   	state = row[:state].to_i
   	comando = row[:comando].to_s
   	tamanho_parametros = row[:parametros].to_i

    nome = "./src/CPU/data/serialization/Module_#{comando}.mem"
    trigger = load(nome)

    #============================#
    case(state)
                  	
    #============================#
    # menor que
    when -1 
     	if( (parametros.length) < tamanho_parametros)
                	
        trigger.make(parametros)
   		  @memory_buffer["ID#{@idp}".to_sym] = jhash(comando,trigger.get)
      else
                		
      	puts "[Sys] Quantidade de parametros em '#{comando}' incorreta." 
        @memory_buffer["ID#{@idp}".to_sym] = jhash(comando,"ParametersException") 
      end
    #============================#
                     
    #============================#
    # igual a
    when 0 
     	if( (parametros.length) == tamanho_parametros)
                 	
     		trigger.make(parametros)          		
     		@memory_buffer["ID#{@idp}".to_sym] = jhash(comando,trigger.get)
      else
                 		
      	puts "[Sys] Quantidade de parametros em '#{comando}' incorreta."  
        @memory_buffer["ID#{@idp}".to_sym] = jhash(comando,"ParametersException") 
      end
    #============================#
                     
    #============================#   
    # maior que
    when 1 
     	if( (parametros.length) > tamanho_parametros)
                 		
     		trigger.make(parametros)         		
     		@memory_buffer["ID#{@idp}".to_sym] = jhash(comando,trigger.get)
      else
                 		
     		puts "[Sys] Quantidade de parametros em '#{comando}' incorreta."
        @memory_buffer["ID#{@idp}".to_sym] = jhash(comando,"ParametersException")  
      end
    #============================#
                     
    #============================#   
    # erro
    else
     	"[Sys] Quantidade de parametros em '#{comando}' não reconhecida."
      @memory_buffer["ID#{@idp}".to_sym] = jhash(comando,"ParametersException")
    #============================#
                     
    end
    #============================#
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
end
#======================================================================#