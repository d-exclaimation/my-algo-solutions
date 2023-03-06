use std::collections::HashMap;

pub fn has_unique_occurence(nums: Vec<i32>) -> bool {
    let mut map = HashMap::new();
    for num in nums {
        let count = map.entry(num).or_insert(0);
        *count += 1;
    }
    let mut set = std::collections::HashSet::new();
    for (_, v) in map {
        if !set.insert(v) {
            return false;
        }
    }
    return true;
}
