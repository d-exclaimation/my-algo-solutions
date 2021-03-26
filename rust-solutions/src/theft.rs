//
//  theft.rust
//  dsa
//
//  Created by d-exclaimation on 8:39 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn max_theft(houses: &Vec<i32>) -> i32 {
    houses.iter()
        .enumerate()
        .map(|(i, _)| theft_move(houses, i)) // O(n) time
        .max()
        .unwrap_or(0)
}

fn theft_move(houses: &Vec<i32>, index: usize) -> i32 {
    println!("Called");
    if index >= houses.len() - 2 {
        return houses[index];
    }

    let mut max_val = -1;

    for i in index + 2..houses.len() {
        max_val = std::cmp::max(
            theft_move(houses, i),
            max_val
        );
    }

    return houses[index] + max_val;
}