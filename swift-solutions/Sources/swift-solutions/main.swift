//
//  main.swift
//  swift-solutions
//
//  Created by d-exclaimation on 20:53.
//

import Foundation

struct CounterState {
    var count: Int
}

enum CounterAction {
    case increment
    case add(by: Int)
    case decrement
    case subtract(by: Int)
    case empty
}

func counterReducer(_ state: CounterState, _ action: CounterAction) -> CounterState {
    switch action {
    case .increment:
        return CounterState(count: state.count + 1)
    case .add(let by):
        return CounterState(count: state.count + by)
    case .decrement:
        return CounterState(count: state.count - 1)
    case .subtract(let by):
        return CounterState(count: state.count - by)
    case .empty:
        return CounterState(count: 0)
    }
}

var reducer = Reducer(counterReducer, initial: CounterState(count: 0))


