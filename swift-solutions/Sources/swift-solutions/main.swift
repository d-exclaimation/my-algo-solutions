//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation


for a in 0..<4 {
    let binA = (a % 2 == 1, a / 2 > 0)
    for b in 0..<4 {
        let binB = (b % 2 == 1, b / 2 > 0)
        let expected = a > b
        let res = gt(a: binA, b: binB)
        if expected != res {
            print("Failure for a: \(a) (\(binA)), b: \(b) \(binB), with expected: \(expected) but received \(res)")
        }
    }
}
