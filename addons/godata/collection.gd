
class_name GDCollection
extends GDIterable

func length() -> int: return 0

func is_empty() -> bool: return false

func add(element: Variant) -> bool: return false

func add_all(elements: GDIterable) -> bool: return false

func has(element: Variant) -> bool: return false

func has_all(elements: GDIterable) -> bool: return false

func remove(element: Variant) -> bool: return false

func remove_all(elements: GDIterable) -> bool: return false

func remove_if(predicate: Callable) -> bool: return false

func clear() -> bool: return false

func equals(other: GDCollection) -> bool: return false

func as_array() -> Array: return []
