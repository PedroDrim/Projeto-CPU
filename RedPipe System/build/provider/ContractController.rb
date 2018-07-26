#=======================================================#
# Classe responsável por gerenciar a cri
class ContractController

    #=======================================================#

    #=======================================================#

    #=======================================================#
    def saveContract(contract)
        classFile = contract.getClassFile

        contractName = "#{contract.getCommand}.rpb"
        
        File.open(contractName, 'wb') do |file| 
            file.write(Marshal.dump(m)) 
        end
    end
    #=======================================================#

    #=======================================================#
    def loadContract(command)
        contractName = "#{command}.rpb"

        object = File.open(contractName) do |file|
            Marshal.load(file)    
        end
          
        return(object)
    end
    #=======================================================#

end
#=======================================================#