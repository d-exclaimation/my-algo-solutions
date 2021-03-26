//
//  airbnb.rust
//  dsa
//
//  Created by d-exclaimation on 8:03 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn buddy_strings(lhs: &str, rhs: &str) -> bool {
    if lhs.len() != rhs.len() {
        return false;
    }

    // Saved values
    let mut saved_lhs: char = '1';
    let mut saved_rhs: char = '1';

    // Use Vectors to better iterate each character
    let lhs_arr: Vec<_> = lhs
        .to_string()
        .chars()
        .into_iter()
        .collect();
    let rhs_arr: Vec<_> = rhs
        .to_string()
        .chars()
        .into_iter()
        .collect();

    for i in 0..lhs_arr.len() {
        if lhs_arr[i] == rhs_arr[i] { continue; }

        // Saved the difference or retrieve it and check
        if saved_lhs == saved_rhs {
            saved_lhs = lhs_arr[i].clone();
            saved_rhs = rhs_arr[i].clone();
        } else {
            return lhs_arr[i] == saved_rhs && rhs_arr[i] == saved_lhs;
        }
    }
    return false;
}