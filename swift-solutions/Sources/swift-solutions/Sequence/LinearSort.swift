//
//  LinearSort.swift
//  swift-solutions
//
//  Created by d-exclaimation on 15:26.
//

func keyPositions<Seq: Sequence, T>(seq: Seq, key: (T) -> Int) -> [Int] where Seq.Element == T {
    let maxKey = seq.map(key).max()!
    var keys = (0...maxKey).map { _ in 0 }
    for i in seq {
        keys[key(i)] += 1
    }
    var sum = 0
    for (i, key) in keys.enumerated() {
        keys[i] = sum
        sum += key
    } 
    return keys
}

func lexicographicalOrder(n: Int) -> [Int] {
    func key(i: Int) -> Int {
        "\(i)".first?.wholeNumberValue ?? 9
    }
    let seq = (1...n).map { $0 }
    var keys = keyPositions(seq: seq, key: key(i:))
    var res = seq.map { $0 }
    for i in seq {
        let k = key(i: i)
        res[keys[k]] = i
        keys[k] += 1
    }
    return res
}