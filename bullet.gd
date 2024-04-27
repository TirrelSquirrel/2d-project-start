extends Area2D

var travelled_distance = 0;
var bullet_damage = 1.0;

func _ready():
	bullet_damage = get_parent().getDamage();

func _physics_process(delta):
	const SPEED = 1000;
	const RANGE = 1200;
	
	var direction = Vector2.RIGHT.rotated(rotation);
	position += direction * SPEED * delta;
	
	travelled_distance += SPEED * delta;
	if travelled_distance > RANGE:
		queue_free();


func _on_body_entered(body):
	queue_free();
	if body.has_method("take_damage"):
		body.take_damage(bullet_damage)
