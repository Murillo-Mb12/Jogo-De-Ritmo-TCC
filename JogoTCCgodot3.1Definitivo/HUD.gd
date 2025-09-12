extends Control

onready var score_label = $ScoreLabel
onready var combo_label = $ComboLabel
onready var feedback_label = $FeedbackLabel
onready var feedback_timer = $FeedbackTimer

func _ready():
    score_label.text = "Score: 0"
    combo_label.text = "Combo: 0"
    feedback_label.text = ""
    feedback_label.visible = false

# chamada pelo Jogo.gd
func update_ui(score, combo, feedback):
    # converte ints para texto
    score_label.text = "Score: " + str(score)
    combo_label.text = "Combo: " + str(combo)

    if feedback != "" and feedback != null:
        feedback_label.text = feedback.capitalize()
        feedback_label.visible = true
        feedback_timer.start()
    else:
        feedback_label.visible = false

# conectar o signal timeout do Timer para esconder feedback
func _on_FeedbackTimer_timeout():
    feedback_label.visible = false
