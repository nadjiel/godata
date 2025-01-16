
class_name GDDoublyLinkedDeque
extends GDDeque

var front: GDDoublyLinkedNode = null

var back: GDDoublyLinkedNode = null

static func from_array(array: Array) -> GDLinear:
	var deque: GDDeque = GDDoublyLinkedDeque.new()
	
	for element: Variant in array:
		deque.add(element)
	
	return deque

func iterator() -> GDIterator:
	return GDDoublyLinkedDequeIterator.create(self)

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
	var new_node := GDDoublyLinkedNode.create(element)
	
	if is_empty():
		front = new_node
		back = front
	else:
		back.next = new_node
		new_node.previous = back
		
		back = new_node
	
	return true

func add_front(element: Variant) -> bool:
	var new_node := GDDoublyLinkedNode.create(element)
	
	if is_empty():
		front = new_node
		back = front
	else:
		front.previous = new_node
		new_node.next = front
		
		front = new_node
	
	return true

func add_back(element: Variant) -> bool:
	return add(element)

func get_element() -> Variant:
	if front == null:
		return null
	
	return front.value

func get_element_front() -> Variant:
	return get_element()

func get_element_back() -> Variant:
	if back == null:
		return null
	
	return back.value

func update(element: Variant) -> bool:
	if is_empty():
		return false
	
	front.value = element
	
	return true

func update_front(element: Variant) -> bool:
	return update(element)

func update_back(element: Variant) -> bool:
	if back == null:
		return false
	
	back.value = element
	
	return true

func remove() -> Variant:
	if is_empty():
		push_error("Tried removing from empty Deque")
		return null
	
	var old_node: GDDoublyLinkedNode = front
	
	front = front.next
	
	if front != null:
		front.previous = null
	
	old_node.next = null
	
	if is_empty():
		back = null
	
	return old_node.value

func remove_front() -> Variant:
	return remove()

func remove_back() -> Variant:
	if is_empty():
		push_error("Tried removing from empty Deque")
		return null
	
	var old_node: GDDoublyLinkedNode = back
	
	back = back.previous
	
	if back != null:
		back.next = null
	
	old_node.previous = null
	
	if is_empty():
		front = null
	
	return old_node.value
