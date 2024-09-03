extends Node

const OPEN_SCENE  = "res://Scenes/OpenScene.tscn"
const GAME_OVER_SCENE = "res://Scenes/hud_gameover.tscn"
var current_lvl = 0
var scene_cache

func _ready():
	#Show Opening Scene
	var open_scene = load(OPEN_SCENE).instantiate()
	get_tree().root.add_child.call_deferred(open_scene)
	open_scene.button_start_pressed.connect(start_game.bind())
	open_scene.button_exit_pressed.connect(exit_game.bind())
	scene_cache = open_scene
	
	
func load_next_level():
	current_lvl += 1
	var name = "Level_" + str(current_lvl)
	var path = "res://Scenes/Levels/%s.tscn" % name
	
	var next_scene = load(path).instantiate()
	###Swap the scene
	get_tree().root.add_child.call_deferred(next_scene)
	get_tree().root.remove_child(scene_cache)
	scene_cache = next_scene
	

func start_game():
	print("Starting Game")
	load_next_level()

func exit_game():
	print("Ending Game")
	var game_over_scene = load(GAME_OVER_SCENE).instantiate()
	get_tree().root.add_child.call_deferred(game_over_scene)
	get_tree().root.remove_child(scene_cache)
	
