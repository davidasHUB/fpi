@tool
extends NPC

func _func_godot_apply_properties(properties : Dictionary):
	self.path="res://resources/%s.tres"%[properties["res"]]
