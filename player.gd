extends CharacterBody2D

signal health_depleted;
var health = 100.0;
var maxHealth = 100.0;

@onready var happyBoo = %HappyBoo;
@onready var healthBar = %HealthBar;
@onready var hitBox = %HitBox;
@onready var gun = %Gun;

func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	velocity = direction * 600;
	move_and_slide();
	
	if velocity.length() > 0.0:
		happyBoo.play_walk_animation();
	else:
		happyBoo.play_idle_animation();

	const DAMAGE_RATE = 5.0;
	var overlapping_mobs = hitBox.get_overlapping_bodies();
	if overlapping_mobs.size() > 0:
		health -= DAMAGE_RATE * overlapping_mobs.size() * delta;
		update_healthBar()
		if health <= 0.0:
			health_depleted.emit();


func upgrade_health(upgrade):
	maxHealth += upgrade;
	print(maxHealth)
	health = maxHealth;
	update_healthBar();

func update_healthBar():
	healthBar.value = health;

func upgrade_damage(upgrade):
	gun.upgrade_damage(upgrade);
	
func upgrade_shoot_speed(upgrade):
	gun.increase_shoot_speed(upgrade)

