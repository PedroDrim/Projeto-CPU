load "../model/Instruction.rb"
load "../error/ErrorCodes.rb"

#=======================================================#
# Classe responsável por converter a entrada do usuário em instruções
class InstructionController
	include ErrorCodes
	
	#=======================================================#
	# Prepara a entrada do usuário, separando métodos e instruções
	# actions: String -> Entrada do usuário
	def prepareInstruction(actions)		
		# Inicializando variáveis
        actionList = Hash.new
        instructionArray = Array.new        

		# Separando comandos do sistema de instruções
		system_command = actions.downcase.split("--")
        
		if system_command.size == 2
			extern_param = system_command[1]
		else
			extern_param = nil
		end

		# Separando e construindo multiplas instruções
		intern_param = system_command[0]
		intern_param = intern_param.split("|")

		if intern_param.size > 0
			intern_param.each do |comando|
				instructionArray.push(createInstruction comando)
			end
		end

		# Definindo hash de instruções
		actionList[:external] = extern_param
		actionList[:instruction] = instructionArray

        return actionList
	end
	#======================================================================#

	#=======================================================#
	# Converte uma instrução em uma ação
	# instruction: Instructions -> Instrução a ser convertido
	def toAction(instruction)
		
	end
	#======================================================================#

	#======================================================================#
	# Método para criar instrução com base em um comando
	# comando: String -> Comando a ser convertido
    private
	def createInstruction(comando)
		padrao = /(\w+)\s+(.+)/
		expressao = padrao.match comando  

      	if(expressao.nil?)
      		param = nil
			erro = ErrorCodes.unknownAction(comando)
      	else
		    comando = expressao[1]
		    param = expressao[2].split(" ")
		    erro = nil
      	end

		return Instruction.new(comando, param, erro)
	end
    #=======================================================#
    
end
#=======================================================#