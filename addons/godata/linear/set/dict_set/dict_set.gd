## This class is an implementation of [GDSet] that uses a [Dictionary]
## to store its data and assure uniqueness in its entries.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b][br]
## [i]Version: 1.0.0[/i]
class_name GDDictSet
extends GDSet

## The [member elements] property stores the data of this [GDDictSet]. [br]
## The data in this [Dictionary] is stored only in its keys, with all values
## being set to [code]null[/code]. The keys are used to take advantage of
## their property of being unique. 
var elements: Dictionary = {}:
	set = set_elements,
	get = get_elements

func set_elements(new_elements: Dictionary) -> void:
	elements = new_elements

func get_elements() -> Dictionary:
	return elements

## The [method from_array] method is a static method that takes an [param array]
## and returns a new [GDDictSet] with all elements got from that array,
## excluding repeated ones. To do that, this method iterates over all elements
## of that array by using a for loop.
## Time complexity: O(n)
## Memory complexity: O(n)
static func from_array(array: Array) -> GDLinear:
	var new_set: GDSet = GDDictSet.new()
	
	for element: Variant in array:
		new_set.add(element)
	
	return new_set

## The [method push_empty_set_error] method pushes an error saying that
## it's not possible accessing elements in an empty Set.
func push_empty_set_error() -> void:
	push_error("Can't take element from empty Set")

## The [method iterator] method returns an instance of a [GDDictSetIterator]
## that can be used to iterate over the elements of this [GDDictSet].
func iterator() -> GDIterator:
	return GDDictSetIterator.create(elements)

## The [method length] method returns the current size of this [GDDictSet]
## by using the [method Dictionary.size] method.
func length() -> int:
	return elements.size()

## The [method is_empty] method returns a [code]bool[/code] indicating
## if this [GDDictSet] is currently empty by using the
## [method Dictionary.is_empty] method.
func is_empty() -> bool:
	return elements.is_empty()

## The [method add] method tries to add a new [param element] to this
## [GDDictSet]. If such [param element] is already present in this [GDDictSet],
## nothing is done and [code]false[/code] is returned, else, it is added
## and [code]true[/code] is returned.
func add(element: Variant) -> bool:
	if elements.has(element):
		return false
	
	set_element(element)
	
	return true

## The [method get_element] method returns a random [param element]
## of this [GDDictSet].
## If there are no elements in it, though, [code]null[/code] is returned,
## and an error warning that an access was tried on an empty [GDDictSet] is
## pushed using the [method push_error] method.
func get_element() -> Variant:
	if is_empty():
		push_empty_set_error()
		return null
	
	return elements.keys().pick_random()

## The [method update] method tries to add a new [param element] to this
## [GDDictSet]. At the end, this method returns a [code]bool[/code],
## with [code]true[/code] meaning the [param element] was already present,
## and [code]false[/code] meaning it wasn't present before.
func update(element: Variant) -> bool:
	var had_element: bool = elements.has(element)
	
	set_element(element)
	
	if not had_element:
		return false
	
	return true

## The [method remove] method removes a random [param element]
## from this [GDDictSet].
## If there are no elements in this [GDDictSet] to remove, though,
## [code]null[/code] is returned, and an error warning that an access
## was tried on an empty [GDDictSet] is pushed using the
## [method push_error] method.
func remove() -> Variant:
	if is_empty():
		push_empty_set_error()
		return null
	
	var random_element: Variant = elements.keys().pick_random()
	
	remove_element(random_element)
	
	return random_element

## The [method equals] method receives an [param other] [GDCollection] and
## compares it with this [GDDictSet]. [br]
## To be considered equal, both [GDCollection]s must be [GDSet]s and they
## both need to have the same elements, no matter the order.
func equals(other: GDCollection) -> bool:
	if not other is GDSet:
		return false
	
	var contains: bool = true
	var is_contained: bool = true
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	if other_i == null:
		return false
	
	while this_i.has_next():
		if not other_i.has_next():
			return false
		
		contains = contains and other.has(this_i.next())
		
		if not contains:
			return false
		
		is_contained = is_contained and self.has(other_i.next())
		
		if not is_contained:
			return false
	
	if other_i.has_next():
		return false
	
	return true

## The [method copy] method returns a shallow copy of this [GDDictSet].
func copy() -> GDCollection:
	return GDDictSet.from_array(elements.keys())

## The [method has] method returns a [code]bool[/code] indicating if the
## received [param element] is present in this [GDDictSet].
func has(element: Variant) -> bool:
	return elements.has(element)

## The [method clear] method empties this [GDDictSet]. [br]
## After that, this method also returns a [code]bool[/code] indicating
## if the removal was really done, which means this [GDDictSet] wasn't
## already empty. [br]
## Also, when clearing this [GDDictSet], the [signal emptied] signal is
## emitted.
func clear() -> bool:
	if is_empty():
		return false
	
	elements.clear()
	
	emptied.emit()
	
	return true

## The [method set_element] method sets an [param element] to this
## [GDDictSet]. [br]
## If such [param element] wasn't already present, this method triggers
## the emission of the [signal added] and [signal updated] signals.
func set_element(element: Variant) -> void:
	var had_element: bool = elements.has(element)
	
	elements[element] = null
	
	if not had_element:
		added.emit(element)
		updated.emit(null, element)

## The [method remove_element] method removes an [param element] from this
## [GDDictSet]. [br]
## If such [param element] was present, this method triggers
## the emission of the [signal removed] and [signal updated] signals. [br]
## If removing this element empties this [GDDictSet], the [signal emptied]
## signal is also emptied.
func remove_element(element: Variant) -> bool:
	var was_removed: bool = elements.erase(element)
	
	if was_removed:
		removed.emit(element)
		updated.emit(element, null)
	if is_empty():
		emptied.emit()
	
	return was_removed

## The [method is_subset] method tells if this [GDDictSet] is a subset of the
## [param other] [GDSet] received. [br]
## If the [param other] argument is [code]null[/code], this method returns
## [code]false[/code].
func is_subset(other: GDSet) -> bool:
	if other == null:
		return false
	
	return other.has_all(self)

## The [method is_superset] method tells if this [GDDictSet] is a superset
## of the [param other] [GDSet] received. [br]
## If the [param other] argument is [code]null[/code], this method returns
## [code]false[/code].
func is_superset(other: GDSet) -> bool:
	if other == null:
		return false
	
	return has_all(other)

## The [method is_disjoint] method tells if this [GDDictSet] is disjoint
## from the [param other] [GDSet] received. [br]
## If the [param other] argument is [code]null[/code], this method returns
## [code]false[/code].
func is_disjoint(other: GDSet) -> bool:
	if other == null:
		return false
	
	var found: bool = false
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		found = found or other.has(i.next())
		
		if found:
			return false
	
	return true

## The [method union] method returns a [GDDictSet] correponding to the
## union of this [GDDictSet] with the [param other] one. [br]
## If the [param other] argument is [code]null[/code], or it doesn't have a
## [GDIterator], this method returns this [GDDictSet] itself.
func union(other: GDSet) -> GDSet:
	if other == null:
		return self
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	if other_i == null:
		return self
	
	var result: GDSet = GDDictSet.new()
	
	while this_i.has_next():
		result.set_element(this_i.next())
		
		if other_i.has_next():
			result.set_element(other_i.next())
	
	while other_i.has_next():
		result.set_element(other_i.next())
	
	return result

## The [method intersection] method returns a [GDDictSet] correponding to the
## intersection of this [GDDictSet] with the [param other] one. [br]
## If the [param other] argument is [code]null[/code], or it doesn't have a
## [GDIterator], this method returns this [GDDictSet] itself.
func intersection(other: GDSet) -> GDSet:
	if other == null:
		return self
	
	var result: GDSet = GDDictSet.new()
	
	var this_i: GDIterator = iterator()
	
	while this_i.has_next():
		var next_element: Variant = this_i.next()
		
		if other.has(next_element):
			result.set_element(next_element)
	
	return result

## The [method difference] method returns a [GDDictSet] correponding to the
## difference of this [GDDictSet] with the [param other] one. [br]
## If the [param other] argument is [code]null[/code], or it doesn't have a
## [GDIterator], this method returns this [GDDictSet] itself.
func difference(other: GDSet) -> GDSet:
	if other == null:
		return self
	
	var result: GDSet = GDDictSet.new()
	
	var this_i: GDIterator = iterator()
	
	while this_i.has_next():
		var next_element: Variant = this_i.next()
		
		if not other.has(next_element):
			result.set_element(next_element)
	
	return result

## The [method symetric_difference] method returns a [GDDictSet]
## correponding to the symetric difference of this [GDDictSet]
## with the [param other] one. [br]
## If the [param other] argument is [code]null[/code], or it doesn't have a
## [GDIterator], this method returns this [GDDictSet] itself.
func symetric_difference(other: GDSet) -> GDSet:
	if other == null:
		return self
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	if other_i == null:
		return self
	
	var result: GDSet = GDDictSet.new()
	
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
