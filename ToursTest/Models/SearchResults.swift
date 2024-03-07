//
//  SearchResults.swift
//  ToursTest
//
//  Created by r.mustafin on 05.03.2024.
//

import Foundation

struct SearchResults {
    let results:[Results]
    let stats: Stats
}
struct Results {
    let offer: Offer
}

struct Offer {
    let hotelId: Int
    let hotelName: String
    let adults: Int
    let duration: Int
    let startDate: String
    let totalPrice: Price
}

struct Price {
    let total: Int
}
struct Stats {
    let count: Int
}
