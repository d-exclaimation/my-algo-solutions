//
//  slices.rust
//  dsa
//
//  Created by d-exclaimation on 4:13 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn create_gift_card(code: &str, k: i32) -> String {
    let mut first_group = String::new();
    let chars: Vec<_> = code.to_uppercase().chars().into_iter().collect();

    // Since the First group can be an exception to the rule,
    // we add each First chars so that the length after that char is now evenly distributed
    while (chars.len() - first_group.len()) % k as usize != 0 {
        first_group.push(chars[first_group.len()]);
    }

    // Now just concat each Kth char with a dash
    let start = first_group.len();
    let mut sub_k = 0;
    for i in start..chars.len() {
        if sub_k % k as usize == 0 && first_group.len() > 0 as usize {
            first_group.push('-');
        }
        first_group.push(chars[i]);
        sub_k += 1
    }

    return first_group;
}