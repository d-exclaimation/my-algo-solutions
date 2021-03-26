//
//  math.rust
//  dsa
//
//  Created by d-exclaimation on 9:05 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn reduce_to_single(num: u32) -> u32 {
    let mut curr = num;
    let mut res: u32 = 0;
    while curr > 0 {
        res += curr % 10;
        curr /= 10;
    }
    if res / 10 > 0 {
        return reduce_to_single(res);
    }
    return res;
}