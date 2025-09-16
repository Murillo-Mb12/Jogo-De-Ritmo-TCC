extends Control

onready var username_field = $MarginContainer/VBoxContainer/UsernameField
onready var password_field = $MarginContainer/VBoxContainer/PasswordField
onready var message_label = $MarginContainer/VBoxContainer/MessageLabel
onready var login_button = $MarginContainer/VBoxContainer/LoginButton
onready var create_button = $MarginContainer/VBoxContainer/CreateAccountButton

func _ready():
    login_button.connect("pressed", self, "_on_login_pressed")
    create_button.connect("pressed", self, "_on_create_pressed")

func _on_login_pressed():
    var user = username_field.text.strip_edges()
    var password = password_field.text.strip_edges()

    if Profiles.login(user, password):
        message_label.text = "Bem-vindo, %s!" % Profiles.get_username()
        get_tree().change_scene("res://Menu.tscn")
    else:
        message_label.text = "Usuário ou senha incorretos!"

func _on_create_pressed():
    # Agora vai para a cena correta:
    get_tree().change_scene("res://Criacaodeconta.tscn")
