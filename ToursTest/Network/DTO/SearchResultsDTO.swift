//
//  SearchResultsDTO.swift
//  ToursTest
//
//  Created by r.mustafin on 05.03.2024.
//

import Foundation

struct SearchResultDTO: Codable {
    let results: [ResultDTO]
    let stats: StatsDTO
    
    func toDomain() -> SearchResults {
        let results = self.results.map { resultDTO in
            Results(offer: resultDTO.offer.toDomain())
        }
        return SearchResults(results: results, stats: self.stats.toDomain())
        
    }
}

struct ResultDTO: Codable {
    let offer: OfferDTO
}

struct OfferDTO: Codable {
    let hotelId: Int
    let adults: Int
    let startDate: String
    let duration: Int
    let originalName: String
    let price: PriceDTO
    
    func toDomain() -> Offer{
        .init(
            hotelId: hotelId,
            hotelName: originalName,
            adults: adults,
            duration: duration,
            startDate: startDate,
            totalPrice: price.toDomain()
        )
    }
}

struct PriceDTO: Codable {
    let total: Int
    func toDomain() -> Price{
        .init(total: total)
    }
}

struct StatsDTO: Codable {
    let count: Int
    func toDomain() -> Stats{
        .init(count: count)
    }
}
