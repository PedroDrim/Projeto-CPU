# Template para o objeto responsavel por atribuir as funcionalidades
# ao "Brain"

load("./Template/ArmTemplate.rb")
#======================================================================#
class ArmQuadrado < ArmTemplate
    
  #======================================================================#
  def initialize(nome)
    super(nome)
    @parametros = 0
    @state = 1 # Status de parametrização (-1: menor que, 0: igual a, +1: maior que)
    @contrato = nil
    @retorno = nil
  end
  #======================================================================#
  
  #======================================================================#
    def contract()
       # Gera um contrato para o "Brain" e armazena suas referências
       # para uso posterior.
       
      @contrato = Hash.new
      @contrato[:param] = @parametros # Quantidade de parametros
      @contrato[:descricao] = nome # Nome
      @contrato[:comando] = "quadrado".downcase # Identiicador
      @contrato[:state] = @state # Status de parametrização (-1: menor que, 0: igual a, +1: maior que)
      
       # Retorna o identificador do contrato
       return(@contrato)
    end
    #======================================================================#
    
    #======================================================================#
    def make(*parameters)
       # Ação exercida pela funcionalidade (método de gatilho)
       parametro = parameters[0]
      if(parametro.length > @parametros)
        
        @resposta = parametro.collect do |elemento|
          (elemento.to_i)**2
        end
        
        @resposta = @resposta[0] if(@resposta.length == 1)
        
      else
        puts "[Quadrado] Quantidade de parâmetros inválida."
        @resposta = nil
      end 
      
    end
    #======================================================================#
    
    #======================================================================#
    def get()
       # Retorna o objeto criado (se houver) pelo metodo make
       return(@resposta)
    end
    #======================================================================#
end
#======================================================================#
