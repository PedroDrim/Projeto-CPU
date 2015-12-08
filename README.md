Projeto-CPU
=======================

Descrição:
----------------
O "Projeto-CPU" é um sistema amador que visa simular uma linguagem com suporte a aprendizado, sua estrutura é dividida em 3 componentes essenciais.

* Brain (cérebro): Responsável pelo aprendizado de novas funções.
* Skeleton (esqueleto): Responsável pela interação entre o usuário e o "cérebro", e entre o usuário e os "módulos".
* Molule (módulos): São as funções-base do sistema, são configuradas externamente e cadastradas em um banco de dados.

Estrutura:
----------------
A estrutura do projeto é feita ná linguagem Ruby e com base em uma arquitetura de camadas aonde o esqueleto se comunica com os "módulos" e com o "cérebro".
Além disso o "esqueleto" é responsável por cadastrar, manipular acesso e remover quaisquér componentes do sistema por meio de um banco de dados Sqlite.

### Diretório:
O diretório do projeto possui uma configuração própria, feita para auxiliar a manutenção e a organização dos dados.

o-> ./src : Diretório-Mãe.

|---> ./src/CPU : Diretório-base.

|------> ./src/CPU/data : Localização dos resultados exportados pelo comando `-export` .

|--------->  ./src/CPU/data/db : Localização do banco de dados Sqlite.

|---------> ./src/CPU/data/serialization : Funções serializadas.

|------> ./src/CPU/data/Essentials : Arquivos essenciais para a manipulação de dados.

|---> ./src/CPU/Head : Funcionamento da camada "cérebro".

|------> ./src/CPU/Head/Essentials : Arquivos essenciais para a camada "cérebro".

|---> ./src/CPU/Module : Funcionamento da camada "módulo".

|------> ./src/CPU/Module/Essentials : Arquivos essenciais para a camada "módulo".

|---> ./src/CPU/Skeleton : Funcionamento da camada "esqueleto".

|------> ./src/CPU/Skeleton/Essentials : Arquivos essenciais para a camada "esqueleto".

o---> ./src/Template : Arquivos de templates.
 

Detalhamento:
----------------
As camadas possuem características própria de forma a garantir a modularidade do sistema, são elas:

### Brain:
O "cérebro" é responsável por realizar as seguintes rotinas:

* Deve Possuir uma palavra-chave (BRA_1): Para identificação, todo "cérebro" deverá possuir uma palavra-chave, entretando essa palavra não é cadastrada no banco de dados.
* Deve Funcionar como uma Rede Neural (BRA_2): O "cérebro" deve possuir uma estrutura base para "inteligência artificial".
* Deve Gerar Novas Funções (BRA_3): O "cérebro" deve ser capaz de aprender novas funcionalidades por meio da inteligência artificial.
* Gerenciamento Contratual (BRA_4): As novas funcionalidades geradas pelo "cérebro" devem possuir um "contrato" para interação com o "esqueleto" como se fosse uma função-base.

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

Banco de dados:
----------------
Todos os contratos são inseridos em um banco de dados Sqlite cuja tabela deverá ter o seguinte formato:

 Palavra-chave | Quantidade de Parametros | Estado de Parametro | Descrição do "módulo"
--------------|--------------------------|---------------------|----------------------
 [_Soma_] | [_0_] | [_1_] | [_Isto soma números_]

Detalhes especiais:
----------------
O sistema deve receber, tratar e ativar a entrada do usuário. Todo esse processo é realizado pelo "esqueleto" cuja saída é uma ação direcionada para as camadas "módulo" ou "cérebro"...

### Manipulação de linguagem:
A entrada do usuário possui a seguinte sintaxe:

* Linha de comando simples `[ palavra-chave ] [ parametros referentes ao método referente a palavra-chave ]`
   * Exemplo: `soma 2 3 4 5`

* Linha de comando composta `[ Linha de comando simples 1 ] | [ Linha de comando simples 2 ]`
   * Exemplo: `soma 2 3 4 5 | quadrado 2`

* Export de resultados simples `[ Linha de comando simples ] -export`
   * Exemplo: `soma 2 3 4 5 -export`.O resultado é um objeto JSON no seguinte formato:

```
{"export_output":[
  {"id":[posição da linha de comando simples], "comando":[palavra-chave da função], "output":[output da função]}
]}
```

* Parametros de recursividade `[ Linha de comando simples ] | [ palavra-chave ] [ parametro 1 ] [ parametro 2 ] [ $n ]`
   * Exemplo: `soma 2 3 4 5 | quadrado $1` , o caractere especial `$1` faz referência ao resultado da primeira linha.

* Comandos base de sistema `system [ man / list ]`, aonde:
   * `system man`: Lista de forma interativa todos os "módulos" acoplado no sistema. Ao selecionar uma delas deverá ser mostrado todas as informações do "módulo". 
   * `system list`: Exibe uma simples lista de todos os "módulos" acoplado no sistema.

* Comando "aprender", aonde o sistema por meio da interação com o "cérebro" deve aprender novas funcionalidades. Mais detalhes no próximo tópico.

### Conexão entre camadas:
O sistema possui uma arquitetura em camadas, aonde a camada "esqueleto" se comunica com as camadas "cérebro" e "módulo".
A comunicação entre as camadas "esqueleto" e "módulo" ocorrem da seguinte maneira:

1. O usuário digita um comando para o sistema, por exemplo: `soma 2 3 | quadrado 3 -export`.

2. O __"cérebro"__ deve receber essa entrada e realizar o seguinte tratamento:
   * Identificar o parametro de sistema, `-export`.
   * Separar multiplos comandos, por meio do identificador `|`.
   * Identificar para cada comando existente "Qual é a sua palavra-chave e quais são seus parâmetros"
   * Retornar um objeto referente ao comando anterior devidamente tratado.

3. O __"cérebro"__ deve, para cada palavra-chave (função) encontrada, resgatar o objeto serializado referente a função e executar método `trigger` existente no __"módulo"__ ,passando como parametros os parametros referentes a função. 

4. O __"módulo"__ irá executar o método `trigger` e seu resultado será armazenado em uma variável de resposta interna.

5. O __"cérebro"__ executa o método `get` do __"módulo"__ e recebe o resultado do método.

6. O __"cérebro"__ deverá então armazenar todos os resultados em um "buffer" de forma que seja possível o mapeamento.

7. O __"cérebro"__ Verifica se existe o parametro de sistema `-export` e em caso afirmativo salva a resposta no formato "JSON". Em caso negativo a resposta é exibida no terminal.
 
Refatoração:
----------------

A refatoração do código possui as seguintes regras:

* Toda função deverá possuir no máximo 20 linhas codificadas.
* Funções do tipo `private` deverão ficar no final da classe.
* Deverá existir no máximo 2 estruturas de repetição por método, com no máximo 3 métodos de profundidade.
* Toda classe / método deverão ser comentadas e documentadas.
