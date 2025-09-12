extends Spatial

var Nota_scn = preload("res://Nota.tscn")

# array de dados das notas (exemplo, troque pelos seus dados reais)
var notes_data = [
    {"pos": 0},
    {"pos": 400},
    {"pos": 800},
    {"pos": 1200},
]

var Nota_scale = 0.0
# referência ao jogo passada por Trilha.gd
var game = null

func _ready():
    add_notes()

func add_notes():
    for Nota_data in notes_data:
        randomize()
        var Nota = Nota_scn.instance()
        Nota.line = (randi() % 3) + 1
        # posição em metros (mesma lógica sua)
        Nota.position = int(Nota_data.pos) * Nota_scale
        # importante: passe a referência 'game' para a Nota
        Nota.game = game
        add_child(Nota)
