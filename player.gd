extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -200.0

var facing_right = true
var direction = 1
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var knockback = -1
var is_dead = false
var spawn_sound = false
var respawn_finished = false 

@onready var anim = get_node("AnimationPlayer") 

func play_respawn_animation():
	velocity = Vector2(0, 0)
	anim.play("respawn")
	if spawn_sound == false:
		spawn_sound = true
		get_node("SoundEffects/Spawn").play()
	await anim.animation_finished
	PlayerData.initial_coordinates = global_position
	respawn_finished = true
	spawn_sound = false
	is_dead = false
	PlayerData.health = 3
	PlayerData.hitstun = -1

func _physics_process(delta):
#	print(respawn_finished)
	if !respawn_finished:
		play_respawn_animation()
	elif PlayerData.remaining_coins == 0:
		anim.play("win")
		GloomInput.input_queue.clear()
		velocity = Vector2(0, 0)
		await anim.animation_finished
		if PlayerData.current_level == 1:
			get_tree().change_scene_to_file("res://level2/level_2.tscn")
			return
		if PlayerData.current_level == 2:
			get_tree().change_scene_to_file("res://Level3/level_3.tscn")
			return
		else:
			get_tree().change_scene_to_file("res://TitleScreen/main.tscn")
			return
	else:
		# Add the gravity.
		if not is_on_floor():
			velocity.y += gravity * 0.4 * delta
		if PlayerData.hitstun == -1:
			# Handle Jump.
			if Input.is_action_just_pressed("ui_accept") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				anim.play("jump")
				get_node("SoundEffects/Jump").play()

			# Get the input direction and handle the movement/deceleration.
			# As good practice, you should replace UI actions with custom gameplay actions.
			direction = Input.get_axis("ui_left", "ui_right")
			if direction:
				if direction == -1:
					get_node("AnimatedSprite2D").flip_h = true
					knockback = 1
					if Input.is_action_just_pressed("ui_accept"):
						GloomInput.input_queue.append(-2)
					else:
						GloomInput.input_queue.append(-1)
				elif direction == 1:
					get_node("AnimatedSprite2D").flip_h = false
					knockback = -1
					if Input.is_action_just_pressed("ui_accept"):
						GloomInput.input_queue.append(2)
					else:
						GloomInput.input_queue.append(1)
				velocity.x = move_toward(velocity.x, direction * SPEED, SPEED / 10)
				if velocity.y == 0:
					anim.play("run")
			else:
				if Input.is_action_just_pressed("ui_accept"):
					GloomInput.input_queue.append(3)
				else:
					GloomInput.input_queue.append(0)
				velocity.x = move_toward(velocity.x, 0, SPEED / 10)
				if velocity.y == 0:
					anim.play("idle")
			if velocity.y > 0:
				anim.play("fall")
		elif PlayerData.health == -1:
			if PlayerData.hitstun == 0:
				if is_dead == false:
					is_dead = true
					get_node("SoundEffects/Death").play()
				await anim.animation_finished
				await get_tree().create_timer(0.7).timeout
				self.queue_free()
			anim.play("hurt")
			velocity.x = knockback * 300
			velocity.y = -100
			PlayerData.hitstun -= 1
	move_and_slide()
