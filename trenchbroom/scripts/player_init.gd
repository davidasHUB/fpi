@tool
extends GoldGdt_Pawn

func _func_godot_apply_properties(properties : Dictionary):
	self.start_view_yaw=360-properties["angle"]
