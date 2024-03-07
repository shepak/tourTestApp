//
//  SingleValueContainer.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import Foundation

public struct SingleValueContainer<Value: Codable>: Codable {
    public var value: Value

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.value = try container.decode(Value.self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(self.value)
    }
}
