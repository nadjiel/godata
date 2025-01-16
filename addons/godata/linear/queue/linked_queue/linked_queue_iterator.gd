
class_name GDLinkedQueueIterator
extends GDIterator

var queue: GDLinkedQueue = null

var pointer: GDLinkedNode = null

var last: GDLinkedNode = null

var prelast: GDLinkedNode = null

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
