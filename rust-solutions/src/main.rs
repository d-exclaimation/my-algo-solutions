//
//  main.rust
//  dsa
//
//  Created by d-exclaimation on 9:41 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
mod twin;

fn main() {
    println!("{}", twin::max_chain_len(vec![(9, 1), (3, 5), (4, 7)]))
}
