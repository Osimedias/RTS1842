extends Node




func attack():
	
	if get_parent().military_units.size() >= 30:
		print("Attack player")
