//
//  turn.rust
//  dsa
//
//  Created by d-exclaimation on 7:52 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn plus_to_minus(s: &str) -> Vec<String> {
    let s_arr: Vec<_> = s.chars().into_iter().collect();
    let mut res = Vec::new();
    for i in 1..s_arr.len() {
        let curr: Vec<_> = s_arr.clone()
            .iter()
            .enumerate()
            .map(|(j, _)| if j == i || j == i - 1 { "-" } else { "+" } )
            .collect();
        let curr_str: String = curr.join("");
        res.push(curr_str);
    }
    return res;
}