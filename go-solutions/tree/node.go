//
//  node.go
//  tree
//
//  Created by d-exclaimation on 4:21 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package tree

import (
	"fmt"
)

type Node struct {
	Val interface{}
	Left *Node
	Right *Node
}

func (tree *Node) MaxDepthValue() int {
	res, ok := tree.Val.(int)
	if !ok {
		return 0
	}
	left, right := res, res
	if tree.Left != nil {
		left = tree.Left.MaxDepthValue() + left
		if res < left {
			res = left
		}
	}

	if tree.Right != nil {
		right = tree.Right.MaxDepthValue() + right
		if res < right {
			res = right
		}
	}
	return res
}

func (tree *Node) PrintInorder() {
	if tree.Left != nil {
		tree.Left.PrintInorder()
	}
	fmt.Println(tree.Val)
	if tree.Right != nil {
		tree.Right.PrintInorder()
	}
}

func (tree *Node) PrintInorderIter() {
	stack :=  make([]*Node, 0)
	curr := tree
	for {
		if curr != nil {
			stack = append(stack, curr)
			curr = curr.Left
		} else if len(stack) > 0 {
			curr = stack[len(stack) - 1]
			stack = stack[:len(stack) - 1]
			fmt.Printf("%d ", curr.Val)
			curr = curr.Right
		} else {
			break
		}
	}
	fmt.Println()
}
