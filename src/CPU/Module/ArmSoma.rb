#======================================================================#
class ArmSoma < ArmTemplate
    
  #======================================================================#
  def initialize(nome)
    
    super(nome)

    # Gera um contrato para o "Brain" e armazena suas referências para uso posterior.
    @contrato = Contrato.new("soma".downcase, nome, 0,1)
    @retorno = nil
  end
  #======================================================================#
  
  #======================================================================#
  def contract()
    
    # Retorna o identificador do contrato
    return(@contrato)
  end
  #======================================================================#
    
  #======================================================================#
  def make(*parameters)
    
    # Ação exercida pela funcionalidade (método de gatilho)
    parametro = parameters[0]
       
    if(parametro.length > @contrato.parametros)
        
    parametro.map! do |elemento|
      
      elemento.to_i
    
    end
        
    @resposta = parametro.inject(:+)
        
    else
    
      puts "[Soma] Quantidade de parâmetros inválida."
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
