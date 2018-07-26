load "../provider/InstructionController.rb"
load "../provider/BoxController.rb"

#=======================================================#
# Classe para inicialização do sistema
class Start

    #=======================================================#
    # Método construtor, responsável por exibir o menu,
    # capturar as informações do usuário e exibir os resultados.
    def initialize
        # Carregando componentes auxiliares do rps
        loadRPS
        
        # Exibindo menu
        slowType("[RPS] Bem-vindo ao RedPipe System.\n", 0.05)
        slowType("[RPS] Digite 'system list' para listar as instruções cadastradas.\n", 0.05)
        slowType("[RPS] Pressione 'CTRL + C' para encerrar o programa.\n", 0.05)
        slowType("[RPS] Ou entre com sua instrução.\n", 0.05)
        
        # Obtendo entrada do usuário
        loop do
            slowType("[<o>] ", 0.05)
            command = gets.chop
            unless command.empty?
                resposta = readCommand command 
                slowType("#{resposta}\n", 0.05)
            end
        end
    end
    #=======================================================#

    #=======================================================#
    # Método para inicializer os componentes auxiliares do sistema
    private
    def loadRPS
        
    end
    #=======================================================#

    #=======================================================#
    # Método para ler a entrada do usuário
    # command: String -> Entrada digitada pelo usuário
    private
    def readCommand(command)
        # Iniciando buffer global
        $buffer = Array.new
        
        # Iniciando controladores e preparando instruções
        instructionController = InstructionController.new
        return instructionController.prepareInstruction command
    end
    #=======================================================#

    #=======================================================#
    # Método para exibir textos com delay
    private
    def slowType(text, speed = 0.1)
        text.split("").each do |letter|
            print letter
            sleep(speed)
        end
    end
    #=======================================================#

end
#=======================================================#

begin 
    Start.new
rescue SystemExit, Interrupt
    puts "\n"
end