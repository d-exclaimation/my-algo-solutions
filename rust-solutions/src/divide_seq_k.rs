pub fn divide_seq_k(nums: Vec<i32>, k: usize) -> bool {
    if (nums.len() % k) != 0 {
        return false;
    }

    if nums.len() == 1 && k == 1 {
        return true;
    }

    let mut buckets = nums.clone();
    let mut splits: Vec<Vec<i32>> = Vec::new();
    buckets.sort();

    for each in buckets {
        let mut has_inserted = false;
        for split in splits.iter_mut() {
            if split.len() >= k {
                continue;
            }
            let should_insert = match split.last() {
                Some(last) => each - last == 1,
                None => true,
            };
            if !should_insert {
                continue;
            }
            has_inserted = true;
            split.push(each);
            break;
        }
        if !has_inserted {
            splits.push(vec![each]);
        }
    }

    return splits.iter().all(|split| split.len() == k);
}
