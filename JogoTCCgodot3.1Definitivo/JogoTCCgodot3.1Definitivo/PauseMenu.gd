extends Control

onready var continue_button = $MarginContainer/VBoxContainer/Continue
onready var menu_button = $MarginContainer/VBoxContainer/Menu
onready var exit_button = $MarginContainer/VBoxContainer/Exit

func _ready():
    continue_button.connect("pressed", self, "_on_continue_pressed")
    menu_button.connect("pressed", self, "_on_menu_pressed")
    exit_button.connect("pressed", self, "_on_exit_pressed")

func open_pause():
    visible = true
    get_tree().paused = true

func close_pause():
    visible = false
    get_tree().paused = false

func _on_continue_pressed():
    close_pause()

func _on_menu_pressed():
    get_tree().paused = false
    get_tree().change_scene("res://Menu.tscn")

func _on_exit_pressed():
    get_tree().quit()
