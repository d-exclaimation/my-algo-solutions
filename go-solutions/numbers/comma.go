//
//  comma.go
//  numbers
//
//  Created by d-exclaimation on 9:08 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package numbers

import (
	"fmt"
)

func Comma(n int) string {
	var (
		str = fmt.Sprintf("%d", n)
		j   = 0
		res = ""
	)

	for i := len(str) - 1; i >= 0; i-- {
		j++
		res = string(str[i]) + res
		if j == 3 && i != 0 {
			res = "," + res
			j = 0
		}
	}
	return res
}
