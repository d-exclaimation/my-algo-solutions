//
//  perfect.rust
//  dsa
//
//  Created by d-exclaimation on 11:47 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn is_perfect_num(val: i32) -> bool {
    let factors: i32 = get_factors(val).iter().sum();
    return factors == val;
}

fn get_factors(val: i32) -> Vec<i32> {
    let mut res = Vec::new();
    for i in 1..(val/2 + 1) {
        if val % i != 0 { continue; }
        res.push(i);
    }
    return res;
}