# simplex

version 1.2

[Aplicação Simplex online](https://fierce-bayou-1370.herokuapp.com)

Cesar Alves    RA 533122  
Gabriel Caires RA 526932  
Vitor Derobe   RA 525510  

Projeto de Pesquisa Operacional  
 - 6º Semestre BCC Univem  

Implementação do método simplex em Ruby para resolução de sistemas lineares, a aplicação resolve problemas de
maximização e minimização para expressões e restrições menores ou iguais a zero (<=).  


### Ferramentas  

- Ruby 2.1.3p242  

- Rails 4.1.6  

- Bootstrap 3.3.5  

- jQuery / AJAX / CoffeeScript 2.2.0  

### Guia de uso  

- Maximizar Z = 3x1 + 5x2  

Expressão  
> 3x1 + 5x2  

Restrições  
> x1 <= 4  
> x2 <= 6  
> 3x1 + 2x2 <= 18  

Clique em "Maximizar"  

- Minimizar Z = -3x1 - 5x2  

Expressão  
> -3x1 - 5x2  

Restrições  
> x1 <= 4  
> x2 <= 6  
> 3x1 + 2x2 <= 18  

Clique em "Minimizar"  

Utilize o botão "Add Restrição" para adicionar campos de textos adicionais para restrições.  
Utilize o botão "-" para remover campos de textos adicionais para restrições.  

- Resultado  

É exibido o passo a passo das tabelas geradas pelo método simplex, com número máximo de 20 iterações.  

## Nota de Liberação Simplex versão 1.3	

### Introdução
Este documento provê uma visão geral da versão do aplicativo Simplex que está sendo liberada. Aqui descreveremos as funcionalidades do aplicativo, bem como seus problemas e limitações conhecidos. Por último são descritas as demandas e os problemas que foram resolvidos para liberação da versão atual.

### 1. Nota de release a ser publicado
- Algoritmo Simplex para problemas de maximização.
- Algoritmo Simplex para problemas de minimização.
- Demonstrar o passo a passo de iterações na tabela.
- Tabela de Sensibilidade.
- Não possuir número fixo para variáveis de decisão.
- Não possuir número fixo de restrições.
- Tratamento de erro para modelos sem solução.
- Tratamento de erro para modelos com infinitas iterações. 

### 2. Problemas conhecidos e limitações
#### Limitação
- As restrições devem ser estritamente menores ou iguais a 0 (<=).
- O tempo de latência pode variar, sendo algumas vezes alto ou baixo.

### 3. Datas Importantes
Segue abaixo as datas importantes do desenvolvimento:

Data  | Evento
------------- | -------------
22/09/15  | Início do planejamento
23/09/15  | Início do desenvolvimento
08/10/15  | Entrega para teste
21/10/15  | Fim do teste
22/10/15  | Início do desenvolvimento
23/09/15  | Liberação para simulação do ambiente de produção
23/10/15  | Ajustes finais
23/10/15  | Liberação para produção

### 4. Compatibilidade
Segue abaixo os requisitos:

Requisitos  | Ferramentas
------------- | -------------
Navegadores  | Mozila Firefox, Chrome, Internet Explorer
Sistema operacional  | Ubuntu, RedHat, Windows, Mac

#### Tecnologias

Tecnologias  | Ferramentas
------------- | -------------
Front-End | HTML, CSS, CoffeeScript
Back-End | Ruby 2.1
Framework WEB | Rails 4.1.6, Bootstrap 3.3.5
IDE | Não Utilizado
Editor de Texto | Sublime Text 2
Design pattern | Não Utilizado
Servidor Web | WEBrick (Heroku)

### 5. Procedimento E ALTERAÇAO DE CONFIGURAçãO do Ambiente
Para alteração no ambiente é necessário possuir o Git e o kit de ferramenta do Heroku instalados, efetuar o login como administrador do repositório no Heroku e adicionar o repositório remoto com o comando “Heroku Create”. Após as etapas de configurações serem concluídas basta realizar um “push” da branch da aplicação no Git diretamente para o repositório remoto do Heroku. Exemplo: “git push heroku master”.

### 6. Atividades Realizadas No período
Nessa liberação foram contemplados os seguintes itens:

Cód | Título | Tarefa | Situação | Observação
------------- | ------------- | ------------- | ------------- | ------------- 
1 | Maximizar | Montar a Tabela Simplex, e possibilitar o usuário a maximizar modelos de simplex com sistemas lineares. | Concluído | Apenas restrições de “<=”
2 | Minimizar | Montar a Tabela Simplex, e possibilitar o usuário a minimizar modelos de simplex com sistemas lineares. | Concluído | Apenas restrições de “<=”
3 | Adição de restrições | Possibilitar o usuário a adicionar inputs para maiores números de restrições. | Concluído | |
4 | Remoção de restrições | Possibilitar o usuário a remover inputs para menores números de restrições. | Concluído | |
5 | Demonstrar passo a passo | Demonstrar ao usuário as alterações na tabela causada pelas iterações do método simplex. | Concluído | |
6 | Tabela de de sensibilidade | Demonstrar ao usuário a tabela de sensibilidade. | Concluído | |
7 | Tratamento de modelos sem solução | Tratar os erros com modelos sem solução e com iterações infinitas. | Concluído | |


