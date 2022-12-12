extends Node



var tracks := [
	"res://data/audio/music/Alba_Longa_Burns.ogg",
	"res://data/audio/music/Albian_Nocturne.ogg",
	"res://data/audio/music/Along_the_Nile.ogg",
	"res://data/audio/music/Ammon-Ra.ogg",
	"res://data/audio/music/An_old_Warhorse_goes_to_Pasture.ogg",
	"res://data/audio/music/As_Seasons_Change.ogg",
	"res://data/audio/music/Bandit_Country.ogg",
	"res://data/audio/music/Beyond_The_Indus.ogg",
	"res://data/audio/music/Calm_Before_the_Storm.ogg",
	"res://data/audio/music/Celtica.ogg",
	"res://data/audio/music/Celtic_Pride.ogg",
	"res://data/audio/music/Cisalpine_Gaul.ogg",
	"res://data/audio/music/Cradle_of_Civilization.ogg",
	"res://data/audio/music/Dried_Tears.ogg",
	"res://data/audio/music/Eastern_Dreams.ogg",
	"res://data/audio/music/Elysian_Fields.ogg",
	"res://data/audio/music/Expedition.ogg",
	"res://data/audio/music/Forging_a_City-State.ogg",
	"res://data/audio/music/From_Every_Corner.ogg",
]


func _ready():
	change_music()
	$background_music.play()



func change_music():
	$background_music.stream = load(tracks[randi() % tracks.size()])



func _on_background_music_finished():
	print("Cambio de Cancion.")
	change_music()
	$background_music.play()
