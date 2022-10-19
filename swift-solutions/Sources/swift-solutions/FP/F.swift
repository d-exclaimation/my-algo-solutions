//
//  F.swift
//  swift-solutions
//
//  Created by d-exclaimation on 12:50.
//

protocol _F {
    associatedtype X
    func y() -> X
}

struct F<X>: _F {
    private let _x: X

    private init(_ x: X) {
        _x = x
    }

    func f<Y>(_ f: (X) -> Y) -> F<Y> {
        .init(f(_x))
    }

    func f<Y>(_ g: (X) -> F<Y>) -> F<Y> {
        g(_x)
    }

    func f<Y>(_ f: (X) async throws -> Y) async rethrows -> F<Y> {
        try await .init(f(_x))
    }

    func f<Y>(_ f: (X) async throws -> F<Y>) async rethrows -> F<Y> {
        try await f(_x)
    }

    func p(_ p: (X) -> Bool) -> Bool {
        p(_x)
    }

    func p(_ p: (X) async throws -> Bool) async rethrows -> Bool {
        try await p(_x)
    }

    func z(_ z: (X) -> Void) -> Void {
        z(_x)
    }

    func z(_ z: (X) async throws -> Void) async rethrows -> Void {
        try await z(_x)
    }

    func u<Y>(_ u: F<Y>) -> F<(X, Y)> {
        .init((_x, u._x))
    }

    func y() -> X {
        _x
    }

    static func x(_ x: X) -> F<X> {
        .init(x)
    }
}

extension F where X: _F {
    func f() -> F<X.X> {
        .init(_x.y())
    }
}