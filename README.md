# simplex

version 1.0

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
