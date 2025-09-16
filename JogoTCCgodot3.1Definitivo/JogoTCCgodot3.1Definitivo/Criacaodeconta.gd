extends Control

onready var username_field = $MarginContainer/VBoxContainer/UsernameField
onready var password_field = $MarginContainer/VBoxContainer/PasswordField
onready var confirm_field = $MarginContainer/VBoxContainer/ConfirmField
onready var message_label = $MarginContainer/VBoxContainer/MessageLabel
onready var create_button = $MarginContainer/VBoxContainer/CreateButton
onready var back_button = $MarginContainer/VBoxContainer/BackButton

func _ready():
    create_button.connect("pressed", self, "_on_create_pressed")
    back_button.connect("pressed", self, "_on_back_pressed")

func _on_create_pressed():
    var user = username_field.text.strip_edges()
    var password = password_field.text.strip_edges()   # ✅ trocado aqui
    var confirm = confirm_field.text.strip_edges()

    if user == "" or password == "":
        message_label.text = "Preencha todos os campos!"
        return

    if password != confirm:
        message_label.text = "As senhas não coincidem!"
        return

    if Profiles.criacao_de_conta(user, password):   # ✅ e aqui
        message_label.text = "Conta criada com sucesso!"
        get_tree().change_scene("res://Login.tscn")
    else:
        message_label.text = "Usuário já existe!"

func _on_back_pressed():
    get_tree().change_scene("res://Login.tscn")
