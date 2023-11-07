extends Node

var pontuacao = 0
func _physics_process(_delta):
	$Label.text = "SCORE " + str(pontuacao)
	pontuacao += 1

