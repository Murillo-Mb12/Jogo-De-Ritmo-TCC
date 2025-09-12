extends Spatial

var Marinho = preload("res://Marinho.tres")
var Roxo = preload("res://Roxo.tres")
var Amarelo = preload("res://Amarelo.tres")

export(int, 1, 3) var line = 1
var position = 0
var is_colliding = false
var collected = false
var Captador = null

# referêcia que deve ser setada pela Barra (Barra.gd)
var game = null

# janelas (em segundos) - ajuste para tunar a dificuldade
const PERFECT_WINDOW = 0.05
const GOOD_WINDOW = 0.15

func _ready():
    set_material()
    set_position()

func _process(delta):
    if collected:
        return
    check_collected()
    # checa se passou do captador (miss) - ajuste o 1.0 conforme sua cena
    var captador_z = 0.0
    if Captador:
        captador_z = Captador.global_transform.origin.z
    if global_transform.origin.z > (captador_z + 1.0) and not collected:
        collected = true
        if game:
            game.add_score("miss")
        hide()

func set_material():
    match line:
        1:
            $MeshInstance.material_override = Marinho
        2:
            $MeshInstance.material_override = Roxo
        3:
            $MeshInstance.material_override = Amarelo

func set_position():
    var x = 0
    match line:
        1: x = -1
        2: x = 0
        3: x = 1
    translation = Vector3(x, 0, -position)

func check_collected():
    if collected:
        return
    if not is_colliding:
        return
    if Captador == null:
        return
    if not Captador.is_collecting:
        return

    # se chegou aqui, o jogador está pressionando enquanto a nota está na área
    # usamos posições globais em Z para calcular distância e converter em "tempo restante"
    var note_z = global_transform.origin.z
    var capt_z = Captador.global_transform.origin.z
    var dist = abs(note_z - capt_z)

    # pega speed (m/s) do game — assumimos que game foi passado e tem a variável speed
    var speed_m_s = 1.0
    if game != null:
        # se por acaso speed for zero, evita divisão por zero
        if game.speed != 0:
            speed_m_s = game.speed
        else:
            speed_m_s = 1.0

    var time_diff = dist / speed_m_s

    var result = "miss"
    if time_diff <= PERFECT_WINDOW:
        result = "perfect"
    elif time_diff <= GOOD_WINDOW:
        result = "good"
    else:
        result = "miss"

    # debug opcional:
    # print("Nota coletada: ", result, " dist=", dist, " time_diff=", time_diff, " speed=", speed_m_s)

    if game:
        game.add_score(result)

    collected = true
    Captador.is_collecting = false
    hide()

# sinais do Area — conecte os sinais do seu nó Area para esses métodos no editor
func _on_area_entered(area):
    if area.is_in_group("Captador"):
        is_colliding = true
        Captador = area.get_parent()

func _on_area_exited(area):
    if area.is_in_group("Captador"):
        is_colliding = false
