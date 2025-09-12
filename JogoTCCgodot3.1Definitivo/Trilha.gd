extends Spatial

var Barra_scn = preload("res://Barra.tscn")
var Barras = []
onready var Barras_node = $BarrasNode

var Barra_length_in_m
var curr_location
var speed_vec
var Nota_scale

# referência ao jogo (passada no setup)
var game = null

func setup(Jogo):
    game = Jogo
    # Trilha usa vector speed para mover Barras_node (z positivo)
    speed_vec = Vector3(0, 0, Jogo.speed)
    Barra_length_in_m = Jogo.Barra_length_in_m
    curr_location = Vector3(0, 0, -Barra_length_in_m)
    Nota_scale = Jogo.Nota_scale
    add_Barras()

func _process(delta):
    # move todas as barras
    Barras_node.translate(speed_vec * delta)
    # checa se alguma barra passou do limite e deve ser removida
    # usamos uma cópia da array para evitar edição durante iteração
    for Barra in Barras.duplicate():
        # condição de remoção similar à sua lógica original
        if Barra.translation.z + Barras_node.translation.z >= Barra_length_in_m:
            remove_Barra(Barra)
            add_Barra()

func add_Barra():
    var Barra = Barra_scn.instance()
    Barra.translation = Vector3(curr_location.x, curr_location.y, curr_location.z)
    Barra.Nota_scale = Nota_scale
    # passa referência ao jogo para a Barra, para que ela passe para as Nota
    Barra.game = game
    Barras.append(Barra)
    Barras_node.add_child(Barra)
    curr_location += Vector3(0, 0, -Barra_length_in_m)

func remove_Barra(Barra):
    Barra.queue_free()
    Barras.erase(Barra)

func add_Barras():
    # instanciar algumas barras iniciais (como você já fazia)
    for i in range(3):
        add_Barra()
