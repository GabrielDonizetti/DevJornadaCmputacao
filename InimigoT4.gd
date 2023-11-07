extends KinematicBody2D

# Velocidade do inimigo (metade da velocidade do jogador)
var speed = 450
# Ponto de origem e destino para a patrulha
var origem = Vector2(100, 0)
var destino = Vector2(500, 0)

var direcao_atual = 1  # Começa indo para a direita

# XP que o jogador ganha ao matar o inimigo
var xp = 20

# Dano que o inimigo causa ao jogador
var dano = 30

# Tempo de ataque (um ataque a cada 0.4 segundos)
var tataque = 0.1

# Distância de ataque
var dataque = 50

# Facilitador para trabalhar com o Timer
onready var timer = $Timer

# Facilitador para trabalhar com o jogador (obtendo o nó da cena Main)
onready var alvo = get_node("/root/Mundo/Heroi")

# Variável para controlar a direção da patrulha
var direcao = 1

func _ready():
	timer.wait_time = tataque
	timer.start()

func _physics_process(_delta):
	$AnimatedSprite.play("default")
	
	# Calcula a distância entre o inimigo e o jogador
	var dist = position.distance_to(alvo.position)

	# Verifica se o jogador está na distância de perseguição e fora da distância de ataque
	if dist > dataque:
		patrulha()  # Chama a função de patrulha

# Função de patrulha
func patrulha():
	

	# Calcula a direção atual com base na posição do inimigo
	if position.x < 34:
		direcao_atual = 1  # Vai para a direita
	elif position.x > 1324:
		direcao_atual = -1  # Vai para a esquerda

	# Define a direção do movimento com base na direção atual
	var move_dir = Vector2(direcao_atual, 0)

	# Calcula o vetor de direção para o movimento
	var direction = move_dir.normalized()
	direction = move_and_slide(direction * speed)

# Chamado quando o Timer dispara (a cada 0.4 segundos)
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
