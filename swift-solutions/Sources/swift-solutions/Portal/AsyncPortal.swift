//
//  AsyncPortal.swift
//  swift-solutions
//
//  Created by d-exclaimation on 18:01.
//

import Foundation

struct AsyncPortal<Element>: AsyncSequence {
    private let stream: AsyncStream<Element>
    private let continuation: AsyncStream<Element>.Continuation?

    init() {
        var cons: AsyncStream<Element>.Continuation? = nil
        stream = AsyncStream<Element> { con in
            cons = con
        }
        continuation = cons
    }

    func yield(_ value: Element) {
        continuation?.yield(value)
    }

    func yield(with result: Result<Element, Never>) {
        continuation?.yield(with: result)
    }

    func finish() {
        continuation?.finish()
    }

    func makeAsyncIterator() -> AsyncStream<Element>.AsyncIterator {
        stream.makeAsyncIterator()
    }

    func next() async -> Element? {
        var iterator = makeAsyncIterator()
        return await iterator.next()
    }
}