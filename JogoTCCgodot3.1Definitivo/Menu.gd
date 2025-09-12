extends Control

# Referências corretas aos nós da árvore
onready var play_button = $MarginContainer/VBoxContainer/Play
onready var settings_button = $MarginContainer/VBoxContainer/Settings
onready var profile_button = $MarginContainer/VBoxContainer/Perfil
onready var quit_button = $MarginContainer/VBoxContainer/Sair

func _ready():
    # Conectar sinais
    play_button.connect("pressed", self, "_on_play_pressed")
    settings_button.connect("pressed", self, "_on_settings_pressed")
    profile_button.connect("pressed", self, "_on_profile_pressed")
    quit_button.connect("pressed", self, "_on_quit_pressed")

# -------------------------
# FUNÇÕES DOS BOTÕES
# -------------------------

func _on_play_pressed():
    get_tree().change_scene("res://Jogo.tscn")

func _on_settings_pressed():
    # Troca de cena para as configurações
    get_tree().change_scene("res://Settings.tscn")

func _on_profile_pressed():
    # Exemplo de diálogo temporário (até você implementar o sistema de login/perfil)
    var dialog = AcceptDialog.new()
    add_child(dialog)
    dialog.dialog_text = "Nome: Jogador\nPontuação Máxima: 0"
    dialog.popup_centered()

func _on_quit_pressed():
    get_tree().quit()


