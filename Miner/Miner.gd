extends KinematicBody2D
var motion = Vector2()
var jumping = false
var state = "idle"
var previous_state 
signal alive
var life = 150
var armor = 0
var beard
var deaths = 0
var speed = 50
var armorr = 0

func _physics_process(delta):
	$"../TextureProgress".value = life
	$"../Label".text = str(life)
	emit_signal("alive")
	if Input.is_action_pressed("MouseL"):
		$Sprite3/Pickaxe/AnimationPlayer.play("Attack")
	#trying to create a block action,but could not finish
	#elif Input.is_action_pressed("MouseR"):
		#$Pickaxe/AnimationPlayer.play("Block")
		#block = true
		
	motion.y += 10
	if Input.is_action_pressed("ui_right"):
		motion.x = speed
		$Sprite.set_scale(Vector2(1,1))
		$Sprite2.set_scale(Vector2(1,1))
		$Sprite3.set_scale(Vector2(1,1))
		_change_anim("moving")
	elif Input.is_action_pressed("ui_left"):
		motion.x = -speed
		$Sprite.set_scale(Vector2(-1,1))
		$Sprite2.set_scale(Vector2(-1,1))
		$Sprite3.set_scale(Vector2(-1,1))
		_change_anim("moving")
	else: 
		motion.x = 0
		_change_anim("idle")
	motion = move_and_slide(motion,Vector2(0,-1))
	if is_on_floor():
		motion.y = 0
		if Input.is_action_pressed("ui_up"):
			motion.y = -200
	if not is_on_floor():
		_change_anim("idle")	
	
func _change_anim(state):
	if state != previous_state:
		match state:
			"idle":
				$AnimationPlayer.play("Idle")
			"moving":
				$AnimationPlayer.play("Movement")
		previous_state = state
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("Enemy"):
		body.queue_free()
		life += 50
	pass # Replace with function body.
func damage(attack):
	if armor != 0:
		armor -= 1
	else:
		armor = armorr
		life += attack
		position.x = 0
		deaths += 1