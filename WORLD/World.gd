extends Node2D
var spawns
var enemy = preload("res://Enemy/Enemy.tscn")
var armor = preload("res://Miner/ARMOR.tscn")
var beard = preload("res://Miner/BEARD.tscn")
onready var miner = get_node("Miner")
var player
var waving = true
func _ready():
	$start.start()

func _on_Miner_alive():
	player = true
	if miner.life <= 0:
		get_tree().change_scene("res://WORLD/Game Over.tscn")
	pass # Replace with function body.


func _on_ARMOR_pressed():
	if miner.life >= 300:
		miner.armorr += 2
		miner.life += -300
		miner.armor = 2
		$Shop/VBoxContainer/ARMOR.queue_free()
		var armorInstanced = armor.instance()
		get_node("Miner/Sprite3").add_child(armorInstanced)
	pass # Replace with function body.


func _on_BEARD_pressed():
	if miner.life >= 1000:
		miner.life += -1000
		$Shop/VBoxContainer/BEARD.queue_free()
		$Miner.speed = 150
		var beardInstanced = beard.instance()
		get_node("Miner/Sprite3").add_child(beardInstanced)
	pass # Replace with function body.


func _on_PICKAXE_pressed():
	if miner.life >= 2000:
		miner.life += -2000
	$Shop/VBoxContainer/PICKAXE.queue_free()
	$Miner/Sprite3/Pickaxe.scale = Vector2(2,3.7)
	pass # Replace with function body.



func _on_spawntimer_timeout():
	if waving == true:
		$spawntimer.start()
		spawns = randi()%449
		var eneS = enemy.instance()
		add_child(eneS)

func _on_level1timer_timeout():
	waving = false
	$Shop.show()
	$shoptimer.start()
	pass # Replace with function body.

func _on_shoptimer_timeout():
	waving = true
	$Shop.hide()
	$level2timer.start()
	pass # Replace with function body.


func _on_level2timer_timeout():
	waving = false
	$Shop.show()
	$Shop/VBoxContainer/ARMOR2.show()
	$shoptimer2.start()
	
	
	pass # Replace with function body.


func _on_shoptimer2_timeout():
	$Shop.hide()
	$level3timer.start()
	waving = true
	pass # Replace with function body.


func _on_level3timer_timeout():
	waving = false
	$Label2.show()
	var endgame_text =("CONGRATULATIONS \nYou died " + str($"Miner".deaths) + "times \nYou finished with " + str($Miner.life) + "life points")
	$Label2.text = endgame_text
	pass # Replace with function body.


func _on_start_timeout():
	$spawntimer.start()
	$level1timer.start()
	$HELP.queue_free()

func _on_ARMOR2_pressed():
	if miner.life >= 700:
		miner.armorr += 2
		miner.armor = 4
		miner.life += -700
		$Shop/VBoxContainer/ARMOR2.queue_free()
	pass # Replace with function body.