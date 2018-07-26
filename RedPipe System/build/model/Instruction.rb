#=======================================================#
# Classe responsável por abtrair uma instrução
class Instruction

    #=======================================================#
    # Método contrutor responsável por inicializar as variáveis
    # command: String -> Comando da instrução
    # param: Array -> Parametros do comando
    # error: String -> Mensagem de erro (caso ocorra)
    def initialize(command, param, error)
        @error = error
        @command = command
        @param = param
    end
    #=======================================================#

    #=======================================================#
    # Obtem o comando da instrução
    def getCommand
        return @command
    end
    #=======================================================#

    #=======================================================#
    # Obtem os parametros da instrução
    def getParam
        return @param
    end
    #=======================================================#

    #=======================================================#
    # Obtem a quantidade de parametros da instrução
    def getParamSize
        return @param.size
    end
    #=======================================================#

    #=======================================================#
    # Obtem o erro (caso tenha) da instrução
    def getError
        return @error
    end
    #=======================================================#

end
#=======================================================#