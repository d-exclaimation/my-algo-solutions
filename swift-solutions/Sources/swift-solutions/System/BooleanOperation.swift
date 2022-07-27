//
//  Binary.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:40.
//

extension Bool {
    func gt(_ other: Bool) -> Bool {
        self && !other
    }

    func eq(_ other: Bool) -> Bool {
        (self && other) || (!self && !other)
    }

    func lt(_ other: Bool) -> Bool {
        !self && other
    }
}

// ((A1 and !B1) OR (((A1 AND B1) OR (!A1 AND !B1)) AND (A0 AND !B0)))
func gt(a: (Bool, Bool), b: (Bool, Bool)) -> Bool {
    let (a0, a1) = a
    let (b0, b1) = b
    let zeroGt = a0.gt(b0)
    let oneGt = a1.gt(b1)
    let oneEq = !a1.lt(b1)
    return (oneEq && zeroGt) || oneGt
}