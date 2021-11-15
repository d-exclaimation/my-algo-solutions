//
//  celebrity.go
//  array
//
//  Created by d-exclaimation on 8:45 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package array

func FindCelebrity(n int, matrix [][]int) int {
	person := -1

	for i := 0; i < n; i++ {
		if i >= len(matrix) {
			person = i + 1
			break
		}
		names := matrix[i]
		if len(names) == 0 {
			person = i + 1
			break
		}
	}

	for _, names := range matrix {
		isKnown := false
		for _, name := range names {
			if name == person {
				isKnown = true
				break
			}
		}
		if !isKnown {
			return -1
		}
	}

	return person
}
