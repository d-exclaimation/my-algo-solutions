package tree

func DeepestLeafSum(root *Node) int {
	if root == nil {
		return 0
	}
	if root.Left == nil && root.Right == nil {
		return root.Val.(int)
	}

	return DeepestLeafSum(root.Left) + DeepestLeafSum(root.Right)
}
