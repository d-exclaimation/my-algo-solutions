//
//  main.rust
//  dsa
//
//  Created by d-exclaimation on 9:41 PM.
//  Copyright © 2021 d-exclaimation. All rights reserved.
//
mod divide_seq_k;
mod form_words;
use std::collections::HashSet;
use std::hash::Hash;

pub enum State<T, E> {
    Loading,
    Success(T),
    Error(E),
}

pub trait Identifiable<T: Eq + Hash> {
    fn id(&self) -> T;

    fn is_equal(&self, other: &Self) -> bool {
        self.id() == other.id()
    }
}

pub struct User {
    pub id: String,
    pub name: Option<String>,
    pub email: String,
}

impl User {
    pub fn display_name(&self) -> String {
        match &self.name {
            Some(name) => name.clone(),
            None => self.email.clone(),
        }
    }
}

impl Identifiable<String> for User {
    fn id(&self) -> String {
        self.email.clone()
    }
}

pub fn unique<T: Eq + Hash, K: Identifiable<T>>(vec: Vec<K>) -> Vec<K> {
    let mut repo = HashSet::new();
    vec.into_iter()
        .filter(|item| repo.insert(item.id()))
        .collect()
}

fn main() {
    println!(
        "{}",
        divide_seq_k::divide_seq_k(vec![1, 2, 3, 3, 4, 4, 5, 6], 4)
    );

    println!(
        "{}",
        form_words::form_words(
            &vec!["abc".to_string(), "bac".to_string(),],
            &vec!['a', 'b', 'c']
        )
    );
}
