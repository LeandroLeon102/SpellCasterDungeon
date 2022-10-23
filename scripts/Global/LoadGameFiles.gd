extends Node

var OS_DATA_FOLDER = OS.get_data_dir()
var GAME_NAME = 'SpellCaster Dungeon'
var GAME_FOLDER = OS_DATA_FOLDER + '/' + GAME_NAME
var CONFIGURATIONS_FOLDER = GAME_FOLDER + '/config'
var DATA_FOLDER = GAME_FOLDER + '/data'

var CONFIG_TEMPLATES = {
	'window_size': Vector2(1980, 1080),
	'fullscreen': false, 
	'master_volume':100,
	'sfx_volume':100,
	'music_volume':100
}

func _ready():
	load_game_path()

func load_game_path():
	var dir = Directory.new()
	var error = dir.open(GAME_FOLDER)
	if error == OK:
		load_game_config()
	else:
		generate_game_folders(GAME_FOLDER)
		load_game_path()

func load_game_config():
	var dir = Directory.new()
	var error = dir.open(CONFIGURATIONS_FOLDER)
	if error != OK:
		generate_game_folders(CONFIGURATIONS_FOLDER)
	else:
		pass
		
	dir = Directory.new()
	error = dir.open(DATA_FOLDER)
	if error != OK:
		generate_game_folders(DATA_FOLDER)
	else:
		pass
	

	
	
func generate_game_folders(folder):
	var dir = Directory.new()
	match folder:
		GAME_FOLDER:
			dir.make_dir(GAME_FOLDER)
		CONFIGURATIONS_FOLDER:
			dir.make_dir(CONFIGURATIONS_FOLDER)
		DATA_FOLDER:
			dir.make_dir(DATA_FOLDER)
	
	
func generate_game_files_template():
	pass

func save_file(path, data):
	pass

func load_file(path):
	pass
	
