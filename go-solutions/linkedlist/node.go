//
//  node.go
//  linkedlist
//
//  Created by d-exclaimation on 8:30 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package linkedlist

import "fmt"

type Node struct {
	Data int
	Next *Node
}

func (root *Node) ToString() string {
	if root.Next == nil {
		return fmt.Sprintf("%d", root.Data)
	}
	return fmt.Sprintf("%d -> %s", root.Data, root.Next.ToString())
}
