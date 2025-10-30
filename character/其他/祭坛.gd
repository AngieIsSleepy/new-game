extends Node2D
var done = false

func show_chat_icon():
	if !done:
		$"感叹号".visible = true
	
func hide_chat_icon():
	if !done:
		$"感叹号".visible = false
