//
//  LinkedBucket.swift
//  swift-solutions
//
//  Created by d-exclaimation on 09:26.
//

public class LinkedBucket<Record: Identifiable> {
    private let bucket: Bucket<Record> = .init()
    private var next: LinkedBucket<Record>? = nil

    public func insert(_ value: Record) throws {
        guard bucket.isFull else {
            return try bucket.insert(value)
        }
        if case .none = next {
            next = .init()
        }
        try next?.insert(value)
    }

    // public func update(with value: Record) throws {
    // }

    // public func search(given id: Record.ID) -> Record? {
    // }

    // public var last: Record? {
    // }
}