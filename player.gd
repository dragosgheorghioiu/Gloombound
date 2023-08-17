extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -235.0

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

func win_condition():
	anim.play("win")
	GloomInput.input_queue.clear()
	velocity = Vector2(0, 0)
	await anim.animation_finished
	if PlayerData.from_level_select == true:
		get_tree().change_scene_to_file("res://TitleScreen/main.tscn")
		return

	elif PlayerData.current_level == 1:
		get_tree().change_scene_to_file("res://level2/level_2.tscn")
		return
	elif PlayerData.current_level == 2:
		get_tree().change_scene_to_file("res://Level3/level_3.tscn")
		return
	else:
		get_tree().change_scene_to_file("res://TitleScreen/main.tscn")
		return

func jump_func():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		get_node("SoundEffects/Jump").play()

func _physics_process(delta):
	if !respawn_finished:
		play_respawn_animation()
	elif PlayerData.remaining_coins == 0:
		win_condition()
	else:
		if not is_on_floor():
			velocity.y += gravity * 0.525 * delta 
		if PlayerData.hitstun == -1:
			jump_func()

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
				velocity.x = move_toward(velocity.x, direction * SPEED / 2.25, SPEED * delta * 3)
				if velocity.y == 0:
					anim.play("run")
			else:
				if Input.is_action_just_pressed("ui_accept"):
					GloomInput.input_queue.append(3)
				else:
					GloomInput.input_queue.append(0)
				velocity.x = move_toward(velocity.x, 0, SPEED * delta * 3)
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
