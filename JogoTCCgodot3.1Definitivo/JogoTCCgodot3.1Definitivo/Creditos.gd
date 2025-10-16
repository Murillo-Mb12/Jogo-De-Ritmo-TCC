extends Control

onready var back_button = $MarginContainer/VBoxContainer/Voltar

func _ready():
    back_button.connect("pressed", self, "_on_voltar_pressed")

func _on_voltar_pressed():
    get_tree().change_scene("res://Menu.tscn")
