//
//  main.go
//  al-go
//
//  Created by d-exclaimation on 6:32 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package main

import "github.com/d-exclaimation/al-go/tree"

func main() {
	oak := &tree.Node{
		Val: 2,
		Left: &tree.Node{
			Val:   0,
			Left:  nil,
			Right: &tree.Node{Val: 1},
		},
		Right: &tree.Node{
			Val:   3,
			Left:  nil,
			Right: &tree.Node{Val: 4},
		},
	}
	oak.PrintInorder()
	oak.PrintInorderIter()
}

