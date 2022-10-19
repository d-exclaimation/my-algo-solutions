//
//  LinkedBucket.swift
//  swift-solutions
//
//  Created by d-exclaimation on 09:26.
//

public class LinkedBucket<Record: Identifiable> {
    private let bucket: Bucket<Record>
    private var next: LinkedBucket<Record>? = nil

    public init(limit: Int = 10) {
        bucket = .init(limit: limit)
    }

    public func insert(_ value: Record) throws {
        guard bucket.isFull else {
            print("Inserting \(value.id) into bucket")
            return try bucket.insert(value)
        }
        print("Inserting \(value.id) into next linked bucket")
        if case .none = next {
            next = .init()
        }
        try next?.insert(value)
    }

    public func update(with value: Record) throws {
        guard case .some = bucket.search(given: value.id) else {
            try next?.update(with: value)
            return
        }
        try bucket.update(with: value)
    }

    public func search(given id: Record.ID) -> Record? {
        bucket.search(given: id) ?? next?.search(given: id)
    }

    public var last: Record? {
        guard let next else {
            return bucket.last
        }
        return next.last
    }
}