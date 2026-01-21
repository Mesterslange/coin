extends Node2D

@export var coin_scene: PackedScene
@export var respawn_time := 1.0
@export var respawn_randomly := true
@export var area_size := Vector2(500, 300)
var score = 0
#@export var game_manager: Node  # træk GameManager ind i Inspector


func _ready():
	#print(game_manager)
	# Start med at spawne 10 mønter
	for i in range(10):
		spawn_coin()

func spawn_coin():
	var coin = coin_scene.instantiate()
	#coin.game_manager = game_manager  # <--- sæt reference
	add_child(coin)
	
	if respawn_randomly:
		# Spawn inden for area_size centreret omkring CoinManager
		var x = randf_range(-area_size.x/2, area_size.x/2)
		var y = randf_range(-area_size.y/2, area_size.y/2)
		coin.position = Vector2(x, y)
	else:
		# Kan vælge en fast position, fx midt
		coin.position = Vector2(0, 0)
	
	# Sørg for z-index og animation
	var sprite = coin.get_node("AnimatedSprite2D")
	sprite.z_index = 5
	sprite.play("Idle")
	coin.connect("collected", Callable(self, "_on_coin_collected"))


	
func _on_coin_collected(_coin):
	# Respawn en ny mønt efter et stykke tid
	#print("Coin collected: ", coin.name)
	#GameManager.addPoint()
	addPoint()
	await get_tree().create_timer(respawn_time).timeout
	spawn_coin()
	


func addPoint():
	score += 1
	print(score)
