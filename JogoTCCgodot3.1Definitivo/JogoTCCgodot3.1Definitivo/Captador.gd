extends Spatial

# Materiais para cada linha
var Marinho = preload("res://Marinho_captador.tres")
var Roxo = preload("res://Roxo_captador.tres")
var Amarelo = preload("res://Amarelo_captador.tres")

export(int, 1,3) var line  # Linha associada ao captador (1, 2 ou 3)

# Estado das teclas
var is_pressed = false 
var is_collecting = false  # controla se está tentando coletar nota

func _ready():
	set_material()  # define o material conforme a linha
	set_process_input(true)  # habilita receber eventos de input

func set_material():
	# Aplica o material correto de acordo com a linha
	match line:
		1:
			$MeshInstance.material_override = Marinho
		2:
			$MeshInstance.material_override= Roxo
		3:
			$MeshInstance.material_override= Amarelo

func _input(event):
	# Detecta pressionar e soltar das teclas para cada linha
	match line:
		1:
			if event.is_action_pressed("ui_left"):
				is_pressed= true 
				is_collecting = true
			elif event.is_action_released("ui_left"):
				is_pressed = false
				is_collecting = false
		2:
			if event.is_action_pressed("ui_down"):
				is_pressed= true 
				is_collecting = true
			elif event.is_action_released("ui_down"):
				is_pressed = false
				is_collecting = false
		3:
			if event.is_action_pressed("ui_right"):
				is_pressed= true 
				is_collecting = true
			elif event.is_action_released("ui_right"):
				is_pressed = false
				is_collecting = false

func _process(delta):
	# Anima o captador quando a tecla está pressionada (diminui um pouco o tamanho)
	if is_pressed:
		self.scale = Vector3(0.9, 0.9, 0.9)
	else:
		self.scale = Vector3(1,1,1)




