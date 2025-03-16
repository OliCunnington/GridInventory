extends GridContainer
class_name Inventory

var item_held: Node2D
var current_index : int

@export var container_height: int
@export var container_width: int

@onready var socket_scene : PackedScene = preload("res://scenes/inventory_socket.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	columns = container_width
	for i in container_height * container_width:
		var s = socket_scene.instantiate()
		s.connect("socket_entered", _socket_entered)
		s.connect("socket_exited", _socket_exited)
		add_child(s)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func check_all_available():
	for i in get_indexes_from_vector(item_held.get_child(0).data.size):
		if !get_child(i).get_availability():
			return false
	return true


func _socket_entered(socket):
	current_index = socket.get_index()
	socket.self_modulate = "00000000"
	if item_held:
		var indexes = get_indexes_from_vector(item_held.get_child(0).data.size)
		if len(indexes) == item_held.get_child(0).data.size.x * item_held.get_child(0).data.size.y:
			for i in indexes:
				get_child(i).self_modulate = Color.GREEN
		else:
			for i in indexes:
				get_child(i).self_modulate = Color.RED


func _socket_exited(socket):
	current_index = -1
	for i in get_children():
		i.self_modulate = "ffffffff"


#turns size vector into list of indexes tp check
func get_indexes_from_vector(vec: Vector2):
	# out of range index
	var max_index = container_height * container_width
	#generate indexes from vector
	var indexes = []
	for j in range(vec[1]):
		#end of row index
		var end_of_row = container_width * (j+1 + ceili(current_index/container_width))
		for i in range(vec[0]):
			var test_index = current_index + i + j * container_width
			# overflow test
			if test_index < end_of_row and test_index < max_index:
				indexes.append(test_index)
	return indexes
