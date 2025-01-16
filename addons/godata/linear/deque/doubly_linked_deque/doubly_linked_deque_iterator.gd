
class_name GDDoublyLinkedDequeIterator
extends GDIterator

var deque: GDDoublyLinkedDeque = null

var pointer: GDDoublyLinkedNode = null

var last: GDDoublyLinkedNode = null

static func create(deque: GDDoublyLinkedDeque) -> GDIterator:
	var iterator := GDDoublyLinkedDequeIterator.new()
	iterator.deque = deque
	iterator.pointer = deque.front
	
	return iterator

func has_next() -> bool:
	return pointer != null

func next() -> Variant:
	var result: Variant = pointer.value
	
	last = pointer
	pointer = pointer.next
	
	return result

func remove() -> void:
	var prelast: GDDoublyLinkedNode = last.previous
	
	if prelast != null:
		prelast.next = pointer
	else:
		deque.front = pointer
	
	last.next = null
	last.previous = null
	
	if deque.is_empty():
		deque.back = null
	else:
		pointer.previous = prelast
