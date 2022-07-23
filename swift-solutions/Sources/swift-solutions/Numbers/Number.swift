//
//  Number.swift
//  swift-solutions
//
//  Created by d-exclaimation on 18:12.
//

enum Number: ExpressibleByIntegerLiteral, ExpressibleByFloatLiteral, Hashable, CustomStringConvertible, Comparable {
    case int(Int)
    case decimal(Double)

    init(integerLiteral value: IntegerLiteralType) {
        self = .int(value)
    }

    init(floatLiteral value: FloatLiteralType) {
        self = .decimal(value)
    }

    var description: String {
        switch (self) {
        case .int(let int):
            return int.description
        case .decimal(let double):
            return double.description
        }
    }

	static func < (lhs: Number, rhs: Number) -> Bool {
        switch (lhs, rhs) {
        case (.int(let left), .int(let right)):
            return left < right
        case (.decimal(let left), .decimal(let right)):
            return left < right
        case (.int(let left), .decimal(let right)):
            return Double(left) < right
        case (.decimal(let left), .int(let right)):
            return left < Double(right)
        }
    }

    static func == (lhs: Number, rhs: Number) -> Bool {
        switch (lhs, rhs) {
        case (.int(let left), .int(let right)):
            return left == right
        case (.decimal(let left), .decimal(let right)):
            return left == right
        default:
            return false
        }
	}

}

extension Number: AdditiveArithmetic, Numeric {
    init?<T>(exactly source: T) where T : BinaryInteger {
        switch (source) {
        case let int as Int:
            self = .int(int)
        default:
            guard let double = Double(exactly: source) else {
                return nil
            }
            self = .decimal(double)
        }
    }

    var magnitude: Number {
        switch (self) {
        case .int(let int):
            return .int(Int(int.magnitude))
        case .decimal(let double):
            return .decimal(double.magnitude)
        }
    }

    static func * (lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case (.int(let left), .int(let right)):
            return .int(left * right)
        case (.decimal(let left), .decimal(let right)):
            return .decimal(left * right)
        case (.int(let left), .decimal(let right)):
            return .decimal(Double(left) * right)
        case (.decimal(let left), .int(let right)):
            return .decimal(left * Double(right))
        } 
    }

    static func *= (lhs: inout Number, rhs: Number) {
        switch (lhs, rhs) {
        case (.int(let left), .int(let right)):
            lhs = .int(left * right)
        case (.decimal(let left), .decimal(let right)):
            lhs = .decimal(left * right)
        case (.int(let left), .decimal(let right)):
            lhs = .decimal(Double(left) * right)
        case (.decimal(let left), .int(let right)):
            lhs = .decimal(left * Double(right))
        } 
    }


    static func - (lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case (.int(let left), .int(let right)):
            return .int(left - right)
        case (.decimal(let left), .decimal(let right)):
            return .decimal(left - right)
        case (.int(let left), .decimal(let right)):
            return .decimal(Double(left) - right)
        case (.decimal(let left), .int(let right)):
            return .decimal(left - Double(right))
        }
    }

    static func + (lhs: Number, rhs: Number) -> Number {
        switch (lhs, rhs) {
        case (.int(let left), .int(let right)):
            return .int(left + right)
        case (.decimal(let left), .decimal(let right)):
            return .decimal(left + right)
        case (.int(let left), .decimal(let right)):
            return .decimal(Double(left) + right)
        case (.decimal(let left), .int(let right)):
            return .decimal(left + Double(right))
        }
    }
}
