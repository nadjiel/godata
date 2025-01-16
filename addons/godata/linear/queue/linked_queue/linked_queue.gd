
class_name GDLinkedQueue
extends GDQueue

var back: GDLinkedNode = null

var front: GDLinkedNode = null

static func from_array(array: Array) -> GDLinear:
	var queue: GDQueue = GDLinkedQueue.new()
	
	for element: Variant in array:
		queue.add(element)
	
	return queue

func iterator() -> GDIterator:
	return GDLinkedQueueIterator.create(self)

func length() -> int:
	var counter: int = 0
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		counter += 1
		
		i.next()
	
	return counter

func is_empty() -> bool:
	return front == null

func is_full() -> bool:
	return false

func add(element: Variant) -> bool:
	var new_node := GDLinkedNode.create(element)
	
	if is_empty():
		front = new_node
		back = front
	else:
		back.next = new_node
		back = new_node
	
	return true

func add_all(elements: GDIterable) -> bool:
	var i: GDIterator = elements.iterator()
	
	var added_all: bool = true
	
	while i.has_next():
		added_all = added_all and add(i.next())
	
	return added_all

func has(element: Variant) -> bool:
	var found: bool = false
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		found = found or (i.next() == element)
		
		if found:
			break
	
	return found

func has_all(elements: GDIterable) -> bool:
	var found: bool = true
	
	var i: GDIterator = elements.iterator()
	
	while i.has_next():
		found = found and has(i.next())
		
		if not found:
			break
	
	return found

func remove() -> Variant:
	var old_node: GDLinkedNode = front
	
	front = front.next
	old_node.next = null
	
	return old_node.value

func clear() -> bool:
	if is_empty():
		return false
	
	var i: GDIterator = iterator()
	
	while i.has_next():
		i.next()
		i.remove()
	
	return true
