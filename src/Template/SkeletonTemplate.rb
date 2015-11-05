class SkeletonTemplate

    def command(action)
       # Envia uma ação para o cerebro "brain" executar.
    end
    
    def attach(objeto)
        # Insere uma nova funcionalidade ao "brain" OU insere um novo "brain" 
        # conforme o desejado.
    end
    
    def detach(objeto)
        # Cancela o contrado de "objeto" removendo sua funcionalidade do
        # "Brain".
    end
    
    def state()
        # Exibe o status das funcionaliadades acopladas no esqueleto
        # (incluindo o cerebro).
    end
end
