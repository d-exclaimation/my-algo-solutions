//
//  blur.go
//  array
//
//  Created by d-exclaimation on 8:15 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

package array

func BoxBlur(image [][]int) [][]int {
	res := make([][]int, 0)
	for i := 1; i < len(image) - 1; i++ {
		curr := make([]int, 0)
		for j := 1; j < len(image[i]) - 1; j++ {
			curr = append(curr, threeByThree(image, i, j))
		}
		res = append(res, curr)
	}
	return res
}

func threeByThree(image [][]int, i int, j int) int {
	minI := i - 1
	maxI := i + 1
	minJ := j - 1
	maxJ := j + 1
	sum := 0
	for n := minI; n <= maxI; n++ {
		for m := minJ; m <= maxJ; m++ {
			sum += image[n][m]
		}
	}
	return sum / 9
}
