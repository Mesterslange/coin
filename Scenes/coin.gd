extends Area2D

signal collected(coin: Node)

func _on_body_entered(body):
		if body.name == "Player":
			emit_signal("collected", self) #sender signal
			queue_free()
		
	
