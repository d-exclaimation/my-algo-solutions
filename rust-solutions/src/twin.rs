//
//  twin.rust
//  dsa
//
//  Created by d-exclaimation on 7:51 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
use::std::collections::HashMap;

#[allow(dead_code)]
pub fn max_unique(arr: Vec<i32>) -> i32 {
    let mut mapper = HashMap::new();
    for i in 0..arr.len() {
        mapper
            .insert(
                arr[i],
                !mapper.contains_key(&arr[i])
            );
    }

    return mapper
        .into_iter()
        .filter(|(_, is_unique)| *is_unique)
        .map(|(key, _)| key)
        .max()
        .unwrap_or(-1);
}

struct NumChain {
    low: i32,
    high: i32,
    next_indices: Vec<usize>
}

impl NumChain {
    fn new(low: i32, high: i32) -> NumChain {
        NumChain {
            low,
            high,
            next_indices: Vec::new()
        }
    }

    fn len(&self, source: &Vec<NumChain>) -> usize {
        if self.next_indices.is_empty() {
            return 1 as usize;
        }
        return self.next_indices
            .iter()
            .map(|index| 1 as usize + source[*index].len(source))
            .max()
            .unwrap_or(0);
    }
}

pub fn max_chain_len(arr: Vec<(i32, i32)>) -> usize {
    let mut chains: Vec<_> = (&arr)
        .iter()
        .map(|(low, high)| NumChain::new(*low, *high))
        .collect();

    chains.sort_by(|lhs, rhs| {
        if lhs.low < rhs.low {
            return std::cmp::Ordering::Less;
        }
        return std::cmp::Ordering::Greater;
    });



    for i in 0..(chains.len() - 1) {
        for j in (i + 1)..chains.len() {
            if chains[i].high >= chains[j].low { continue; }
            chains[i].next_indices.push(j);
        }
    }

    return chains.iter()
        .map(|chain| chain.len(&chains))
        .max()
        .unwrap_or(0 as usize);
}