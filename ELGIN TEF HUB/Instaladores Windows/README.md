<!-- 

Este arquivo contem as notas de liberação para o software Elgin TEFHUB :: E1_TEF
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
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

///FIM
-->
<!-- Adiciona novas entradas abaixo deste comentário -->

# Release Notes - Lib E1_TEF
## 25/02/2026 - v05.06.02

### Melhorias
- N/A

### Correções
- Confirmação PIX estável (card 310)
  - Correção no fluxo de confirmação/desfazimento Digipay

### Componentes

|   Componente    | Versão      |
|-----------------|-------------|
| E1_TEF          | 05.06.02    |
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
- Coleta remota de LOGs
	Implementação do serviço de coleta de LOGs
	Ao instalar essa versão será gerada a documentação no link:
	http://localhost:7172/swagger/index.html
- Atualização Provider 3 - v4.31.0
- Atualização Provider 5 - v4.4.6.2

### Correções
- Correção do card 301
	Inclusão do NSU no retorno das transações
- Correção do card 310
	Implementação de uma validação em casos de erro de comunicação.
- Correção do card 311
	Implementação de registro em LOG com o resultado da ativação silenciosa do Provider 5
- Correção do card 314
	Padronização dos dados antes da validação.

### Componentes

|   Componente    | Versão      |
|-----------------|-------------|
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

## 04/11/2025 - v05.05.00

### Melhorias
- Atualização do client Provider7 para a versão 4.1.2.37;
  - Essa nova versão suporta o novo trilho voucher.
- Atualização do client Provider5 para a versão 4.4.5.

### Correções
- Correção do card 270;
  - Identificamos um bug na versão x86 do GP que causava o travamento da solução;
  - Removemos a utilização da biblioteca E1_Updater e o bug foi corrigido.
- Correção do número sequencial na coletas das funções administrativas;
- Correção do card 271;
- Correção do card 277;
- Correção do card 279;
- Correção do card 280.
- Correção do card 281.
  - Valor de automacao_coleta_retorno devolvido pela lib nas novas versões do Provider 5.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
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
| E1_ETX      | 04.06.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 02.00.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 09/10/2025 - v05.04.00

### Melhorias
- Atualização do componente TEF Passivo.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.04.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.04.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 02/10/2025 - v05.03.00

### Melhorias
- Atualização modulo ETX
 - Nova versão do modulo ETX possui melhorias para funcionamento do TEFWEB Assincrono.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
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
- Implementação da Manutenção (desativação) para o motor Scope
- Compatibilização de versões do ElginTEFPassivo (GP)
  - Modo de operação troca de arquivos passa a ser exclusivo na operação do GP.
    Dessa forma não será possível realizar operações financeiras que não sejam iniciadas pela automação integrada.
    Operações via TEF Autônomo somente serão possíveis se a parametrização do terminal estiver configurada para tal.
 
### Correções
- Correção referente ao card 246.
  - Foi corrigida a exibição das mensagens MsgOp1 e MsgCI2 para o provider 7.
- Toda a ativação silenciosa Destaxa teve timeout padronizado.
- Correção referente ao card 253.
- Desfazimento Aditum corrigido.
- Correção referente ao card 257.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.03.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| E1_Connect  | 01.03.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.29.1      |
| Provider 5  | 4.4.4-5     |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 26/08/2025 - v05.01.00

### Melhorias
- Atualização de motores
 - Atualiza versão do provider 2 para 2.4.3
 - Atualiza versão do provider 3 para 4.29.1
 - Atualiza versão do provider 5 para 4.4.4-5
- Melhorias nas regras de bloqueio do terminal.
  - Melhorias gerais na regra para bloqueio de terminais.

### Correções
- Correção referente ao card 235
  - Foi adicionada uma nova forma de validação para aguardar o provider5 se tornar responsivo após inicialização.
- Correção referente ao card 238.
### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.03.00    |
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
  
### Correções
- Correções no protoloco para compatibilidade com Provider7
  - Correção no mapeamento das chaves tipocartao e formapagamento

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |
| Provider 6  | 1.0.0       |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 27/06/2025 - v05.00.00

### Melhorias
- Implementação da integração com novo motor.
  - Primeira versão com suporte ao provedor 7
  - Implementação das operações de Débito, Crédito, Pré-Datado, Voucher (via débito) e Cancelamento.
  
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |
| Provider 6  | 1.0.0       |
| Provider 7  | 4.1.1       |

----------------------------------------------

## 06/06/2025 - v04.00.02

### Melhorias
- Correção referente ao card 205.
  - Foi implementado a função abort da API Aditum, responsável por abortar transações já iniciadas e aguardando interação do      consumidor.
- Correção referente ao card 206.
  - Esta correção tem relação com o card Bug/194:
    - Implementada uma nova validação no retorno da função IniciarLojaAditum.
    - Se a inicialização falhar, a flag de validação não sofre mais alterações. Fazendo com que em caso de falha seja solicitada nova inicialização de loja Aditum.
- Correção referente ao card 210.
  - Para que não tenha mais nenhum tipo de incompatibilidade, foi implementada a exclusão do atalho Client TEF.lnk da pasta de inicialização do sistema operacional.
- Exclusão do diretório legado Auttar C:\CTFClient.
- Correção referente ao card 212.
  - Alteração na validação da chave CancellationStatus.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.02.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |
| Provider 6  | 1.0.0       |

----------------------------------------------
## 09/04/2025 - v04.00.01

### Melhorias

### Correções
- Correção referente ao card Bug/194:
  - Foi adicionado uma validação na função de inicialização de loja aditum, onde a rotina de inicialização só será executada na primeira vez.
    - Esta implementação acaba com a atualização de tabelas em todas as transações seguintes a uma transação PIX.
  - Correção na exibição do QRCode nos pinpads PPC-930.
- Correção de um bug encontrado no retorno das transações mal sucedidas Destaxa.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.01    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |

----------------------------------------------

## 13/02/2025 - v04.00.00

### Melhorias
- Implementação da Ativação silenciosa para motor Destaxa.
	- A partir desta versão a ativação do motor é feita automaticamente durante a inicialização.
  - Não será mais necessário a inserção dos dados de CNPJ e Código de Assinatura.
- Implementação da função de Desativação Destaxa.
	- A desativação é feita através da operação de Manutenção.
- Atualização do componente E1_ETX para a versão 04.01.02.
	- Melhorias no processo de autenticação.
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
| E1_ETX      | 04.01.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.7       |
| Provider 3  | 4.24.03     |
| Provider 5  | 4.4.3       |

----------------------------------------------

## 07/02/2025 - v03.04.01

### Melhorias

### Correções
- Correção da função administrativa de relatório.
  - Inclusão do campo Loja e resultadoTransacao no retorno da função. Correção do BUG 178.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 05/02/2025 - v03.04.00

### Melhorias
- Melhoria no processamento de pagamentos PIX.
  - Pagamento PIX permanece em processamento mesmo se houver instabilidades de rede.

### Correções
- Tratamento no display do pinpad ao finalizar pagamento PIX.
  - Exibição do texto definido pela AC no display do pinpad após finalizar um pagamento PIX.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 30/01/2025 - v03.03.00

### Melhorias
- Envio de dados do pinpad para o servidor.
  - A coleta dos dados do pinpad é feita pela função PPE_GetInfo. Dados incluídos no payload de atualização do terminal.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 27/01/2025 - v03.02.01

### Melhorias

### Correções
- Correção da função de relatório.
  - Corrigido o processo de parsing da data de consulta, que causava a geração de relatórios com dados inconsistentes.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------
## 22/01/2025 - v03.02.00

### Melhorias
- Criação de tratamento para o parâmetro "versaoAC" Auttar.
  - Criação de um método para tratar o conteúdo da String retornada em versaoAC no Flow da Auttar.
- Adição de funcionalidade na função Administrativa Reimpressão.
  - Seguindo o padrão TEF Elgin, hoje se o usuário não informar a data da transação (primeiro dado solicitado para captura), a E1_TEF realizará
    a impressão da última venda feita.

### Correções
- Correção da função de reimpressão - Bug 148.
  - Inclusão no TEF HUB de todos os campos retornados no TEF Elgin.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 15/01/2025 - v03.01.01

### Melhorias

### Correções
- Correções na função Manutenção.
  - Correção da mensagem de retorno ao finalizar o processo de Manutenção;
  - Reset do objeto DB para não ser mais necessário a reinicialização da Automação Comercial;
  - Inclusão de uma mensagem de Sucesso no LOG.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.01    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 09/01/2025 - v03.01.00

### Melhorias
- Implementação da função Manutenção, responsável pela desativação do terminal.
  - A função Manutencao faz parte o pacote de funções administrativas;
  - A função valida a senha adm parametrizada no servidor. Caso nenhuma senha esteja cadastrada, utiliza-se a senha padrão "833482";
  - Suporte para todos os motores TEF que operamos.


### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.01.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 18/12/2024 - v03.00.03

### Melhorias
- Suporte a pinpad Lane3600
  - Suporte a comunicação com Lane3600 para as operações de pix.
  - Suporte a comunicação com Lane3600 para operações de TEF com provider 3 em ambiente linux.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 16/12/2024 - v03.00.02

### Melhorias
- Atualização do módulo E1_UPLOADER
  - Atualiza a versão do módulo de contingência para versão 02.00.00 com suporte a linux 32 bits.
- Suporte a pinpad Lane3000
  - Suporte a comunicação com Lane3000 para as operações de pix.
  - Suporte a comunicação com Lane3000 para operações de TEF com provider 3 em ambiente linux.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 02.00.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 12/12/2024 - v03.00.01

### Melhorias

### Correções
- Correção na operação de débito parcelado e pré datado.
  - Correção na formatação da data enviada para o provedor 3 nas operações de débito parcelado e pré datado.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 03/12/2024 - v03.00.00

### Melhorias
- Performance na Operação PIX
  - Redução do intervalo de tempo entre as verificações de status de pagamento, proporcionando uma atualização mais ágil e uma experiência de usuário aprimorada.

### Correções
- Compatibilidade com Linux 32 bits
  - Remoção de dependências incompatíveis com ambientes Linux 32 bits, garantindo o funcionamento adequado da aplicação nessas plataformas.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 28/11/2024 - v02.26.03

### Melhorias

### Correções
- Correção na transação debito.
  - Correção para operação de debito no fluxo do provider 2 para terminais com configuração de pré-datado habilitado.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 27/11/2024 - v02.26.02

### Melhorias

### Correções

### Componentes
- Atualização da lib ETX para versão 04.00.02
  - Remove "administrative password" na integração do provider 2.

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.02    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| Provider 2  | 2.3.5       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 21/11/2024 - v2.26.01

### Melhorias

### Correções
- Correção para loop na captura de data.
  - Corrige operação de coleta de data para transações pré-datadas com a utilização do provider 3.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 12/11/2024 - v2.26.00

### Melhorias
- Função de coleta de dados no pinpad
  - A partir desta versão a biblioteca passa a suportar coleta de dados no pinpad.
  - Para utilização deste recurso se faz necessário um PINPAD USB com protocolo ABECS 2.12.
  -  Os seguintes dados são suportados: 
      - 0001 = DIGITE O RG <br>
      - 0002 = DIGITE O CPF <br>
      - 0003 = DIGITE O CNPJ <br>
      - 0004 = DIGITE O DDD+TELEFONE <br>
      - 0010 = DIGITE O DDD <br>
      - 0011 = REDIGITE O DDD <br>
      - 0012 = DIGITE O TELEFONE <br>
      - 0013 = REDIGITE O TELEFONE <br>
      - 0014 = DIGITE DDD+TELEFONE <br>
      - 0015 = REDIGITE DDD+TELEFONE <br>
      - 0016 = DIGITE O CPF <br>
      - 0017 = REDIGITE O CPF <br>
      - 0018 = DIGITE O RG <br>
      - 0019 = REDIGITE O RG <br>
      - 0020 = DIGITE OS 4 ÚLTIMOS DÍGITOS <br>
      - 0021 = DIGITE CÓDIGO DE SEGURANÇA <br>
      - 0022 = DIGITE O CNPJ <br>
      - 0023 = REDIGITE O CNPJ <br>
      - 0024 = DIGITE A DATA (DDMMAAAA) <br>
      - 0025 = DIGITE A DATA (DDMMAA) <br>
      - 0026 = DIGITE A DATA (DDMM) <br>
      - 0027 = DIGITE O DIA (DD) <br>
      - 0028 = DIGITE O MÊS (MM) <br>
      - 0029 = DIGITE O ANO (AA) <br>
      - 0030 = DIGITE O ANO (AAAA) <br>
      - 0031 = DATA DE NASCIMENTO (DDMMAAAA) <br>
      - 0032 = DATA DE NASCIMENTO (DDMMAA) <br>
      - 0033 = DATA DE NASCIMENTO (DDMM) <br>
      - 0034 = DIA DO NASCIMENTO (DD) <br>
      - 0035 = MÊS DO NASCIMENTO (MM) <br>
      - 0036 = ANO DO NASCIMENTO (AA) <br>
      - 0037 = ANO DO NASCIMENTO (AAAA) <br>
      - 0038 = DIGITE IDENTIFICAÇÃO <br>
      - 0039 = CÓDIGO DE FIDELIDADE <br>
      - 0040 = NÚMERO DA MESA <br>
      - 0041 = QUANTIDADE DE PESSOAS <br>
      - 0042 = DIGITE QUANTIDADE <br>
      - 0043 = NÚMERO DA BOMBA <br>
      - 0044 = NÚMERO DA VAGA <br>
      - 0045 = NÚMERO DO GUICHÊ/CAIXA <br>
      - 0046 = CÓDIGO DO VENDEDOR <br>
      - 0047 = CÓDIGO DO GARÇOM <br>
      - 0048 = NOTA DO ATENDIMENTO <br>
      - 0049 = NÚMERO DA NOTA FISCAL <br>
      - 0050 = NÚMERO DA COMANDA <br>
      - 0051 = PLACA DO VEÍCULO <br>
      - 0052 = DIGITE QUILOMETRAGEM <br>
      - 0053 = QUILOMETRAGEM INICIAL <br>
      - 0054 = QUILOMETRAGEM FINAL <br>
      - 0055 = DIGITE PORCENTAGEM <br>
      - 0056 = PESQUISA DE SATISFAÇÃO (0 a 10) <br>
      - 0057 = AVALIE ATENDIMENTO (0 a 10) <br>
      - 0058 = DIGITE O TOKEN <br>
      - 0059 = DIGITE NÚMERO DO CARTÃO <br>
      - 0060 = NÚMERO DE PARCELAS <br>
      - 0061 = CÓDIGO DO PLANO <br>
      - 0062 = CÓDIGO DO PRODUTO
- Função de confirmação de dados no pinpad.
  - Essa função pode ser utilizada com o retorno da função de coleta de dados no pinpad para validar a entrada do usuário.
  - A automação também pode enviar um texto livre para ser validado pelo usuário no pinpad, para tal, basta enviar o prefixo "data=" seguido do conteúdo a ser validado.
  - O pinpad irá apresentar a informação solicitada pela automação com um prefixo "Confirme: ".
  - O pinpad possui limitações de apresentação, por isso é importante que a automação não envie um texto acima de 50 caracteres.
### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042300-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 04/11/2024 - v02.25.00

### Melhorias
- Modernização no armazenamento dos dados do terminal e de dados relevantes das transações.
  - Os dados do terminal e das transações agora são armazenados em uma base centralizada e unificada, e não mais em arquivos .dat individuais, com exceção dos dados de contingência (pastas 'vendas' e 'cfinf').
  - Os dados presentes nos arquivos .dat do cliente serão migrados automaticamente para essa nova base.
- Identificação da máquina onde o terminal foi instalado.
  - Como uma proteção adicional, a biblioteca de TEF funcionará somente na máquina onde o terminal foi instalado, impedindo a migração da base entre máquinas.
- Identificação do terminal com um GUID único junto ao GPC.
  - A habilitação seguida de confirmação de terminais com um identificador "reaproveitado" de um terminal desabilitado fará, a partir desta versão, com que qualquer outro terminal com o mesmo identificador seja bloqueado e fique inoperante.
  - Isso é útil nos casos onde o terminal é desabilitado incorretamente, fazendo com que somente o terminal habilitado mais recentemente (com o mesmo identificador) seja operacional.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 04.00.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.01.00    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042000-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 17/10/2024 - v02.24.00

### Melhorias
- Melhorias no sequencial de coleta.
  -  Flexibiliza o sequencial de coleta de tal modo onde se o mesmo estiver incorreto a operação não será abortada.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.08.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042000-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 27/09/2024 - v02.23.00

### Melhorias
- Suporte a sistema operacional linux.
  - A partir desta versão a LIB E1_Tef passa a suporta sistemas operacional Linux.
  - A compilação e testes foram realizados sob GLIBC 2.23 (Ubuntu GLIBC 2.23-0ubuntu11.3) para ambiente i386 e x86_64.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.08.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042000-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 26/09/2024 - v02.22.01

### Melhorias
- Envio de dados presentes no arquivo de configuração da biblioteca para os servidores Elgin.
  - Os dados sobre o PDV configurados na biblioteca, através do método *ConfigurarDadosPDV* ou editando diretamente o arquivo, agora também são enviados aos servidores de parametrização e histórico.
- Inclusão do "Identificador do Terminal" no comprovante das transações.
  - A última linha dos comprovantes gerados agora possuem a informação do "Identificador do Terminal" (no formato "PDV: ID"), correspondente ao parâmetro "identificadorPontoCaptura" do método *ConfigurarDadosPDV* e à chave de mesmo nome do arquivo de configuração da biblioteca.

### Correções
- Comprovante incompleto que era retornado em casos de transação negada.
  - A biblioteca somente retornará os comprovantes das transações caso estas sejam recebidas de seus provedores, tipicamente em caso de transação aprovada.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.08.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042000-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 23/09/2024 - v02.22.00

### Melhorias
- Melhorias adicionais na inicialização das vendas no provedor #3.
  - Remoção da dependência "pinpad.dll" / "pinpad.so" e mudanças no tratamento do pinpad, acarretando um melhor tempo no início das operações.

### Correções
- Crash ao migrar do provedor #3 para outro provedor.
  - A biblioteca "pinpad.dll" / "pinpad.so", responsável pelo bug que causava esse crash, foi removida.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.08.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| Provider 2  | 2.3.0       |
| Provider 3  | C042000-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 17/09/2024 - v02.21.02

### Melhorias
- Tempo de inicialização das vendas no provedor #3.
  - A configuração do provedor #3 agora é realizada apenas na inicialização da 1a transação, melhorando o desempenho das próximas operações.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 06/09/2024 - v02.21.01

### Melhorias

### Correções
- Data da 1a parcela sendo solicitada mais de uma vez no CDC pelo provedor #3.
  - Nessa versão foi corrigida a situação onde a "data da 1a parcela" era solicitada mais de uma vez quando uma venda débito parcelado (CDC) era realizada atráves do provedor #3.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 04/09/2024 - v02.21.00

### Melhorias
- Implementação da funcionalidade "Relatório".
  - Nessa versão foi implementado o "Relatório", comum a todos os provedores, onde o usuário pode consultar todas as transações realizadas numa determinada data.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.02.00    |
| E1_UPLOADER | 01.00.08    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 23/08/2024 - v99.20.01

### Melhorias
- Ajustes na integração com provedor #5:
  - Melhoria no layout dos comprovantes;
  - Remoção da mensagem sobre transações pendentes que aparecia no início das vendas;
  - Texto default para mostrar no pinpad caso nenhum tenha sido informado pelo usuário.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.07    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 20/08/2024 - v99.20.00

### Melhorias
- Integração do provedor #5 e migração do TEF Elgin para o Elgin TEFHUB.
  - Nessa versão o provedor #5 e os recursos presentes no TEF Elgin foram migrados para o Elgin TEFHUB, formando um único pacote padronizado.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.07.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.07    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |
| Provider 5  | 4.3.9       |

----------------------------------------------

## 30/07/2024 - v99.16.01

### Melhorias

### Correções
- Bug que solicitava coleta de dados já informados.
  - Quando um payload com dados pré-informados da transação era enviado para lib do ETH sem pré-informar o tipo de operação (parâmetro "(int)codigoOperacao"), os dados informados no payload eram perdidos após a escolha da operação no menu e tais dados eram solicitados novamente.
  - Esse bug foi corrigido nesta versão e os dados pré-informados no payload não serão perdidos após a escolha da operação desejada nos menus.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 2.3.0       |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 26/07/2024 - v99.16.00

### Melhorias
- Envio do modo de integração ao servidor de histórico.
  - Adição da chave 'integrationBy' no payload que a lib do ETH gera com os dados da transação enviada ao servidor de histórico.
- Melhorias no menu de pagamentos.
  - Sempre que o usuário acionar a função RealizarPagamentoTEF sem especificar o código da operação desejada será gerado um menu onde é possível escolher entre "Cartões" ou "Carteiras digitais", conforme a disponibilidade dessas operações no GPC e no motor em uso.
  - A tabela a seguir apresenta os possíveis valores que podem ser enviados no parâmetro "(int)codigoOperacao" da função RealizarPagamentoTEF:

| Valor | Significado |
| :---: | :---------- |
| 1     | Crédito |
| 2     | Débito |
| 3     | Voucher |
| 4     | Frota |
| 5     | Private label |
| 21    | Pix |
| 0     | Menu de cartões [1...5] |
| 20    | Menu de carteiras digitais [21] |
| -1    | Menu de pagamentos [0,20] |
| ...   | Qualquer outro valor equivale a -1 |

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 22/07/2024 - v99.15.00

### Melhorias
- Operação de ativação via menu administrativo.
  - Agora é possível ativar um terminal através do menu administrativo.
- Geração do comprovante de ativação.
  - Após uma ativação bem-sucedida é gerado um comprovante com os dados do terminal ativado no local de instalação da solução.
- Suporte a ativação com numero de terminal.
  - Durante a ativação do terminal é possível informar, opcionalmente, o identificador de um terminal específico para ativação.
- Informação do host na ativação.
  - A lib do ETH captura o hostname do terminal a ser habilitado e envia no payload de confirmação ao GPC.
- Menu administrativo dinâmico.
  - As opções disponíveis no menu administrativo são apresentadas conforme o status do terminal (habilitado ou desabilitado).
- Padronização do local de load da lib do pinpad.
  - As dependências da lib do ETH são buscadas, por padrão, no diretório de instalação da solução.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.06.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 18/07/2024 - v99.14.00

### Melhorias
- Habilita logs da para a DLL.
  - Passa a ser criado a variavel de ambiente no momento da instalação para que a dll gere logs automaticamente.
- Melhoria na geração do arquivo de licença.
  - A partir desta versão a dll passa a gerar os arquivos de licença no diretório de instalação do TEFHUB. Isso deve afetar apenas as novas instalações.
- Aumenta o timeout para operações do PIX.
  - Aumenta o tempo limite para geração de QRCode, Desfazimento e Cancelamento para 180 Seg (3 min). Esse valor é parametrizavel via servidor de parametros.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.06.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.06    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 11/07/2024 - v99.13.00

### Melhorias
- Adiciona codigo de identificação elgin no comprovante.
  - Adiciona o ElginREF no comprovante das transações. Este será utilizado para operações diversas idependentemente do motor.
- Melhorias no log.
  - Adiciona ambiente de operação no logs.
- Operação de cancelamento comum.
  - Remove a necessidade de informar o tipo da transação no momento do cancelamento.
- Retrocompatibilidade do PIX
  - Passa a suportar as funções RealizarPixTEF, ConfirmarOperacaoTEF e RealizarAdmTEF (para cancelamento) nas operações de PIX do TEFHUB.

### Correções
- Correção no menu administrativo.
  - Corrige erro ao gerar o menu administrativo em terminais que possuem
  somente PIX ativo.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.04.01    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.04    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 27/06/2024 - v99.12.01

### Melhorias
- Coleta para vias de impressão.
  - Coleta da informação "vias de reimpressão" na operação "adm reimprimir"

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
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
- Correções na confirmação de transação.
  - Corrige falha no fluxo de confirmação de transações realizadas pelo Tef Web.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.04.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.04    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 12/06/2024 - v99.11.01

### Melhorias
- Adiciona identificador do terminal
  - Retorno da chave "identificadorPontoCaptura" nas transações bem-sucedidas da biblioteca.

### Correções

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.04.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.04    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------

## 07/06/2024 - v99.11.00

### Melhorias
- Apresenta QRCode pix no pinpad.
  - Passa a apresentar o QRCode do PIX nos PINPAD padrão ABECS 2.12.

- Melhorias na função de reimpressão.

### Correções
- Correção no comprovante.
  - Correção na formatação dos comprovantes.

### Componentes

| Componente  | Versão      |
|-------------|-------------|
| E1_ETX      | 03.04.00    |
| E1_UPDATER  | 01.00.04    |
| E1_UPLOADER | 01.00.03    |
| Provider 2  | 1.4.11      |
| Provider 3  | C041901-D00 |

----------------------------------------------