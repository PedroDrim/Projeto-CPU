# Template para o objeto responsavel por atribuir as funcionalidades
# ao "Brain"

class ArmTemplate
    
  def initialize(nome)
    @nome = nome
  end
  
  def nome()
    return @nome
  end
  
  def contract()
    # Gera um contrato para o "Brain" e armazena suas referências
    # para uso posterior.
       
    # Retorna o identificador do contrato
    return(-1) # exemplo de retorno
  end
    
  def make(*parameters)
    # Ação exercida pela funcionalidade (método de gatilho)
  end
    
  def get()
    # Retorna o objeto criado (se houver) pelo metodo make
  end
end