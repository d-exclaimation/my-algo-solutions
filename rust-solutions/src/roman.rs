//
//  roman.rust
//  dsa
//
//  Created by d-exclaimation on 9:36 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
use std::collections::HashMap;

pub fn roman_to_int(roman: &str) -> i32 {
    // O(n) space, O(n) time
    let chars: Vec<i32> = roman
        .to_string()
        .chars()
        .into_iter()
        .map(map_roman)
        .rev()
        .collect();
    let mut res = 0;
    let mut max = 0;

    // O(1) space, O(n) time
    for each in chars {
        res = res + if each < max { -1 * each } else { each };
        max = std::cmp::max(max, each);
    }

    // O(n + 1) space, O(2n) time
    // O(n) space, O(n) time
    return res;
}

pub fn map_roman(roman: char) -> i32 {
    let mapper: HashMap<char, i32> = vec![
        ('I', 1),
        ('V', 5),
        ('X', 10),
        ('L', 50),
        ('C', 100),
        ('D', 500),
        ('M', 1000)
    ]
        .into_iter()
        .collect();

    return *mapper.get(&roman).unwrap_or(&0)
}