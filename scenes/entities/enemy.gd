extends CharacterBody3D

var HP:int=10
@onready var looks:MeshInstance3D = $theWay_you_dress
@onready var anim=$AnimationPlayer
func dmg():
	HP-=1
	anim.play("hit")
	if HP<=0:
		queue_free()
