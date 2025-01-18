@icon("res://addons/godata/icons/collection.svg")
## This class is the base class for the data structures of [code]godata[/code].
##
## The [GDCollection] class brings together the most common methods for data
## structures. Most of those methods just have their signature defined here,
## letting their implementation open for the specific data structure,
## but some of them are implemented here in a generalized way. [br]
## This class inherits from the [GDIterable] class to guarantee that
## objects made from it have the ability to be iterated over in an unified way.
## [br]
## When creating new data structures for the [code]godata[/code] library.
## It is recommended that they extend from this class in order to be easily
## used in contexts where a [GDCollection] is expected. [br]
## Like stated in the [GDIterable] class, this hierarchical structure is
## based on the Collections API from the Java language, hence the [GDCollection]
## name.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b][br]
## [i]Version: 1.0.0[/i]
class_name GDCollection
extends GDIterable

## The [signal emptied] signal should be emitted by implementations of this
## [GDCollection] to notify when they are emptied.
signal emptied()

## The [signal filled] signal should be emitted by implementations of this
## [GDCollection] to notify when they are filled. [br]
## If a [GDCollection] doesn't have a [code]size[/code] limitation,
## then this signal may not be emitted, since they can't be filled.
signal filled()

## The [signal added] signal should be emitted by implementations of this
## [GDCollection] to notify when they have a value added to them. [br]
## When emitted, this signal should pass the new element that was added.
signal added(element: Variant)

## The [signal updated] signal should be emitted by implementations of this
## [GDCollection] to notify when they have a value update. [br]
## When emitted, this signal should pass the old element and
## the new element that were changed.
signal updated(old_element: Variant, new_element: Variant)

## The [signal removed] signal should be emitted by implementations of this
## [GDCollection] to notify when they have a value removed. [br]
## When emitted, this signal should pass the old element that was removed.
signal removed(element: Variant)

## The [method length] method has its signature defined in the [GDCollection]
## class, but should be overwritten by custom [GDCollection] implementations.
## [br]
## The purpose of this method is to provide a way of knowing what is the
## current length (or size) of this [GDCollection].
## With that objective in mind, the return value is an
## [code]int[/code] with the current size.
func length() -> int: return 0

## The [method is_empty] method should be overwritten
## by custom [GDCollection] implementations. [br]
## The purpose of this method is to provide a way of knowing if the
## [GDCollection] is currently empty.
func is_empty() -> bool: return false

## The [method is_full] method should be overwritten
## by custom [GDCollection] implementations. [br]
## The purpose of this method is to provide a way of knowing if the
## [GDCollection] is currently full.
func is_full() -> bool: return false

## The [method add] method is supposed to be overwritten
## by concrete [GDCollection] implementations. [br]
## When called, this method should perform the default [code]add[/code]
## operation for this [GDCollection], which, in the case of [GDStack]s
## would be adding a new element to the top, and, in the case of
## [GDQueue]s would be adding a new element to the back. [br]
## For other data structures, the default place of addition may vary. [br]
## When done, this method should return a [code]bool[/code] indicating
## if the addition was successful or not.
func add(element: Variant) -> bool: return false

## The [method get_element] method is supposed to be overwritten
## by concrete [GDCollection] implementations. [br]
## When called, this method should return the expected element
## for this [GDCollection], which, in the case of [GDStack]s
## would be the element in the top, and, in the case of
## [GDQueue]s would be the element in the front. [br]
## For other data structures, the default place from where
## the element is got may vary.
func get_element() -> Variant: return null

## The [method update] method is supposed to be overwritten
## by concrete [GDCollection] implementations. [br]
## Such method expects an [param element], which should be used as the
## new value instead of an old one in a certain spot in the [GDCollection].
## Where such spot is located depends on the data structure,
## e.g.: in the case of [GDStack]s that
## would be the element of the top, and, in the case of
## [GDQueue]s it would be the element of the front. [br]
## For other data structures, the default place of the update may vary. [br]
## When done, this method should return a [code]bool[/code] indicating
## if the operation was successful or not.
func update(element: Variant) -> bool: return false

## The [method remove] method is supposed to be overwritten
## by concrete [GDCollection] implementations. [br]
## When called, this method should perform the default [code]removal[/code]
## operation for this [GDCollection], which, in the case of [GDStack]s
## would be removing an element from the top, and, in the case of
## [GDQueue]s would be removing an element from the front. [br]
## For other data structures, the default place of removal may vary. [br]
## When finished, this method should return the element that it removed, or
## [code]null[/code], if no removal occurred. [br]
## In that case an error or warning might also be pushed,
## but that depends on the implementation.
func remove() -> Variant: return null

## The [method equals] method should be overwritten
## in order for there to be a convenient way of
## knowing if this [GDCollection] is equal to another
## taking their elements in account, and not their memory addresses.
func equals(other: GDCollection) -> bool: return false

## The [method as_array] method should be overwritten for providing a way
## of recovering a version of this [GDCollection] converted into an [Array].
func as_array() -> Array: return []

## The [method push_no_iterator_error] method pushes an error warning that
## an iteration attempt was tried on a [GDCollection] without an [GDIterator].
func push_no_iterator_error() -> void:
	push_error("Tried to iterate Collection without Iterator")

## The [method add_all] method receives a [GDIterator] through which it
## runs over while adding each one of its elements, using the [method add]
## method, in this [GDCollection]. [br]
## Since this method uses the [method add] method, it will only work if
## an implementation is provided to that method. [br]
## At the end of its execution, this method returns a [code]bool[/code]
## indicating if all of the [param elements] were added.
func add_all(elements: GDIterable) -> bool:
	var i: GDIterator = elements.iterator()
	
	var added_all: bool = true
	
	while i.has_next():
		added_all = added_all and add(i.next())
	
	return added_all

## The [method has] method receives an [param element] and, using
## the [method iterator] method, runs through each entry of
## this [GDCollection] looking for an element that matches (comparison
## is made using the [code]==[/code] operator). [br]
## Since this method uses the [method iterator] method, it will only work if
## an implementation is provided to that method, otherwise, it
## will always return [code]false[/code] and also push an error
## warning that an iteration was tried even though there's no iterator. [br]
## At the end of its execution, this method returns a [code]bool[/code]
## indicating if the [param element] was found.
func has(element: Variant) -> bool:
	var found: bool = false
	
	var i: GDIterator = iterator()

	if i == null:
		push_no_iterator_error()
		return false
	
	while i.has_next():
		found = found or (i.next() == element)
		
		if found:
			break
	
	return found

## The [method has_all] method receives a [GDIterable] through which it
## runs over while testing each one of its elements, using the [method has]
## method, to see if they are present in this [GDCollection]. [br]
## This method only works if the [param elements] [GDIterable] has a valid
## [GDIterator], otherwise, it will always return [code]false[/code] and also
## push an error warning that an iteration was tried even though there's
## no iterator. [br]
## At the end of its execution, this method returns a [code]bool[/code]
## indicating if all of the [param elements] were found.
func has_all(elements: GDIterable) -> bool:
	var found: bool = true
	
	var i: GDIterator = elements.iterator()
	
	if i == null:
		push_no_iterator_error()
		return false

	while i.has_next():
		found = found and has(i.next())
		
		if not found:
			break
	
	return found

## The [method clear] method uses the [method iterator] method to run over
## the elements of this [GDCollection] while removing each one. [br]
## Since this method uses the [method iterator] method, it will only work
## if the it is implemented, otherwise, it will always return
## [code]false[/code] and also push an error warning that an
## iteration was tried even though there's no iterator. [br]
## To check if the operation was successful, the [method is_empty] method
## is also used, so if it is not implemented the behavior will be
## unwanted. [br]
## At the end of its execution, this method returns a [code]bool[/code]
## indicating if the operation was successful and also emits the
## [signal emptied] signal, in that case. [br]
func clear() -> bool:
	if is_empty():
		return false
	
	var i: GDIterator = iterator()
	
	if i == null:
		push_no_iterator_error()
		return false

	while i.has_next():
		i.next()
		i.remove()
	
	if is_empty():
		emptied.emit()
		return true
	
	return false
