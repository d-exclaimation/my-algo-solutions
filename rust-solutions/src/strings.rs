//
//  strings.rust
//  dsa
//
//  Created by d-exclaimation on 7:29 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

use std::str::Chars;
use std::collections::HashSet;
use std::iter::FromIterator;
use std::cmp::max;

pub struct Solution {}

impl Solution {
    pub fn can_spell(magazine: Vec<char>, note: String) -> bool {
        let mut cut_out: HashSet<_> = HashSet::from_iter(magazine.iter().clone());
        for c in note.chars().clone() {
            if cut_out.contains(&c) {
                cut_out.remove(&c);
            } else {
                return false;
            }
        }
        return true;
    }

    pub fn longest_k_distinct(word: String, k: i32) -> i32 {
        let mut distinct = 1;
        let mut max_count = -1;
        let chars: Vec<_> = word.chars().clone().collect();
        for i in 0..chars.len() {
            println!("\nCurr sequence");
            let mut prev = chars[i].clone();
            distinct = 1;
            let mut curr = 0;
            for j in i..chars.len() {
                println!("{}", chars[j]);
                if prev != chars[j] {
                    if distinct >= k {
                        break;
                    }
                    distinct += 1;
                    prev = chars[j].clone();
                }
                curr += 1;
            }
            max_count = max(max_count, curr);
        }
        return max_count;
    }
}