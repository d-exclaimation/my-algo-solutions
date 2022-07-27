//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation

print(lexicographicalOrder(n: 11))

let tree: BiTree<Int> = .node(1, 
    left: .leaf(2), 
    right: .lnode(4, 
        left: .leaf(8)
    )
)

print(tree.zipZag())

print(Number.orderedDigits(low: 15, high: 48))

print(rearrange([4, 1, 3, 3, 2]) { $0 != $1 })

print(farFromLand([
  [0, 0, 1],
  [0, 0, 0],
  [0, 0, 0]
]))

print(isLastCharacter(for: [1, 0, 1, 1, 0]))