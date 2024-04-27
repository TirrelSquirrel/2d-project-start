extends Area2D

@onready var timer = %Timer;

var bullet_damage = 1.0;

func _physics_process(_delta):
	var enemies_in_range = get_overlapping_bodies();
	if enemies_in_range.size() > 0:
		var target_enemy = enemies_in_range.front();
		look_at(target_enemy.global_position);


func shoot():
	const BULLET = preload("res://bullet.tscn");
	var new_bullet = BULLET.instantiate();
	new_bullet.global_position = %ShootingPoint.global_position;
	new_bullet.global_rotation = %ShootingPoint.global_rotation;	
	%ShootingPoint.add_child(new_bullet);

func increase_shoot_speed(upgrade):
	timer.wait_time = timer.wait_time - upgrade;
	
func upgrade_damage(upgrade):
	bullet_damage += upgrade;

func _on_timer_timeout():
	shoot();
