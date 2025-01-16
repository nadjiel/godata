
class_name GDArrayStackIterator
extends GDIterator

var elements: Array = []

var index: int = -1

static func create(elements: Array) -> GDIterator:
	var iterator := GDArrayStackIterator.new()
	iterator.elements = elements
	iterator.index = elements.size() - 1
	
	return iterator

func has_next() -> bool:
	return index != -1

func next() -> Variant:
	var result: Variant = elements[index]
	
	index -= 1
	
	return result

func remove() -> void:
	elements.remove_at(index + 1)
