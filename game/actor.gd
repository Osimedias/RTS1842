class_name Actor
extends Node3D

@export var normal_actor : PackedScene
@export var veteran_actor : PackedScene
@export var guard_actor : PackedScene
@export var imperial_actor : PackedScene


var state : int = 0


##Buscar alguna forma de mejorar esto.

func change_actor():
	
	var new_actor
	
	match  state:
		0:
			if get_node_or_null("Actor"):
				get_node("Actor").queue_free()
			new_actor = normal_actor.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			new_actor.name = "Actor"
			add_child(new_actor)
			new_actor.transform.origin = transform.origin
		1:
			if get_node_or_null("Actor"):
				get_node("Actor").queue_free()
			new_actor = veteran_actor.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			new_actor.name = "Actor"
			add_child(new_actor)
			new_actor.transform.origin = transform.origin
		2:
			if get_node_or_null("Actor"):
				get_node("Actor").queue_free()
			new_actor = guard_actor.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			new_actor.name = "Actor"
			add_child(new_actor)
			new_actor.transform.origin = transform.origin
		3:
			if get_node_or_null("Actor"):
				get_node("Actor").queue_free()
			new_actor = imperial_actor.instantiate(PackedScene.GEN_EDIT_STATE_INSTANCE)
			new_actor.name = "Actor"
			add_child(new_actor)
			new_actor.transform.origin = transform.origin
