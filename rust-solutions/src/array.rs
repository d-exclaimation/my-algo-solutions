//
//  array.rust
//  dsa
//
//  Created by d-exclaimation on 7:15 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
use std::collections::HashMap;

fn harmonic_subsequence(arr: Vec<i32>) -> i32 {
    let mut first_record: HashMap<i32, usize> = HashMap::new();
    let mut end_record: HashMap<i32, usize> = HashMap::new();
    for i in 0..arr.len() {
        first_record.insert(arr[i], if first_record.contains_key(&arr[i]) { std::cmp::min(first_record[&arr[i]], i) } else { i });
        end_record.insert(arr[i], if end_record.contains_key(&arr[i]) { std::cmp::max(end_record[&arr[i]], i) } else { i });
    }
    let max_res = first_record
        .iter()
        .map(|(key, value)| {
            let mut res: usize = 0;
            if end_record.get(&(key - 1)).unwrap_or(&0) > value {
                res = std::cmp::max(res,  end_record.get(&(key - 1)).unwrap() - value);
            } else if end_record.get(&(key + 1)).unwrap_or(&0) > value {
                res = std::cmp::max(res, end_record.get(&(key + 1)).unwrap() - value);
            }
            return res;
        }).max().unwrap();
    return max_res as i32;
}

fn find_disappeared_numbers(arr: Vec<i32>) -> Vec<i32> {
    // O(n) space and O(1) time
    let mut remover = vec![1; arr.len()];

    // O(1) space and O(n) time
    for each in arr {
        let index = if each > 0 { (each - 1) as usize } else { 0 };
        remover[index] -= 1;
    }

    // O(k) space and O(1) time
    let mut result: Vec<i32> = Vec::new();

    // O(1) space and O(n) time
    for i in 0..remover.len() {
        if remover[i] != 1 {
            continue;
        }
        result.push((i + 1) as i32);
    }

    // O(n) + O(k) + O(2) space and O(2n) + O(2) time
    // O(n) space and O(n) time
    return result;
}

pub fn all_equal(nums: Vec<i32>) -> i32 {
    if is_all_equal(nums) {
        return 0;
    }

    return rec_equal(nums.clone(), 0);
}

fn rec_equal(nums: Vec<i32>, index: i32) -> i32 {
    if is_all_equal(nums) || curr > 100 {
        return 0;
    }
    let mut counts = Vec::new();
    for i in 0..nums.len() {
        let curr: Vec<_> = nums.iter().enumerate().map(|(j, x)| if i == j { *x } else { *x + 1 } ).collect();
        counts.push( rec_equal(curr, index + 1));
    }
    return *(counts.iter().min().unwrap());
}

fn is_all_equal(nums: Vec<i32>) -> bool {
    let init = nums[0];
    for i in 1..nums.len() {
        if init != nums[i] {
            return false
        }
    }
    return true
}
