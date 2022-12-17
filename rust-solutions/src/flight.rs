use std::collections::HashMap;

pub fn destination(flights: Vec<(char, char)>) -> char {
  let mut network = HashMap::new();
  flights.iter().for_each(|(from, to)| {
    network.insert(from.clone(), to.clone());
  });

  let mut previous= ' ';
  let mut current = flights.first().map(|(from, _)| from.clone());
  while current.is_some() {
    match current {
      Some(from) => match network.get(&from) {
        Some(next) => {
          current = Some(next.clone());
        }
        None => {
          previous = from;
          current = None;
        }
      }
      None => {
        current = None;
      }
    }
  }


  return previous.clone();
}
