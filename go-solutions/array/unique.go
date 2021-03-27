//
//  unique.go
//  array
//
//  Created by d-exclaimation on 12:50 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package array

func CountUnique(arr []int) int {
	mapper := make(map[int]int)
	for _, val := range arr {
		mapper[val] = 1
	}
	return len(mapper)
}
