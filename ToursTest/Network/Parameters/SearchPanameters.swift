//
//  SearchPanameters.swift
//  ToursTest
//
//  Created by r.mustafin on 03.03.2024.
//

import Foundation

struct SearchRequest: Codable {
    let search: SearchParameters
}

struct SearchParameters: Codable {
    let departCityID: Int
    let regionIds: [Int]
    let startFrom: String
    let startTo: String
    let durationFrom: Int
    let durationTo: Int
    let adults: Int
}
