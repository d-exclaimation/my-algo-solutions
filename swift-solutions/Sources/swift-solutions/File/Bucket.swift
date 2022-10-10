//
//  Bucket.swift
//  swift-solutions
//
//  Created by d-exclaimation on 09:26.
//

public class Bucket<Record: Identifiable> {
    private let limit: Int
    private var history: Array<Record.ID> = .init()
    private var storage: Dictionary<Record.ID, Record> = .init()

    public init(limit: Int = 10) {
        self.limit = limit
    }

    public func insert(_ value: Record) throws {
        if history.count >= limit {
            throw FullError(limit: limit)
        }
        if case .some = storage[value.id] {
            throw DuplicateError(id: value.id)
        }
        storage[value.id] = value
        history.append(value.id)
    }

    public func update(with value: Record) throws {
        if case .none = storage[value.id] {
            throw NotExistError(id: value.id)
        }
        storage[value.id] = value
    }

    public func search(given id: Record.ID) -> Record? {
        storage[id]
    }

    public var last: Record? {
        guard let lastid = history.last else {
            return nil
        }
        return storage[lastid]
    }

    public func pop() -> Record? {
        guard let record = last else {
            return nil
        }
        _ = history.popLast()
        storage.removeValue(forKey: record.id)
        return record
    }

    public var isFull: Bool {
        history.count == limit
    }


    public struct DuplicateError: Error {
        public var id: Record.ID
    }
    public struct NotExistError: Error {
        public var id: Record.ID
    }
    public struct FullError: Error {
        public var limit: Int
    }
}