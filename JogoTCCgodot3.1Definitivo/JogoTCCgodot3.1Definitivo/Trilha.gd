extends Spatial

# Pré-carrega a cena da Barra (nota visual do jogo)
var Barra_scn = preload("res://Barra.tscn")

# Lista de barras ativas na trilha
var Barras = []

# Nó que vai conter as barras na cena
onready var Barras_node = $BarrasNode

# Variáveis de configuração
var Barra_length_in_m        # Comprimento de uma barra
var curr_location            # Posição atual onde a próxima barra será criada
var speed_vec                # Velocidade das barras (movimento)
var Nota_scale               # Escala para posicionar notas

# Referência para o nó principal do jogo
var game = null

# Função chamada pelo Jogo.gd para inicializar
func setup(Jogo):
    game = Jogo
    speed_vec = Vector3(0, 0, Jogo.speed)       # Define a velocidade no eixo Z
    Barra_length_in_m = Jogo.Barra_length_in_m  # Comprimento de cada barra
    curr_location = Vector3(0, 0, -Barra_length_in_m)  # Posição inicial para a 1ª barra
    Nota_scale = Jogo.Nota_scale                # Escala usada nas notas
    add_Barras()                                # Adiciona as barras iniciais

# Função chamada a cada frame
func _process(delta):
    # Move todas as barras juntas
    Barras_node.translate(speed_vec * delta)

    # Verifica se alguma barra passou do limite visível
    for Barra in Barras.duplicate():
        if Barra.translation.z + Barras_node.translation.z >= Barra_length_in_m:
            remove_Barra(Barra)  # Remove a barra da cena
            add_Barra()          # Adiciona uma nova no fim da trilha

# Cria uma nova barra e adiciona à cena
func add_Barra():
    var Barra = Barra_scn.instance()
    Barra.translation = Vector3(curr_location.x, curr_location.y, curr_location.z)
    Barra.Nota_scale = Nota_scale   # Passa a escala para a barra
    Barra.game = game               # Passa referência do jogo (necessária para as notas)
    Barras.append(Barra)
    Barras_node.add_child(Barra)
    curr_location += Vector3(0, 0, -Barra_length_in_m)  # Atualiza posição da próxima barra

# Remove a barra da cena e da lista
func remove_Barra(Barra):
    Barra.queue_free()
    Barras.erase(Barra)

# Adiciona barras iniciais (ex: para preencher a tela no começo)
func add_Barras():
    for i in range(3):
        add_Barra()

