extends Area3D
class_name Talk_area

@export var ui:Player_ui


var Npc_data:NPC_DATA

var Npc_name:String
var Npc_text_data:String
var Npc_text_color:Color


func can_talk()->bool:
	return ui.can_talk


func give_talk_data(res:NPC_DATA):
	Npc_data=res

func remove_talk_data():
	Npc_data=null


func talk_visiblity(toggle:bool)->void:
	if toggle:
		ui.display_text("talk(E)")
		return 
	ui.hide_display_text()
