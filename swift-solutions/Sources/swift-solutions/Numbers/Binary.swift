//
//  Binary.swift
//  swift-solutions
//
//  Created by d-exclaimation on 19:39.
//

enum Binary {
    typealias List = [Int]
}

extension Binary.List {
    var booleans: [Bool] {
        map { $0 != 0 }
    }
}

func isLastCharacter(for binary: Binary.List) -> Bool {
    var list = binary.map { $0 }
    var curr = list.removeFirst()
    while (!list.isEmpty) {
        if curr == 1 {
            let _ = list.removeFirst()
            if list.isEmpty {
                return false
            }
        }
        curr = list.removeFirst()
    }
    return curr == 0
}