
extends GutTest

var Deque: GDScript = preload("res://addons/godata/linear/deque/doubly_linked_deque/doubly_linked_deque.gd")

var deque: GDDeque

class MockCollection extends GDCollection:
	pass

func before_each() -> void:
	deque = Deque.new()

func after_all() -> void:
	queue_free()

#region Method length

func test_length_starts_as_zero() -> void:
	assert_eq(deque.length(), 0, "Length didn't start as 0")

func test_length_returns_right_size_if_not_empty() -> void:
	deque.add(1)
	
	assert_eq(deque.length(), 1, "Length didn't match expected size")

func test_length_returns_right_size_if_empty() -> void:
	deque.add(1)
	deque.remove()
	
	assert_eq(deque.length(), 0, "Length didn't match expected size")

#endregion

#region Method is_empty

func test_is_empty_initially() -> void:
	assert_true(deque.is_empty(), "Deque wasn't empty on start")

func test_is_not_empty_once_added_value() -> void:
	deque.add(1)
	
	assert_false(deque.is_empty(), "Deque was considered empty with content")

func test_is_empty_once_cleared() -> void:
	deque.add(1)
	deque.clear()
	
	assert_true(deque.is_empty(), "Deque wasn't empty once cleared")

#endregion

#region Method add

func test_add_returns_true_on_success() -> void:
	assert_true(deque.add(1), "Deque didn't return true when adding value")

func test_add_saves_value() -> void:
	deque.add(1)
	
	assert_eq(deque.get_element(), 1, "Deque didn't save added value")

func test_add_saves_value_after_emptied() -> void:
	deque.add(1)
	deque.remove()
	deque.add(2)
	
	assert_eq(deque.get_element(), 2, "Deque didn't save added value")

func test_add_saves_values_to_back() -> void:
	deque.add(1)
	deque.add(2)
	
	assert_eq(
		deque.as_array(),
		[ 1, 2 ],
		"Deque didn't save values at right spot"
	)

#endregion

#region Method add_all

func test_add_all_returns_true_on_success() -> void:
	assert_true(
		deque.add_all(Deque.from_array([ 1, 2 ])),
		"Add_all didn't return true on addition"
	)

func test_add_all_saves_values_in_right_order() -> void:
	deque.add_all(Deque.from_array([ 1, 2 ]))
	
	assert_true(
		deque.equals(Deque.from_array([ 1, 2 ])),
		"Deque didn't save values at right order"
	)

#endregion

#region Method has

func test_has_returns_true_if_value_is_present() -> void:
	deque.add(1)
	
	assert_true(deque.has(1), "Has returned false for existent value")

func test_has_returns_false_if_value_is_absent() -> void:
	assert_false(deque.has(1), "Has returned true for absent value")

#endregion

#region Method has_all

func test_has_all_returns_false_with_absent_values() -> void:
	deque.add(1)
	
	assert_false(
		deque.has_all(Deque.from_array([ 1, 2 ])),
		"Has_all returned true even though some values are absent"
	)

func test_has_all_returns_true_with_present_values() -> void:
	deque.add(1)
	deque.add(2)
	
	assert_true(
		deque.has_all(Deque.from_array([ 2, 1 ])),
		"Has_all returned false even though all values are present"
	)

#endregion

#region Method remove

func test_remove_returns_null_on_empty_deque() -> void:
	assert_null(deque.remove(), "Remove didn't return null")

func test_remove_returns_resultant_value() -> void:
	deque.add(1)
	
	assert_eq(deque.remove(), 1, "Remove didn't return right value")

func test_remove_takes_value_away() -> void:
	deque.add(1)
	
	deque.remove()
	
	assert_true(deque.is_empty(), "Remove didn't take value away")

func test_remove_takes_away_right_value() -> void:
	deque.add(1)
	deque.add(2)
	
	assert_eq(deque.remove(), 1, "Remove didn't take right value away")

#endregion

#region Method clear

func test_clear_returns_true_on_success() -> void:
	deque.add(1)
	deque.add(2)
	
	assert_true(deque.clear(), "Clear didn't return true on success")

func test_clear_returns_false_on_failure() -> void:
	assert_false(deque.clear(), "Clear didn't return false on failure")

func test_clear_empties_deque() -> void:
	deque.add(1)
	deque.add(2)
	
	deque.clear()
	
	assert_true(deque.is_empty(), "Clear didn't empty deque")

#endregion

#region Method equals

func test_equals_returns_false_with_unordered_deque() -> void:
	deque.add(1)
	deque.add(2)
	
	assert_false(
		deque.equals(Deque.from_array([ 2, 1 ])),
		"Different deques matched"
	)

func test_equals_returns_false_comparing_with_non_deques() -> void:
	assert_false(
		deque.equals(MockCollection.new()),
		"Non deque matched"
	)

func test_equals_returns_true_with_equivalent_deque() -> void:
	deque.add(1)
	deque.add(2)
	
	assert_true(
		deque.equals(Deque.from_array([ 1, 2 ])),
		"Equivalent deques didn't match"
	)

#endregion
