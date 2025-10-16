extends Control

export(float) var splash_duration = 3.0
onready var logo = $TextureRect

func _ready():
    # Começa invisível
    logo.modulate.a = 0.0

    # Cria o Tween por código
    var tween = Tween.new()
    add_child(tween)

    # Anima o aparecimento do logo
    tween.interpolate_property(logo, "modulate:a", 0.0, 1.0, splash_duration, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    tween.start()

    # Espera e muda de cena
    yield(get_tree().create_timer(splash_duration), "timeout")
    _go_to_menu()

func _go_to_menu():
    get_tree().change_scene("res://Login.tscn")
