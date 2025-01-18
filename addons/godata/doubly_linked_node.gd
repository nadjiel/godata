@icon("res://addons/godata/icons/doubly_linked_node.svg")
## This class represents a node that can be used in doubly linked data
## structures. This node is not the same as Godot's built-in [Node]s.
## 
## This class is a simple container that can store a [member value] and also
## a reference to a [member next] and a [member previous] [GDDoublyLinkedNode]s,
## so that a chain of these nodes can be easily created.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b][br]
## [i]Version: 1.0.0[/i]
class_name GDDoublyLinkedNode
extends GDLinkedNode

## The [member previous] property should store a reference to the previous
## [GDDoublyLinkedNode] in the sequence to which this [GDDoublyLinkedNode]
## belongs. [br]
## By default, this property is set to [code]null[/code], meaning that
## there's no previous node in the sequence.
var previous: GDDoublyLinkedNode = null:
	set = set_previous,
	get = get_previous

func set_previous(new_node: GDDoublyLinkedNode) -> void:
	previous = new_node

func get_previous() -> GDDoublyLinkedNode:
	return previous

## The [method create] method is a static method that helps with the creation
## of new [GDDoublyLinkedNode]s by directly accepting a [param value]
## for them to store.
static func create(value: Variant) -> GDLinkedNode:
	var node := GDDoublyLinkedNode.new()
	node.value = value
	
	return node
