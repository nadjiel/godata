@icon("res://addons/godata/icons/iterator.svg")
## The [GDIterator] class is the super class that defines the structure
## that a [GDIterator] should have.
## 
## This class is meant to be overwritten in a subclass that defines exactly
## how the iteration of a [GDIterable] should occurr.
## [br][br]
## [b]Author: nadjiel (https://github.com/nadjiel)[/b]
class_name GDIterator
extends Resource

## The [method has_next] method has its signature defined in the [GDIterator]
## class, but should be overwritten by custom [GDIterator]s.
## The purpose of this method is provide a way to know if the iteration
## should stop or not based on if there is a next value to iterate to.
func has_next() -> bool: return false

## The [method next] method should be overwritten by custom [GDIterator]s.
## Its purpose is to provide a way of retrieving the next value in the
## iteration while also incrementing the iteration to the next step.
func next() -> Variant: return null

## The [method remove] method also should be overwritten by custom
## [GDIterator]s.
## The intent of this method is to remove the previous value returned by the
## [method next] method from the data structure that is being iterated upon.
func remove() -> void: pass
