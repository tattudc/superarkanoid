extends Control
@onready var label_points = $LabelPoints
@onready var label_record = $LabelRecord
@onready var label_lives = $LabelLives

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	label_points.text = 'Pontos: ' + str(GameManage.pontos)
	label_record.text = 'Recorde: ' + str(GameManage.record)
	label_lives.text = 'Vidas: ' + str(GameManage.lives)
