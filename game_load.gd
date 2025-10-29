extends Node

var current_scene_path: String = ""
const SAVE_PATH := "res://savegame.json"

func save_game():
	var data = {"current_scene_path": current_scene_path}
	var f = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	f.store_string(JSON.stringify(data))
	f.close()


func load_game() -> int:
	if not FileAccess.file_exists(SAVE_PATH):
		return 0
	var f = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var text = f.get_as_text()
	f.close()
	var parsed = JSON.parse_string(text)
	if typeof(parsed) == TYPE_DICTIONARY and parsed.has("current_scene_path"):
		current_scene_path = parsed["current_scene_path"]
		return 1
	return 2
