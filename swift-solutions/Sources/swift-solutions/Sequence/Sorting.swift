//
//  Sorting.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:49.
//

func valueSort<T: Hashable>(_ seq: any Sequence<T>) -> [T] {
    var counts = [T: Int]()
    seq.forEach { elem in 
        if let count = counts[elem] {
            counts[elem] = count + 1
        } else {
            counts[elem] = 1
        }
    }

    return seq.sorted { lhs, rhs in
        counts[lhs] ?? 0 < counts[rhs] ?? 0
    }
}