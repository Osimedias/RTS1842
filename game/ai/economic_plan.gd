extends Node

var villagers : Array = []

func create_villager():
	if get_parent().food >= 50 and villagers.size() >= 30:
		print("Create villager and append to villager list")


func gather_resource_for_plan(resource : String):
	
	for villager in villagers:
		pass
	pass

