
class_name GDDictSetIterator
extends GDIterator

var elements: Dictionary = {}

var index: int = 0

static func create(elements: Dictionary) -> GDIterator:
	var iterator := GDDictSetIterator.new()
	iterator.elements = elements
	
	return iterator

func has_next() -> bool:
	return index < elements.size()

func next() -> Variant:
	var result: Variant = elements.keys()[index]
	
	index += 1
	
	return result

func remove() -> void:
	elements.erase(elements.keys()[index - 1])
