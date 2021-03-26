//
//  tree.rust
//  dsa
//
//  Created by d-exclaimation on 7:33 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub struct TreeNode {
    pub val: i32,
    pub left: Option<Box<TreeNode>>,
    pub right: Option<Box<TreeNode>>
}

impl TreeNode {
    fn new() -> TreeNode {
        return TreeNode {
            val: 0,
            left: Option::None,
            right: Option::None,
        }
    }

    fn to_string(&self) -> String {
        
    }
}