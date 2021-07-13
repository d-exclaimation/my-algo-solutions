package numbers

// count odd number between start and end
func count_odd_number(start int, end int) int {
	var count int
	for i := start; i <= end; i++ {
		if is_odd(i) {
			count++
		}
	}
	return count
}

func is_odd(num int) bool {
	return num%2 != 0
}

type LinkedNode struct {
	Value int
	Next  *LinkedNode
}

func detectCycleInLinkedNode(head *LinkedNode) bool {
	if head == nil {
		return false
	}
	slow := head
	fast := head
	for fast != nil && fast.Next != nil {
		slow = slow.Next
		fast = fast.Next.Next
		if slow == fast {
			return true
		}
	}
	return false
}
