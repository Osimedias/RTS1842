class_name TechnologyNodeData
extends Resource


var id : int
var name : String
var time_cost : int
var food_cost : int
var wood_cost : int
var coin_cost : int
var pop_cost : int
var fame_cost : int

var actioner : TechnologyNodeActioners
var children : Array
var parent : TechnologyNodeData

var unlocked : bool
