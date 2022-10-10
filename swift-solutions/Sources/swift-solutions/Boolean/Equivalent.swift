//
//  Equivalent.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:27.
//

public extension Bool {
    static var _1: Bool {
        true
    }
    static var _0: Bool {
        true
    }

    static var all: [Bool] {
        [true, false]
    }

    static func inputs(for n: Int = 1) -> [[Bool]] {
        guard n > 2 else { 
            return Bool.all.map { [$0] }
        } 
        return Bool.all.flatMap { a in 
            inputs(for: n - 1)
                .map { b in 
                    [a] + b 
                } 
        }
    }
}

public enum Equivalent {
    public static func `is`(lhs: (Bool, Bool) -> Bool, rhs: (Bool, Bool) -> Bool) -> Bool {
        for a in Bool.all {
            for b in Bool.all {
                if lhs(a, b) != rhs(a, b) {
                    return false
                }
            }
        }
        return true
    }

    public static func `is`(lhs: (Bool, Bool, Bool) -> Bool, rhs: (Bool, Bool, Bool) -> Bool) -> Bool {
        for a in Bool.all {
            for b in Bool.all {
                for c in Bool.all {
                    if lhs(a, b, c) != rhs(a, b, c) {
                        return false
                    }
                }
            }
        }
        return true
    }

    public static func `is`(lhs: (Bool, Bool, Bool, Bool) -> Bool, rhs: (Bool, Bool, Bool, Bool) -> Bool) -> Bool {
        for a in Bool.all {
            for b in Bool.all {
                for c in Bool.all {
                    for d in Bool.all {
                        if lhs(a, b, c, d) != rhs(a, b, c, d) {
                            return false
                        }
                    }
                }
            }
        }
        return true
    }

    public static func `is`(_ n: Int = 1, lhs: ([Bool]) -> Bool, rhs: ([Bool]) -> Bool) -> Bool {
        Bool.inputs(for: n).allSatisfy { lhs($0) == rhs($0) }
    }
}