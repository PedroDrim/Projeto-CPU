#=======================================================#
# Template para o objeto responsavel por realizar o processo de inteligência
# artificial e decidir quando utilizar as funcionalidades dos objetos "Arm"

class BrainTemplate
  
  #=======================================================#
  def initialize(nome,id)
    @nome = nome
    @id = id
  end
  #=======================================================#
  
  #=======================================================#
  def nome()
    return @nome
  end
  #=======================================================#
  
  #=======================================================#
  def id()
    return @id
  end
  #=======================================================#
  
  #=======================================================#
  def think(*parameters)
    # Método de inteligência artifical para tomar uma ação
  end
  #=======================================================#
  
end
#=======================================================#