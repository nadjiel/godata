
extends GutTest

var Stack: GDScript = preload("res://addons/godata/linear/stack/stack.gd")

var stack: GDStack

class MockCollection extends GDCollection:
	pass

func before_each() -> void:
	stack = Stack.new()

func after_all() -> void:
	queue_free()

#region Method length

func test_length_starts_as_zero() -> void:
	assert_eq(stack.length(), 0, "Length didn't start as 0")

func test_length_returns_right_size_if_not_empty() -> void:
	stack.add(1)
	
	assert_eq(stack.length(), 1, "Length didn't match expected size")

func test_length_returns_right_size_if_empty() -> void:
	stack.add(1)
	stack.remove()
	
	assert_eq(stack.length(), 0, "Length didn't match expected size")

#endregion

#region Method is_empty

func test_is_empty_initially() -> void:
	assert_true(stack.is_empty(), "Stack wasn't empty on start")

func test_is_not_empty_once_added_value() -> void:
	stack.add(1)
	
	assert_false(stack.is_empty(), "Stack was considered empty with content")

func test_is_empty_once_cleared() -> void:
	stack.add(1)
	stack.clear()
	
	assert_true(stack.is_empty(), "Stack wasn't empty once cleared")

#endregion

#region Method add

func test_add_returns_true_on_success() -> void:
	assert_true(stack.add(1), "Stack didn't return true when adding value")

func test_add_saves_value() -> void:
	stack.add(1)
	
	assert_eq(stack.as_array(), [ 1 ], "Stack didn't save added value")

func test_add_saves_values_to_top() -> void:
	stack.add(1)
	stack.add(2)
	
	assert_eq(
		stack.as_array(),
		[ 2, 1 ],
		"Stack didn't save values at right spot"
	)

#endregion

#region Method add_all

func test_add_all_returns_true_on_success() -> void:
	assert_true(
		stack.add_all(Stack.from_array([ 1, 2 ])),
		"Add_all didn't return true on addition"
	)

func test_add_all_saves_values_in_right_order() -> void:
	stack.add_all(Stack.from_array([ 1, 2 ]))
	
	assert_eq(
		stack.as_array(),
		[ 2, 1 ],
		"Stack didn't save values at right order"
	)

#endregion

#region Method has

func test_has_returns_true_if_value_is_present() -> void:
	stack.add(1)
	
	assert_true(stack.has(1), "Has returned false for existent value")

func test_has_returns_false_if_value_is_absent() -> void:
	assert_false(stack.has(1), "Has returned true for absent value")

#endregion

#region Method has_all

func test_has_all_returns_false_with_absent_values() -> void:
	stack.add(1)
	
	assert_false(
		stack.has_all(Stack.from_array([ 1, 2 ])),
		"Has_all returned true even though some values are absent"
	)

func test_has_all_returns_true_with_present_values() -> void:
	stack.add(1)
	stack.add(2)
	
	assert_true(
		stack.has_all(Stack.from_array([ 2, 1 ])),
		"Has_all returned false even though all values are present"
	)

#endregion

#region Method remove

func test_remove_returns_resultant_value() -> void:
	stack.add(1)
	
	assert_eq(stack.remove(), 1, "Remove didn't return right value")

func test_remove_takes_value_away() -> void:
	stack.add(1)
	
	assert_true(stack.is_empty(), "Remove didn't take value away")

func test_remove_takes_away_right_value() -> void:
	stack.add(1)
	stack.add(2)
	
	assert_eq(stack.remove(), 2, "Remove didn't take right value away")

#endregion

#region Method clear

func test_clear_returns_true_on_success() -> void:
	stack.add(1)
	stack.add(2)
	
	assert_true(stack.clear(), "Clear didn't return true on success")

func test_clear_returns_false_on_failure() -> void:
	assert_false(stack.clear(), "Clear didn't return false on failure")

func test_clear_empties_stack() -> void:
	stack.add(1)
	stack.add(2)
	
	stack.clear()
	
	assert_true(stack.is_empty(), "Clear didn't empty stack")

#endregion

#region Method equals

func test_equals_returns_false_with_unordered_stack() -> void:
	stack.add(1)
	stack.add(2)
	
	assert_false(
		stack.equals(Stack.from_array([ 2, 1 ])),
		"Different stacks matched"
	)

func test_equals_returns_false_comparing_with_non_stacks() -> void:
	assert_false(
		stack.equals(MockCollection.new()),
		"Non stack matched"
	)

func test_equals_returns_true_with_equivalent_stack() -> void:
	stack.add(1)
	stack.add(2)
	
	assert_true(
		stack.equals(GDStack.from_array([ 1, 2 ])),
		"Equivalent stacks didn't match"
	)

#endregion
