extends TextureRect
class_name Item

var textures = [preload("res://assets/circ.png"), preload("res://assets/rect.png")]
var hovering : bool = false
var selected : bool = false
var start_pos : Vector2
var sockets : Array

@onready var data : ItemData

signal item_selected(item)
signal item_released(item)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	texture = textures.pick_random()
	data.color = [Color.RED, Color.BLUE, Color.GREEN].pick_random() 
	data.size.x = randi_range(1,4)
	data.size.y = randi_range(1,4)
	self_modulate = data.color
	
	size = data.size * 40
	#pivot_offset = size / 2 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		get_parent().global_position = get_global_mouse_position() #- size/2


func _input(event: InputEvent) -> void:
	if hovering and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !selected:
		selected = true
		start_pos = get_parent().global_position
		mouse_filter = MOUSE_FILTER_IGNORE
		emit_signal("item_selected", self)
	elif selected:
		if event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
			selected = false
			mouse_filter = MOUSE_FILTER_PASS
			emit_signal("item_released", self)
		elif event.is_action_pressed("rotate"):
			_rotate_item()


func _on_mouse_entered() -> void:
	if !selected:
		hovering = true


func _on_mouse_exited() -> void:
	if !selected:
		hovering = false


func _rotate_item():
	data.size = Vector2(data.size.y, data.size.x)
	rotation_degrees += 90
	match rotation_degrees:
		90.0:
			position = Vector2(size.y, 0)
		180.0:
			position = Vector2(size.x, size.y)
		270.0:
			position = Vector2(0, size.x)
		_:
			rotation_degrees = 0
			position = Vector2.ZERO


func return_to_original_position():
	get_parent().global_position = start_pos
