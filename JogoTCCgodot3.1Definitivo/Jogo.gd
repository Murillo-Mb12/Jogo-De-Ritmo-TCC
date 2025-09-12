extends Spatial

onready var Musica_node = $Musica
onready var Trilha_node = $Trilha
var hud = null  # vamos localizar com segurança em _ready()

var audio
var audio_filei = "res://Beethoven - Für Elise (Piano Version).ogg"

var tempo
var Barra_length_in_m
var quarter_time_in_sec
var speed
var Nota_scale
var start_pos_in_sec

# score / combo
var score = 0
var combo = 0

func _ready():
    # ---------- localizar HUD de forma robusta ----------
    hud = _find_hud_node(self)  # procura dentro da cena Jogo
    if hud:
        print("HUD encontrado em:", hud.get_path(), " tipo:", hud.get_class())
        if not hud.has_method("update_ui"):
            print("AVISO: o nó encontrado NÃO possui 'update_ui'. Verifique se o script HUD.gd está anexado e define essa função.")
    else:
        print("AVISO: HUD não encontrado automaticamente. Tentando caminhos padrão...")
        if has_node("HUDLayer/HUD"):
            hud = get_node("HUDLayer/HUD")
        elif has_node("HUD"):
            hud = get_node("HUD")
        if hud:
            print("HUD encontrado via caminho padrão:", hud.get_path(), " tipo:", hud.get_class())
            if not hud.has_method("update_ui"):
                print("AVISO: nó via caminho padrão não tem 'update_ui'.")
        else:
            print("AVISO: HUD não foi encontrado. Você precisa instanciar HUD.tscn como HUDLayer/HUD ou HUD como filho do Jogo.")

    # ---------- restante da inicialização ----------
    audio = load(audio_filei)
    calc_params()
    Musica_node.setup(self)
    Trilha_node.setup(self)

    # atualiza HUD inicial, somente se o método existir
    if hud and hud.has_method("update_ui"):
        hud.update_ui(score, combo, "")
    else:
        print("OBS: update_ui não foi chamada porque HUD inválido ou não tem a função.")

func calc_params():
    tempo  = 144
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

    # chamamos update_ui somente se o hud existir e tiver o método
    if hud and hud.has_method("update_ui"):
        hud.update_ui(score, combo, result_type)
    else:
        print("AVISO: não foi possível atualizar HUD (hud nulo ou sem update_ui). score:", score, " combo:", combo)

# ----------------- funções utilitárias -----------------
# procura recursivamente um nó que declare a função 'update_ui'
func _find_hud_node(node):
    if node == null:
        return null
    # verificamos se o nó atual tem a função
    if node.has_method("update_ui"):
        return node
    # caso contrário, procura nos filhos recursivamente
    for child in node.get_children():
        var found = _find_hud_node(child)
        if found:
            return found
    return null


