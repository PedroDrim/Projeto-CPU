Projeto-CPU
=======================

# Descrição:
----------------
O "Projeto-CPU" é um sistema amador que visa simular uma linguagem com suporte a aprendizado, sua estrutura é dividida em 3 componentes essenciais.

* Brain (cérebro): Responsável pelo aprendizado de novas funções.
* Skeleton (esqueleto): Responsável pela interação entre o usuário e o "cérebro", e entre o usuário e os "módulos".
* Molule (módulos): São as funções-base do sistema, são configuradas externamente e cadastradas em um banco de dados.

# Estrutura:
----------------
A estrutura do projeto é feita ná linguagem Ruby e com base em uma arquitetura de camadas aonde o esqueleto se comunica com os "módulos" e com o "cérebro".
Além disso o "esqueleto" é responsável por cadastrar, manipular acesso e remover quaisquér componentes do sistema por meio de um banco de dados Sqlite.

# Detalhamento:
----------------
As camadas possuem características própria de forma a garantir a modularidade do sistema, são elas:

### Brain:
O "cérebro" é responsável por realizar as seguintes rotinas:

* Item 1 Deve Possuir uma palavra-chave (BRA_1): Para identificação, todo "cérebro" deverá possuir uma palavra-chave, entretando essa palavra não é cadastrada no banco de dados.
* [_Á implementar_]

### Skeleton:
O "esqueleto" é responsável por realiazar as seguintes rotinas:

* Cadastrar Módulos (SK_1): Os "módulos" devem ser cadastrados antes da primeira inicialização do sistema. Deve ser feita uma verificação do "módulo" de forma a evitar duplicidade de funções e caso a função já exista deverá ser exibido uma mensagem de aviso.

* Buscar Módulos (SK_2): Todo "módulo" possui como chave única uma "palavra de acesso" existente em um "contrato", por meio dessa palavra o "esqueleto" verifica a presença ou ausência do cadastro da função no banco de dados e caso a função não exista deverá ser exibido uma mensagem de aviso.

* Remover Módulos (SK_3): Os "módulos" podem ser removidos com base na "palavra de acesso" e caso a função não exista deverá ser exibido uma mensagem de aviso entretanto.

* Manipular "cérebro" (SK_4): O "cérebro" do sistema deve ser acoplado no sistema entretanto poderá ser removido ou substituido. Caso o sistema em sua execução não detecte um "cérebro" o sistema deverá exibir uma mensagem de aviso e criar um "vazio" e em seguida iniciar o sistema.

* Desacoplar Tudo (SK_5): O sistema deverá remover todos os sistemas nele acoplados, incluíndo "módulos" e "ceŕebro". Uma mensagem de aviso deverá ser gerada.

* Serializar Dados (SK_6): Todo "módulo" ou "cérebro" acoplado no sistema deverá ser serializado para uso posterior e melhor gerênciamento de memória. Os dados serializados de "módulos" deverão possuir a seguinte nomenclatura "Module_[palavra-chave].mem" e os dados serializados de "cérebros" 
deverão possuir a seguinte nomenclatura "Brain_[palavra-chave].mem"

* Manipular Dados Serializados (SK_7): Todo "módulo" ou "cérebro" possuem funções e características únicas, ao chamar uma função o sistema deve gerar um objeto com base no dado serializado e em seguida inicia-lo. Caso o sistema desacople algum deles, o objeto serializado também deverá ser removido.

* Manipulação De Linguagem (SK_8): Será detalhado em outro tópico.

* Conexão com o "cérebro" e com os "módulos" (SK_9): Será detalhado em outro tópico.

* Acesso a descrições gerais (SK_10): Todo "módulo" deverá possui em seu "contrato" uma breve descrição de seu funcionamento, essa descrição poderá ser acessada pelo usuário sempre que necessário.

### Module:
Os "módulos" são objetos-padrões do sistema e devem possuir as seguintes características:

* Existência de um "contrato" (MOD_1): Todo "módulo" deverá possuir um contrato com as seguintes características;
   * Uma palavra-chave, sem espaços e/ou caracteres especiais, para acesso.

   * Quantidade de parâmetros esperados.

   * "Estado de parâmetro" sendo -1 para "menor que", 0 para "igual á" e 1 para "maior que".

   * Descrição geral do funcionamento do "módulo".

   * Método de ativação "trigger" (MOD_2): Todo "módulo" deverá possuir um método de nome "trigger" que poderá receber uma quantidade infinita de parametros.

   * Variável de resultado (MOD_3): Todo "módulo" deverá atribuir sua resposta em uma "variável especial" independente da existência ou não de resultados manipuláveis.

   * Método de resposta "get" (MOD_4): Todo "módulo" deverá possuir um método de nome "get" que deverá retorna a variável de resposta.

   * Independência (MOD_5): Todo "módulo" é independente e portanto deverá possuir suas próprias regras de segurança e tratamento de erros. 

# Banco de dados:
----------------
Todos os contratos são inseridos em um banco de dados Sqlite cuja tabela deverá ter o seguinte formato:

 Palavra-chave | Quantidade de Parametros | Estado de Parametro | Descrição do "módulo"
--------------|--------------------------|---------------------|----------------------
 [_Soma_] | [_0_] | [_1_] | [_Isto soma números_]

# Detalhes especiais:
----------------

### Manipulação de linguagem:

### Conexão entre camadas:


