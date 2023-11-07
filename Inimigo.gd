extends KinematicBody2D

# Velocidade do inimigo (metade da velocidade do jogador)
var speed = 250

# XP que o jogador ganha ao matar o inimigo
var xp = 20

# Dano que o inimigo causa ao jogador
var dano = 20

# Tempo de ataque (um ataque a cada 0.2 segundos)
var tataque = 0.6

# Distância de ataque
var dataque = 50

# Distância de perseguição
var dpers = 10000

# Facilitador para trabalhar com o Timer
onready var timer = $Timer

# Facilitador para trabalhar com o jogador (obtendo o nó da cena Main)
onready var alvo = get_node("/root/Mundo/Heroi")

func _ready():
	timer.wait_time = tataque
	timer.start()

# Process é chamada a 60 vezes por segundo
func _physics_process(_delta):
	$AnimatedSprite.play("default")
	
	# Calcula a distância entre o inimigo e o jogador
	var dist = position.distance_to(alvo.position)

	# Verifica se o jogador está na distância de perseguição e fora da distância de ataque
	if dist > dataque and dist < dpers :
		# Calcula o vetor de direção para o jogador
		var direction = (alvo.position - position).normalized()
		direction = move_and_slide(direction * speed)

# Chamado quando o Timer dispara (a cada 0.2 segundos)
func _on_Timer_timeout():
	# Verifica se o inimigo está a uma distância de ataque do jogador
	var dist2 = position.distance_to(alvo.position)
	if dist2 <= dataque:
		alvo.toma_dano(dano)

# Chamado quando o inimigo morre
func morre():
	alvo.toma_xp(xp)
	# Exclui este nó e o inimigo desaparece
	queue_free()
