@icon("res://addons/godata/icons/iterable.svg")
## This class defines an object that can be iterated
## over with the use of a [GDIterator].
##
## The [GDIterable] class is the uppermost class in the hierarchy of the
## [code]godata[/code] library. Such hierarchy works in a similar fashion
## to how the Collections Framework in Java is structured. [br]
## The data structures of the [code]godata[/code] library generally
## extend from this [GDIterable] in order to allow iterations to be
## performed over them. [br]
## This class extends from [Resource] to take advantage of its memory
## management features and also to allow users to easily store the
## data structures they create with this library.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b]
class_name GDIterable
extends Resource

## The [method iterator] method has its signature defined in the
## [GDIterable] class, but should be overwritten by implemented data structures
## so that it can return a custom [GDIterator] that can iterate over them.
func iterator() -> GDIterator: return null

## The [method for_each] method accepts a [Callable] and calls it for each
## element of the data structure that has this method. [br]
## The iteration is performed in the order that the [GDIterator] (returned
## by the [method iterator] method) defines. [br]
## The [Callable] that this method accepts is supposed to expect each element
## of this data structure per call.
func for_each(action: Callable) -> void:
	var iterator: GDIterator = iterator()
	
	while iterator.has_next():
		action.call(iterator.next())
