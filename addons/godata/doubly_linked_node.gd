
class_name GDDoublyLinkedNode
extends GDLinkedNode

var previous: GDDoublyLinkedNode = null

static func create(value: Variant) -> GDLinkedNode:
	var node := GDDoublyLinkedNode.new()
	node.value = value
	
	return node
