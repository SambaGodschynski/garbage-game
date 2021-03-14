extends Button

func _pressed():
	var man = get_tree().get_root().find_node("manual", true, false)
	man.visible = true
	
