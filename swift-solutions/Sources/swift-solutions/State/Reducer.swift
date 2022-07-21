//
//  Reducer.swift
//  swift-solutions
//
//  Created by d-exclaimation on 16:07.
//

import Foundation

struct Reducer<State: Sendable, Actions> {
    private var reducer: (State, Actions) -> State
    var state: State

    init(_ reducer: @escaping (State, Actions) -> State, initial state: State) {
        self.reducer = reducer
        self.state = state
    }
    
    mutating func dispatch(_ action: Actions) {
        state = reducer(state, action)
    }
}


