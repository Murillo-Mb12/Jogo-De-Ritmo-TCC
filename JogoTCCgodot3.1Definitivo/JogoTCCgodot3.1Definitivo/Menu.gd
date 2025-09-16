extends Control

# Referências aos botões do menu
onready var play_button = $MarginContainer/VBoxContainer/Play
onready var settings_button = $MarginContainer/VBoxContainer/Settings
onready var profile_button = $MarginContainer/VBoxContainer/Perfil
onready var quit_button = $MarginContainer/VBoxContainer/Sair

func _ready():
    # Conecta os botões aos métodos correspondentes
    play_button.connect("pressed", self, "_on_play_pressed")
    settings_button.connect("pressed", self, "_on_settings_pressed")
    profile_button.connect("pressed", self, "_on_profile_pressed")
    quit_button.connect("pressed", self, "_on_quit_pressed")

# -------------------------
# FUNÇÕES DOS BOTÕES
# -------------------------

# Inicia o jogo
func _on_play_pressed():
    get_tree().change_scene("res://Jogo.tscn")

# Vai para as configurações
func _on_settings_pressed():
    get_tree().change_scene("res://Settings.tscn")

# Mostra um diálogo com perfil (ainda básico)
func _on_profile_pressed():
    var dialog = AcceptDialog.new()
    add_child(dialog)
    var user = Profiles.get_username()
    var score = Profiles.get_highscore()
    dialog.dialog_text = "Nome: %s\nPontuação Máxima: %d" % [user, score]
    dialog.popup_centered()

# Sai do jogo
func _on_quit_pressed():
    get_tree().quit()
