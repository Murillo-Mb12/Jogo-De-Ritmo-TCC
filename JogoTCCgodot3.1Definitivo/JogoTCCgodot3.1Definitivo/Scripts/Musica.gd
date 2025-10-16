extends Spatial

# Referência ao nó de áudio
onready var player = $AudioStreamPlayer

# Variáveis de controle
var speed
var started
var pre_start_duration  # tempo antes da música começar (usado para sincronizar)
var start_pos_in_sec    # posição inicial da música (offset em segundos)

func _ready():
	pass  # nada a fazer aqui por enquanto

# Inicializa os dados recebidos do jogo
func setup(game):
	player.stream = game.audio  # define a música que vai tocar

	speed = game.speed
	started = false
	pre_start_duration = game.Barra_length_in_m  # tempo para sincronizar com as barras
	start_pos_in_sec = game.start_pos_in_sec     # atraso inicial da música

# Inicia a reprodução da música
func start():
	started = true
	player.play(start_pos_in_sec)

# Verifica se é hora de iniciar a música
func _process(delta):
	if not started:
		pre_start_duration -= speed * delta  # simula o "avanço" da trilha
		if pre_start_duration <= 0:
			start()  # começa a tocar quando o tempo de espera acaba
			return
