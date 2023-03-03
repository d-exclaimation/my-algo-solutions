use std::collections::HashSet;

pub fn form_words(words: &Vec<String>, chars: &Vec<char>) -> usize {
    let checker = chars.iter().collect::<HashSet<_>>();

    words
        .iter()
        .filter(|word| word.chars().all(|c| checker.contains(&c)))
        .map(|word| word.len())
        .sum()
}
