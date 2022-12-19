extends Node


var food : int = 500
var wood : int = 500
var coin : int = 500
var pop : int = 0

var ally = []
var neutral = []
var enemy = []



func resource_empty():
	
	if food == 0:
		$economic_plan.ather_resource_for_plan("food")
	if wood == 0:
		$economic_plan.ather_resource_for_plan("wood")
	if coin == 0:
		$economic_plan.ather_resource_for_plan("coin")
	

func ask_for_resource():
	pass


