extends Node
class_name Talk

signal move(b:bool)
signal talk(b:bool)

enum Talk_State{
	NONE,
	ON_TRIGGER,
	ON_END,
	ON_BACK
}

var state:Talk_State=Talk_State.NONE

func change_state(st:Talk_State):
	state=st


func look_state():
	match state:
		Talk_State.NONE:
			print("none")
		Talk_State.ON_TRIGGER:
			emit_signal("move",false)
			emit_signal("talk",true)
		Talk_State.ON_END:
			emit_signal("move",true)
			emit_signal("talk",false)
