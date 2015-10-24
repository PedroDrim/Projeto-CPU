#====================================================================#
class Neuronio
  
  #====================================================================#
  def initialize(pesos, bias = 0)

    @bias = bias
    @pesos = pesos
    
  end
  #====================================================================#
  
  #====================================================================#
  def training(entrada,saida)
    # Entrada será um vetor contendo os valores a serem analisados no treinamento
    # Saida será apenas o valor esperado

    rate = 0.001 # Taxa de aprendizado
    
    # Iniciando processo de treinamento
    begin
      error = false
      
      # Varrendo vetor de pesos
      soma = 0 
      index = 0
      for index in 0...(@pesos.length)
        # Somando resultado da análise
        soma = soma + (@pesos[index] * entrada[index])
      end
      
      # Verificando se o resultado obtido é igual ao esperado
      obtido = signalchange(soma - @bias)
      if(obtido != saida)
          
        # Caso seja diferente, reajuste os pesos
        aprendizado = rate * (saida - obtido)
        
        for index in 0...(@pesos.length)
          @pesos[index] = @pesos[index] + (aprendizado * entrada[index])
        end
      
        error = true
      end
      
    end until !error
    
    # fim do processo de treinamento
  end
  #====================================================================#

  #====================================================================#
  def sinapse(entrada)
    
    # Varrendo vetor de pesos
      soma = 0 
      index = 0
      for index in 0...(@pesos.length)
        # Somando resultado da análise
        soma = soma + (@pesos[index] * entrada[index])
      end
      
      # Verificando se o resultado obtido é igual ao esperado
      obtido = signalchange(soma - @bias)
      
    puts "O resultado é: #{obtido}"
      
  end
  #====================================================================#

  #====================================================================#
  def pesos()
    
    return(@pesos)

  end
  #====================================================================#

  #====================================================================#  
  private
  def signalchange(entrada)
    # Math.tanh(entrada)
    return entrada >= 0? 1:-1
  end
  #====================================================================#
    
end
#====================================================================#
