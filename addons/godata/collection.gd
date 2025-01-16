
class_name GDCollection
extends GDIterable

func length() -> int: return 0

func is_empty() -> bool: return false

func is_full() -> bool: return false

func add(element: Variant) -> bool: return false

func add_all(elements: GDIterable) -> bool: return false

func has(element: Variant) -> bool: return false

func has_all(elements: GDIterable) -> bool: return false

func remove() -> Variant: return null

func clear() -> bool: return false

func equals(other: GDCollection) -> bool: return false

func as_array() -> Array: return []
