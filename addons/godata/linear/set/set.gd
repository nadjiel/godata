
class_name GDSet
extends GDLinear

func set_element(element: Variant) -> void: pass

func remove_element(element: Variant) -> bool: return false

func is_subset(other: GDSet) -> bool: return false

func is_superset(other: GDSet) -> bool: return false

func is_disjoint(other: GDSet) -> bool: return false

func union(other: GDSet) -> GDSet: return null

func intersection(other: GDSet) -> GDSet: return null

func difference(other: GDSet) -> GDSet: return null

func symetric_difference(other: GDSet) -> GDSet: return null

func union_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	var i: GDIterator = others.iterator()
	
	while i.has_next():
		result = result.union(i.next())
	
	if result == self:
		result = self.copy()
	
	return result

func intersection_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	var i: GDIterator = others.iterator()
	
	while i.has_next():
		result = result.intersection(i.next())
	
	if result == self:
		result = self.copy()
	
	return result

func difference_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	var i: GDIterator = others.iterator()
	
	while i.has_next():
		result = result.difference(i.next())
	
	if result == self:
		result = self.copy()
	
	return result

func symetric_difference_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	var i: GDIterator = others.iterator()
	
	while i.has_next():
		result = result.symetric_difference(i.next())
	
	if result == self:
		result = self.copy()
	
	return result
