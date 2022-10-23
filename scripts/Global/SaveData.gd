extends Node

	
func save_data(path, data:int) -> void:
	var file := File.new()
	file.open(path, File.WRITE)
	file.store_var(data)
	file.close()
	
func load_data(path):
	var file := File.new()
	file.open(path, File.READ)
	var data = file.get_var()
	file.close()
	return data
