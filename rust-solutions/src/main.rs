//
//  main.rust
//  dsa
//
//  Created by d-exclaimation on 9:41 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
mod flight;

fn main() {
    println!("{}", flight::destination(vec![('a', 'b'), ('c', 'd'), ('b', 'c')]));
}
