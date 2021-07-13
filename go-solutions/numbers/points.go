package numbers

type Points struct {
	X int
	Y int
}

func isPointsOnTheSameLine(points []Points) bool {
	if len(points) <= 2 {
		return true
	}
	for i := 1; i < len(points); i++ {
		if points[i].X != points[i-1].X {
			return false
		}
	}
	return true
}
