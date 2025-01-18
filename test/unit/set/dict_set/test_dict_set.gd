
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
