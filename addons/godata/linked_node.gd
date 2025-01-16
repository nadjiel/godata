
class_name GDLinkedNode
extends Resource

var value: Variant:
	set = set_value,
	get = get_value

var next: GDLinkedNode:
	set = set_next,
	get = get_next

func set_value(new_value: Variant) -> void:
	value = new_value

func get_value() -> Variant:
	return value

func set_next(new_node: GDLinkedNode) -> void:
	next = new_node

func get_next() -> GDLinkedNode:
	return next

static func create(value: Variant) -> GDLinkedNode:
	var node := GDLinkedNode.new()
	node.value = value
	
	return node
