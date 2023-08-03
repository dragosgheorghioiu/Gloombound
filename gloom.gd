extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -200.0

var direction
var start_moving = true
var spawn_finished = false 
var spawn_sound = false
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

func play_respawn_animation():
	anim.play("spawn")
	if spawn_sound == false:
		spawn_sound = true
		get_node("SoundEffects/Spawn").play()
	await anim.animation_finished
	spawn_finished = true
	get_node("CollisionShape2D").disabled = false
	get_node("Hitbox/CollisionShape2D").disabled = false
	spawn_sound = false

func _physics_process(delta):
	if !spawn_finished:
		play_respawn_animation()
	elif PlayerData.remaining_coins == 0:
		anim.play("despawn")
		velocity = Vector2(0,0)
	else:
	# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * 0.4 * delta
		if !GloomInput.input_queue.is_empty():
			var input = GloomInput.input_queue.pop_front()
			if (input == 2 || input == 3 || input == -2) and is_on_floor():
					velocity.y = JUMP_VELOCITY
					anim.play("jump")

				# Get the input direction and handle the movement/deceleration.
				# As good practice, you should replace UI actions with custom gameplay actions.
			if input:
				if input == -1 || input == -2:
					get_node("AnimatedSprite2D").flip_h = true
					velocity.x = move_toward(velocity.x, -SPEED, SPEED / 10)
				elif input == 1 || input == 2:
					get_node("AnimatedSprite2D").flip_h = false
					velocity.x = move_toward(velocity.x, SPEED, SPEED / 10)
				elif input == 3:
					velocity.x = move_toward(velocity.x, 0, SPEED / 10)
				if velocity.y == 0:
					anim.play("run")
			else:
				velocity.x = move_toward(velocity.x, 0, SPEED / 10)
				if velocity.y == 0:
					anim.play("idle")
			if velocity.y > 0:
				anim.play("fall")
	move_and_slide()


func _on_hitbox_body_entered(body):
	if body.name == 'Player':
		get_node("Hitbox/CollisionShape2D").disabled = true
		velocity = Vector2(0,0)
		GloomInput.input_queue.clear()
		anim.play("idle")
		PlayerData.health = -1
		PlayerData.hitstun = 10
		await get_tree().create_timer(0.8).timeout
		anim.play("despawn")
		await anim.animation_finished
		self.queue_free()
