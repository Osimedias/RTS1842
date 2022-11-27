extends Node




var current_tool := 0


func _input(event):
	if event is InputEventKey:
		if event.keycode == KEY_T and event.is_pressed():
			print("Entrando al Modo Editor de Terrenos")
		if event.keycode == KEY_X and event.is_pressed():
			print("Entrando al Editor de Datos")
		if event.keycode == KEY_Q and event.is_pressed():
			print("Entrando a Objetos")
		if event.keycode == KEY_E and event.is_pressed():
			print("Para poner putos de control para muros has click con el boton izquierdo en cualquier lugar del terreno")
		
		if event.keycode == KEY_Q and event.keycode == KEY_SHIFT and event.is_pressed():
			get_tree().quit()
