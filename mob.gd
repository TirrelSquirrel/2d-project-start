extends CharacterBody2D

@export var health = 3.0;
@export var speed = 300.0;
@export_enum("Green", "Red", "Silver") var type;



@onready var player = get_node("/root/Game/Player");


func _ready():
	%Slime.play_walk();


func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position);
	velocity = direction * speed;
	move_and_slide();


func take_damage(damage_taken):
	health -= damage_taken;
	%Slime.play_hurt();
	if health <= 0:
		handle_death();

func spawn_smoke():
	const SMOKE_SCENE = preload("res://smoke_explosion/smoke_explosion.tscn");
	var smoke = SMOKE_SCENE.instantiate();
	get_parent().add_child(smoke);
	smoke.global_position = global_position;

func spawn_powerup():
	const POWERUP_GENERIC = preload("res://power_up_generic.tscn");
	var powerup = POWERUP_GENERIC.instantiate();
	get_parent().add_child(powerup);
	powerup.global_position = global_position;

func handle_death():
	get_parent().mob_count -= 1;
	queue_free();
	spawn_smoke();
	var rng = randi_range(0,type);
	if rng !=0:
		print("Se viene power", rng)
		spawn_powerup()
	else:
		print("No hay power", rng)
