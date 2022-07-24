//
//  Abstract.swift
//  swift-solutions
//
//  Created by d-exclaimation on 13:12.
//

import Foundation

func rearrangeAdjacent(_ ids: [Int]) -> [Int] {
    rearrange(ids, rule: { $0 != $1})
}

func rearrange<T>(_ ids: [T], rule: (T, T) -> Bool) -> [T] {
    var saved = T?.none 
    var res = [T]()
    for id in ids {
        guard let last = res.last else {
            res.append(id)
            continue
        }
        if let curr = saved, rule(last, curr) {
            res.append(curr)
            saved = nil
            if rule(curr, id) {
                res.append(id)
            } else {
                saved = id
            }
        } else if rule(last, id) {
            res.append(id)
        } else {
            saved = id
        }
    }

    if let saved = saved {
        if let last = res.last {
            if rule(saved, last) {
                res.append(saved)
            } else {
                return rearrange([saved] + res, rule: rule)
            }
        } else {
            res.append(saved)
        }
    }

    return res
}