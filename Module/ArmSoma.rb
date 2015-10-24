# Template para o objeto responsavel por atribuir as funcionalidades
# ao "Brain"

load("Template/ArmTemplate.rb")
#======================================================================#
class ArmSoma < ArmTemplate
    
  #======================================================================#
  def initialize(nome)
    super(nome)
    @parametros = 2
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
      @contrato[:comando] = "soma".downcase # Identiicador
      
       # Retorna o identificador do contrato
       return(@contrato)
    end
    #======================================================================#
    
    #======================================================================#
    def make(*parameters)
       # Ação exercida pela funcionalidade (método de gatilho)
       parametro = parameters[0]
      if(parametro.length == @parametros)
        @resposta = parametro[0].to_i + parametro[1].to_i
        
      else
        puts "Quantidade de parâmetros inválida."
        @resposta = "Erro"
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
