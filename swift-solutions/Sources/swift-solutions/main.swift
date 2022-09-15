//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation

var valid = 0

func die() -> Int {
    // Int.random(in: 1...6)
    if (valid > 3) {
        return Int.random(in: 1...6)
    }
    valid += 1
    return 1

}

func decideWhoIsPlayer1(_ i: Int, ins: AsyncPortal<Int>, outs: AsyncPortal<Int>) async -> Bool {
    while (true) {
        let mine = die()
        outs.yield(mine)

        guard let other = await ins.next() else {
            return false
        }
        if mine != other {
            return mine > other
        }
        print("p\(i): We got the same score")
    }
}

let in0 = AsyncPortal<Int>()
let in1 = AsyncPortal<Int>()

let board0 = Task {
    await print(decideWhoIsPlayer1(1, ins: in0, outs: in1) ? "p1: I am going first" : "p1: I am going last")
}

let board1 = Task {
    await print(decideWhoIsPlayer1(2, ins: in1, outs: in0) ? "p1: I am going first" : "p1: I am going last")
}

RunLoop.main.run()