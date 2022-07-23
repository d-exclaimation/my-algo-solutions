//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation

print(lexicographicalOrder(n: 11))

let tree = BiTree<Int>.node(1, 
    left: .leaf(2), 
    right: .node(4, 
        left: .leaf(8), 
        right: .leaf(16)
    )
)

print(tree.zipZag())