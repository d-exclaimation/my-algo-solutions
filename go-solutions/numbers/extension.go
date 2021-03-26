//
//  extension.go
//  numbers
//
//  Created by d-exclaimation on 12:30 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package numbers

type IntegerArray []int

func (arr IntegerArray) Map(mapping func(int) int) []int {
	var res = make([]int, len(arr))
	for i, val := range arr {
		res[i] = mapping(val)
	}
	return res
}
