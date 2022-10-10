//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation

let z1 = { (a: Bool, b: Bool, c: Bool) in a || !b || !c }
let z2 = { (a: Bool, b: Bool, c: Bool) in !a && (b || !c) }

print(Equivalent.is(lhs: z1, rhs: z2))

RunLoop.main.run()