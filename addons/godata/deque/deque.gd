
class_name GDDeque
extends GDCollection

signal inserted(index: int, value: Variant)
signal removed(index: int, value: Variant)
signal updated(index: int, old_value: Variant, new_value: Variant)

func insert_first(element: Variant) -> void: pass

func insert_last(element: Variant) -> void: pass

func get_first() -> Variant: return null

func get_last() -> Variant: return null

func get_element(id: int) -> Variant: return null

func update_first(element: Variant) -> bool: return false

func update_last(element: Variant) -> bool: return false

func remove_first() -> Variant: return null

func remove_last() -> Variant: return null
