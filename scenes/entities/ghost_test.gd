class_name NPC extends Node3D

@export var res:NPC_DATA
@export var path:String

var can_talk=false

func show_name():
	print(res.name)

func _ready() -> void:
	if path!="":
		res=ResourceLoader.load(path)
	
func _on_npc_area_entered(area: Area3D) -> void:
	if area.is_in_group("player"):
		var player_col = area as Talk_area
		can_talk=true
		
		player_col.talk_visiblity(true)
		player_col.give_talk_data(res)


func _on_npc_area_exited(area: Area3D) -> void:
	if area.is_in_group("player"):
		var player_col = area as Talk_area
		
		can_talk=false
		player_col.talk_visiblity(false)
		player_col.remove_talk_data()
