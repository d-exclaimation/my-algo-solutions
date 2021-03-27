//
//  main.go
//  al-go
//
//  Created by d-exclaimation on 6:32 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package main

import (
	"fmt"
	"github.com/d-exclaimation/al-go/array"
)

func main() {
	fmt.Printf("Unique count is %d", array.CountUnique([]int{1, 2, 2, 4, 4, 6, 8, 8}))
}

