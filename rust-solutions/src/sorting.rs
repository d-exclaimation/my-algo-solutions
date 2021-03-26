//
//  sorting.rust
//  dsa
//
//  Created by d-exclaimation on 9:15 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
pub enum Tri {
    First,
    Second,
    Third,
}


pub fn three_sorted(nums: Vec<Tri>) -> Vec<Tri> {
    let mut count: [i32; 3] = [0; 3];
    for i in 0..nums.len() {
        match nums[i] {
            Tri::First => { count[0] += 1 }
            Tri::Second => { count[1] += 1 }
            Tri::Third => { count[2] += 1 }
        }
    }
    let mut index = 0;
    return nums.iter().enumerate().map(|_|{
        if count[index] == 0 {
            index += 1
        }
        count[index] -= 1;
        return match index + 1 {
            1 => { Tri::First }
            2 => { Tri::Second }
            3 => { Tri::Third }
            _ => { Tri::First }
        };
    }).collect();
}