
class_name GDCollection
extends GDIterable

func length() -> int: return 0

func is_empty() -> bool: return false

func is_full() -> bool: return false

func add(element: Variant) -> bool: return false

func get_element() -> Variant: return null

func update(element: Variant) -> bool: return false

func remove() -> Variant: return null

func equals(other: GDCollection) -> bool: return false

func as_array() -> Array: return []

func add_all(elements: GDIterable) -> bool:
	var i: GDIterator = elements.iterator()
	
	var added_all: bool = true
	
	while i.has_next():
		added_all = added_all and add(i.next())
	
	return added_all

func has(element: Variant) -> bool:
	var found: bool = false
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		found = found or (i.next() == element)
		
		if found:
			break
	
	return found

func has_all(elements: GDIterable) -> bool:
	var found: bool = true
	
	var i: GDIterator = elements.iterator()
	
	while i.has_next():
		found = found and has(i.next())
		
		if not found:
			break
	
	return found

func clear() -> bool:
	if is_empty():
		return false
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		i.next()
		i.remove()
	
	return true
