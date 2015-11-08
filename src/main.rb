#!/usr/bin/ruby

#=======================================================#
# Carregando gemas e arquivos necessários
#require("sqlite3")
#require("json")

# Iniciando todos os arquivos essenciais para o sistema com a extensao .rb
argv_base = ARGV
argv_base.delete("-r")

argv_template = argv_base.select {|file| file[/Template/]}
argv_base -= argv_template

argv_essentials = argv_base.select {|file| file[/Essentials/]}
argv_base -= argv_essentials

argv_main = argv_base.select {|file| file[/main/]}
argv_base -= argv_main

argv_template.each { |file| load file}
argv_essentials.each { |file| load file}
argv_base.each { |file| load file}

#=======================================================#

#=======================================================#
# Carregando objetos primarios
brain = Brain.new("TecnoBrain","TCB")
soma = ArmSoma.new("Somatório de inteiros")
quadrado = ArmQuadrado.new("Obtem o quadrado de um conjunto de numeros")

skeleton_teste = Skeleton.new(brain)
skeleton_teste.attach(soma)
skeleton_teste.attach(quadrado)
#=======================================================#

#=======================================================#
# Iniciando interacao de teste

$ciclo = false
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
