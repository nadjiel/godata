
extends GutTest

var Queue: GDScript = preload("res://addons/godata/queue/queue.gd")

var queue: GDQueue

class MockCollection extends GDCollection:
	pass

func before_each() -> void:
	queue = Queue.new()

func after_all() -> void:
	queue_free()

#region Method length

func test_length_starts_as_zero() -> void:
	assert_eq(queue.length(), 0, "Length didn't start as 0")

func test_length_returns_right_size_if_not_empty() -> void:
	queue.add(1)
	
	assert_eq(queue.length(), 1, "Length didn't match expected size")

func test_length_returns_right_size_if_empty() -> void:
	queue.add(1)
	queue.remove()
	
	assert_eq(queue.length(), 0, "Length didn't match expected size")

#endregion

#region Method is_empty

func test_is_empty_initially() -> void:
	assert_true(queue.is_empty(), "Queue wasn't empty on start")

func test_is_not_empty_once_added_value() -> void:
	queue.add(1)
	
	assert_false(queue.is_empty(), "Queue was considered empty with content")

func test_is_empty_once_cleared() -> void:
	queue.add(1)
	queue.clear()
	
	assert_true(queue.is_empty(), "Queue wasn't empty once cleared")

#endregion

#region Method add

func test_add_returns_true_on_success() -> void:
	assert_true(queue.add(1), "Queue didn't return true when adding value")

func test_add_saves_value() -> void:
	queue.add(1)
	
	assert_eq(queue.as_array().back(), 1, "Queue didn't save added value")

func test_add_saves_values_to_end() -> void:
	queue.add(1)
	queue.add(2)
	
	assert_eq(
		queue.as_array(),
		[ 2, 1 ],
		"Queue didn't save values at right spot"
	)

#endregion

#region Method add_all

func test_add_all_returns_true_on_success() -> void:
	assert_true(
		queue.add_all(Queue.from_array([ 1, 2 ])),
		"Add_all didn't return true on addition"
	)

func test_add_all_saves_values_in_right_order() -> void:
	queue.add_all(Queue.from_array([ 1, 2 ]))
	
	assert_eq(
		queue.as_array(),
		[ 2, 1 ],
		"Queue didn't save values at right order"
	)

#endregion

#region Method has

func test_has_returns_true_if_value_is_present() -> void:
	queue.add(1)
	
	assert_true(queue.has(1), "Has returned false for existent value")

func test_has_returns_false_if_value_is_absent() -> void:
	assert_false(queue.has(1), "Has returned true for absent value")

#endregion

#region Method has_all

func test_has_all_returns_false_with_absent_values() -> void:
	queue.add(1)
	
	assert_false(
		queue.has_all(Queue.from_array([ 1, 2 ])),
		"Has_all returned true even though some values are absent"
	)

func test_has_all_returns_true_with_present_values() -> void:
	queue.add(1)
	queue.add(2)
	
	assert_true(
		queue.has_all(Queue.from_array([ 2, 1 ])),
		"Has_all returned false even though all values are present"
	)

#endregion

#region Method remove

func test_remove_returns_resultant_value() -> void:
	queue.add(1)
	
	assert_eq(queue.remove(), 1, "Remove didn't return right value")

func test_remove_takes_value_away() -> void:
	queue.add(1)
	
	assert_true(queue.is_empty(), "Remove didn't take value away")

func test_remove_takes_away_right_value() -> void:
	queue.add(1)
	queue.add(2)
	
	assert_eq(queue.remove(), 1, "Remove didn't take right value away")

#endregion

#region Method clear

func test_clear_returns_true_on_success() -> void:
	queue.add(1)
	queue.add(2)
	
	assert_true(queue.clear(), "Clear didn't return true on success")

func test_clear_returns_false_on_failure() -> void:
	assert_false(queue.clear(), "Clear didn't return false on failure")

func test_clear_empties_queue() -> void:
	queue.add(1)
	queue.add(2)
	
	queue.clear()
	
	assert_true(queue.is_empty(), "Clear didn't empty queue")

#endregion

#region Method equals

func test_equals_returns_false_with_unordered_queue() -> void:
	queue.add(1)
	queue.add(2)
	
	assert_false(
		queue.equals(Queue.from_array([ 2, 1 ])),
		"Different queues matched"
	)

func test_equals_returns_false_comparing_with_non_queues() -> void:
	assert_false(
		queue.equals(MockCollection.new()),
		"Non queue matched"
	)

func test_equals_returns_true_with_equivalent_queue() -> void:
	queue.add(1)
	queue.add(2)
	
	assert_true(
		queue.equals(GDQueue.from_array([ 1, 2 ])),
		"Equivalent queues didn't match"
	)

#endregion
