
extends GutTest

var Set: GDScript = preload("res://addons/godata/linear/set/dict_set/dict_set.gd")

var gdset: GDSet

var test_array: Array = []

class MockCollection extends GDCollection:
	pass

func before_each() -> void:
	gdset = Set.new()
	test_array = []

func after_all() -> void:
	queue_free()

#region Signal emptied

func test_emptied_is_not_emitted_on_empty_set_cleared() -> void:
	watch_signals(gdset)
	
	gdset.clear()
	
	assert_signal_not_emitted(gdset, "emptied", "Emptied was emitted")

func test_emptied_is_emitted_on_set_cleared() -> void:
	gdset.set_element(1)
	
	watch_signals(gdset)
	
	gdset.clear()
	
	assert_signal_emitted(gdset, "emptied", "Emptied wasn't emitted")

func test_emptied_is_emitted_on_set_cleared_via_removal() -> void:
	gdset.set_element(1)
	
	watch_signals(gdset)
	
	gdset.remove_element(1)
	
	assert_signal_emitted(gdset, "emptied", "Emptied wasn't emitted")

#endregion

#region Signal added

func test_added_is_not_emitted_with_repeated_value_addition() -> void:
	gdset.set_element(1)
	
	watch_signals(gdset)
	
	gdset.set_element(1)
	
	assert_signal_not_emitted(gdset, "added", "Added was emitted")

func test_added_is_emitted_on_value_added() -> void:
	watch_signals(gdset)
	
	gdset.set_element(1)
	
	assert_signal_emitted(gdset, "added", "Added wasn't emitted")

#endregion

#region Signal updated

func test_updated_is_emitted_on_value_added() -> void:
	watch_signals(gdset)
	
	gdset.set_element(1)
	
	assert_signal_emitted(gdset, "updated", [ null, 1 ])

func test_updated_is_emitted_on_value_removed() -> void:
	gdset.set_element(1)
	
	watch_signals(gdset)
	
	gdset.remove_element(1)
	
	assert_signal_emitted(gdset, "updated", [ 1, null ])

#endregion

#region Signal added

func test_removed_is_not_emitted_with_absent_value_deletion() -> void:
	watch_signals(gdset)
	
	gdset.remove()
	
	assert_signal_not_emitted(gdset, "removed", "Removed was emitted")

func test_removed_is_emitted_on_value_removed() -> void:
	gdset.add(1)
	
	watch_signals(gdset)
	
	gdset.remove_element(1)
	
	assert_signal_emitted(gdset, "removed", "Removed wasn't emitted")

#endregion

#region Method iterator

func test_iterator_returns_valid_iterator() -> void:
	assert_not_null(gdset.iterator(), "Iterator returned null")

#endregion

#region Method for_each

func test_for_each_executes_for_every_entry() -> void:
	gdset.for_each(
		func(element: Variant) -> void: test_array.append(element)
	)

	assert_eq(gdset.as_array(), test_array, "For each didn't iterate")

#endregion

#region Method length

func test_length_starts_as_zero() -> void:
	assert_eq(gdset.length(), 0, "Length didn't start as 0")

func test_length_returns_right_size_if_not_empty() -> void:
	gdset.add(1)
	
	assert_eq(gdset.length(), 1, "Length didn't match expected size")

func test_length_returns_right_size_if_empty() -> void:
	gdset.add(1)
	gdset.remove()
	
	assert_eq(gdset.length(), 0, "Length didn't match expected size")

#endregion

#region Method is_empty

func test_is_empty_initially() -> void:
	assert_true(gdset.is_empty(), "Set wasn't empty on start")

func test_is_not_empty_once_added_value() -> void:
	gdset.add(1)
	
	assert_false(gdset.is_empty(), "Set was considered empty with content")

func test_is_empty_once_cleared() -> void:
	gdset.add(1)
	gdset.clear()
	
	assert_true(gdset.is_empty(), "Set wasn't empty once cleared")

#endregion

#region Method add

func test_add_returns_true_on_success() -> void:
	assert_true(gdset.add(1), "Set didn't return true when adding value")

func test_add_returns_false_if_value_already_exists() -> void:
	gdset.add(1)

	assert_false(
		gdset.add(1), "Set didn't return false when adding existing value"
	)

func test_add_saves_value() -> void:
	gdset.add(1)
	
	assert_eq(gdset.get_element(), 1, "Set didn't save added value")

func test_add_saves_value_after_emptied() -> void:
	gdset.add(1)
	gdset.remove()
	gdset.add(2)
	
	assert_eq(gdset.get_element(), 2, "Set didn't save added value")

func test_add_doesnt_save_repeated_values() -> void:
	gdset.add(1)
	gdset.add(1)
	
	assert_eq(gdset.as_array(), [ 1 ], "Set saved repeated values")

#endregion

#region Method get_element

func test_get_element_returns_any_element() -> void:
	gdset.add(1)
	gdset.add(2)
	gdset.add(3)

	assert_between(
		gdset.get_element(),
		1,
		3,
		"Set didn't return any element"
	)

#endregion

#region Method update

func test_update_returns_true_on_success() -> void:
	gdset.add(1)

	assert_true(gdset.update(1), "Set didn't return true when updating value")

func test_update_returns_false_if_value_didnt_exist() -> void:
	assert_false(
		gdset.update(1), "Set didn't return false when updating nonexisting value"
	)

func test_update_saves_value() -> void:
	gdset.update(1)
	
	assert_eq(gdset.get_element(), 1, "Set didn't save updated value")

func test_update_saves_value_after_emptied() -> void:
	gdset.update(1)
	gdset.remove()
	gdset.update(2)
	
	assert_true(gdset.has(2), "Set didn't save updated value")

func test_update_doesnt_save_repeated_values() -> void:
	gdset.update(1)
	gdset.update(1)
	
	assert_eq(gdset.as_array(), [ 1 ], "Set saved repeated values")

#endregion

#region Method remove

func test_remove_returns_null_on_empty_set() -> void:
	assert_null(gdset.remove(), "Remove didn't return null")

func test_remove_returns_resultant_value() -> void:
	gdset.add(1)
	
	assert_eq(gdset.remove(), 1, "Remove didn't return right value")

func test_remove_takes_value_away() -> void:
	gdset.add(1)
	
	gdset.remove()
	
	assert_true(gdset.is_empty(), "Remove didn't take value away")

func test_remove_takes_away_any_value_present() -> void:
	gdset.add(1)
	gdset.add(2)
	
	assert_between(
		gdset.remove(),
		1,
		2,
		"Remove didn't take right value away"
	)

#endregion

#region Method equals

func test_equals_returns_true_with_unordered_set() -> void:
	gdset.add(1)
	gdset.add(2)
	
	assert_true(
		gdset.equals(Set.from_array([ 2, 1 ])),
		"Equal unordered sets didn't match"
	)

func test_equals_returns_false_comparing_with_non_sets() -> void:
	assert_false(
		gdset.equals(MockCollection.new()),
		"Non set matched"
	)

func test_equals_returns_true_with_equivalent_set() -> void:
	gdset.add(1)
	gdset.add(2)
	
	assert_true(
		gdset.equals(Set.from_array([ 1, 2 ])),
		"Equivalent sets didn't match"
	)

#endregion

#region Method as_array

func test_as_array_returns_all_entries_ordered() -> void:
	gdset.add(1)
	gdset.add(2)
	
	assert_eq(
		gdset.as_array(),
		[ 1, 2 ],
		"As_array didn't return all entries"
	)

#endregion

#region Method add_all

func test_add_all_returns_true_on_success() -> void:
	assert_true(
		gdset.add_all(Set.from_array([ 1, 2 ])),
		"Add_all didn't return true on addition"
	)

func test_add_all_saves_values_in_right_order() -> void:
	gdset.add_all(Set.from_array([ 1, 2 ]))
	
	assert_eq(
		gdset.as_array(),
		[ 1, 2 ],
		"Set didn't save values at right order"
	)

func test_add_all_doesnt_save_repeated_values() -> void:
	gdset.add_all(GDLinkedQueue.from_array([ 1, 1, 1 ]))
	
	assert_eq(
		gdset.as_array(),
		[ 1 ],
		"Set saved repeated values"
	)

#endregion

#region Method has

func test_has_returns_true_if_value_is_present() -> void:
	gdset.add(1)
	
	assert_true(gdset.has(1), "Has returned false for existent value")

func test_has_returns_false_if_value_is_absent() -> void:
	assert_false(gdset.has(1), "Has returned true for absent value")

#endregion

#region Method has_all

func test_has_all_returns_false_with_absent_values() -> void:
	gdset.add(1)
	
	assert_false(
		gdset.has_all(Set.from_array([ 1, 2 ])),
		"Has_all returned true even though some values are absent"
	)

func test_has_all_returns_true_with_present_values() -> void:
	gdset.add(1)
	gdset.add(2)
	
	assert_true(
		gdset.has_all(Set.from_array([ 2, 1 ])),
		"Has_all returned false even though all values are present"
	)

#endregion

#region Method clear

func test_clear_returns_true_on_success() -> void:
	gdset.add(1)
	gdset.add(2)
	
	assert_true(gdset.clear(), "Clear didn't return true on success")

func test_clear_returns_false_on_failure() -> void:
	assert_false(gdset.clear(), "Clear didn't return false on failure")

func test_clear_empties_set() -> void:
	gdset.add(1)
	gdset.add(2)
	
	gdset.clear()
	
	assert_true(gdset.is_empty(), "Clear didn't empty gdset")

#endregion

#region Method from_array

func test_from_array_returns_corresponding_set() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	
	assert_eq(
		gdset.as_array(),
		[ 1, 2, 3 ],
		"From array didn't convert properly"
	)

func test_from_array_doesnt_save_repeated_values() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 1 ])
	
	assert_eq(
		gdset.as_array(),
		[ 1, 2 ],
		"From array saved repeated values"
	)

#endregion

#region Method set_element

func test_set_element_saves_value() -> void:
	gdset.set_element(1)
	
	assert_eq(gdset.get_element(), 1, "Set_element didn't save value")

func test_set_element_saves_value_after_emptied() -> void:
	gdset.set_element(1)
	gdset.remove()
	gdset.set_element(2)
	
	assert_eq(gdset.get_element(), 2, "Set_element didn't save value")

func test_set_element_doesnt_save_repeated_values() -> void:
	gdset.set_element(1)
	gdset.set_element(1)
	
	assert_eq(gdset.as_array(), [ 1 ], "Set_element saved repeated values")

#endregion

#region Method remove_element

func test_remove_element_returns_false_on_empty_set() -> void:
	assert_false(gdset.remove_element(1), "Remove_element didn't return false")

func test_remove_element_returns_true_on_success() -> void:
	gdset.add(1)
	
	assert_true(gdset.remove_element(1), "Remove_element didn't return true")

func test_remove_element_takes_value_away() -> void:
	gdset.add(1)
	
	gdset.remove_element(1)
	
	assert_true(gdset.is_empty(), "Remove_element didn't take value away")

func test_remove_takes_away_expected_value() -> void:
	gdset.add(1)
	gdset.add(2)
	
	gdset.remove_element(2)
	
	assert_eq(
		gdset.as_array(),
		[ 1 ],
		"Remove_element didn't take right value away"
	)

#endregion

#region Method is_subset

func test_is_subset_returns_false_for_supersets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2 ])
	
	assert_false(
		gdset.is_subset(gdset2),
		"Is_subset returned true for superset"
	)

func test_is_subset_returns_true_for_subsets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2 ])
	
	assert_true(
		gdset2.is_subset(gdset),
		"Is_subset returned false for subset"
	)

func test_is_subset_returns_true_for_equal_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2, 3 ])
	
	assert_true(
		gdset2.is_subset(gdset),
		"Is_subset returned false for equal sets"
	)

func test_is_subset_returns_false_for_disjoint_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 4, 5, 6 ])
	
	assert_false(
		gdset2.is_subset(gdset),
		"Is_subset returned true for disjoint sets"
	)

#endregion

#region Method is_superset

func test_is_superset_returns_true_for_supersets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2 ])
	
	assert_true(
		gdset.is_superset(gdset2),
		"Is_superset returned false"
	)

func test_is_superset_returns_false_for_subsets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2 ])
	
	assert_false(
		gdset2.is_superset(gdset),
		"Is_superset returned true"
	)

func test_is_superset_returns_true_for_equal_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2, 3 ])
	
	assert_true(
		gdset2.is_superset(gdset),
		"Is_superset returned false"
	)

func test_is_superset_returns_false_for_disjoint_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 4, 5, 6 ])
	
	assert_false(
		gdset2.is_superset(gdset),
		"Is_superset returned true"
	)

#endregion

#region Method is_disjoint

func test_is_disjoint_returns_false_for_supersets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2 ])
	
	assert_false(
		gdset.is_disjoint(gdset2),
		"Is_disjoint returned true"
	)

func test_is_disjoint_returns_false_for_subsets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2 ])
	
	assert_false(
		gdset2.is_disjoint(gdset),
		"Is_disjoint returned true"
	)

func test_is_disjoint_returns_false_for_equal_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2, 3 ])
	
	assert_false(
		gdset2.is_disjoint(gdset),
		"Is_disjoint returned true"
	)

func test_is_disjoint_returns_true_for_disjoint_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 4, 5, 6 ])
	
	assert_true(
		gdset2.is_disjoint(gdset),
		"Is_disjoint returned false"
	)

#endregion

#region Method union

func test_union_adds_two_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 4, 5 ])
	
	var union: GDSet = gdset.union(gdset2)
	
	assert_true(
		union.equals(GDDictSet.from_array([ 1, 2, 3, 4, 5 ])),
		"Union set didn't include all elements"
	)

func test_union_of_equal_sets_same_as_any_of_them() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2, 3 ])
	
	var union: GDSet = gdset.union(gdset2)
	
	assert_true(
		union.equals(gdset) and union.equals(gdset2),
		"Union didn't equal summed sets"
	)

func test_union_ignores_repeated_values() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3, 4, 5 ])
	
	var union: GDSet = gdset.union(gdset2)
	
	assert_true(
		union.equals(GDDictSet.from_array([ 1, 2, 3, 4, 5 ])),
		"Union set included repeated elements"
	)

func test_union_is_commutative() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3, 4, 5 ])
	
	var union1: GDSet = gdset.union(gdset2)
	var union2: GDSet = gdset2.union(gdset)
	
	assert_true(
		union1.equals(union2),
		"Unions didn't equal"
	)

func test_union_results_in_new_set() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3, 4, 5 ])
	
	var union: GDSet = gdset.union(gdset2)
	
	assert_true(
		union != gdset and union != gdset2,
		"Union isn't a new set object"
	)

#endregion

#region Method intersection

func test_intersection_cuts_two_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 2, 1 ])
	
	var intersection: GDSet = gdset.intersection(gdset2)
	
	assert_true(
		intersection.equals(GDDictSet.from_array([ 1, 2 ])),
		"Intersection set didn't include only mutual elements"
	)

func test_intersection_of_disjoint_sets_is_empty() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 4, 5 ])
	
	var intersection: GDSet = gdset.intersection(gdset2)
	
	assert_true(
		intersection.equals(GDDictSet.new()),
		"Intersection wasn't empty"
	)

func test_intersection_ignores_repeated_values() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3 ])
	
	var intersection: GDSet = gdset.intersection(gdset2)
	
	assert_true(
		intersection.equals(GDDictSet.from_array([ 1, 3 ])),
		"Intersection included repeated elements"
	)

func test_intersection_is_commutative() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3, 4, 5 ])
	
	var intersection1: GDSet = gdset.intersection(gdset2)
	var intersection2: GDSet = gdset2.intersection(gdset)
	
	assert_true(
		intersection1.equals(intersection2),
		"Intersections didn't equal"
	)

#endregion

#region Method difference

func test_difference_gives_includes_only_elements_from_first_set() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 2, 1 ])
	
	var difference: GDSet = gdset.difference(gdset2)
	
	assert_true(
		difference.equals(GDDictSet.from_array([ 3 ])),
		"Difference didn't include only first set's elements"
	)

func test_difference_of_equal_sets_is_empty() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2, 3 ])
	
	var difference: GDSet = gdset.difference(gdset2)
	
	assert_true(
		difference.equals(GDDictSet.new()),
		"Difference wasn't empty"
	)

func test_difference_ignores_repeated_values() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3 ])
	
	var difference: GDSet = gdset.difference(gdset2)
	
	assert_true(
		difference.equals(GDDictSet.from_array([ 2 ])),
		"Difference included repeated elements"
	)

func test_difference_is_not_commutative() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3, 4, 5 ])
	
	var difference1: GDSet = gdset.difference(gdset2)
	var difference2: GDSet = gdset2.difference(gdset)
	
	assert_false(
		difference1.equals(difference2),
		"Differences were equal"
	)

#endregion

#region Method symetric_difference

func test_symetric_difference_excludes_intersection() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 2, 1, 4 ])
	
	var symetric_difference: GDSet = gdset.symetric_difference(gdset2)
	
	assert_true(
		symetric_difference.equals(GDDictSet.from_array([ 3, 4 ])),
		"Symetric_difference didn't exclude intersection"
	)

func test_symetric_difference_of_equal_sets_is_empty() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 2, 3 ])
	
	var symetric_difference: GDSet = gdset.symetric_difference(gdset2)
	
	assert_true(
		symetric_difference.equals(GDDictSet.new()),
		"Symetric_difference wasn't empty"
	)

func test_symetric_difference_ignores_repeated_values() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3, 4 ])
	
	var symetric_difference: GDSet = gdset.symetric_difference(gdset2)
	
	assert_true(
		symetric_difference.equals(GDDictSet.from_array([ 2, 4 ])),
		"Symetric_difference included repeated elements"
	)

func test_symetric_difference_is_commutative() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 1, 3, 4, 5 ])
	
	var symetric_difference1: GDSet = gdset.symetric_difference(gdset2)
	var symetric_difference2: GDSet = gdset2.symetric_difference(gdset)
	
	assert_true(
		symetric_difference1.equals(symetric_difference2),
		"Symetric_differences weren't equal"
	)

#endregion

#region Method union_all

func test_union_all_adds_all_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 4, 5 ])
	var gdset3: GDSet = GDDictSet.from_array([ 6, 7 ])
	
	var union: GDSet = gdset.union_all(GDLinkedQueue.from_array(
		[ gdset, gdset2, gdset3 ]
	))
	
	assert_true(
		union.equals(GDDictSet.from_array([ 1, 2, 3, 4, 5, 6, 7 ])),
		"Union didn't include all elements"
	)

#endregion

#region Method intersection_all

func test_intersection_all_gets_common_elements_of_all_sets() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 2, 4, 5 ])
	var gdset3: GDSet = GDDictSet.from_array([ 6, 7, 2 ])
	
	var intersection: GDSet = gdset.intersection_all(GDLinkedQueue.from_array(
		[ gdset, gdset2, gdset3 ]
	))
	
	assert_true(
		intersection.equals(GDDictSet.from_array([ 2 ])),
		"Intersection didn't include only common elements"
	)

#endregion

#region Method difference_all

func test_difference_all_gets_elements_only_from_the_first_set() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 2, 4, 5 ])
	var gdset3: GDSet = GDDictSet.from_array([ 6, 3, 7 ])
	
	var difference: GDSet = gdset.difference_all(GDLinkedQueue.from_array(
		[ gdset2, gdset3 ]
	))
	
	assert_true(
		difference.equals(GDDictSet.from_array([ 1 ])),
		"Difference didn't include only first set's elements"
	)

#endregion

#region Method difference_all

func test_symetric_difference_all_excludes_intersection() -> void:
	gdset = GDDictSet.from_array([ 1, 2, 3 ])
	var gdset2: GDSet = GDDictSet.from_array([ 2, 4, 5 ])
	var gdset3: GDSet = GDDictSet.from_array([ 6, 3, 7 ])
	
	var symetric_difference: GDSet = gdset.symetric_difference_all(GDLinkedQueue.from_array(
		[ gdset2, gdset3 ]
	))
	
	assert_true(
		symetric_difference.equals(GDDictSet.from_array([ 1, 4, 5, 6, 7 ])),
		"Symetric_difference didn't exclude intersection"
	)

#endregion
