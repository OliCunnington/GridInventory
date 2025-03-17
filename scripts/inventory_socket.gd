extends TextureRect
class_name ItemSocket


var item_held : Node2D

signal socket_entered(socket)
signal socket_exited(socket)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mouse_entered() -> void:
	emit_signal("socket_entered", self)


func _on_mouse_exited() -> void:
	emit_signal("socket_exited", self)


#true if item_held == null / socket free
func get_availability():
	return item_held == null


func set_item(item):
	item_held = item


#probably not needed?
func get_item(item):
	return item_held


func clear_item():
	item_held = null
