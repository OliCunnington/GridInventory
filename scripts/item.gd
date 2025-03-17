extends TextureRect
class_name Item

var textures = [preload("res://assets/circ.png"), preload("res://assets/rect.png")]
var hovering : bool = false
var selected : bool = false
var start_pos : Vector2

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
	pivot_offset = size / 2 

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if selected:
		get_parent().global_position = get_global_mouse_position() #- size/2


func _input(event: InputEvent) -> void:
	if hovering and event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT and !selected:
		selected = true
		start_pos = get_parent().global_position
		emit_signal("item_selected", self)
	elif selected and event is InputEventMouseButton and event.is_released() and event.button_index == MOUSE_BUTTON_LEFT:
		selected = false
		get_parent().global_position = start_pos
		emit_signal("item_released", self)


func _on_mouse_entered() -> void:
	if !selected:
		print("Mouse entered")
		#scale = Vector2(1.25, 1.25)
		hovering = true


func _on_mouse_exited() -> void:
	if !selected:
		print("Mouse exited")
		#scale = Vector2.ONE
		hovering = false
