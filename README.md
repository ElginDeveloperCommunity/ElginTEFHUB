
# TEF-Elgin

## Documentação
[Link para a Documentação do ElginTEF](https://elgindevelopercommunity.github.io/group__g7.html)

[Como instalar e atualizar o TEF Elgin](https://github.com/ElginDeveloperCommunity/TEF-Elgin/wiki/Instalando-e-Atualizando-TEF-Elgin)

## Requisitos para instalação:
* Windows:
  * Versões que estejam dentro da vigencia de suporte da Microsoft.
  * Hardware: 4GB de RAM disponível. 80 GB de espaço disponível em disco.
* Linux:
  * Ubuntu: Versões LTS à partir da 18. (Ubuntu 18.04.6, 20.04.6 ou Ubuntu 22.04.6)
  * Debian: 9 ou superior.
  * Linux Lite: 6.6 ou superior.
  * Arch: "Rolling release" oficial, garatindo que os pacotes adicionais estejam atualizados.
  *  Hardware: 4GB de RAM disponível. 80 GB de espaço disponível em disco.
* Android:
  * Versão 7 ou superior.
  * Hardware: 2GB de RAM disponível. 16GB de espaço disponível em disco.

  
## Elgin TEF
O Tef Pay Elgin é uma solução que fornece para Automação Comercial integração para que seja possivel a captura de transações financeiras através de diversos concentradores de Tef disponíveis no mercado.

A Solução de TEF Elgin conta também com um módulo `E1_TEFPay_Passivo` que foi desenvolvida para facilitar as transações Eletrônicas usando o Modo de troca de arquivos com mensageria padrão `CHAVE = VALOR`

# Módulo Passivo
O módulo passivo foi desenvolvido para facilitar a integração de parceiros que ja possuem implementações no padrão troca de arquivos.
A troca de arquivos utiliza-se de dois diretorios. Um deles necessário para automação enviar os arquivos de requisição para api. A automação grava um arquivo nesse diretório para ser lido pela API, o qual esta continuamente tentando ler arquivo nesse local. O outro diretório serve para a API Elgin enviar arquivos para a automação. A Api TEF Elgin grava o arquivo de saida nesse diretorio para ser lido pela automação.
Os diretorios são criados na execução da aplicação se caso não existirem, os caminhos usados como padrão são: 

`C:\Cliente\Req` - para arquivo de requisição de transações.

`C:\Cliente\Resp` - para arquivos de Status e de resposta para automação.

Há dois tipos de arquivos para troca de dados entre automação e APITEF. Um deles serve para enviar dados e o outro para enviar uma resposta confirmando o recebimento dos dados.
O arquivo de dados recebe o nome “INTPOS.001”. Já o arquivo de confirmação de recebimento de dados recebe o nome “INTPOS.STS”.

Abaixo segue um diagrama do fluxo de iterações entre PDV e E1_TEFPay_Passivo e logo adiante um exemplo dos arquivos de requisição e resposta:

![Diagrama de sequencia para fluxo de comunicação entre PDV e Módulo de troca de arquivos](https://user-images.githubusercontent.com/78883867/117910368-2fc08100-b2b2-11eb-8b97-952024370e13.png)

Exemplo de Transação Venda Débito/Crédito 

Arquivo IntPos.001 gerado pela Automação na Etapa 1 de uma operação CRT.
C:\Cliente\Req\IntPos.001

Dados escritos:

    000-000 = CRT
    001-000 = 1
    002-000 = 123456
    003-000 = 4500
    004-000 = 0
    999-999 = 0

Arquivo IntPos.Sts gerado pelo Módulo E1_TEFPAY_Passivo na Etapa 2 de uma operação CRT.
C:\Cliente\Resp\IntPos.Sts

Dados retornados pela API:

    000-000 = CRT
    001-000 = 1
    999-999 = 0

Arquivo IntPos.001 gerado pelo Módulo E1_TEFPAY_Passivo na Etapa 4 de uma operação CRT. (Após a captura da transação na etapa 3)
C:\Cliente\Resp\IntPos.001

Dados retornados pela API:

    000-000 = CRT
    001-000 = 1
    002-000 = 123456
    003-000 = 4500
    010-000 = ELECTRON
    010-001 = 103
    010-003 = 21
    010-004 = 417402
    010-005 = 7578
    011-000 = 03603511027
    012-000 = 001315
    013-000 = 001315
    018-000 = 01
    022-000 = 0326
    023-000 = 192414
    028-000 = 37
    029-001 = ELGIN PAY TESTE BANRISUL
    029-002 = 92.702.067/0001-96   
    029-003 = R CAPITAO MONTANHA, 177
    029-004 = CENTRO PORTO ALEGRE RS
    029-005 = 
    029-006 = 
    029-007 = 
    029-008 = 
    029-009 =                  REDE                 
    029-010 = 
    029-011 = REDESHOP  -      OKI                  
    029-012 = 
    029-013 = 
    029-014 = COMPROV: 123456789 VALOR: 45,00
    029-015 = 
    029-016 = ESTAB:013932594 SCOPE TESTE SIMULADO  
    029-017 = DD.MM.AA-HH:MM:SS TERM:PV123456/pppnnn
    029-018 = CARTAO: ************7578
    029-019 = AUTORIZACAO: 123456                   
    029-020 = ARQC:36DEFEF9D3490BC5
    029-021 = 
    029-022 = **************************************
    029-023 =          D E M O N S T R A C A O      
    029-024 =  Transacao sem validade para reembolso
    029-025 =     Autorizacao gerada por simulador  
    029-026 = **************************************
    029-027 = 
    029-028 =     TRANSACAO AUTORIZADA MEDIANTE     
    029-029 =         USO DE SENHA PESSOAL.         
    029-030 =                                       
    029-031 = 0
    029-032 = CONTROLE 03603511027  OKI BRASIL SCOPE
    029-033 = 
    029-034 = 
    029-035 = 
    029-036 = 
    029-037 = 
    030-000 = Transação Finalizada com Sucesso
    043-000 = SIMULADOR
    047-000 = 00
    050-000 = 000
    150-000 = 000000000000002
    210-004 = 4174020000007578=25080000000000000000
    210-052 = 001
    210-052 = 001
    300-001 = 0825
    600-000 = 01425787000104
    701-016 = 0326
    999-999 = 0

Arquivo IntPos.001 gerado pela Automação na Etapa 6 de uma operação CRT. (Após a automação ter realizado a impressão e armazenado os dados da transação)
C:\Cliente\Req\IntPos.001

Dados Escritos pela automação para confirmação de uma venda:

    000-000 = CNF
    001-000 = 1
    027-000 = 123456
    999-999 = 0
    
Arquivo IntPos.Sts gerado pelo Módulo E1_TEFPAY_Passivo na Etapa 7 de uma operação CRT.
C:\Cliente\Resp\IntPos.Sts

Dados Retornados pela API:

    000-000 = CNF
    001-000 = 1
    999-999 = 0

## Operações com PIX
Para realizar uma operação PIX, a automação deve gerar um arquivo IntPos.001 com os seguintes dados:

Dados escritos:

	000-000 = PIX
	001-000 = 1
	002-000 = 123456
	003-000 = 400
	999-999 = 0

## Utilizar o PIX4 para transações TEF
Para utilizar o PIX4 para transações com Pix, basta alterar no arquivo de configurações `config_tef.json` a chave `"pix4": 0` para `"pix4": 1`.
<br>
Exemplo de arquivo de configuração:  
```json

	{
	"file_req": "IntPos.001",
    "file_resp": "IntPos.Sts",
    "log": 1,
    "path_in": "C:/Cliente/Req",
    "path_out": "C:/Cliente/Resp",
    "pix4": 1,
    "produto_tef": 2,
    "tag_comprovante": 0
	}
```

## Customização do Gerenciador Padrão 
No arquivo de configuração `config_tef.json` pode ser adicionado um bloco opcional com várias possibilidades de customização.

### Descrição das chaves de customização 
`caminho_logo`: chave que define o caminho que se encontra a imagem que deve ser apresentada na aplicação. Exemplo: `C:/logo.png`
- Caso o caminho não seja um caminho válido, a imagem não será alterada
- Dimensões ideais para a imagem customizada: 800x200
- Formato ideal: PNG

`cor_destaque`: chave que recebe um valor hexadecimal para alteração da cor dos botões e da tarja principal da aplicação.
<br>`cor_fonte1`: chave que recebe um valor hexadecimal para alteração da cor dos labels que são atualizados para o usuário.
<br>`cor_fonte2`: chave que recebe um valor hexadecimal para alteração da cor da fonte dos botões e da tarja.
<br>`cor_fundo`: chave que recebe um valor hexadecimal para alteração da cor de fundo da aplicação.
<br>`cor_selecao`: chave que recebe um valor hexadecimal para alteração da cor da tarja de seleção de opções da operação.

- Caso o valor passado não seja um valor hexadecimal válido a aplicação não sofrerá nenhuma alteração e será usada a cor definida por padrão.

Exemplo de arquivo de configuração com customização:
```json

	{
		"customizacao": {
			"caminho_logo": "Logo Elgin Pay - Azul.png",
			"cor_destaque": "#0093ff",
			"cor_fonte1": "#000000",
			"cor_fonte2": "#ffffff",
			"cor_fundo": "#ffffff",
			"cor_selecao": "#D5D5D5"
		}
		"file_req": "IntPos.001",
		"file_resp": "IntPos.Sts",
    	"log": 0,
    	"path_in": "C:/Cliente/Req",
    	"path_out": "C:/Cliente/Resp",
    	"pix4": 0,
    	"produto_tef": 2,
    	"tag_comprovante": 0
	}
```
