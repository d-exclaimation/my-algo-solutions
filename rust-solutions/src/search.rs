//
//  search.rust
//  dsa
//
//  Created by d-exclaimation on 3:28 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn binary_search(nums: Vec<i32>, target: i32) -> usize {
    if target < nums[0] {
        return 0;
    }

    if target > nums[nums.len() - 1 as usize] {
        return nums.len()
    }

    let mut low_bound: usize = 0;
    let mut up_bound: usize = nums.len() - 1 as usize;
    let mut index = (up_bound + low_bound) / 2 as usize;
    while nums[index] != target && up_bound - low_bound > 1 {
        if nums[index] < target {
            low_bound = index;
        } else {
            up_bound = index;
        }
        index = (up_bound + low_bound) / 2 as usize;
    }

    println!("at {}, ({})", index, nums[index]);

    if nums[index] != target {
        return if nums[index] > target { index - 1 as usize } else { index + 1 as usize }
    }
    return index;
}