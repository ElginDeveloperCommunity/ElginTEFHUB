<!-- 
Este arquivo contem as notas de liberação para o software Elgin TEFHUB :: GP
Para novas atualizações adicione o bloco abaixo com os detalhes da liberação:

///INICIO

## {DATA} - v{VERSÃO}

### Melhorias
- {Descrição da melhoria para area de negócios.}
  - {Descrição da melhoria para area tecnica.}

### Correções
- {Descrição da correção para area de negócios.}
  - {Descrição da correção para area tecnica.}

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.00.03    |
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

///FIM
-->
# Release Notes - GP TEFHUB
## 11/02/2026 - v05.06.01

### Melhorias
- Atualização do componente provider 3

### Componentes

|   Componente    | Versão      |
|-----------------|-------------|
| E1_TEF          | 05.06.00    |
| E1_ETX          | 04.06.00    |
| E1_UPDATER      | 01.02.00    |
| E1_UPLOADER     | 02.00.01    |
| E1_Connect      | 02.00.00    |
| E1_ETH_Service  | 01.00.00    |
| Provider 2      | 2.3.7       |
| Provider 3      | 4.32.2      |
| Provider 5      | 4.4.6.2     |
| Provider 7      | 4.1.2.37    |

----------------------------------------------

## 16/01/2026 - v05.06.00

### Melhorias
- Atualização do componente E1_Tef para v05.06.00
- Coleta remota de LOGs
	Implementação do serviço de coleta de LOGs
	Ao instalar essa versão será gerada a documentação no link:
	http://localhost:7172/swagger/index.html
- Atualização Provider 3 - v4.31.0
- Atualização Provider 5 - v4.4.6.2

### Correções
- Correção do card 303
	Centralização da tela do gerenciador padrão
- Correção do card 305
	Correção do ícone da aplicação

### Componentes

|   Componente    | Versão      |
|-----------------|-------------|
| E1_TEF          | 05.06.00    |
| E1_ETX          | 04.06.00    |
| E1_UPDATER      | 01.02.00    |
| E1_UPLOADER     | 02.00.01    |
| E1_Connect      | 02.00.00    |
| E1_ETH_Service  | 01.00.00    |
| Provider 2      | 2.3.7       |
| Provider 3      | 4.31.0      |
| Provider 5      | 4.4.6.2     |
| Provider 7      | 4.1.2.37    |

----------------------------------------------

## 28/10/2025 - v05.05.00

### Melhorias
- Atualização do client Scope para a versão 4.1.2.37
- Atualização do client Destaxa para a versão 4.4.5
- Atualização do componente E1_Tef para a versão 05.05.00

### Correções
- Correção do card 270.
    - Identificamos um bug na versão x86 do GP que causava o travamento da solução;
    - Removemos a utilização da biblioteca E1_Updater e o bug foi corrigido.
- Correção do número sequencial na coletas das funções administrativas.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 05.05.00    |
| E1_ETX      | 04.06.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 02.00.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.5       |
| Provider 7  | 4.1.2.37    |

----------------------------------------------

## 09/10/2025 - v05.04.01

### Melhorias

### Correções
- Normalização de NSU nas consultas do banco de dados.
  - Implementação de comparação numérica via CAST para garantir compatibilidade entre NSUs com ou sem zeros à esquerda.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 05.04.01    |
| E1_ETX      | 04.06.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 02.00.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 03/10/2025 - v05.04.00

### Melhorias
- Implementação do endpoint /consulta
  - Permite consultar a resposta de transações síncronas (identificador) e assíncronas (uuid).

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 05.03.00    |
| E1_ETX      | 04.05.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 02.00.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 02/10/2025 - v05.03.00

### Melhorias
- Implementação do modo assíncrono do TEFWEB
  - Nova versão suporta transações assíncronas com retornos via webhook.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 05.03.00    |
| E1_ETX      | 04.04.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.04.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 18/09/2025 - v05.02.00

### Melhorias
- Compatibilização de versões do ElginTEFPassivo (GP)
  - Versão Amigao inserida na versão corrente do GP.
  - O modo padrão passa a ser o modo troca de arquivos.
  - A partir dessa versão inicia-se a substituição gradativa do arquivo config_tef.json 
- Atualização do componente E1_Tef:
 - Implementação da Manutenção (desativação) para o motor Scope.
  
### Correções
- Correções no componente E1_Tef.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 05.02.00    |
| E1_ETX      | 04.03.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.03.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 22/08/2025 - v05.01.00

### Melhorias
- Atualização de motores
 - Atualiza versão do provider 2 para 2.4.3
 - Atualiza versão do provider 3 para 4.29.1
 - Atualiza versão do provider 5 para 4.4.4-5
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 05.01.00    |
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.03.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 07/08/2025 - v05.00.02

### Melhorias
- Atualização da Lib E1_Tef
 - Atualiza a lib E1_Tef para versão 05.00.02 com melhorias do protocolo provider 7
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 05.00.02    |
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.03.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 25/07/2025 - v05.00.01

### Melhorias
  
### Correções
- Correção do card 219 e 221:
	- Foi incluída uma nova rotina de exclusão de arquivos legado VBI.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 04.00.03    |
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.03.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 28/06/2025 - v05.00.00

### Melhorias
- Inclusão do componente E1_Provider7 e dependêcias.
  - Nesta versão foi incluido os componentes do novo Provider
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 04.00.02    |
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.03.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 26/06/2025 - v04.00.03

### Melhorias
- Atualização do componente E1_Connect para a versão 01.03.00 
  - Correção referente ao card 46 - TEF WEB.
    - Foi criado uma nova rota para recuperar o ultimo retorno.
    - A rota a ser estimulada é a http://localhost:2001/tef/v1/ultimo_retorno via método GET.
    - Esta rota retornará o último retorno referente a última interação realizada.
  - Correção referente ao card 111 - TEF WEB.
    - Foi implementado a possibilidade de solicitar uma reimpressão enviando todos os dados necessários de uma só vez (data e nsu da transação).
  - Correção referente ao card 58 - TEF WEB.
    - Foi implementada a adequação do valor das chaves do Json de retorno de venda.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 04.00.02    |
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.03.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |

----------------------------------------------

## 06/06/2025 - v04.00.02

### Melhorias
- Atualização do componente E1_TEF para a versão 04.00.02 
  - Correção referente ao card 205.
  - Correção referente ao card 206.
  - Correção referente ao card 210.
    - Atualização do instalador para exclusão do atalho Client TEF.lnk na pasta de inicialização do sistema operacional.
  - Atualização do instalador para Exclusão do diretório legado Auttar C:\CTFClient.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 04.00.02    |
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |

----------------------------------------------

## 09/04/2025 - v04.00.01

### Melhorias
- Atualização do componente E1_TEF para a versão 04.00.01 
  - Correção referente ao card Bug/194:
  - Foi adicionado uma validação na função de inicialização de loja aditum, onde a rotina de inicialização só será executada na primeira vez.
    - Esta implementação acaba com a atualização de tabelas em todas as transações seguintes a uma transação PIX.
  - Correção na exibição do QRCode nos pinpads PPC-930.
  - Correção de um bug encontrado no retorno das transações mal sucedidas Destaxa.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 04.00.01    |
| E1_ETX      | 04.01.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |

----------------------------------------------

## 13/02/2025 - v04.00.00

### Melhorias
- Atualização do componente E1_TEF para a versão 04.00.00
  - Implementação da Ativação silenciosa para motor Destaxa.
	  - A partir desta versão a ativação do motor é feita automaticamente durante a inicialização.
    - Não será mais necessário a inserção dos dados de CNPJ e Código de Assinatura.
  - Implementação da função de Desativação Destaxa.
	  - A desativação é feita através da operação de Manutenção.
- Atualização do componente E1_ETX para a versão 04.01.02
	- Reset de um objeto interno da biblioteca ETX.
- Atualização dos Motores TEF para as versões mais recentes, conforme destacado na sessão componentes.
  - Motor Destaxa - Versão 4.4.3:
    - Suporte a ativação silenciosa.
  - Motor Auttar - Versão 4.24.3:
    - Melhoria do horário de verão.
  - Motor Aditum - Versão 2.3.7:
    - Melhorias gerais do fluxo transacional.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 04.00.00    |
| E1_ETX      | 04.01.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |

----------------------------------------------


## 07/02/2025 - v03.04.01

### Melhorias
- Atualização do componente E1_TEF para a versão 03.04.01
  - Inclusão do campo Loja e resultadoTransacao no retorno da função. Correção do BUG 178.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.04.01    |
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 05/02/2025 - v03.04.00

### Melhorias
- Atualização do componente E1_TEF para a versão 03.04.00.
  - Exibição do texto definido pela AC no display do pinpad após finalizar um pagamento PIX;
  - Pagamento PIX permanece em processamento mesmo se houver instabilidades de rede.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.04.00    |
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 30/01/2025 - v03.03.00

### Melhorias
- Atualização do componente E1_TEF para a versão 03.03.00
  - Implementação do envio de dados do pinpad para o servidor.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.03.00    |
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 27/01/2025 - v03.02.01

### Melhorias
- Atualização do componente E1_TEF para a versão 03.02.01
  - Atualiza versão do componente E1_TEF com correções na operação de relatório diário.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.02.01    |
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------
## 23/01/2025 - v03.02.00

### Melhorias
- Atualização do componente E1_TEF para a versão 03.02.00
  - Criação de tratamento para o parâmetro "versaoAC" Auttar.
  - Adição de funcionalidade na função Administrativa Reimpressão.
  - Inclusão no TEF HUB de todos os campos retornados no TEF Elgin.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.02.00    |
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------


## 15/01/2024 - v03.01.01

### Melhorias
- Atualização do componete E1_TEF para a versão 03.01.01 e componente E1_ETX para a versão 04.01.01.
  - A versão 03.01.01 corrige apontamentos levantados na fase de teste:
    - Tratamento de retorno para Automação Comercial;
    - Inclusão de novas linhas de LOG;
    - Refaturação em algumas funções do DB Local.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.01.01    |
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 13/01/2025 - v03.01.00

### Melhorias

### Correções

### Componentes
 - Atualização do componente E1_Tef para versão 03.01.00
  - A versão 03.01.00 implementa a função Manutencao faz parte o pacote de funções administrativas.

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.01.00    |
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------
## 03/01/2025 - v03.00.04

### Melhorias
- Melhoria nas transições entre janelas.
  - Ao finalizar a operação o foco é devolvido para a automação.
- Aumento da área de apresentação do logotipo.
  - A área para apresentação do logotipo foi ajustada para 220x80 px.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.00.03    |
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 18/12/2024 - v03.00.03

### Melhorias
- Atualização da lib_ppelgin.
  - Atualiza a lib de comunicação com pinpad com suporte ao pinpad Lane3600.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.00.03    |
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------
## 16/12/2024 - v03.00.02

### Melhorias
- Atualização da lib E1_Tef.
  - Atualização da lib E1_Tef para versão 03.00.02 com melhorias na integração com módulo e1_uploader;
- Atualização da lib_ppelgin.
  - Atualiza a lib de comunicação com pinpad com suporte ao pinpad Lane3000.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.00.02    |
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------
## 03/12/2024 - v03.00.00

### Melhorias
- Atualização E1_TEF
  - Atualização da lib E1_TEF com melhorias na operação PIX.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 03.00.00    |
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 28/11/24 - v02.25.01

### Melhorias

### Correções

### Componentes
- Atualização da lib E1_TEF
  - Atualiza lib E1_TEF para versão 02.26.03 com melhorias na integração com provider 2.

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.26.03    |
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 21/11/2024- v2.25.00

### Melhorias
- Melhorias geral no instalador
  - Remove arquivos antigos de instalação do provedor 3.
  - Altera pasta de instalação do provider 3 para utilizar o diretório padrão de instalação do TEFHUB.
- Atualiza o client E1_TEF
  - Atualiza o client E1_TEF para a versão 02.26.01.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.26.01    |
| E1_ETX      | 04.00.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 12/11/2024 - v2.24.00

### Melhorias
- Atualização da lib do ETH para versão 02.26.00.
  - Nessa versão foi implementado as funções de coleta de dados no pinpad.

### Correções

### Componentes
 - Atualização do provider 2 para versão 2.3.5

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.26.00    |
| E1_ETX      | 04.00.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 04/11/2024 - v02.23.00

### Melhorias
- Atualização da lib do ETH para versão 02.25.00.
  - Nessa versão foram realizadas melhorias no armazenamento dos dados do terminal e das transações e melhorias na identificação do terminal.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.25.00    |
| E1_ETX      | 04.00.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 31/10/2024 - v02.22.01

### Melhorias

### Correções

### Componentes
- Nova versão do provider 3.
  - Adiciona suporte a apresentação do valor da transação na tela do pinpad durante a captura do cartão.

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.22.01    |
| E1_ETX      | 03.08.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 26/09/2024 - v02.22.01

### Melhorias
- Atualização da lib do ETH para versão 02.22.01.
  - Nessa versão foram realizadas melhorias no envio de dados aos servidores Elgin e ajustes nos comprovantes das transações.
- Alteração em label do instalador.
  - A frase "Piloto contactless BIN" foi alterada para "Contactless BIN".

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.22.01    |
| E1_ETX      | 03.08.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042000-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 24/09/2024 - v02.22.00

### Melhorias
- Atualização da lib do ETH para versão 02.22.00.
  - Nessa versão foram aplicadas novas melhorias no provedor #3.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.22.00    |
| E1_ETX      | 03.08.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042000-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 10/09/2024 - v02.21.03

### Melhorias
- Atualização da lib E1_Tef para versão 02.21.02
  - Versão 02.21.02 da E1_Tef possui melhorias no fluxo de inicialização do provider 3.

### Correções
- Correção na versão do provider 5 instalado.
  - Anexa versão 4.3.9 ao fluxo de instalação.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.21.02    |
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 10/09/2024 - v02.21.02

### Melhorias
- Adiciona retorno de código do bin.
  - IntPos de saída passa a retornar a TAG 010-004 com o bin do cartão.
- Mantem uma cópia do arquivo de dll E1_TEF com nome antigo.
  - Realiza uma cópia da DLL E1_TEF com a nomenclatura antiga (E1_Tef01.dll) para manter retrocompatibilidade.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.21.01    |
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 06/09/2024 - v02.21.01

### Melhorias
- Atualização da lib do ETH para versão 02.21.01.
  - Nessa versão foi feita uma correção no CDC pelo provedor #3.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.21.01    |
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 04/09/2024 - v02.21.00

### Melhorias
- Atualização da lib do ETH para versão 02.21.00.
  - Nessa versão foi implementada a funcionalidade "Relatório".

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 02.21.00    |
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 23/08/2024 - v99.20.01

### Melhorias
- Atualização da lib do ETH para versão 99.20.01.
  - Nessa versão foram realizados ajustes finos na integração com provedor #5.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.20.01    |
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.07    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 20/08/2024 - v99.20.00

### Melhorias
- Atualização de dependências do GP.
  - Libs E1_TEF, E1_ETX e E1_UPLOADER atualizadas para as versões 99.20.00, 03.07.00 e 01.00.07, respectivamente.
  - Nessa versão houve a integração do provedor #5 e a migração do TEF Elgin para o Elgin TEFHUB.

- Melhorias no instalador.
  - Adicionado o módulo do provedor #5, versão 4.3.9.
  - Suporte ao provedor #5 no script de instalação.

### Correções
- Correções no modulo E1_Connect - TEFWEB
  - Correção no envio de data e nsu da transação de cancelamento.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.20.00    |
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.07    |
| E1_Connect  | 01.02.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 05/08/2024 - v99.17.02

### Melhorias
- Melhorias no instalador.
  - Nessa versão o instalador passa a verificar se a quantidade de memória RAM disponível no sistema atende os requisitos.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.16.01    |
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 30/07/2024 - v99.17.01

### Melhorias
- Atualização da lib do ETH para versão 99.16.01.
  - Nessa versão da lib o bug que solicitava coleta de dados já informados foi corrigido.

### Correções
- Bug que não exibia o QRCode do PIX na tela do GP.
  - Nessa versão foi corrigido o bug que não exibia o QRCode do PIX na tela do GP quando o PIX era acionado via menu de pagamentos.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.16.01    |
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 27/07/2024 - v99.17.00

### Melhorias
- Atualização do instalador GP
  - Atualiza instalador do Provider2 para versão 2.3.0
  - Altera diretório de instalação do Provider 2 para {app}/Provider2
  - Remove arquivos desnecessários.

### Correções
- Correção no fluxo de instalação.
  - Corrige problema gerados no momento da instalação do componente GP3. Erros 11, 31 e 32.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.16.00    |
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 26/07/2024 - v99.16.00

### Melhorias
- Atualização da lib do ETH para versão 99.16.00, com melhorias na geração do menu de pagamentos.
  - Para acessar o menu de pagamentos "completo" - que inclui as opções de "Cartões" e "Carteiras digitais" -, basta *não enviar* no arquivo IntPos.001 as chaves 011-000 / 731-000.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.16.00    |
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 22/07/2024 - v99.15.00

### Melhorias
- Atualização de dependências do GP
  - Libs E1_TEF e E1_ETX atualizadas

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.15.00    |
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 18/07/2024 - v99.14.00

### Melhorias
- Novos códigos de bandeiras.
  - Adiciona novos códigos de bandeira no retorno da TAG 010-003
- Padronização código da adquirente.
  - Padradroniza o código de adquirente para compor o o valor da TAG 010-001 para os novos provedores.

### Correções
- Remove arquivos desnecessários.
  - Remove arquivos de homologação da instação em modo produção.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.14.00    |
| E1_ETX      | 03.06.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 11/07/2024 - v99.13.00

### Melhorias
- Adiciona identificação do EC ativo.
  - Adiciona no titulo da janela o a razão social e CNPJ ativo.

- Melhoria na tela do PIX.
  - Na tela do QR Code do Pix, informa ao operador que é necessário aguardar a confirmação do pagamento.

### Correções
- Correção no Fluxo de cancelamento.
  - Remove "Tela extra" no fluxo de cancelamento das transações.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.13.00    |
| E1_ETX      | 03.04.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.05    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 27/06/2024 - v99.12.01

### Melhorias

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.12.01    |
| E1_ETX      | 03.04.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.04    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 14/06/2024 - v99.12.00

### Melhorias
- Adiciona suporte a operação Pré-datado.
  - Suporta transações do tipo pré-datado na venda débito.

- Adiciona suporte a operação débito parcelado.
  - Suporta transações do tipo débito parcelado.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.12.00    |
| E1_ETX      | 03.04.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.04    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 12/06/2024 - v99.11.01

### Melhorias

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.11.01    |
| E1_ETX      | 03.04.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.04    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 07/06/2024 - v99.11.00

### Melhorias
- Logotipo TEFHUB.
  - Novo logotipo do TEHHUB da tela principal.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_TEF      | 99.11.00    |
| E1_ETX      | 03.04.00    |
| E1_UPDATER  | 01.00.03    |
| E1_UPLOADER | 01.00.03    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------