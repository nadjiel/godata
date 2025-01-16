
class_name GDLinkedQueueIterator
extends GDIterator

var queue: GDLinkedQueue = null:
	set = set_queue,
	get = get_queue

var pointer: GDLinkedNode = null:
	set = set_pointer,
	get = get_pointer

var last: GDLinkedNode = null:
	set = set_last,
	get = get_last

var prelast: GDLinkedNode = null:
	set = set_prelast,
	get = get_prelast

func set_queue(new_queue: GDLinkedQueue) -> void:
	queue = new_queue

func get_queue() -> GDLinkedQueue:
	return queue

func set_pointer(new_node: GDLinkedNode) -> void:
	pointer = new_node

func get_pointer() -> GDLinkedNode:
	return pointer

func set_last(new_node: GDLinkedNode) -> void:
	last = new_node

func get_last() -> GDLinkedNode:
	return last

func set_prelast(new_node: GDLinkedNode) -> void:
	last = new_node

func get_prelast() -> GDLinkedNode:
	return last

static func create(queue: GDLinkedQueue) -> GDIterator:
	var iterator := GDLinkedQueueIterator.new()
	iterator.queue = queue
	iterator.pointer = queue.front
	
	return iterator

func has_next() -> bool:
	return pointer != null

func next() -> Variant:
	var result: Variant = pointer.value
	
	prelast = last
	last = pointer
	pointer = pointer.next
	
	return result

func remove() -> void:
	if prelast != null:
		prelast.next = last.next
	
	last.next = null
	queue.front = pointer
	
	if queue.is_empty():
		queue.back = null
