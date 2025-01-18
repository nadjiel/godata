
class_name GDSet
extends GDLinear

func set_element(element: Variant) -> void: pass

func remove_element(element: Variant) -> bool: return false

func is_subset(other: GDSet) -> bool: return false

func is_superset(other: GDSet) -> bool: return false

func is_disjoint(other: GDSet) -> bool: return false

func union(other: GDSet) -> GDSet: return null

func intersection(other: GDSet) -> GDSet: return null

func difference(other: GDSet) -> GDSet: return null

func symetric_difference(other: GDSet) -> GDSet: return null
