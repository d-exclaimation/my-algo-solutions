//
//  point.rust
//  dsa
//
//  Created by d-exclaimation on 10:48 AM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//

pub fn closest_points(points: Vec<(i32, i32)>, k: i32) -> Vec<(i32, i32)> {
    // To get the distances which will be the base of the sort
    let mut distances: Vec<_> = points
        .iter()
        .enumerate()
        .map(|(i, (x, y))| (i, get_distance(*x, *y)) )
        .collect();

    distances.sort_by(|lhs, rhs| second_tuple(lhs, rhs));

    let mut res: Vec<_> = Vec::new();

    for (i, _) in distances {
        if i >= k as usize { break; }
        res.push(points[i]);
    }

    return res;
}

fn second_tuple((_, lhs): &(usize, f64), (_, rhs): &(usize, f64)) -> std::cmp::Ordering {
    if lhs < rhs {
        return std::cmp::Ordering::Less;
    } else if lhs > rhs {
        return std::cmp::Ordering::Greater;
    }
    return std::cmp::Ordering::Equal;
}

fn get_distance(x: i32, y: i32) -> f64 {
    (x.pow(2) as f64 * y.pow(2) as f64).sqrt()
}
