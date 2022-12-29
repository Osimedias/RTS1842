class_name Actioner
extends Resource


@export var name : String = ""
@export_enum(PLAYER,UNIT,STRUCTURE,HERDABLES) var modification = 0
@export_enum(ADD,MUL,SUB) var operator = 0
@export var value : int
