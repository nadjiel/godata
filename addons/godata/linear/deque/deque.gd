
class_name GDDeque
extends GDLinear

signal added_front(element: Variant)

signal added_back(element: Variant)

signal updated_front(old_element: Variant, new_element: Variant)

signal updated_back(old_element: Variant, new_element: Variant)

signal removed_front(element: Variant)

signal removed_back(element: Variant)

func add_front(element: Variant) -> bool: return false

func add_back(element: Variant) -> bool: return false

func get_element_front() -> Variant: return null

func get_element_back() -> Variant: return null

func update_front(element: Variant) -> bool: return false

func update_back(element: Variant) -> bool: return false

func remove_front() -> Variant: return null

func remove_back() -> Variant: return null
