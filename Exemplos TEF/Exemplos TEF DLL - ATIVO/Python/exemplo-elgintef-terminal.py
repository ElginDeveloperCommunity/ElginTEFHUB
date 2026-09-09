# Exemplo Python Elgin TEF Linux
import json
import inspect
import elgintef

ADM_USUARIO = ''
ADM_SENHA   = ''

###########################################################
####################### TESTES ############################
###########################################################

def teste_api_elgintef():
    elgintef.set_client_tcp('127.0.0.1', 60906)
    elgintef.configurar_dados_pdv('ElginTef Python', 'v1.0.000', 'Elgin', '01', 'T0004')

    # 1) iniciar conexão com client
    start = iniciar()

    retorno = get_retorno(start)
    if retorno == None or retorno != '1':
        finalizar()
        return -1

    # 2) realizar operação 
    sequencial = get_sequencial(start)
    sequencial = incrementar_sequencial(sequencial)

    resp = vender(0, sequencial)     # Pgto --> Perguntar tipo do cartao
    # resp = vender(1, sequencial)   # Pgto --> Cartao de credito
    # resp = vender(2, sequencial)   # Pgto --> Cartao de debito
    # resp = vender(3, sequencial)   # Pgto --> Voucher (debito)
    # resp = vender(4, sequencial)   # Pgto --> Frota (debito)
    # resp = vender(5, sequencial)   # Pgto --> Private label (credito)
    # resp = adm(0, sequencial)      # Adm  --> Perguntar operacao
    # resp = adm(1, sequencial)      # Adm  --> Cancelamento
    # resp = adm(2, sequencial)      # Adm  --> Pendencias
    # resp = adm(3, sequencial)      # Adm  --> Reimpressao
    
    retorno = get_retorno(resp) 
    if retorno == None: # Continuar operação / iniciar o processo de coleta 
        resp = coletar(0, jsonify(resp))# coletar vendas
        # resp = coletar(1, jsonify(resp)) # coletar vendas

        retorno = get_retorno(resp)
        
    # 3) verificar o resultado / confirmar
    if retorno == None:
        print_ter(True, 'ERRO AO COLETAR DADOS', True, False)
    elif retorno == '0':
        print_ter(True, 'TRANSAÇÃO OK, INICIANDO A CONFIRMAÇÃO...', True, False)
        sequencial = get_sequencial(resp)

        # confirma a operação através do sequencial utilizado 
        cnf = confirmar(sequencial)
        retorno = get_retorno(cnf)
        if retorno == None or retorno != '1':
            finalizar()
            return -1
    elif retorno == '1':
        print_ter(True, 'TRANSAÇÃO OK', True, False)
    else:
        print_ter(True, 'ERRO NA TRANSAÇÃO', True, False)

    # 4) finalizar conexão 
    end = finalizar()
    retorno = get_retorno(end)
    if retorno == None or retorno != '1':
        finalizar()
        return -1
    return 0

###########################################################
##### METODOS PARA O CONTROLE DA TRANSAÇÃO (E1_TEF) #######
###########################################################

def iniciar():
    payload = {}

    # payload.Add("aplicacao",         "Meu PDV");
    # payload.Add("aplicacao_tela",    "Meu PDV");
    # payload.Add("versao",            "v0.0.001");
    # payload.Add("estabelecimento",   "Elgin");
    # payload.Add("loja",              "01");
    # payload.Add("terminal",          "T0004");

    # payload.Add("nomeAC",                        "Meu PDV");
    # payload.Add("textoPinpad",                   "Meu PDV");
    # payload.Add("versaoAC",                      "v0.0.001");
    # payload.Add("nomeEstabelecimento",           "Elgin");
    # payload.Add("loja",                          "01");
    # payload.Add("identificadorPontoCaptura",     "T0004");

    start = elgintef.iniciar_operacao_tef(stringify(payload))
    print_tag(str(inspect.stack()[0][3]).upper(), start)
    return start

def vender(cartao:int, sequencial:str):
    print_tag(str(inspect.stack()[0][3]).upper(), 'SEQUENCIAL UTILIZADO NA VENDA: ' + sequencial)
    
    payload = {}
    payload['sequencial'] = sequencial

#    payload["transacao_valor"]  = "10.00";
#    payload["valorTotal"]       = "1000";
    
    pgto = elgintef.realizar_pagamento_tef(cartao, stringify(payload), True)
    print_tag(str(inspect.stack()[0][3]).upper(), pgto)
    return pgto

def adm(opcao:int, sequencial:str):
    print_tag(str(inspect.stack()[0][3]).upper(), 'SEQUENCIAL UTILIZADO NA ADM: ' + sequencial)

    payload = {}
    payload['sequencial'] = sequencial

#    payload["transacao_administracao_usuario"]  = ADM_USUARIO;
#    payload["transacao_administracao_senha"]    = ADM_SENHA;
#    payload["admUsuario"]                       = ADM_USUARIO;
#    payload["admSenha"]                         = ADM_SENHA;
    
    adm = elgintef.realizar_adm_tef(opcao, stringify(payload), True)
    print_tag(str(inspect.stack()[0][3]).upper(), adm)
    return adm

def coletar(operacao:int, root:dict):
    # chaves utilizadas na coleta 
    #    coletaRetorno,      // In/Out; out: 0 = continuar coleta, 9 = cancelar coleta
    #    coletaSequencial,   // In/Out
    #    coletaMensagem,     // In/[Out]
    #    coletaTipo,         // In
    #    coletaOpcao,        // In
    #    coletaInformacao;   // Out
    
    # Extrai os dados da resposta/coleta
    coletaRetorno       = get_string_value_in(root, 'tef', 'automacao_coleta_retorno')
    coletaSequencial    = get_string_value_in(root, 'tef', 'automacao_coleta_sequencial')
    coletaMensagem      = get_string_value_in(root, 'tef', 'mensagemResultado')
    coletaTipo          = get_string_value_in(root, 'tef', 'automacao_coleta_tipo')
    coletaOpcao         = get_string_value_in(root, 'tef', 'automacao_coleta_opcao')

    print_tag(str(inspect.stack()[0][3]).upper(), coletaMensagem.upper())

    # em caso de erro, encerra a coleta 
    if coletaRetorno != '0':
        return stringify(root)

    # em caso de sucesso, monta o novo payload e continua a coleta
    payload = {} 
    payload['automacao_coleta_retorno']     = coletaRetorno
    payload['automacao_coleta_sequencial']  = coletaSequencial

    # coleta dado do usuário, caso necessário
    if coletaTipo != None and coletaOpcao == None: # valor inserido (texto)
        print_ter(False, 'INFORME O VALOR SOLICITADO: ', False, False)
        coletaInformacao = input()
        print_ter(False, '', True, False)
        payload['automacao_coleta_informacao'] = coletaInformacao

    elif coletaTipo != None and coletaOpcao != None: # valor selecionado (lista)
        opcoes = coletaOpcao.split(';')
        for i, opcao in enumerate(opcoes):
            print_ter(False, '[' + str(i) + ']' + opcao.upper() + '\n', False, False)

        print_ter(False, '\nDIGITE A OPÇÃO DESEJADA: ', False, False)
        coletaInformacao = opcoes[int(input())]
        print_ter(False, '', True, False)
        payload['automacao_coleta_informacao'] = coletaInformacao

    # informa dados coletados
    if operacao == 1:
        resp = elgintef.realizar_adm_tef(0, stringify(payload), False)
    else:
        resp = elgintef.realizar_pagamento_tef(0, stringify(payload), False)

    # verificar fim da coleta
    retorno = get_retorno(resp)
    if retorno != None: # fim da coleta 
        return resp

    return coletar(operacao, jsonify(resp))


def confirmar(sequencial):
    print_tag(str(inspect.stack()[0][3]).upper(), 'SEQUENCIAL DA OPERAÇÃO A SER CONFIRMADA: ' + sequencial)

    cnf = elgintef.confirmar_operacao_tef(int(sequencial), 1)
    print_tag(str(inspect.stack()[0][3]).upper(), cnf)
    return cnf

def finalizar():
    end = elgintef.finalizar_operacao_tef(1) # lib resolve o sequencial
    print_tag(str(inspect.stack()[0][3]).upper(), end)
    return end

###########################################################
###### METODOS UTILITARIOS PARA O EXEMPLO PYTHON ##########
###########################################################

def incrementar_sequencial(sequencial):
    try:
        return str(int(sequencial) + 1)
    except:
        return None

def get_retorno(resp):
    # A API retorna o status da operação em `tef.retorno`.
    # `resultadoTransacao` era usado por versões antigas da API; ao consultá-lo
    # em uma resposta atual ele retorna None e o fluxo finaliza logo após iniciar.
    return get_string_value_in(jsonify(resp), 'tef', 'retorno')

def get_sequencial(resp):
    return get_string_value_in(jsonify(resp), 'tef', 'sequencial')

def jsonify(json_string):
    return json.loads(json_string)

def stringify(json_data):
    return json.dumps(json_data, indent=4)

def get_string_value_in(json, key1, key2):
    try:
        value = json[key1][key2] # chave não existente vai pro KeyError
                          # json vazio ('' = str) = TypeError

        if not isinstance(value, str):
            return None # valor da chave não é do tipo string

        return str(value) # retorna valor (pode ser vazio)
    except KeyError:
        return None
    except TypeError:
        return None

def get_string_value(json, key):
    try:
        value = json[key] # chave não existente vai pro KeyError
                          # json vazio ('' = str) = TypeError

        if not isinstance(value, str):
            return None # valor da chave não é do tipo string

        return str(value) # retorna valor (pode ser vazio)
    except KeyError:
        return None
    except TypeError:
        return None

def print_tag(tag : str, msg : str):
    print_ter(True, '', False, False)
    print_ter(False, '[' + tag.upper() + '] ' + msg, False, True)
    print_ter(False, '', True, False)

def print_ter(header:bool, msg:str, footer:bool, compact:bool):
    div = '================================================================'
    if header:
        print(div)

    if compact:
        msg = msg.strip().replace('\n', '')

    print(msg)

    if footer:
        print(div) 

if __name__ == "__main__":
    teste_api_elgintef()
