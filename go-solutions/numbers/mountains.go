//
//  mountains.go
//  numbers
//
//  Created by d-exclaimation on 8:30 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package numbers

func validMountainArray(arr []int) bool {
	// O(n) time and O(1) space
	for i := 0; i < len(arr) / 2; i++ {
		var j = len(arr) - 1 - i
		if arr[i] != arr[j] {
			return false
		}
		if i > 0 && arr[i] <= arr[i - 1] {
			return false
		}
	}

	var mid = arr[len(arr) / 2]
	if mid <= arr[(len(arr) / 2) - 1] {
		return false
	}
	return true
}
