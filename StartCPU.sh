#!/bin/bash

#========================================================================#
# Verificando/criando a estruturacao da arvore de diretorios
directoryValidation() {

# Existe pasta src?
if [ -d ./src ]
then
	echo "Directory ./src : OK!"
else
	echo "Directory ./src : FAIL!"
	mkdir ./src
        echo "Directory created."
fi

# Existe pasta src/CPU?
if [ -d ./src/CPU ] 
then
	echo "Directory ./src/CPU : OK!"
else
	echo "Directory ./src/CPU : FAIL!"
	mkdir ./src/CPU
	echo "Directory created."
fi

# Existe pasta src/CPU/data?
if [ -d ./src/CPU/data ]
then
	echo "Directory ./src/CPU/data : OK!"
else
	echo "Directory ./src/CPU/data : FAIL!"
	mkdir ./src/CPU/data
	echo "Directory created."
fi

# Existe pasta src/CPU/data/db?
if [ -d ./src/CPU/data/db ]
then
	echo "Directory ./src/CPU/data/db : OK!"
else
	echo "Directory ./src/CPU/data/db : FAIL!"
	mkdir ./src/CPU/data/db
	echo "Directory created."
fi

# Existe pasta src/CPU/data/serialization?
if [ -d ./src/CPU/data/serialization ]
then
	echo "Directory ./src/CPU/data/serialization : OK!"
else
	echo "Directory ./src/CPU/data/serialization : FAIL!"
	mkdir ./src/CPU/data/serialization
	echo "Directory created."
fi

# Existe pasta src/CPU/data/output?
if [ -d ./src/CPU/data/output ]
then
	echo "Directory ./src/CPU/data/output : OK!"
else
	echo "Directory ./src/CPU/data/output : FAIL!"
	mkdir ./src/CPU/data/output
	echo "Directory created."
fi

# Existe pasta src/CPU/data/Essentials?
if [ -d ./src/CPU/data/Essentials ]
then
	echo "Directory ./src/CPU/data/Essentials : OK!"
else
	echo "Directory ./src/CPU/data/Essentials : FAIL!"
	mkdir ./src/CPU/data/Essentials
	echo "Directory created."
fi

 # Existe pasta src/CPU/Head?
if [ -d ./src/CPU/Head ]
then
	echo "Directory ./src/CPU/Head : OK!"
else
	echo "Directory ./src/CPU/Head : FAIL!"
	mkdir ./src/CPU/Head
	echo "Directory created."
fi

 # Existe pasta src/CPU/Head/Essentials?
if [ -d ./src/CPU/Head/Essentials ]
then
	echo "Directory ./src/CPU/Head/Essentials : OK!"
else
	echo "Directory ./src/CPU/Head/Essentials : FAIL!"
	mkdir ./src/CPU/Head/Essentials
	echo "Directory created."
fi

# Existe pasta src/CPU/Module?
if [ -d ./src/CPU/Module ]
then
	echo "Directory ./src/CPU/Module : OK!"
else
	echo "Directory ./src/CPU/Module : FAIL!"
	mkdir ./src/CPU/Module
	echo "Directory created."
fi

# Existe pasta src/CPU/Module/Essentials?
if [ -d ./src/CPU/Module/Essentials ]
then
	echo "Directory ./src/CPU/Module/Essentials : OK!"
else
	echo "Directory ./src/CPU/Module/Essentials : FAIL!"
	mkdir ./src/CPU/Module/Essentials
	echo "Directory created."
fi

# Existe pasta src/CPU/Skeleton?
if [ -d ./src/CPU/Skeleton ]
then
	echo "Directory ./src/CPU/Skeleton : OK!"
else
	echo "Directory ./src/CPU/Skeleton : FAIL!"
	mkdir ./src/CPU/Skeleton
	echo "Directory created."
fi

# Existe pasta src/CPU/Skeleton/Essentials?
if [ -d ./src/CPU/Skeleton/Essentials ]
then
	echo "Directory ./src/CPU/Skeleton/Essentials : OK!"
else
	echo "Directory ./src/CPU/Skeleton/Essentials : FAIL!"
	mkdir ./src/CPU/Skeleton/Essentials
	echo "Directory created."
fi

# Existe pasta src/Template?
if [ -d ./src/Template ]
then
	echo "Directory ./src/Template : OK!"
else
	echo "Directory ./src/Template : FAIL!"
	mkdir ./src/Template
	echo "Directory created."
fi

}

#========================================================================#

#========================================================================#
# Verificando a existencia das gemas basicas necessarias para o sistema
gemVerification() {
	echo "A implementar"
}
#========================================================================#

#========================================================================#
# Iniciando o sistema
startSystemCPU(){
	directoryValidation
	gemVerification
	RB_FILES_LIST=$(find . -name '*.rb' -exec echo -r {} \;) 
	ruby ./src/main.rb $RB_FILES_LIST
}
#========================================================================#

startSystemCPU
