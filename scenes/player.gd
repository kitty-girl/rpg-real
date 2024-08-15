extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("walk_left", "walk_right", "walk_front", "walk_back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = lerpf(direction.x * SPEED, velocity.x, 0.16 * 60 * delta)
		velocity.z = lerpf(direction.z * SPEED, velocity.z, 0.16 * 60 * delta)
	else:
		velocity.x = lerpf(velocity.x, direction.x * SPEED, 0.24 * 60 * delta)
		velocity.z = lerpf(velocity.z, direction.z * SPEED, 0.24 * 60 * delta)

	move_and_slide()
