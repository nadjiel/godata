@icon("res://addons/godata/icons/set.svg")
## This class is the superclass for implementations of Sets
## in the [code]godata[/code] library.
##
## The [GDSet] class provides the common interface to inheriting the Sets
## that inherit it. Besides, this class also provides default implementation
## to some methods out of the box.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b][br]
## [i]Version: 1.0.0[/i]
class_name GDSet
extends GDLinear

## The [method set_element] method is supposed to be overwritten
## by concrete [GDSet] implementations. [br]
## When called, this method should perform the addition of the received
## [param element] to this [GDSet], if such element isn't already added.
func set_element(element: Variant) -> void: pass

## The [method remove_element] method is supposed to be overwritten
## by concrete [GDSet] implementations. [br]
## When called, this method should perform the removal of the received
## [param element] from this [GDSet]. [br]
## This method should return a [code]bool[/code] indicating if the
## removal could occur.
func remove_element(element: Variant) -> bool: return false

## The [method is_subset] method should be overwritten
## by concrete [GDSet] implementations. [br]
## This method should provide a way of testing if this [GDSet] is contained
## by the [param other] provided [GDSet], returning
## the result as a [code]bool[/code].
func is_subset(other: GDSet) -> bool: return false

## The [method is_superset] method should be overwritten
## by concrete [GDSet] implementations. [br]
## This method should provide a way of testing if this [GDSet] contains
## the [param other] provided [GDSet], returning
## the result as a [code]bool[/code].
func is_superset(other: GDSet) -> bool: return false

## The [method is_disjoint] method should be overwritten
## by concrete [GDSet] implementations. [br]
## This method should provide a way of testing if this [GDSet] is disjoint
## of the [param other] provided [GDSet], returning
## the result as a [code]bool[/code].
func is_disjoint(other: GDSet) -> bool: return false

## The [method union] method should be defined
## by [GDSet] implementations inheriting from this class. [br]
## This method should return another [GDSet] that is the result of
## the union between this [GDSet] and the [param other] [GDSet] received.
func union(other: GDSet) -> GDSet: return null

## The [method intersection] method should be defined
## by [GDSet] implementations inheriting from this class. [br]
## This method should return another [GDSet] that is the result of
## the intersection between this [GDSet] and the [param other] [GDSet] received.
func intersection(other: GDSet) -> GDSet: return null

## The [method difference] method should be defined
## by [GDSet] implementations inheriting from this class. [br]
## This method should return another [GDSet] that is the result of
## the difference between this [GDSet] and the [param other] [GDSet] received.
func difference(other: GDSet) -> GDSet: return null

## The [method symetric_difference] method should be defined
## by [GDSet] implementations inheriting from this class. [br]
## This method should return another [GDSet] that is the result of
## the symetric_difference between this [GDSet] and the
## [param other] [GDSet] received.
func symetric_difference(other: GDSet) -> GDSet: return null

## The [method union_all] method receives a [GDIterable] through which it
## runs over in order to realize the union of this [GDSet] with all
## [GDSet]s that it contains. [br]
## For that, this method uses the [method union] method, hence, it
## will only work if an implementation is provided to that method. [br]
## At the end of its execution, this method returns the resultant [GDSet].
## If something goes wrong, though, like the [param others] argument being
## [code]null[/code] or it not having an [GDIterator], this method may
## return this [GDSet] itself.
func union_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	if others == null:
		return result
	
	var i: GDIterator = others.iterator()
	
	if i == null:
		return result
	
	while i.has_next():
		result = result.union(i.next())
	
	return result

## The [method intersection_all] method receives a [GDIterable] through which it
## runs over in order to realize the intersection of this [GDSet] with all
## [GDSet]s that it contains. [br]
## For that, this method uses the [method intersection] method, hence, it
## will only work if an implementation is provided to that method. [br]
## At the end of its execution, this method returns the resultant [GDSet].
## If something goes wrong, though, like the [param others] argument being
## [code]null[/code] or it not having an [GDIterator], this method may
## return this [GDSet] itself.
func intersection_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	if others == null:
		return result
	
	var i: GDIterator = others.iterator()
	
	if i == null:
		return result
	
	while i.has_next():
		result = result.intersection(i.next())
	
	return result

## The [method difference_all] method receives a [GDIterable] through which it
## runs over in order to realize the difference of this [GDSet] with all
## [GDSet]s that it contains. [br]
## For that, this method uses the [method difference] method, hence, it
## will only work if an implementation is provided to that method. [br]
## At the end of its execution, this method returns the resultant [GDSet].
## If something goes wrong, though, like the [param others] argument being
## [code]null[/code] or it not having an [GDIterator], this method may
## return this [GDSet] itself.
func difference_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	if others == null:
		return result
	
	var i: GDIterator = others.iterator()
	
	if i == null:
		return result
	
	while i.has_next():
		result = result.difference(i.next())
	
	return result

## The [method symetric_difference_all] method receives a [GDIterable]
## through which it runs over in order to realize the
## symetric_difference of this [GDSet] with all
## [GDSet]s that it contains. [br]
## For that, this method uses the [method symetric_difference] method, hence, it
## will only work if an implementation is provided to that method. [br]
## At the end of its execution, this method returns the resultant [GDSet].
## If something goes wrong, though, like the [param others] argument being
## [code]null[/code] or it not having an [GDIterator], this method may
## return this [GDSet] itself.
func symetric_difference_all(others: GDIterable) -> GDSet:
	var result: GDSet = self
	
	if others == null:
		return result
	
	var i: GDIterator = others.iterator()
	
	if i == null:
		return result
	
	while i.has_next():
		result = result.symetric_difference(i.next())
	
	return result
