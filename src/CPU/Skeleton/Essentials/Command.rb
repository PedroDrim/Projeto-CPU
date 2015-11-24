#======================================================================#
class Command

	#======================================================================#
	# Gera um objeto de ações para o comando inserido
  	def initialize(actions)
		  
		actions.downcase!
	    system_command = actions.split("--")
		
		if(system_command.size == 2)
			extern_param = system_command[1]
		end
    
		intern_param = system_command[0]
    	intern_param = intern_param.split("|")
		
		intern_param.each do |comando|
			
		end
 	end
	#======================================================================#
	
	#======================================================================#
	private
	def tratamento(comando)
		
	  	padrao = /(\w+)\s+(.+)/
      	expressao = padrao.match(action)  
      
      	#============================#
      	if(expressao.nil?)
        
        	puts "[Sys] Acao '#{action}' desconhecida." 
        
        	memory_buffer[id.to_s.to_sym] = jhash("SystemException",nil)
        	id += 1
      	else
		  
		end
		#============================#
		
	end
	#======================================================================#
end
#======================================================================#