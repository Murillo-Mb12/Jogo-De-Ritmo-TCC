extends Spatial

onready var Musica_node = $Musica
onready var Trilha_node = $Trilha
var hud = null

var audio
var audio_filei = "res://Musicas/Beethoven - Für Elise (Piano Version).ogg"

var tempo
var Barra_length_in_m
var quarter_time_in_sec
var speed
var Nota_scale
var start_pos_in_sec

var score = 0
var combo = 0

func _ready():
    # Carrega música da seleção de fase (caso exista)
    if Global.selected_music.path != "":
        audio_filei = Global.selected_music.path
        tempo = Global.selected_music.bpm
    else:
        tempo = 144  # fallback padrão

    hud = _find_hud_node(self)
    if hud == null and has_node("HUDLayer/HUD"):
        hud = get_node("HUDLayer/HUD")

    audio = load(audio_filei)
    calc_params()
    
    Musica_node.setup(self)
    Trilha_node.setup(self)

    if hud and hud.has_method("update_ui"):
        hud.update_ui(score, combo, "")

func calc_params():
    Barra_length_in_m = 8
    quarter_time_in_sec = 60.0 / float(tempo)
    var bar_duration = 4.0 * quarter_time_in_sec
    speed = Barra_length_in_m / float(bar_duration)
    Nota_scale = Barra_length_in_m / float(4 * 400)
    start_pos_in_sec = 0.6

func add_score(result_type):
    match result_type:
        "perfect":
            score += 100
            combo += 1
        "good":
            score += 50
            combo += 1
        "miss":
            combo = 0

    if hud and hud.has_method("update_ui"):
        hud.update_ui(score, combo, result_type)

func _find_hud_node(node):
    if node == null:
        return null
    if node.has_method("update_ui"):
        return node
    for child in node.get_children():
        var found = _find_hud_node(child)
        if found:
            return found
    return null

onready var pause_menu = $PauseMenu

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        if pause_menu.visible:
            pause_menu.close_pause()
        else:
            pause_menu.open_pause()
