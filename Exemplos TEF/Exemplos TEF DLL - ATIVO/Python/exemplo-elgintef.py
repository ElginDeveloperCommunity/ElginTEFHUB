# python3 
# -*- coding: utf-8 -*- 
# --------------------------------------------------------------------------------------------
# Created By  : Gabriel Alves Franzeri
# Author e-mail: gabriel.franzeri@elgin.com.br
# Created Date: 25/08/2022 ..etc
# version ='1.0'
# --------------------------------------------------------------------------------------------
# """Exemplo ElginTef para Linux em Python 3.10"""
# --------------------------------------------------------------------------------------------
# IMPORTANTE
# Executar código utilizando python 64 bits
# --------------------------------------------------------------------------------------------
# imports 

import json
import queue
import asyncio
import inspect
import warnings
import elgintef
import threading
import tkinter.font as tkFont
from tkinter import messagebox
from concurrent.futures import thread
from tkinter import Button, Tk, Label, Frame, Listbox, Entry, Text, StringVar, Scrollbar, VERTICAL, NSEW, NS, EW, W, E, FLAT, SUNKEN, END, RAISED
warnings.filterwarnings("ignore", category=DeprecationWarning) 

# --------------------------------------------------------------------------------------------

LARGE_FONT_STYLE = ('Arial', 12, 'bold') # brandon, musc, montserrat, coco goose
SMALL_FONT_STYLE = ('Arial', 11, 'bold')
BUTTON_FONT_STYLE = ('Arial', 9)
COLOR_BG_FRAME = '#ecf0f1'
COLOR_BG_LABEL = '#ecf0f1'
COLOR_FG_LABEL = '#2c3e50'
COLOR_BG_ENTRY = '#bdc3c7'
COLOR_BG_BUTTON = '#95a5a6'
COLOR_FG_BUTTON = '#2c3e50'

OPERACAO_VENDER = 0 
OPERACAO_ADM = 1

ADM_USUARIO = ''
ADM_SENHA   = ''

# =========================================
# | =========  PÁGINA PRINCIPAL ========= |
# =========================================

class Main:
    # =========================================
    # | ===========  BEGIN LAYOUT =========== |
    # =========================================

    def __init__(self):

        # create root window
        self.root = Tk()
        self.root.title("Pagamento Python")
        w = 300
        h = 250
        sw = self.root.winfo_screenwidth()
        sh = self.root.winfo_screenheight()
        self.root.geometry('%dx%d+%d+%d' % (w, h, (sw - w) / 2, (sh - h) / 2))
        self.root.resizable(width=False, height=False)
        # self.root.resizable(1,1)
        self.root.minsize(300,200)
        self.root.iconbitmap(r'./edc-ico.ico')

        self.root.grid_rowconfigure(0, weight=1)
        self.root.grid_columnconfigure(0, weight=1)

        # create frames
        self.main_frame = self.create_main_frame()

        self.list_box = self.create_list_box()
        self.button = self.create_button()
        self.labels = self.create_main_labels()

    def create_main_frame(self):
        frame = Frame(self.root, bg=COLOR_BG_FRAME, borderwidth=2, border=10)
        frame.grid(column=0, row=0, sticky='', padx=(30, 30), pady=(30, 30))
        frame.columnconfigure(0, weight=1)
        frame.rowconfigure(0, weight=1)
        frame.rowconfigure(1, weight=1)
        frame.rowconfigure(2, weight=2)
        frame.rowconfigure(3, weight=1)
        return frame
    
    def create_main_labels(self):
        titulo = Label(self.main_frame, text='Configuração', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=LARGE_FONT_STYLE)
        titulo.grid(column=0, row=0, sticky=W, pady=(0, 0))   

        titulo_lst = Label(self.main_frame, text='Selecione a operação', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=SMALL_FONT_STYLE)
        titulo_lst.grid(column=0, row=1, sticky=W, pady=(10, 0))

    def create_list_box(self):
        my_scrollbar = Scrollbar(self.main_frame, orient=VERTICAL)

        opcoes = ('Operações Pagamentos', 'Operações Adminstrativo')
        opcoes_var = StringVar(value=opcoes)

        lst_box = Listbox(self.main_frame, listvariable=opcoes_var, justify='center', fg='#333333', borderwidth='1px', font=BUTTON_FONT_STYLE, yscrollcommand=my_scrollbar, height=2)
        lst_box.grid(column=0, row=2, sticky=(NSEW), pady=(5,5))

        my_scrollbar.config(command=lst_box.yview)
        my_scrollbar.grid(column=1, row=2, sticky=NS)
        return lst_box
    
    def create_button(self):
        btn = Button(self.main_frame, text='Carregar Funções', relief=RAISED, bg=COLOR_BG_BUTTON, fg=COLOR_FG_BUTTON, font=SMALL_FONT_STYLE, borderwidth=1, width=17, command=self.get_selection)
        btn.grid(column=0, row=3, columnspan=2, padx=5, pady=5, sticky=NSEW)
        return btn

    # =======================================
    # | ===========  END LAYOUT =========== | 
    # =======================================

    def get_selection(self):
        try:
            v = self.list_box.curselection()[0]
            if v == 0:
                self.root.destroy()
                w = Pagamento()
                w.run()
            else:
                self.root.destroy()
                w = Adm()
                w.run()
        except IndexError:
            messagebox.showinfo('Atenção', 'Selecione uma operação')

    def run(self):
        self.root.mainloop()

# =========================================
# | =========  PÁGINA PAGAMENTO ========= |
# =========================================

class Pagamento:
    # =========================================
    # | ===========  BEGIN LAYOUT =========== |
    # =========================================

    def __init__(self):

        # create root window
        self.root = Tk()
        self.root.protocol("WM_DELETE_WINDOW", self.on_closing)
        self.root.title('Pagamento')
        self.root.resizable(width=False, height=False)
        self.root.minsize(300,200)
        self.root.iconbitmap(r'./edc-ico.ico')

        self.root.grid_rowconfigure(0, weight=1)
        self.root.grid_columnconfigure(0, weight=1)

        # create frames
        self.main_frame = self.create_main_frame()
        self.value_frame = self.create_value_frame()
        self.operator_frame = self.create_operator_frame()
        self.logs_frame = self.create_logs_frame()

        # create widgets
        self.labels = self.create_labels()
        self.buttons = self.create_buttons()
        self.entry = self.create_entry()
        self.logs_text = self.create_logs_text()
        self.lst_box = self.create_list_box()

        # variables for thread safety
        self.queue_thread = queue.Queue()
        self.queue_ui = queue.Queue()

        self.g_cancelar_coleta = ''
        self.g_valor_total = ''

        # disable widgets at start
        self.entry['state'] = 'disabled'
        self.lst_box['state'] = 'disabled'
        self.buttons['ok']['state'] = 'disabled'
        self.buttons['canc']['state'] = 'disabled'

    def create_main_frame(self):
        frame = Frame(self.root, bg=COLOR_BG_FRAME, borderwidth=2, border=10)
        frame.grid(column=0, row=0, sticky=NSEW, padx=(5, 5), pady=(5, 5))
        frame.columnconfigure(0, weight=1)
        frame.columnconfigure(1, weight=1)
        frame.rowconfigure(0, weight=1)
        frame.rowconfigure(1, weight=1)
        return frame

    def create_value_frame(self):
        frame = Frame(self.main_frame, bg=COLOR_BG_FRAME, borderwidth=2)
        frame.grid(column=0, row=0, sticky=NSEW, padx=(1, 1), pady=(1, 1))
        return frame

    def create_operator_frame(self):
        frame = Frame(self.main_frame, bg=COLOR_BG_FRAME, borderwidth=2)
        frame.grid(column=0, row=1, sticky=NSEW, padx=(1, 1), pady=(1, 1))
        frame.rowconfigure(0, weight=1)
        frame.rowconfigure(1, weight=1)
        frame.rowconfigure(2, weight=1)
        frame.rowconfigure(3, weight=1)
        frame.rowconfigure(4, weight=1)
        return frame

    def create_logs_frame(self):
        frame = Frame(self.main_frame, bg=COLOR_BG_FRAME, borderwidth=2)
        frame.grid(column=1, row=0, rowspan=2, sticky=NS, padx=(1, 1), pady=(1, 1))
        return frame
    
    def create_labels(self):
        self.lbl_value_text = StringVar()
        self.lbl_value_text.set('')
        lbl_value = Label(self.value_frame, text='Operação', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=LARGE_FONT_STYLE)
        lbl_value.grid(column=0, row=0, sticky=W, pady=(0, 0))   

        lbl_operator_title = Label(self.operator_frame, text='Processamento Operador', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=LARGE_FONT_STYLE)
        lbl_operator_title.grid(column=0, row=0, columnspan=2, sticky=W, pady=(10, 0))

        lbl_logs = Label(self.logs_frame, text='Logs', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=LARGE_FONT_STYLE)
        lbl_logs.grid(column=0, row=0, sticky=W, pady=(10, 0))

        self.lbl_operator_text = StringVar()
        self.lbl_operator_text.set('Bem Vindo')
        lbl_operator = Label(self.operator_frame, textvariable=self.lbl_operator_text, relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=SMALL_FONT_STYLE)
        lbl_operator.grid(column=0, row=1, columnspan=2, sticky=W, pady=(10, 0))
        return lbl_operator
    
    def create_buttons(self):
        btns = {}
        btns['iniciar_operacao'] = Button(self.value_frame, text='Iniciar Operação', relief=RAISED, bg=COLOR_BG_BUTTON, fg=COLOR_FG_BUTTON, font=SMALL_FONT_STYLE, borderwidth=1, width=17, command=self.btn_iniciar_pagamento)
        btns['iniciar_operacao'].grid(column=0, row=1, columnspan=2, padx=5, pady=5, sticky=NSEW)
        btns['ok'] = Button(self.operator_frame, text='Ok', relief=RAISED, bg=COLOR_BG_BUTTON, fg=COLOR_FG_BUTTON, font=SMALL_FONT_STYLE, borderwidth=1, width=17, command=self.btn_ok_click)
        btns['ok'].grid(column=3, row=4, padx=5, pady=5, sticky=NSEW)
        btns['canc'] = Button(self.operator_frame, text='Cancelar', relief=RAISED, bg=COLOR_BG_BUTTON, fg=COLOR_FG_BUTTON, font=SMALL_FONT_STYLE, borderwidth=1, width=17, command=self.btn_canc_click)
        btns['canc'].grid(column=1, row=4, columnspan=2, padx=5, pady=5, sticky=NSEW)
        return btns

    def create_entry(self):
        self.operator_entry_str = StringVar()
        self.operator_entry_str.set('')
        operator_entry = Entry(self.operator_frame, textvariable=self.operator_entry_str, relief=SUNKEN, bg=COLOR_BG_ENTRY, font=BUTTON_FONT_STYLE, width=33)
        operator_entry.grid(column=0, columnspan=2, row=2, sticky=(W, E), pady=(10, 5))
        return operator_entry

    def create_list_box(self):
        my_scrollbar = Scrollbar(self.operator_frame, orient=VERTICAL)

        opcoes = ('Operações Pagamentos', 'Operações Adminstrativo')
        opcoes_var = StringVar(value=opcoes)

        lst_box = Listbox(self.operator_frame, listvariable=opcoes_var, justify='left', fg='#333333', borderwidth='1px', font=BUTTON_FONT_STYLE, yscrollcommand=my_scrollbar, height=4)
        lst_box.grid(column=0, row=3, columnspan=2, sticky=(NSEW), pady=(5,5))

        my_scrollbar.config(command=lst_box.yview)
        my_scrollbar.grid(column=2, row=3, sticky=NS)
        return lst_box

    def create_logs_text(self):
        self.logs = StringVar()
        logs_entry = Text(self.logs_frame, relief=SUNKEN, bg=COLOR_BG_ENTRY, width=70)
        logs_entry.grid(column=0, row=1, sticky=NS, padx=(10, 0), pady=(10, 20))
        logs_entry.insert(END, '')

        sb_ver = Scrollbar(self.logs_frame, orient=VERTICAL)
        sb_ver.grid(column=1, row=1, sticky=NS, pady=(10, 20))

        logs_entry.config(yscrollcommand=sb_ver.set)
        sb_ver.config(command=logs_entry.yview)
        return logs_entry

    # =======================================
    # | ===========  END LAYOUT =========== | 
    # =======================================

    # =======================================
    # | ========== GUI FUNCTIONS ========== | 
    # =======================================

    def btn_ok_click(self):
        if bool(self.lst_box.winfo_ismapped()):
            try:
                ret_list = self.lst_box.curselection()[0]
                ret_list = str(ret_list)
            except IndexError:
                messagebox.showinfo('Atenção', 'Escolha uma opção')
                return

        if self.lbl_operator_text.get() == '' and bool(self.lbl_operator_text.winfo_ismapped()):
            messagebox.showinfo('Atenção', 'Escolha uma opção')
            return

        ret_entry = self.entry.get()
        self.entry.delete(0, END)
        self.labels.grid_remove()
        self.entry.grid_remove()
        self.buttons['ok'].grid_remove()
        self.buttons['canc'].grid_remove()

        if bool(self.lst_box.winfo_ismapped()):
            self.queue_ui.put(ret_list)    
        else:
            self.queue_ui.put(ret_entry)
        self.lst_box.grid_remove()

    def btn_canc_click(self):
        self.g_cancelar_coleta = '9'
        self.queue_ui.put('9')
    
    def btn_iniciar_pagamento(self):

        # enable widgets at start
        self.entry['state'] = 'normal'
        self.lst_box['state'] = 'normal'
        self.buttons['ok']['state'] = 'normal'
        self.buttons['canc']['state'] = 'normal'

        self.labels.grid()
        self.lbl_operator_text.set('AGUARDE...')

        # if self.lbl_value_text.get() != '':
        #     self.g_valor_total = self.lbl_value_text + '00'
        # self.lbl_value_text.set('')

        self.buttons['iniciar_operacao']['state'] = 'disabled'
        self.thread = AsyncioThread(self.queue_ui, self.queue_thread, OPERACAO_VENDER, self.g_cancelar_coleta, self.g_valor_total)
        self.root.after(200, self.update_gui) 
        self.thread.start()

    def print_ui(self, msg:str):
        self.lst_box.grid_remove()
        self.entry.grid_remove()
        self.buttons['ok'].grid_remove()
        self.buttons['canc'].grid_remove()

        self.lbl_operator_text.set(msg)
        self.labels.grid()
        
        # does not show buttons and entry during processing
        if self.not_in(msg):
            self.entry.grid()
            self.entry.focus()
            self.buttons['ok'].grid()
            self.buttons['canc'].grid()

        # at the end, enable 'iniciar_operação' button
        if 'FINALIZADA' in msg:
            self.buttons['iniciar_operacao']['state'] = 'normal'

    def print_ui_list(self, msg : list):
        self.lst_box.delete(0, END)

        self.entry.grid_remove()
        self.buttons['canc'].grid_remove()
        self.labels.grid()
        self.buttons['ok'].grid()

        self.lst_box.insert(END, *msg)
        self.lst_box.grid()

    def write_logs(self, logs : str, div=True):
        if div:
            logs = '\n=======================================\n' + logs
        self.logs_text.insert(END, logs)
        self.logs_text.yview(END)

    def not_in(self, msg : str):
        strings = ['AGUARDE', 'FINALIZADA', 'PASSAGEM', 'CANCELADA', 'APROVADA']
        for e in strings:
            if e in msg: 
                contem = False
                break
            else: contem = True
        return contem

    def teste(self):
        self.buttons['iniciar_operacao']['state'] = 'disabled'
        self.thread = AsyncioThread(self.queue_ui, self.queue_thread)
        self.root.after(200, self.update_gui) 
        self.thread.start()
    
    def update_gui(self):
        if not self.thread.is_alive() and self.queue_thread.empty():
            print('end of thread')
            return

        while not self.queue_thread.empty():
            ret = self.queue_thread.get()
            if (type(ret) == list):
                self.print_ui_list(ret)
            elif not ret.startswith('write_logs'):
                self.print_ui(ret)
            else:
                # write logs
                ret = ret.split('write_logs')[1]
                self.write_logs(ret)
            
        self.root.after(200, self.update_gui)
     
    # closes the window and starts the main
    def on_closing(self):
        self.root.destroy()
        main = Main()
        main.run()

    # starts the window
    def run(self):
        self.root.mainloop()

class Adm:
    def __init__(self):

        # create root window
        self.root = Tk()
        self.root.protocol("WM_DELETE_WINDOW", self.on_closing)
        self.root.title('Administrativa')
        self.root.resizable(width=False, height=False)
        self.root.minsize(300,200)
        self.root.iconbitmap(r'./edc-ico.ico')

        self.root.grid_rowconfigure(0, weight=1)
        self.root.grid_columnconfigure(0, weight=1)

        # create frames
        self.main_frame = self.create_main_frame()
        self.value_frame = self.create_value_frame()
        self.operator_frame = self.create_operator_frame()
        self.logs_frame = self.create_logs_frame()

        # create widgets
        self.labels = self.create_labels()
        self.buttons = self.create_buttons()
        self.entry = self.create_entry()
        self.logs_text = self.create_logs_text()
        self.lst_box = self.create_list_box()

        # variables for thread safety
        self.queue_thread = queue.Queue()
        self.queue_ui = queue.Queue()

        self.g_cancelar_coleta = ''
        self.g_valor_total = ''

        # disable widgets at start
        self.entry['state'] = 'disabled'
        self.lst_box['state'] = 'disabled'
        self.buttons['ok']['state'] = 'disabled'
        self.buttons['canc']['state'] = 'disabled'

    def create_main_frame(self):
        frame = Frame(self.root, bg=COLOR_BG_FRAME, borderwidth=2, border=10)
        frame.grid(column=0, row=0, sticky=NSEW, padx=(5, 5), pady=(5, 5))
        frame.columnconfigure(0, weight=1)
        frame.columnconfigure(1, weight=1)
        frame.rowconfigure(0, weight=1)
        frame.rowconfigure(1, weight=1)
        return frame

    def create_value_frame(self):
        frame = Frame(self.main_frame, bg=COLOR_BG_FRAME, borderwidth=2)
        frame.grid(column=0, row=0, sticky=NSEW, padx=(1, 1), pady=(1, 1))
        return frame

    def create_operator_frame(self):
        frame = Frame(self.main_frame, bg=COLOR_BG_FRAME, borderwidth=2)
        frame.grid(column=0, row=1, sticky=NSEW, padx=(1, 1), pady=(1, 1))
        frame.rowconfigure(0, weight=1)
        frame.rowconfigure(1, weight=1)
        frame.rowconfigure(2, weight=1)
        frame.rowconfigure(3, weight=1)
        frame.rowconfigure(4, weight=1)
        return frame

    def create_logs_frame(self):
        frame = Frame(self.main_frame, bg=COLOR_BG_FRAME, borderwidth=2)
        frame.grid(column=1, row=0, rowspan=2, sticky=NS, padx=(1, 1), pady=(1, 1))
        return frame
    
    def create_labels(self):
        self.lbl_value_text = StringVar()
        self.lbl_value_text.set('')
        lbl_value = Label(self.value_frame, text='Operação', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=LARGE_FONT_STYLE)
        lbl_value.grid(column=0, row=0, sticky=W, pady=(0, 0))   

        lbl_operator_title = Label(self.operator_frame, text='Processamento Operador', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=LARGE_FONT_STYLE)
        lbl_operator_title.grid(column=0, row=0, columnspan=2, sticky=W, pady=(10, 0))

        lbl_logs = Label(self.logs_frame, text='Logs', relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=LARGE_FONT_STYLE)
        lbl_logs.grid(column=0, row=0, sticky=W, pady=(10, 0))

        self.lbl_operator_text = StringVar()
        self.lbl_operator_text.set('Bem Vindo')
        lbl_operator = Label(self.operator_frame, textvariable=self.lbl_operator_text, relief=FLAT, bg=COLOR_BG_LABEL, fg=COLOR_FG_LABEL, font=SMALL_FONT_STYLE)
        lbl_operator.grid(column=0, row=1, columnspan=2, sticky=W, pady=(10, 0))
        return lbl_operator
    
    def create_buttons(self):
        btns = {}
        btns['iniciar_operacao'] = Button(self.value_frame, text='Iniciar Operação', relief=RAISED, bg=COLOR_BG_BUTTON, fg=COLOR_FG_BUTTON, font=SMALL_FONT_STYLE, borderwidth=1, width=17, command=self.btn_iniciar_pagamento)
        btns['iniciar_operacao'].grid(column=0, row=1, columnspan=2, padx=5, pady=5, sticky=NSEW)
        btns['ok'] = Button(self.operator_frame, text='Ok', relief=RAISED, bg=COLOR_BG_BUTTON, fg=COLOR_FG_BUTTON, font=SMALL_FONT_STYLE, borderwidth=1, width=17, command=self.btn_ok_click)
        btns['ok'].grid(column=3, row=4, padx=5, pady=5, sticky=NSEW)
        btns['canc'] = Button(self.operator_frame, text='Cancelar', relief=RAISED, bg=COLOR_BG_BUTTON, fg=COLOR_FG_BUTTON, font=SMALL_FONT_STYLE, borderwidth=1, width=17, command=self.btn_canc_click)
        btns['canc'].grid(column=1, row=4, columnspan=2, padx=5, pady=5, sticky=NSEW)
        return btns

    def create_entry(self):
        self.operator_entry_str = StringVar()
        self.operator_entry_str.set('')
        operator_entry = Entry(self.operator_frame, textvariable=self.operator_entry_str, relief=SUNKEN, bg=COLOR_BG_ENTRY, font=BUTTON_FONT_STYLE, width=33)
        operator_entry.grid(column=0, columnspan=2, row=2, sticky=(W, E), pady=(10, 5))
        return operator_entry

    def create_list_box(self):
        my_scrollbar = Scrollbar(self.operator_frame, orient=VERTICAL)

        opcoes = ('Operações Pagamentos', 'Operações Adminstrativo')
        opcoes_var = StringVar(value=opcoes)

        lst_box = Listbox(self.operator_frame, listvariable=opcoes_var, justify='left', fg='#333333', borderwidth='1px', font=BUTTON_FONT_STYLE, yscrollcommand=my_scrollbar, height=4)
        lst_box.grid(column=0, row=3, columnspan=2, sticky=(NSEW), pady=(5,5))

        my_scrollbar.config(command=lst_box.yview)
        my_scrollbar.grid(column=2, row=3, sticky=NS)
        return lst_box

    def create_logs_text(self):
        self.logs = StringVar()
        logs_entry = Text(self.logs_frame, relief=SUNKEN, bg=COLOR_BG_ENTRY, width=70)
        logs_entry.grid(column=0, row=1, sticky=NS, padx=(10, 0), pady=(10, 20))
        logs_entry.insert(END, '')

        sb_ver = Scrollbar(self.logs_frame, orient=VERTICAL)
        sb_ver.grid(column=1, row=1, sticky=NS, pady=(10, 20))

        logs_entry.config(yscrollcommand=sb_ver.set)
        sb_ver.config(command=logs_entry.yview)
        return logs_entry

    # =======================================
    # | ===========  END LAYOUT =========== | 
    # =======================================

    # =======================================
    # | ========== GUI FUNCTIONS ========== | 
    # =======================================

    def btn_ok_click(self):
        if bool(self.lst_box.winfo_ismapped()):
            try:
                ret_list = self.lst_box.curselection()[0]
                ret_list = str(ret_list)
            except IndexError:
                messagebox.showinfo('Atenção', 'Escolha uma opção')
                return

        if self.lbl_operator_text.get() == '' and bool(self.lbl_operator_text.winfo_ismapped()):
            messagebox.showinfo('Atenção', 'Escolha uma opção')
            return

        ret_entry = self.entry.get()
        self.entry.delete(0, END)
        self.labels.grid_remove()
        self.entry.grid_remove()
        self.buttons['ok'].grid_remove()
        self.buttons['canc'].grid_remove()

        if bool(self.lst_box.winfo_ismapped()):
            self.queue_ui.put(ret_list)    
        else:
            self.queue_ui.put(ret_entry)
        self.lst_box.grid_remove()

    def btn_canc_click(self):
        self.g_cancelar_coleta = '9'
        self.queue_ui.put('9')
    
    def btn_iniciar_pagamento(self):

        # enable widgets at start
        self.entry['state'] = 'normal'
        self.lst_box['state'] = 'normal'
        self.buttons['ok']['state'] = 'normal'
        self.buttons['canc']['state'] = 'normal'

        self.labels.grid()
        self.lbl_operator_text.set('AGUARDE...')

        # if self.lbl_value_text.get() != '':
        #     self.g_valor_total = self.lbl_value_text + '00'
        # self.lbl_value_text.set('')

        self.buttons['iniciar_operacao']['state'] = 'disabled'
        self.thread = AsyncioThread(self.queue_ui, self.queue_thread, OPERACAO_ADM, self.g_cancelar_coleta, self.g_valor_total)
        self.root.after(200, self.update_gui) 
        self.thread.start()

    def print_ui(self, msg:str):
        self.lst_box.grid_remove()
        self.entry.grid_remove()
        self.buttons['ok'].grid_remove()
        self.buttons['canc'].grid_remove()

        self.lbl_operator_text.set(msg)
        self.labels.grid()
        
        # does not show buttons and entry during processing
        if self.not_in(msg):
            self.entry.grid()
            self.entry.focus()
            self.buttons['ok'].grid()
            self.buttons['canc'].grid()

        # at the end, enable 'iniciar_operação' button
        if 'FINALIZADA' in msg:
            self.buttons['iniciar_operacao']['state'] = 'normal'

    def print_ui_list(self, msg : list):
        self.lst_box.delete(0, END)

        self.entry.grid_remove()
        self.buttons['canc'].grid_remove()
        self.labels.grid()
        self.buttons['ok'].grid()

        self.lst_box.insert(END, *msg)
        self.lst_box.grid()

    def write_logs(self, logs : str, div=True):
        if div:
            logs = '\n=======================================\n' + logs
        self.logs_text.insert(END, logs)
        self.logs_text.yview(END)

    def not_in(self, msg : str):
        strings = ['AGUARDE', 'FINALIZADA', 'PASSAGEM', 'CANCELADA', 'APROVADA']
        for e in strings:
            if e in msg: 
                contem = False
                break
            else: contem = True
        return contem

    def teste(self):
        self.buttons['iniciar_operacao']['state'] = 'disabled'
        self.thread = AsyncioThread(self.queue_ui, self.queue_thread)
        self.root.after(200, self.update_gui) 
        self.thread.start()
    
    def update_gui(self):
        if not self.thread.is_alive() and self.queue_thread.empty():
            print('end of thread')
            return

        while not self.queue_thread.empty():
            ret = self.queue_thread.get()
            if (type(ret) == list):
                self.print_ui_list(ret)
            elif not ret.startswith('write_logs'):
                self.print_ui(ret)
            else:
                # write logs
                ret = ret.split('write_logs')[1]
                self.write_logs(ret)
            
        self.root.after(200, self.update_gui)
     
    def on_closing(self):
        self.root.destroy()
        main = Main()
        main.run()
    
    def run(self):
        self.root.mainloop()

class AsyncioThread(threading.Thread):
    def __init__(self, queue_ui, queue_thread, modo_operacao, cancelar_coleta, valor_total):
        self.asyncio_loop = asyncio.get_event_loop()
        self.queue_ui = queue_ui
        self.queue_thread = queue_thread
        self.modo_operacao = modo_operacao
        self.g_cancelar_coleta = cancelar_coleta
        self.g_valor_total = valor_total
        threading.Thread.__init__(self)

    def run(self):
        # self.asyncio_loop.run_until_complete(self.teste_api_elgintef())
        asyncio.run(self.teste_api_elgintef())

    ###########################################################
    ####################### TESTES ############################
    ###########################################################

    async def teste_api_elgintef(self):
        elgintef.set_client_tcp('127.0.0.1', 60906)
        elgintef.configurar_dados_pdv('ElginTef Python', 'v1.0.000', 'Elgin', '01', 'T0004')

        # 1) iniciar conexão com client
        start = self.iniciar()

        retorno = self.get_retorno(start)
        if retorno == None or retorno != '1':
            self.finalizar()
            return -1

        # 2) realizar operação 
        sequencial = self.get_sequencial(start)
        sequencial = self.incrementar_sequencial(sequencial)

        # resp = self.vender(0, sequencial)     # Pgto --> Perguntar tipo do cartao
        # resp = vender(1, sequencial)   # Pgto --> Cartao de credito
        # resp = vender(2, sequencial)   # Pgto --> Cartao de debito
        # resp = vender(3, sequencial)   # Pgto --> Voucher (debito)
        # resp = vender(4, sequencial)   # Pgto --> Frota (debito)
        # resp = vender(5, sequencial)   # Pgto --> Private label (credito)
        # resp = adm(0, sequencial)      # Adm  --> Perguntar operacao
        # resp = adm(1, sequencial)      # Adm  --> Cancelamento
        # resp = adm(2, sequencial)      # Adm  --> Pendencias
        # resp = adm(3, sequencial)      # Adm  --> Reimpressao

        if self.modo_operacao == 0:
            resp = self.vender(0, sequencial)
        else:
            resp = self.adm(0, sequencial)
        
        retorno = self.get_retorno(resp) 
        if retorno == None: # Continuar operação / iniciar o processo de coleta 
            # 0 - para coletar vender / 1 - para coletar adm
            resp = self.coletar(self.modo_operacao, self.jsonify(resp))# coletar vendas

            retorno = self.get_retorno(resp)
            
        # 3) verificar o resultado / confirmar
        if retorno == None:
            self.print_thread('ERRO AO COLETAR DADOS')
            self.print_thread('write_logsERRO AO COLETAR DADOS')
        elif retorno == '0':

            comprovante_loja = self.get_comprovante(resp, 'loja')
            comprovante_cliente = self.get_comprovante(resp, 'cliente')
            self.print_thread('write_logs' + comprovante_loja)
            self.print_thread('write_logs' + comprovante_cliente)
            self.print_thread('write_logsTRANSAÇÃO OK, INICIANDO A CONFIRMAÇÃO...')
            self.print_thread('TRANSAÇÃO OK, INICIANDO A CONFIRMAÇÃO...')
            sequencial = self.get_sequencial(resp)

            # confirma a operação através do sequencial utilizado 
            cnf = self.confirmar(sequencial)
            retorno = self.get_retorno(cnf)
            if retorno == None or retorno != '1':
                self.finalizar()
                return -1
        elif retorno == '1':
            self.print_thread('write_logsTRANSAÇÃO OK')
            self.print_thread('TRANSAÇÃO OK')
        else:
            # write_logs
            self.print_thread('write_logsERRO NA TRANSAÇÃO')
            self.print_thread('ERRO NA TRANSAÇÃO')

        # 4) finalizar conexão 
        end = self.finalizar()
        retorno = self.get_retorno(end)
        if retorno == None or retorno != '1':
            self.finalizar()
            return -1
        return 0

###########################################################
##### METODOS PARA O CONTROLE DA TRANSAÇÃO (E1_TEF) #######
###########################################################

    def iniciar(self):
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

        start = elgintef.iniciar_operacao_tef(self.stringify(payload))
        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + start)
        return start

    def vender(self, cartao:int, sequencial:str):
        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + ': SEQUENCIAL UTILIZADO NA VENDA: ' + sequencial)
        
        payload = {}
        payload['sequencial'] = sequencial

#    payload["transacao_valor"]  = "10.00";
        if self.g_valor_total != '':
            payload["valorTotal"]       = self.g_valor_total;
        
        pgto = elgintef.realizar_pagamento_tef(cartao, self.stringify(payload), True)
        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + pgto)
        return pgto

    def adm(self, opcao:int, sequencial:str):
        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + ': SEQUENCIAL UTILIZADO NA ADM: ' + sequencial)

        payload = {}
        payload['sequencial'] = sequencial

#    payload["transacao_administracao_usuario"]  = ADM_USUARIO;
#    payload["transacao_administracao_senha"]    = ADM_SENHA;
#    payload["admUsuario"]                       = ADM_USUARIO;
#    payload["admSenha"]                         = ADM_SENHA;
        
        adm = elgintef.realizar_adm_tef(opcao, self.stringify(payload), True)
        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + adm)
        return adm

    def coletar(self, operacao:int, root:dict):
        # chaves utilizadas na coleta 
        #    coletaRetorno,      // In/Out; out: 0 = continuar coleta, 9 = cancelar coleta
        #    coletaSequencial,   // In/Out
        #    coletaMensagem,     // In/[Out]
        #    coletaTipo,         // In
        #    coletaOpcao,        // In
        #    coletaInformacao;   // Out
        
        # Extrai os dados da resposta/coleta
        coletaRetorno       = self.get_string_value_in(root, 'tef', 'automacao_coleta_retorno')
        coletaSequencial    = self.get_string_value_in(root, 'tef', 'automacao_coleta_sequencial')
        coletaMensagem      = self.get_string_value_in(root, 'tef', 'mensagemResultado')
        coletaTipo          = self.get_string_value_in(root, 'tef', 'automacao_coleta_tipo')
        coletaOpcao         = self.get_string_value_in(root, 'tef', 'automacao_coleta_opcao')

        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + ' - ' + coletaMensagem.upper())
        self.print_thread(coletaMensagem.upper())

        # em caso de erro, encerra a coleta 
        if coletaRetorno != '0':
            return self.stringify(root)

        # em caso de sucesso, monta o novo payload e continua a coleta
        payload = {} 
        payload['automacao_coleta_retorno']     = coletaRetorno
        payload['automacao_coleta_sequencial']  = coletaSequencial

        # coleta dado do usuário, caso necessário
        if coletaTipo != None and coletaOpcao == None: # valor inserido (texto)
            self.print_thread('write_logsINFORME O VALOR SOLICITADO: ')
            coletaInformacao = self.read_input()

            if self.g_cancelar_coleta != '':
                payload['automacao_coleta_retorno'] = self.g_cancelar_coleta
                self.g_cancelar_coleta = ''

            payload['automacao_coleta_informacao'] = coletaInformacao

        elif coletaTipo != None and coletaOpcao != None: # valor selecionado (lista)
            elements = []
            opcoes = coletaOpcao.split(';')
            for i, opcao in enumerate(opcoes):
                self.print_thread('write_logs' + '[' + str(i) + '] ' + opcao.upper() + '\n')
                elements.append('[' + str(i) + '] ' + opcao.upper() + '\n') 

            self.print_thread(elements)
            
            self.print_thread('write_logsDIGITE A OPÇÃO DESEJADA: ')
            coletaInformacao = opcoes[int(self.read_input())]
            payload['automacao_coleta_informacao'] = coletaInformacao
            elements.clear()

        # informa dados coletados
        if operacao == 1:
            resp = elgintef.realizar_adm_tef(0, self.stringify(payload), False)
        else:
            resp = elgintef.realizar_pagamento_tef(0, self.stringify(payload), False)

        self.print_thread('write_logs' + resp)
        # verificar fim da coleta
        retorno = self.get_retorno(resp)
        if retorno != None: # fim da coleta 
            return resp

        return self.coletar(operacao, self.jsonify(resp))


    def confirmar(self, sequencial):
        self.print_thread(str(inspect.stack()[0][3]).upper() + ' SEQUENCIAL DA OPERAÇÃO A SER CONFIRMADA: ' + sequencial)
        self.print_thread('AGUARDE, CONFIRMANDO OPERAÇÃO...')

        cnf = elgintef.confirmar_operacao_tef(int(sequencial), 1)
        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + cnf)
        # print('operação finalizada')
        return cnf

    def finalizar(self):
        end = elgintef.finalizar_operacao_tef(1) # lib resolve o sequencial
        self.print_thread('write_logs' + str(inspect.stack()[0][3]).upper() + end)
        self.g_valor_total = ''
        self.print_thread('OPERAÇÃO FINALIZADA')
        return end

    ###########################################################
    ###### METODOS UTILITARIOS PARA O EXEMPLO PYTHON ##########
    ###########################################################

    def incrementar_sequencial(self, sequencial):
        try:
            return str(int(sequencial) + 1)
        except:
            return None

    def get_retorno(self, resp):
        # A API retorna o status da operação em `tef.retorno`.
        # `resultadoTransacao` era usado por versões antigas da API; ao consultá-lo
        # em uma resposta atual ele retorna None e o fluxo finaliza logo após iniciar.
        return self.get_string_value_in(self.jsonify(resp), 'tef', 'retorno')

    def get_sequencial(self, resp):
        return self.get_string_value_in(self.jsonify(resp), 'tef', 'sequencial')

    def get_comprovante(self, resp, via):
        if via == 'loja':
            return self.get_string_value_in(self.jsonify(resp), 'tef', 'comprovanteDiferenciadoLoja')
        elif via == 'cliente':
            return self.get_string_value_in(self.jsonify(resp), 'tef', 'comprovanteDiferenciadoPortador')
        else:
            return ''

    def jsonify(self, json_string):
        return json.loads(json_string)

    def stringify(self, json_data):
        return json.dumps(json_data, indent=4)

    def get_string_value_in(self, json, key1, key2):
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

    def get_string_value(self, json, key):
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

    def print_thread(self, msg):
        self.queue_thread.put(msg)

    def read_input(self):
        # pausa a thread, aguarda pela resposta do usuário na GUI
        while True:
            if not self.queue_ui.empty():
                retorno_ui = self.queue_ui.get()
                break
        return retorno_ui



if __name__ == "__main__":
    app = Main()
    app.run()
