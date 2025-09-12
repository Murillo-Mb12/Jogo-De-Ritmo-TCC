extends Control

onready var volume_slider = $MarginContainer/VBoxContainer/HBoxContainer/Volume/VolumeSlider
onready var resolution_selector = $MarginContainer/VBoxContainer/HBoxContainer2/Resolucao/ResolutionSelector
onready var back_button = get_node("Back")

func _ready():
    # Conectar sinais (estilo Godot 3.x)
    volume_slider.connect("value_changed", self, "_on_volume_changed")
    resolution_selector.connect("item_selected", self, "_on_resolution_selected")
    back_button.connect("pressed", self, "_on_back_pressed")

    # Configurações iniciais do volume
    volume_slider.min_value = 0
    volume_slider.max_value = 1
    volume_slider.step = 0.01

    # Carregar volume salvo
    load_volume_setting()  # Carregar volume logo no início

    # Opções de resolução (modo janela/tela)
    resolution_selector.add_item("Janela (1280x720)")
    resolution_selector.add_item("Janela (1920x1080)")
    resolution_selector.add_item("Janela (2560x1440)")
    resolution_selector.add_item("Tela Cheia")

# Função chamada quando o volume for alterado
func _on_volume_changed(value):
    update_music_volume(value)
    save_volume_setting(value)  # Salva o volume quando alterado

# Função para atualizar o volume da música
func update_music_volume(value):
    var idx = AudioServer.get_bus_index("Master")  # Bus principal de áudio
    AudioServer.set_bus_volume_db(idx, linear2db(value))  # Converte de linear para decibéis

# Função para salvar o volume no arquivo de configuração
func save_volume_setting(value):
    var config = ConfigFile.new()
    var error = config.load("user://settings.cfg")
    
    # Verifica se o arquivo existe, se não, cria o arquivo
    if error != OK:
        print("Arquivo de configuração não encontrado, criando novo arquivo.")
    
    config.set_value("settings", "volume", value)
    config.save("user://settings.cfg")
    print("Volume salvo:", value)

# Função para carregar o volume quando a cena é iniciada
func load_volume_setting():
    var config = ConfigFile.new()
    var error = config.load("user://settings.cfg")
    
    # Se o arquivo não for encontrado, define o volume para 1 (100%)
    if error == OK:
        var saved_volume = config.get_value("settings", "volume", 1)  # Valor padrão 1 (100%)
        volume_slider.value = saved_volume  # Definindo o valor do slider para o salvo
        update_music_volume(saved_volume)  # Atualiza o volume da música com o valor carregado
        print("Volume carregado:", saved_volume)
    else:
        print("Erro ao carregar o arquivo de configuração! Usando volume padrão.")
        volume_slider.value = 1  # Valor padrão 100%
        update_music_volume(1)

# Função para alterar a resolução
func _on_resolution_selected(index):
    match index:
        0: OS.set_window_size(Vector2(1280, 720))
        1: OS.set_window_size(Vector2(1920, 1080))
        2: OS.set_window_size(Vector2(2560, 1440))
        3: OS.set_window_fullscreen(true)

# Função chamada ao pressionar o botão 'Back'
func _on_back_pressed():
    get_tree().change_scene("res://Menu.tscn")