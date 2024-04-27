extends Node2D

@onready var spawn_area = %PathFollow2D;
@onready var timer = %Timer;
@onready var gameOver = %GameOver;
@onready var menu = %StartMenu;

var mobs_in_wave =  3;
var current_wave = 1;

var mob_count = 0;

@export var MAX_MOBS = 20;

func _ready():
	get_tree().paused = true;

func startGame():
	spawn_wave(mobs_in_wave);

func spawn_mob():
	var green_slime = preload("res://mob.tscn").instantiate();
	var red_slime = preload("res://red_slime.tscn").instantiate();
	var silver_slime = preload("res://silver_slime.tscn").instantiate();
	var new_mob = green_slime;
	
	if randf()*10 < current_wave:
		new_mob = red_slime;
	if randf()*50 < current_wave:
		new_mob = silver_slime;
	
	spawn_area.progress_ratio = randf();
	new_mob.global_position = spawn_area.global_position;
	add_child(new_mob);
	mob_count += 1;

func spawn_wave(mob_number):	
	var wave = randf()*mob_number;
	current_wave += 1;
	for n in wave:
		spawn_mob();


func _on_timer_timeout():
	while mob_count < MAX_MOBS:
		mobs_in_wave = mobs_in_wave + (randf()*2);
		timer.wait_time = timer.wait_time + 0.2;
		spawn_wave(mobs_in_wave);


func _on_player_health_depleted():
	gameOver.visible = true;
	get_tree().paused = true;

func _on_play_again_pressed():
	get_tree().paused = false;	
	get_tree().reload_current_scene();


func _on_exit_pressed():
	get_tree().quit();


func _on_play_pressed():
	get_tree().paused = false;
	menu.visible = false
	startGame();

