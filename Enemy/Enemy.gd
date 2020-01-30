extends KinematicBody2D
onready var miner = get_node("../Miner")
var motion = Vector2()
var distance
var state = "idle"
var previous_state
var blocked = false
var movingR = false
var movingL = false

func _ready():
	position.x = ((randi() %449)+192)
func _physics_process(delta):
	motion.y += 10
	motion = move_and_slide(motion,Vector2(0,-1))
	if $"..".player == true:
		distance = (miner.position.x - position.x)
#		if distance < -50 and distance > -3000:
#			motion.x = -20
#			if moving == false:
#				$Movement.play("moving")
#				moving = true
		if distance < -50 and distance > -3000:
			motion.x = -20
			if movingR == false:
				$Movement.play("moving")
				movingR = true
				$Sprite.set_scale(Vector2(0.813,0.813))
				$Sprite2.set_scale(Vector2(0.813,0.813))
				#$Sprite3/SPEAR.set_scale(Vector2(1.211,0.7))
				$Sprite3.set_scale(Vector2(0.813,0.813))
		elif distance > 50 and distance < 3000:
			motion.x = 20
			if movingL == false:
				$Movement.play("moving")
				movingL = true
				$Sprite.set_scale(Vector2(-0.813,0.813))
				$Sprite2.set_scale(Vector2(-0.813,0.813))
				#$Sprite3/SPEAR.set_scale(Vector2(-1.211,0.7))
				$Sprite3.set_scale(Vector2(-0.813,0.813))
		else:
			$Movement.play("idle")
			#moving = false
			if motion.x > 0:
				movingL = false
			if motion.x < 0:
				movingR = false
		if distance > -90 or distance <90:
			state = "attack"
			_change_state(state)
		else:
			state = "idle"
			_change_state(state)
	

func _change_state(state):
	if state != previous_state:
		match state:
			"idle":
				$AnimationPlayer.play("Idle")
			"attack":
				$AnimationPlayer.play("Attack")
		previous_state = state

func _on_Spear_body_entered(body):
	print(body.name)
	if body.is_in_group("Miner"):
		body.damage(-100)
	pass # Replace with function body.
