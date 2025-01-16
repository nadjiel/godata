
class_name GDArrayStack
extends GDStack

var elements: Array = []

static func from_array(array: Array) -> GDLinear:
	var stack: GDStack = GDArrayStack.new()
	
	for element: Variant in array:
		stack.add(element)
	
	return stack

func iterator() -> GDIterator:
	return GDArrayStackIterator.create(elements)

func length() -> int:
	return elements.size()

func is_empty() -> bool:
	return elements.is_empty()

func is_full() -> bool:
	return false

func add(element: Variant) -> bool:
	elements.push_back(element)
	
	return true

func add_all(elements: GDIterable) -> bool:
	var i: GDIterator = elements.iterator()
	
	var added_all: bool = true
	
	while i.has_next():
		added_all = added_all and add(i.next())
	
	return added_all

func has(element: Variant) -> bool:
	return elements.has(element)

func has_all(elements: GDIterable) -> bool:
	var found: bool = true
	
	var i: GDIterator = elements.iterator()
	
	while i.has_next():
		found = found and has(i.next())
		
		if not found:
			break
	
	return found

func remove() -> Variant:
	if is_empty():
		push_error("Tried removing from empty Stack")
		return null
	
	return elements.pop_back()

func clear() -> bool:
	if is_empty():
		return false
	
	elements.clear()
	
	return true

func get_element() -> Variant:
	return elements.back()
