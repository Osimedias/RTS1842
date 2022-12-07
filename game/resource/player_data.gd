class_name PlayerData
extends Resource

## Data container for players in game

var player_name : String = "Player 1"
var player_color : Color = Color.BLUE
var civilization : Civilization
var resources : Dictionary = {
	"food" : 0,
	"wood" : 0,
	"coin" : 0,
	"current_pop" : 0,
	"fame" : 0
}

#Estado diplomatico de otros jugadores
var ally := []
var enemy := []
var neutral := []
