
class_name GDIterable
extends Resource

func iterator() -> GDIterator: return null

func for_each(action: Callable) -> void:
	var iterator: GDIterator = iterator()
	
	while iterator.has_next():
		action.call(iterator.next())
