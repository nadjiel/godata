
class_name GDSet
extends GDCollection

func is_subset(other: GDSet) -> bool: return false

func is_superset(other: GDSet) -> bool: return false

func is_disjoint(other: GDSet) -> bool: return false

func union(others: GDIterable) -> GDSet: return self

func intersection(others: GDIterable) -> GDSet: return self

func difference(others: GDIterable) -> GDSet: return self

func symetric_difference(others: GDIterable) -> GDSet: return self
