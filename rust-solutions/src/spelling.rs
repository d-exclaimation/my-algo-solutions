//
//  spelling.rust
//  dsa
//
//  Created by d-exclaimation on 10:41 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn appropriate_placement(nums: Vec<i32>) -> Vec<String> {
    return nums.into_iter().map(|x|{
        return match x {
            1 => { "Gold Medal".to_string() }
            2 => { "Silver Medal".to_string() }
            3 => { "Bronze Medal".to_string() }
            _ => { format!("{}", x) }
        }
    }).collect()
}