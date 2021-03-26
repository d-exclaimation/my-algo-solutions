//
//  calculation.go
//  numbers
//
//  Created by d-exclaimation on 8:30 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package numbers


func maxProfit(day []int) int {
	// Proof of concepts O(n^2)
	var res = -1
	for i := 0; i < len(day); i++ {
		var diff = 0
		for j := i + 1; j < len(day); j++ {
			var curr = day[j] - day[i]
			if curr >= diff {
				diff = curr
			}
		}
		if diff >= res {
			res = diff
		}
	}

	return res
}
