
class_name GDDoublyLinkedDequeIterator
extends GDIterator

var deque: GDDoublyLinkedDeque = null:
	set = set_deque,
	get = get_deque

var pointer: GDDoublyLinkedNode = null:
	set = set_pointer,
	get = get_pointer

var last: GDDoublyLinkedNode = null:
	set = set_last,
	get = get_last

func set_deque(new_deque: GDDoublyLinkedDeque) -> void:
	deque = new_deque

func get_deque() -> GDDoublyLinkedDeque:
	return deque

func set_pointer(new_node: GDDoublyLinkedNode) -> void:
	pointer = new_node

func get_pointer() -> GDDoublyLinkedNode:
	return pointer

func set_last(new_node: GDDoublyLinkedNode) -> void:
	last = new_node

func get_last() -> GDDoublyLinkedNode:
	return last

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
