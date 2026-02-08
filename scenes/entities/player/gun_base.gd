extends Node3D
class_name GunBase

@export var ray : RayCast3D
@export var gun_point:ColorRect

enum Guns{
	Bone_Breaker,
}

var current_gun:Guns=Guns.Bone_Breaker
@onready var gunanim = $"gun-anim"

func _ready() -> void:
	gunanim.play("idle")

func play_shoot():
	if gunanim.current_animation=="idle":
		gunanim.play("shot")
		if ray.is_colliding():
			var ray_data=ray.get_collider()
			
			if ray_data.is_in_group("enemy"):
				var obj=ray_data.get_parent()
				obj.dmg()
		

func gun_animation_finished(anim_name: StringName) -> void:
	if anim_name=="shot":
		gunanim.play("idle")

func _process(_delta: float) -> void:
	if ray.is_colliding():
			var ray_data=ray.get_collider()
			if ray_data!=null and ray_data.is_in_group("enemy"):
				gun_point.color=Color.RED
			else:
				gun_point.color=Color.WHITE
