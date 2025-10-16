extends Control

# Referências para os elementos da interface (labels e timer)
onready var score_label = $ScoreLabel
onready var combo_label = $ComboLabel
onready var feedback_label = $FeedbackLabel
onready var feedback_timer = $FeedbackTimer

func _ready():
    # Inicializa os textos da HUD
    score_label.text = "Score: 0"
    combo_label.text = "Combo: 0"
    feedback_label.text = ""
    feedback_label.visible = false  # esconde o feedback no início

# Função chamada pelo Jogo.gd para atualizar a interface
func update_ui(score, combo, feedback):
    # Atualiza o texto do score e do combo
    score_label.text = "Score: " + str(score)
    combo_label.text = "Combo: " + str(combo)

    # Se houver feedback (ex: "perfect", "miss"), mostra por tempo limitado
    if feedback != "" and feedback != null:
        feedback_label.text = feedback.capitalize()  # capitaliza (ex: "Perfect")
        feedback_label.visible = true
        feedback_timer.start()  # inicia o timer para esconder depois
    else:
        feedback_label.visible = false

# Função chamada automaticamente quando o timer termina
func _on_FeedbackTimer_timeout():
    feedback_label.visible = false  # esconde o feedback
