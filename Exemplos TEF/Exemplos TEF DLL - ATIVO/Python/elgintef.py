# Elgin Tef Python 
# Gabriel Franzeri - gabriel.franzeri@elgin.com.br 
# 24/08/2022

import ctypes
import platform

if platform.system() == 'Windows':
    ffi = ctypes.WinDLL('C:/Elgin/TEF/E1_Tef01.dll')
else:
    ffi = ctypes.cdll.LoadLibrary('./libE1_Tef.so.01.01.00')

def get_produto_tef():
    fn = ffi.GetProdutoTef
    fn.restype = ctypes.c_int
    fn.argtypes = []

    return int(fn())

def get_client_tcp():
    fn = ffi.GetClientTCP 
    fn.restype = ctypes.c_char_p
    fn.argtypes = []

    return fn().decode('utf-8')

def set_client_tcp(ip, porta):
    fn = ffi.SetClientTCP 
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_char_p, ctypes.c_int]

    ip = ctypes.c_char_p(bytes(ip, 'utf-8'))
    porta = ctypes.c_int(porta)

    return fn(ip, porta).decode('utf-8')

def configurar_dados_pdv(texto_pinpad, versao_ac, nome_estabelecimento, loja, identificador_ponto_captura):
    fn = ffi.ConfigurarDadosPDV 
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p, ctypes.c_char_p]

    texto_pinpad = ctypes.c_char_p(bytes(texto_pinpad, 'utf-8'))
    versao_ac = ctypes.c_char_p(bytes(versao_ac, 'utf-8'))
    nome_estabelecimento = ctypes.c_char_p(bytes(nome_estabelecimento, 'utf-8'))
    loja = ctypes.c_char_p(bytes(loja, 'utf-8'))
    identificador_ponto_captura = ctypes.c_char_p(bytes(identificador_ponto_captura, 'utf-8'))

    return fn(texto_pinpad, versao_ac, nome_estabelecimento, loja, identificador_ponto_captura).decode('utf-8')

def iniciar_operacao_tef(dados_captura):
    fn = ffi.IniciarOperacaoTEF
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_char_p]
    
    dados_captura = ctypes.c_char_p(bytes(dados_captura, 'utf-8'))

    return fn(dados_captura).decode('utf-8')

def recuperar_operacao_tef(dados_captura):
    fn = ffi.RecuperarOperacaoTEF
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_char_p]

    dados_captura = ctypes.c_char_p(bytes(dados_captura, 'utf-8'))

    return fn(dados_captura).decode('utf-8')

def realizar_pagamento_tef(codigo_operacao, dados_captura, nova_transacao):
    fn = ffi.RealizarPagamentoTEF
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_bool]

    codigo_operacao = ctypes.c_int(codigo_operacao)
    dados_captura = ctypes.c_char_p(bytes(dados_captura, 'utf-8'))
    nova_transacao = ctypes.c_bool(nova_transacao)

    return fn(codigo_operacao, dados_captura, nova_transacao).decode('utf-8')

def realizar_adm_tef(codigo_operacao, dados_captura, nova_transacao):
    fn = ffi.RealizarAdmTEF
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_int, ctypes.c_char_p, ctypes.c_bool]

    codigo_operacao = ctypes.c_int(codigo_operacao)
    dados_captura = ctypes.c_char_p(bytes(dados_captura, 'utf-8'))
    nova_transacao = ctypes.c_bool(nova_transacao)

    return fn(codigo_operacao, dados_captura, nova_transacao).decode('utf-8')

def confirmar_operacao_tef(id, acao):
    fn = ffi.ConfirmarOperacaoTEF
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_int, ctypes.c_int]

    id = ctypes.c_int(id)
    acao = ctypes.c_int(acao)

    return fn(id, acao).decode('utf-8')

def finalizar_operacao_tef(id):
    fn = ffi.FinalizarOperacaoTEF
    fn.restype = ctypes.c_char_p
    fn.argtypes = [ctypes.c_int]

    id = ctypes.c_int(id)

    return fn(id).decode('utf-8')
