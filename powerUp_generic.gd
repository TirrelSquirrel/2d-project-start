extends StaticBody2D

@onready var sprite2D = %Sprite2D;

@export_enum("Health", "Damage", "ShootSpeed") var power_type;

@export_group("Sprites")
@export var heal = Texture;
@export var damage = Texture;
@export var shoot_speed = Texture;

@export_group("Power Cuantities")
@export var health = 1;
@export var dmg = 0.1;
@export var shootSpeed = 0.01;

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
	if body.has_method("upgrade_health"):
		body.upgrade_health(health)
	despawn();
	
func upgrade_damage(body):
	if body.has_method("upgrade_damage"):
		body.upgrade_damage(dmg)
	despawn();	
	
func upgrade_shoot_speed(body):
	if body.has_method("upgrade_shoot_speed"):
		body.upgrade_shoot_speed(shootSpeed)
	despawn();	
	
func despawn():
	queue_free();

func _on_timer_timeout():
	sprite2D.modulate = Color.PURPLE;	
	despawn();
