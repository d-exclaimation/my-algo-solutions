//
//  numbers.rust
//  dsa
//
//  Created by d-exclaimation on 9:02 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

fn min_rotated_sorted(arr: &mut Vec<i32>) -> i32 {
    // O(k) time where n is the number of rotation, worst case is O(n - 1)
    if arr[0] < arr[arr.len() - 1] {
        return arr[0]
    }
    while arr[0] > arr[arr.len() - 1] {
        let back  = arr.pop().unwrap();
        arr.insert(0, back);
    }
    return arr[0]
}

fn all_dups(arr: &mut Vec<i32>) -> Vec<i32> {
    let mut res: Vec<i32> = Vec::new();
    for i in 0..arr.len() {
        let curr = (arr[i].abs() - 1) as usize;
        if arr[curr] < 0 {
            res.push(arr[i].abs())
        } else {
            arr[curr] *= -1;
        }
    }
    return res;
}

pub fn fibonacci(n: i32) -> i32 {
    let mut prev = 0;
    if n < 1 {
        return prev;
    }
    let mut curr = 1;
    for _ in 0..n {
        let next = curr + prev;
        prev = curr;
        curr = next;
    }
    return curr;
}