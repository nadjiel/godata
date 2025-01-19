
class_name GDDictSet
extends GDSet

var elements: Dictionary = {}:
	set = set_elements,
	get = get_elements

func set_elements(new_elements: Dictionary) -> void:
	elements = new_elements

func get_elements() -> Dictionary:
	return elements

static func from_array(array: Array) -> GDLinear:
	var new_set: GDSet = GDDictSet.new()
	
	for element: Variant in array:
		new_set.add(element)
	
	return new_set

func iterator() -> GDIterator:
	return GDDictSetIterator.create(elements)

func length() -> int:
	return elements.size()

func is_empty() -> bool:
	return elements.is_empty()

func add(element: Variant) -> bool:
	if elements.has(element):
		return false
	
	set_element(element)
	
	return true

func get_element() -> Variant:
	return elements.keys().pick_random()

func update(element: Variant) -> bool:
	var had_element: bool = elements.has(element)
	
	set_element(element)
	
	if not had_element:
		return false
	
	return true

func remove() -> Variant:
	var random_element: Variant = elements.keys().pick_random()
	
	remove_element(random_element)
	
	return random_element

func equals(other: GDCollection) -> bool:
	if not other is GDSet:
		return false
	
	var is_superset: bool = true
	var is_subset: bool = true
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	while this_i.has_next():
		if not other_i.has_next():
			return false
		
		is_superset = is_superset and other.has(this_i.next())
		
		if not is_superset:
			return false
		
		is_subset = is_subset and self.has(other_i.next())
		
		if not is_subset:
			return false
	
	if other_i.has_next():
		return false
	
	return true

func copy() -> GDCollection:
	var result: GDSet = GDDictSet.from_array(elements.keys())
	
	return result

func has(element: Variant) -> bool:
	return elements.has(element)

func clear() -> bool:
	if is_empty():
		return false
	
	elements.clear()
	
	emptied.emit()
	
	return true

func set_element(element: Variant) -> void:
	var had_element: bool = elements.has(element)
	
	elements[element] = null
	
	if not had_element:
		added.emit(element)
		updated.emit(null, element)
	else:
		updated.emit(element, element)

func remove_element(element: Variant) -> bool:
	var was_removed: bool = elements.erase(element)
	
	if was_removed:
		removed.emit(element)
	if is_empty():
		emptied.emit()
	
	return was_removed

func is_subset(other: GDSet) -> bool:
	return other.has_all(self)

func is_superset(other: GDSet) -> bool:
	return has_all(other)

func is_disjoint(other: GDSet) -> bool:
	var found: bool = false
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		found = found or other.has(i.next())
		
		if found:
			return false
	
	return true

func union(other: GDSet) -> GDSet:
	var result: GDSet = GDDictSet.new()
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	while this_i.has_next():
		result.set_element(this_i.next())
		
		if other_i.has_next():
			result.set_element(other_i.next())
	
	while other_i.has_next():
		result.set_element(other_i.next())
	
	return result

func intersection(other: GDSet) -> GDSet:
	var result: GDSet = GDDictSet.new()
	
	var this_i: GDIterator = iterator()
	
	while this_i.has_next():
		var next_element: Variant = this_i.next()
		
		if other.has(next_element):
			result.set_element(next_element)
	
	return result

func difference(other: GDSet) -> GDSet:
	var result: GDSet = GDDictSet.new()
	
	var this_i: GDIterator = iterator()
	
	while this_i.has_next():
		var next_element: Variant = this_i.next()
		
		if not other.has(next_element):
			result.set_element(next_element)
	
	return result

func symetric_difference(other: GDSet) -> GDSet:
	var result: GDSet = GDDictSet.new()
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	while this_i.has_next():
		var this_element: Variant = this_i.next()
		
		if not other.has(this_element):
			result.set_element(this_element)
		
		if not other_i.has_next():
			continue
		
		var other_element: Variant = other_i.next()
		
		if not self.has(other_element):
			result.set_element(other_element)
	
	while other_i.has_next():
		var other_element: Variant = other_i.next()
		
		if not self.has(other_element):
			result.set_element(other_element)
	
	return result
