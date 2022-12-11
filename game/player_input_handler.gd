extends Node
# TODO: Pasar esto a los nodos de las entidades dentro del "Mundo"
enum command_context {
	WORKER,
	BUILDING,
	MILITARY
}


var context : int

func _input(event):
	
	if event is InputEventKey and event.is_pressed():
		match event.keycode:
			KEY_H:
				print("Sent to Firts TC")
			
