//
//  Island.swift
//  swift-solutions
//
//  Created by d-exclaimation on 19:12.
//

func farFromLand(_ grid: [[Int]]) -> Int {
    struct Island {
        var x: Int
        var y: Int
        var isIsland: Bool
    
        func distance(_ other: Island) -> Int {
            other.isIsland != isIsland ? abs(x - other.x) + abs(y - other.y) : 0
        }
    }

    let islands = grid
        .enumerated()
        .flatMap { (i, row) in 
            row
            .enumerated()
            .map { (j, column) in Island(x: i, y: j, isIsland: column != 0) } 
        }

    return islands
        .compactMap { island in islands.map(island.distance).max() }
        .max() ?? 0
}