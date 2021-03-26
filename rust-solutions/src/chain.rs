//
//  chain.rust
//  dsa
//
//  Created by d-exclaimation on 2:02 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
use::std::collections::HashMap;

pub fn is_chainable(words: Vec<String>) -> bool {
    let mut start_map = HashMap::new();
    for i in 0..words.len() {
        let curr = words[i].chars().nth(0).unwrap();
        let prev = *start_map.get(&curr).unwrap_or(&0);
        start_map.insert(curr, prev + 1);
    }

    for j in 0..words.len() {
        let ends = words[j].chars().nth(words[j].len() - 1).unwrap();
        if start_map.contains_key(&ends) {
            let prev = *start_map.get(&ends).unwrap();
            if prev == 1 {
                start_map.remove(&ends);
            } else {
                start_map.insert(ends, prev - 1);
            }
        }
    }
    let mut count = 0;
    for (_, value) in start_map {
        count += value;
    }

    return count <= 1;
}