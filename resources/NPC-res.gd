@icon("res://icon.png")
class_name NPC_DATA extends Resource

@export var name:String="" ## name of the npc
@export var raw_text:Array[String]=[] ## raw npc text data
@export var frame:int=0 ## frame npc data
@export var color:Color= Color.BLACK ## npc color data

func _init(_name:String="",_text:Array[String]=[],_frame:int=0,_color:Color=Color.BLACK) -> void:
	name=_name
	raw_text=_text
	frame=_frame 
	color=_color
