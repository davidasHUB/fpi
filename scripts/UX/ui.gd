class_name Player_ui extends Control


@export var body: GoldGdt_Controls
@onready var label: Label = $text/Label
@onready var text_action = $"use-display-text/text-show"
@onready var text_box = $"Text-box"
@onready var text_box_name=$"Text-box/NinePatchRect/name/text_name"
@onready var text_box_text=$"Text-box/NinePatchRect/text/text_info"

var can_close:bool=false 
var can_talk:bool = false 



func on_end():
	can_talk=true
	can_close=true 

func start_dialog(data:NPC_DATA):
	can_talk=false
	can_close=false
	text_action.hide()
	text_box_name.text=data.name
	text_box_text.text=data.raw_text[0]
	text_box_text.visible_ratio=0
	var t=create_tween()
	t.tween_property(text_box_text,"visible_ratio",1.0,1.0)
	t.tween_callback(on_end)

#
#func _ready() -> void:
	#pass
	#


func display_text_box(toggle:bool, data:NPC_DATA):
	if toggle:
		start_dialog(data)
		text_box.show()
		return
	text_box.hide()


func display_text(text:String)->void:
	text_action.text=text
	text_action.show()
	can_talk=true

func hide_display_text():
	text_action.hide()
	can_talk=false
#
#func _process(_delta: float) -> void:
	#if body!=null:
		#label.text = "$"+str(body.gun_base.current_gun)
		#
