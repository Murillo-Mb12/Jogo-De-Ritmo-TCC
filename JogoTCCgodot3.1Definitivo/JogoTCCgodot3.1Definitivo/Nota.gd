extends Spatial

# Materiais usados para cada linha
var Marinho = preload("res://Marinho.tres")
var Roxo = preload("res://Roxo.tres")
var Amarelo = preload("res://Amarelo.tres")

# Linha da nota (1, 2 ou 3) — pode ser definido no editor
export(int, 1, 3) var line = 1

# Posição no tempo (usada para posicionar a nota)
var position = 0

# Estado da nota
var is_colliding = false
var collected = false
var Captador = null  # Referência ao captador (área de colisão)

# Referência ao jogo (setada pela barra que cria a nota)
var game = null

# Janelas de tempo para avaliação do acerto (em segundos)
const PERFECT_WINDOW = 0.05
const GOOD_WINDOW = 0.15

func _ready():
    set_material()  # Define a cor da nota com base na linha
    set_position()  # Define a posição inicial da nota

func _process(delta):
    if collected:
        return  # Não faz nada se já foi coletada

    check_collected()  # Verifica se o jogador acertou a nota

    # Se a nota passou do captador e não foi coletada, conta como "miss"
    var captador_z = 0.0
    if Captador:
        captador_z = Captador.global_transform.origin.z
    if global_transform.origin.z > (captador_z + 1.0) and not collected:
        collected = true
        if game:
            game.add_score("miss")
        hide()

# Define o material da nota conforme a linha
func set_material():
    match line:
        1:
            $MeshInstance.material_override = Marinho
        2:
            $MeshInstance.material_override = Roxo
        3:
            $MeshInstance.material_override = Amarelo

# Define a posição inicial da nota (x pela linha, z pela posição no tempo)
func set_position():
    var x = 0
    match line:
        1: x = -1
        2: x = 0
        3: x = 1
    translation = Vector3(x, 0, -position)

# Verifica se a nota está sendo coletada no momento certo
func check_collected():
    if collected or not is_colliding or Captador == null or not Captador.is_collecting:
        return

    # Calcula distância entre a nota e o captador (no eixo Z)
    var note_z = global_transform.origin.z
    var capt_z = Captador.global_transform.origin.z
    var dist = abs(note_z - capt_z)

    # Converte distância em diferença de tempo (em segundos)
    var speed_m_s = 1.0
    if game != null and game.speed != 0:
        speed_m_s = game.speed

    var time_diff = dist / speed_m_s  # tempo de diferença em segundos

    # Define o resultado baseado na janela de acerto
    var result = "miss"
    if time_diff <= PERFECT_WINDOW:
        result = "perfect"
    elif time_diff <= GOOD_WINDOW:
        result = "good"
    else:
        result = "miss"

    # Informa o jogo do resultado
    if game:
        game.add_score(result)

    collected = true
    Captador.is_collecting = false  # Impede múltiplas coletas
    hide()  # Esconde a nota

# Detecta quando entra na área do captador
func _on_area_entered(area):
    if area.is_in_group("Captador"):
        is_colliding = true
        Captador = area.get_parent()  # Pega o nó pai do Area (Captador)

# Detecta quando sai da área do captador
func _on_area_exited(area):
    if area.is_in_group("Captador"):
        is_colliding = false
