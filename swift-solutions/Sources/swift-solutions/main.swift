//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation

let res = F
    .x(1)
    .f({ $0 + 1})
    .f({ $0 + 2 })
    .f({ F.x($0) })
    .y()

RunLoop.main.run()