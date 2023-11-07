extends KinematicBody2D

# Variáveis globais
var movimento = Vector2()
var vidas = 200


# Velocidade máxima do personagem
const MAX_SPEED = 300

func _physics_process(_delta):
	# Controle de movimento do personagem
	controle_de_movimento()
	$Label.text = "VIDA " + str(vidas)


func controle_de_movimento():
	movimento = Vector2(0, 0)  # Zera o movimento
	if position.y < -20:
		position.y = 779
	if position.x < -20:
		position.x = 1378
	if position.x > 1378:
		position.x = -20
	if position.y > 779:
		position.y = -20
	if Input.is_action_pressed("ui_right"):
		movimento.x = MAX_SPEED
		movimento = limitar_velocidade_horizontal(movimento)
		$AnimatedSprite.play("caminhar")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		
		movimento.x = -MAX_SPEED
		movimento = limitar_velocidade_horizontal(movimento)
		$AnimatedSprite.play("caminhar")
		$AnimatedSprite.flip_h = true
	elif Input.is_action_pressed("ui_up"):
		movimento.y = -MAX_SPEED
		$AnimatedSprite.play("descendo")
		$AnimatedSprite.flip_v = false
	elif Input.is_action_pressed("ui_down"):
		movimento.y = MAX_SPEED
		$AnimatedSprite.play("descendo")
		$AnimatedSprite.flip_v = true
	else:
		$AnimatedSprite.play("parado")
	movimento = move_and_slide(movimento)

func limitar_velocidade_horizontal(velocidade):
	# Limita a velocidade horizontal para MAX_SPEED
	velocidade.x = clamp(velocidade.x, -MAX_SPEED, MAX_SPEED)
	return velocidade

# Função para receber dano
func toma_dano(dano):
	if vidas > 0:
		vidas -= dano
		print("Vidas: ", vidas)
	elif vidas < 1:
		morre()

# Função para lidar com a morte do personagem
func morre():
	# Realiza ações relacionadas à morte do personagem, como reiniciar a cena
	queue_free()  # Libera o nó atual
	get_tree().reload_current_scene()  # Reinicia a cena
