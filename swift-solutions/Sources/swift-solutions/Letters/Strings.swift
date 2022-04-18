//
//  Strings.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

func uniqueCharacterSubstringCount(for str: String) -> Int {
    countUniqueCharSubstring(for: str.map({ $0 }))
}

private func countUniqueCharSubstring(for seq: [String.Element], at i: Int = 0, to j: Int = 0) -> Int {
    guard j < seq.count else { return 0 }

    guard i < seq.count && seq[i] == seq[j] else { 
        return countUniqueCharSubstring(for: seq, at: j + 1, to: j + 1) 
    }

    return 1 + countUniqueCharSubstring(for: seq, at: i + 1, to: j)
}