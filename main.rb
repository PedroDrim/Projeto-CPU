#=======================================================#
# Carregando gemas e arquivos necessários
require("mysql2")
require("json")

load("./CPU/Skeleton.rb")
load("./CPU/Head/Brain.rb")
load("./CPU/Head/Neuronio.rb")
load("./Module/ArmSoma.rb")
load("./Module/ArmQuadrado.rb")
#=======================================================#

#=======================================================#
# Carregando objetos primarios
brain = Brain.new("TecnoBrain","TCB")
soma = ArmSoma.new("Somatório de 2 inteiros")
quadrado = ArmQuadrado.new("Obtem o quadrado de um numero")

skeleton_teste = Skeleton.new(brain)
skeleton_teste.attach(soma)
skeleton_teste.attach(quadrado)
#=======================================================#

#=======================================================#
# Iniciando interacao de teste

$ciclo = true
while($ciclo)
			
	print "\n[*] Digite o comando: "
	comando = gets.chop!
	skeleton_teste.command(comando)

end
#=======================================================#
#skeleton_teste.detach(soma)
#skeleton_teste.detach_all

#teste = Neuronio.new(pesos = [1,1])

#entrada1 = [1,0]
#entrada2 = [0,1]
#entrada3 = [0,0]
#entrada4 = [1,1]

#saida1 = -1
#saida2 = -1
#saida3 = 1
#saida4 = 1

#puts "-"
#puts teste.pesos
#teste.training(entrada1, saida1)
#puts "-"
#puts teste.pesos
#teste.training(entrada2, saida2)
#puts "-"
#puts teste.pesos
#teste.training(entrada3, saida3)
#puts "-"
#puts teste.pesos
#teste.training(entrada4, saida4)
#puts "-"
#puts teste.pesos
#puts "--"
#teste.sinapse(entrada2)
