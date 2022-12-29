class_name BuildingData
extends EntityData




@export_category("Base")
@export var techs_need : Array[Technology]
@export var add_pop : int = 5
@export_category("Construction")
@export var max_builders : int = 1
@export var build_time : float = 0.60
@export var build_limit : int = 1
@export_category("Statistics")
@export var garrison_type : String = "Villagers"
@export var garrison : int = 0
@export var damage_multiplier := {}
@export_category("Ranged Attack")
@export var range : int = 32
@export var rate_of_fire : float = 3.0
@export_category("Anti-Ship Attack")
@export var anti_ship_damage : int = 75
@export var anti_ship_multiplier := {}
@export var anti_ship_rate_of_fire : float = 3.0
@export_category("Train")
@export var units : Array[UnitData]
@export_category("Technology")
@export var techs : Array[Technology]
