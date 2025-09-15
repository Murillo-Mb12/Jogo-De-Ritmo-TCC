extends Spatial

# Referências a nós importantes
onready var Musica_node = $Musica
onready var Trilha_node = $Trilha
var hud = null  # referência segura para o HUD, localizada no _ready()

# Dados da música e gameplay
var audio
var audio_filei = "res://Beethoven - Für Elise (Piano Version).ogg"

# Parâmetros de tempo e movimento
var tempo
var Barra_length_in_m
var quarter_time_in_sec
var speed
var Nota_scale
var start_pos_in_sec

# Pontuação e combo
var score = 0
var combo = 0

func _ready():
    # Tenta localizar o HUD na cena de forma robusta
    hud = _find_hud_node(self)
    if hud:
        print("HUD encontrado em:", hud.get_path(), " tipo:", hud.get_class())
        if not hud.has_method("update_ui"):
            print("AVISO: HUD encontrado não tem a função 'update_ui'. Verifique o script do HUD.")
    else:
        # Caso não encontre, tenta caminhos padrão
        print("AVISO: HUD não encontrado automaticamente. Tentando caminhos padrão...")
        if has_node("HUDLayer/HUD"):
            hud = get_node("HUDLayer/HUD")
        elif has_node("HUD"):
            hud = get_node("HUD")
        if hud:
            print("HUD encontrado via caminho padrão:", hud.get_path(), " tipo:", hud.get_class())
            if not hud.has_method("update_ui"):
                print("AVISO: HUD via caminho padrão não tem 'update_ui'.")
        else:
            print("AVISO: HUD não foi encontrado. Instancie HUD.tscn corretamente na cena.")

    # Carrega áudio e configura parâmetros do jogo
    audio = load(audio_filei)
    calc_params()
    
    # Configura nós musicais e trilha, passando referência do jogo
    Musica_node.setup(self)
    Trilha_node.setup(self)

    # Atualiza HUD inicial, se possível
    if hud and hud.has_method("update_ui"):
        hud.update_ui(score, combo, "")
    else:
        print("OBS: HUD inválido ou sem função 'update_ui', não atualizou a interface.")

# Calcula parâmetros baseados no tempo da música e tamanho da barra
func calc_params():
    tempo  = 144  # BPM da música
    Barra_length_in_m = 8  # comprimento da barra em metros (m)
    quarter_time_in_sec = 60.0 / float(tempo)  # duração do tempo de semínima (1/4)
    var bar_duration = 4.0 * quarter_time_in_sec  # duração de uma barra (4 tempos)
    speed = Barra_length_in_m / float(bar_duration)  # velocidade do movimento da barra
    Nota_scale = Barra_length_in_m / float(4 * 400)  # escala para notas
    start_pos_in_sec = 0.6  # atraso para começar a música

# Atualiza a pontuação e combo com base no resultado da nota
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

    # Atualiza a HUD se possível
    if hud and hud.has_method("update_ui"):
        hud.update_ui(score, combo, result_type)
    else:
        print("AVISO: não foi possível atualizar HUD (hud nulo ou sem 'update_ui'). score:", score, " combo:", combo)

# ----------------- funções utilitárias -----------------
# Procura recursivamente um nó que tenha a função 'update_ui' (busca pelo HUD)
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
    if event.is_action_pressed("ui_cancel"): # ESC
        if pause_menu.visible:
            pause_menu.close_pause()
        else:
            pause_menu.open_pause()




