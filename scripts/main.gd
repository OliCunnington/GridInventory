extends Control

var hovering_delete : bool

@onready var panel: Panel = $VBoxContainer/Panel
@onready var inventory: Inventory = $Inventory
@onready var delete_panel: Panel = $Panel

@export var item_scene : PackedScene


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


# generate new item
func _on_button_pressed() -> void:
	if panel.get_child_count() > 0:
		return
	var rect = item_scene.instantiate()
	rect.get_child(0).data = ItemData.new()
	rect.get_child(0).connect("item_selected", _item_selected)
	rect.get_child(0).connect("item_released", _item_released)
	panel.add_child(rect)
	rect.position = (panel.size / 2) - (rect.get_child(0).size / 2)


func _item_selected(_item):
	for i in _item.sockets:
		inventory.get_child(i).clear_item()
	#_item.sockets = []
	inventory.item_held = _item.get_parent()


func _item_released(_item):
	if hovering_delete:
		_item.get_parent().queue_free()
	else:
		inventory.place_item()
	inventory.item_held = null


func _on_panel_mouse_entered() -> void:
	hovering_delete = true
	delete_panel.self_modulate = "555555"


func _on_panel_mouse_exited() -> void:
	hovering_delete = false
	delete_panel.self_modulate = "ffffff"
