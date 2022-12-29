class_name UnitData
extends EntityData



@export_category("Base")
@export var pop_cost : int = 1
@export var type : PackedStringArray
@export var age : Technology
@export var training_time : float = 0.30
@export var has_training_limit : bool = false
@export var training_limit : int = 99
@export var resists = {}
@export var speed : float = 4.0
@export var ability : PackedStringArray
@export_category("Melee Damage")
@export var melee_attack : int = 13
@export var melee_multipler : Dictionary
@export var rate_of_fire : float = 1.5
@export_category("Ranged Damage")
@export var ranged_attack : int = 23
@export var range_radius : int = 12
@export var range_multipler : Dictionary
@export var range_rate_of_fire : int = 3.0
@export_category("Siege Damage")
@export var siege_attack : int = 20
@export var siage_range : int = 6
@export var siage_multipler : Dictionary
@export var siege_rate_of_fire : float = 3.0
