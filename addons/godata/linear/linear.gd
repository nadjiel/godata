@icon("res://addons/godata/icons/linear.svg")
## This class is the base class for the linear data structures
## of [code]godata[/code].
##
## The [GDLinear] class is meant to be extended by data structures
## that have a linear structure, such as [GDQueue]s, [GDStack]s, and [GDDeque]s,
## so that they can be used in similar contexts through polymorphism. [br]
## Besides, this class also provides some common functionality to inheriting
## data structures.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b][br]
## [i]Version: 1.0.0[/i]
class_name GDLinear
extends GDCollection

## The [method from_array] method is a static method should be overwritten
## in order to provide a straightforward way to convert [Array]s into
## a specific implementation of [GDLinear] data structure.
static func from_array(array: Array) -> GDLinear: return null

## The [method equals] method receives an [param other] [GDCollection] and
## tries to iterate over it, while also iterating over itself,
## testing if they both match all of their elements. [br]
## If both [GDCollection]s don't have the same size, this method returns
## [code]false[/code]. It also does so if at least one of their elements
## don't match (using the [code]==[/code] operator). [br]
## If the [param other] [GDCollection] isn't a [GDLinear] collection,
## this method also returns [code]false[/code]. [br]
## Since this method needs to iterate over both [GDCollection]s, if one of
## them doesn't implement the [method GDCollection.iterator] method, it will
## always return [code]false[/code], pushing an error warning that it tried
## to execute an iteration without having an [GDIterator].
func equals(other: GDCollection) -> bool:
	if not other is GDLinear:
		return false
	
	var this_i: GDIterator = iterator()
	var other_i: GDIterator = other.iterator()
	
	if this_i == null or other_i == null:
		return false

	while this_i.has_next():
		if not other_i.has_next():
			return false
		
		var this_value: Variant = this_i.next()
		var other_value: Variant = other_i.next()
		
		if this_value != other_value:
			return false
	
	if other_i.has_next():
		return false
	
	return true

## The [method as_array] method converts this [GDLinear] collection into
## an [Array]. For that, it iterates over this [GDCollection],
## storing all elements in an [Array] and, in the end, returns that
## array. [br]
## Since this method needs to iterate over this [GDCollection], if it
## doesn't implement the [method GDCollection.iterator] method, it will
## always return an empty [Array], pushing an error warning that it tried
## to execute an iteration without having an [GDIterator].
func as_array() -> Array:
	var result: Array = []
	
	var i: GDIterator = iterator()
	
	if i == null:
		return result
	
	while i.has_next():
		result.push_back(i.next())
	
	return result
