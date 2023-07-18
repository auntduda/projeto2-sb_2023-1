# Projeto 2 da disciplina de Software Básico - Calculadora em x86

## Alunos

- Davi Jesus de Almeida Paturi - 200016784
- Maria Eduarda Carvalho Santos - 190092556

## Descrição

O projeto 2 da disciplina de Software Básico cursada no semestre de 2023.1 se deu pela criação de uma calculadora de operações básicas, feita em Assembly x86 da arquitetaura Intel. O projeto é dado pela implementação das operações de **SOMA**, **SUBTRAÇÃO**, **MULTIPLICAÇÃO**, **DIVISÃO**, **EXPONENCIAÇÃO** E **MÓDULO**, cada operação separada em diferentes arquivos do esqueleto. A calculadora foi programada no padrão Intel de sintaxe, e a manipulação de operações é dada por meio de passagem de parâmetros pela pilha. O arquivo ``main.asm`` contém a chamada de módulos das operações, além da declaração de variáveis e strings locais, a serem utilizadas nos arquivos que implementam as operações aritméticas por meio da passagem de argumentos a partir da pilha d eexecução do programa. O arquivo ``main.asm`` se encontra na pasta ``src``, bem como os arquivos que compõem as operações descritas e o arquivo que implementa as operações de leitura e escrita por meio das respetivas chamadas de sistema. A pasta ``obj`` contém os arquivos objetos gerados a partir da ligação do programa, e o arquivo ``Makefile`` contém a estrutura necessária para ligar e executar o projeto de maneira simples.

## Ligando e Executando o Projeto

Para que o projeto possa ser avaliado, é necessário executar a seguinte linha de comando:

``make -f Makefile``

Após, os arquivos que compõem o projeto estarão ligados, e o executável ``calc`` estará pronto para ser executado, a partir da seguinte linha de comando:

``./calc``
