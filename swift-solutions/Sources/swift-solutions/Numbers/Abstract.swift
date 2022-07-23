//
//  Abstract.swift
//  swift-solutions
//
//  Created by d-exclaimation on 18:12.
//

import Foundation

extension Int {
    func isConsecutive(next other: Int) -> Bool {
        other - self == 1
    }

    func isConsecutive(before other: Int) -> Bool {
        self - other == 1
    }

    var isConsecutive: Bool {
        var res = self / 10
        var prev = self % 10
        while (res > 0) {
            let curr = res % 10
            if !curr.isConsecutive(next: prev) {
                return false
            }
            prev = curr
            res = res / 10
        }
        return true
    }
}

extension Number {
    static func orderedDigits(low: Int, high: Int) -> [Int] {
        var stack = [Int]()
        for each in (low...high).filter({ $0.isConsecutive }) {
            guard let last = stack.last else {
                stack.append(each)
                continue
            }
            let curr = Int("\(each)".first!.description) ?? 0
            if (last % 10) == curr {
                stack.append(each)
            }
        }
        return stack
    }
}
