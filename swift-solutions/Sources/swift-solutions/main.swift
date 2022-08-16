//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation


let z: (Bool, Bool) -> Bool = { $0 || !$1 }

print(Equivalent.is(lhs: z, rhs: { !(!$0 && $1) }))
print(Equivalent.is(lhs: z, rhs: { ($0 && !$1) || ($0 && $1) || (!$0 && !$1)  }))
print(Equivalent.is(lhs: z, rhs: { !($0 && !$1) }))
print(Equivalent.is(lhs: z, rhs: { !$0 || $1 }))