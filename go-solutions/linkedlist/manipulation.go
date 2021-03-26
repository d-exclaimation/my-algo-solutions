//
//  manipulation.go
//  linkedlist
//
//  Created by d-exclaimation on 8:31 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package linkedlist

func Reversed(head *Node) *Node {
	var (
		prev *Node = nil
		curr =  head
	)
	for curr != nil {
		next := curr.Next
		curr.Next = prev
		prev = curr
		curr = next
	}
	return prev
}

func RemoveDups(head *Node) {
	if head == nil {
		return
	}

	var (
		prev *Node = nil
		curr = head
		hashset = make(map[int]bool)
	)

	for curr != nil {
		_, ok := hashset[curr.Data]
		if ok && prev != nil {
			prev.Next = curr.Next
		} else {
			hashset[curr.Data] = true
			prev = curr
		}

		curr = curr.Next
	}
}