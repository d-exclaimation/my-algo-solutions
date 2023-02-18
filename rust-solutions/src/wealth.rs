pub fn most_weath(wealths: Vec<Vec<i32>>) -> i32 {
    let res = wealths.iter().map(|row| row.iter().sum()).max();
    match res {
        Some(value) => value,
        None => 0,
    }
}
