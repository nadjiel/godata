
class_name GDLinkedNode
extends Resource

var value: Variant

var next: GDLinkedNode

static func create(value: Variant) -> GDLinkedNode:
	var node := GDLinkedNode.new()
	node.value = value
	
	return node
