#======================================================================#
class ActionList

	#======================================================================#
	# Gera um objeto de ações para o comando inserido
	def initialize(actions)
		
		@actionList = Hash.new
		@id = 1

		actions.downcase!
		system_command = actions.split("--")
		
		if(system_command.size == 2)
			extern_param = system_command[1]
		else
			extern_param = nil
		end

		intern_param = system_command[0]
		intern_param = intern_param.split("|")

		@hashParam = Hash.new
		if(intern_param.size > 0)

			intern_param.each do |comando|
				comando = "#{comando} " 
				@hashParam[("ID#{@id}").to_sym] = createAction(comando)
				@id = @id+1 
			end

		end

		@actionList[:config] = {size: intern_param.size , ext: extern_param}
		@actionList[:action] = @hashParam

	end
	#======================================================================#

	#======================================================================#
	# Retorna o actionList
	def getActionList()
    	return(@actionList)
	end	
	#======================================================================#

	#======================================================================#
	def createAction(comando)

		action = Hash.new

		padrao = /(\w+)\s+(.+)/
		expressao = padrao.match(comando)  
		
      	#=========================================#
      	if(expressao.nil?)
      		
      		action[:key] = nil
      		action[:message] = "[Sys] Acao '#{comando}' desconhecida."
      	
      	else
      		
		    action[:key] = expressao[1]
		    action[:param] = expressao[2].split(" ")
		    action[:size] = action[:param].size
      	end
		 #=========================================#

		return(action)
	end
	#======================================================================#
end
#======================================================================#