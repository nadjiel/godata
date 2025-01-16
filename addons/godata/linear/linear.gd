
class_name GDLinear
extends GDCollection

static func from_array(array: Array) -> GDLinear: return null

func equals(other: GDCollection) -> bool:
	if not other is GDLinear:
		return false
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	while this_i.has_next():
		if not other_i.has_next():
			return false
		
		var this_value: Variant = this_i.next()
		var other_value: Variant = other_i.next()
		
		if this_value != other_value:
			return false
	
	if other.has_next():
		return false
	
	return true

func as_array() -> Array:
	var result: Array = []
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		result.push_back(i.next())
	
	return result
