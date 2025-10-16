extends Control

onready var fase1_button = $MarginContainer/VBoxContainer/Fase1
onready var fase2_button = $MarginContainer/VBoxContainer/Fase2
onready var fase3_button = $MarginContainer/VBoxContainer/Fase3
onready var voltar_button = $MarginContainer/VBoxContainer/Voltar

func _ready():
    fase1_button.connect("pressed", self, "_on_fase1_pressed")
    fase2_button.connect("pressed", self, "_on_fase2_pressed")
    fase3_button.connect("pressed", self, "_on_fase3_pressed")
    voltar_button.connect("pressed", self, "_on_voltar_pressed")

func _on_fase1_pressed():
    Global.selected_music = {
        "path": "res://Musicas/Beethoven - Für Elise (Piano Version).ogg",
        "bpm": 144
    }
    get_tree().change_scene("res://Jogo.tscn")

func _on_fase2_pressed():
    Global.selected_music = {
        "path": "res://Musicas/100.-MEGALOVANIA-_UNDERTALE-Soundtrack_-Toby-Fox.ogg",
        "bpm": 240
    }
    get_tree().change_scene("res://Jogo.tscn")

func _on_fase3_pressed():
    Global.selected_music = {
        "path": "res://Musicas/Minute by Minute.ogg",
        "bpm": 143
    }
    get_tree().change_scene("res://Jogo.tscn")

func _on_voltar_pressed():
    get_tree().change_scene("res://Menu.tscn")
