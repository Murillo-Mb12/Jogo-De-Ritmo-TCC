extends Control

onready var play_button = $MarginContainer/VBoxContainer/Play
onready var settings_button = $MarginContainer/VBoxContainer/Settings
onready var profile_button = $MarginContainer/VBoxContainer/Perfil
onready var creditos_button = $MarginContainer/VBoxContainer/Creditos
onready var quit_button = $MarginContainer/VBoxContainer/Sair

func _ready():
    play_button.connect("pressed", self, "_on_play_pressed")
    settings_button.connect("pressed", self, "_on_settings_pressed")
    profile_button.connect("pressed", self, "_on_profile_pressed")
    creditos_button.connect("pressed", self, "_on_creditos_pressed")
    quit_button.connect("pressed", self, "_on_quit_pressed")

# Agora abre o seletor de fases
func _on_play_pressed():
    get_tree().change_scene("res://SeletorFase.tscn")

func _on_settings_pressed():
    get_tree().change_scene("res://Settings.tscn")

func _on_profile_pressed():
    var dialog = AcceptDialog.new()
    add_child(dialog)
    var user = Profiles.get_username()
    var score = Profiles.get_highscore()
    dialog.dialog_text = "Nome: %s\nPontuação Máxima: %d" % [user, score]
    dialog.popup_centered()

func _on_creditos_pressed():
    get_tree().change_scene("res://Creditos.tscn")

func _on_quit_pressed():
    get_tree().quit()
