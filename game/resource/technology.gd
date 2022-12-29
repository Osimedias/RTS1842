class_name Technology
extends Resource


@export var name : String = ""
@export var portrait : Texture2D
@export_enum(AGE,UNIT,STRUCTURE) var type = 0
@export var time_research : int = 30
@export var food_cost : int
@export var wood_cost : int
@export var coin_cost : int
@export var fame_cost : int

@export var superside : Technology
@export var auto_research : bool
@export var actioner : Actioner
