extends StaticBody2D

@onready var sprite2D = %Sprite2D;

@export_enum("Health", "Damage", "ShootSpeed") var power_type;

@export_category("Sprites")
@export var heal = Texture;
@export var damage = Texture;
@export var shoot_speed = Texture;

@export_group("")

func _ready():
	if(power_type == null): 
		power_type = randi_range(0, 2)
	match power_type:
		0:
			sprite2D.set_texture(heal)
		1:
			sprite2D.set_texture(damage)
		2:
			sprite2D.set_texture(shoot_speed)

func _on_area_2d_body_entered(body):
	match power_type:
		0:
			upgrade_health(body)
		1:
			upgrade_damage(body)
		2:
			upgrade_shoot_speed(body)

func upgrade_health(body):
	print("hey")
	despawn();
	if body.has_method("upgrade_health"):
		body.upgrade_health(5)
	
func upgrade_damage(body):
	print("hey")
	
	despawn();
	if body.has_method("upgrade_damage"):
		body.upgrade_damage(0.1)
	
func upgrade_shoot_speed(body):
	print("hey")
	
	despawn();
	if body.has_method("upgrade_shoot_speed"):
		body.upgrade_shoot_speed(0.01)
	
func despawn():
	queue_free();

func _on_timer_timeout():
	sprite2D.modulate = Color.PURPLE;	
	despawn();
