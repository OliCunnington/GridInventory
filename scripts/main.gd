extends Control

@onready var panel: Panel = $VBoxContainer/Panel
@onready var inventory: Inventory = $Inventory

@export var item_scene : PackedScene


func _ready() -> void:
	pass


func _process(delta: float) -> void:
	pass


# generate new item
func _on_button_pressed() -> void:
	# placeholder #TODO
	var rect = item_scene.instantiate()
	rect.get_child(0).data = ItemData.new()
	rect.get_child(0).connect("item_selected", _item_selected)
	rect.get_child(0).connect("item_released", _item_released)
	panel.add_child(rect)
	rect.position = (panel.size / 2) - (rect.get_child(0).size / 2)


func _item_selected(_item):
	inventory.item_held = _item.get_parent()


func _item_released(_item):
	#inventory.item_held.position = inventory.item_held.get_child(0).start_pos
	inventory.item_held = null
