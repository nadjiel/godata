@icon("res://addons/godata/icons/linked_node.svg")
## This class represents a node that can be used in linked data structures.
## This node is not the same as Godot's built-in [Node]s.
## 
## This node is a simple container that can store a [member value] and also
## a reference to a [member next] [GDLinkedNode], so that a chain of these nodes
## can be easily created.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b][br]
## [i]Version: 1.0.0[/i]
class_name GDLinkedNode
extends Resource

## The [member value] property is meant to store whatever value it is desired
## that this [GDLinkedNode] contains.
var value: Variant:
	set = set_value,
	get = get_value

## The [member next] property should store a reference to the next
## [GDLinkedNode] in the sequence to which this [GDLinkedNode] belongs. [br]
## By default, this property is set to [code]null[/code], meaning that
## there's no next node in the sequence.
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

## The [method create] method is a static method that helps with the creation
## of new [GDLinkedNode]s by directly accepting a [param value]
## for them to store.
static func create(value: Variant) -> GDLinkedNode:
	var node := GDLinkedNode.new()
	node.value = value
	
	return node
