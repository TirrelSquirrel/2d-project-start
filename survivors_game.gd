extends Node2D

@onready var spawn_area = %PathFollow2D;
@onready var timer = %Timer;
@onready var gameOver = %GameOver;

var mobs_in_wave =  3;

func _ready():
	spawn_wave(mobs_in_wave);

func spawn_mob():
	var new_mob = preload("res://mob.tscn").instantiate();
	spawn_area.progress_ratio = randf();
	new_mob.global_position = spawn_area.global_position;
	add_child(new_mob);

func spawn_wave(mob_number):	
	var wave = randf()*mob_number;
	for n in wave:
		spawn_mob();


func _on_timer_timeout():
	mobs_in_wave = mobs_in_wave + (randf()*2);
	timer.wait_time = timer.wait_time + 0.2;
	spawn_wave(mobs_in_wave);


func _on_player_health_depleted():
	gameOver.visible = true;
	get_tree().paused = true;
