extends Node2D

func _ready() -> void:
	Dialogic.start("睡觉")
	await Dialogic.timeline_ended
	delete_save()
	get_tree().change_scene_to_file("res://scenes/结局/好结局.tscn")

func delete_save():
	var path := "user://savegame.json"
	if FileAccess.file_exists(path):
		var err := DirAccess.remove_absolute(path)
		if err != OK:
			print("删除失败: ", err)
	else:
		print("没有存档文件")
