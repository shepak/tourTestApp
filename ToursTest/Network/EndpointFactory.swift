//
//  EndpointFactory.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import Foundation

enum EndpointFactory {
    
    
    enum EmptyParameters: String, Codable {
        case none
    }
    
    
//    enum SearchParameters: String {
//        case departCityId = "search[depart_city_id]"
//        case regionIds = "search[region_ids]"
//        case startFrom = "search[start_from]"
//        case startTo = "search[start_to]"
//        case durationTo = "search[duration_to]"
//        case durationFrom = "search[duration_from]"
//        case adults = "search[adults]"
//
//    }
    
    enum SearchParameters: String, Codable {
        case departCityId
        case regionIds
        case startFrom
        case startTo
        case durationTo
        case durationFrom
        case adults
        
    }
    
    enum getSearchParameters: String, Codable{
        case limit
    }
    
    static func makeDepartCitiesEndpoint() -> Endpoint<EmptyParameters> {
        Endpoint(
            type: .get,
            scheme: .https,
            host: GlobalStorage.shared.host,
            path: "/api/v2/public/depart_cities",
            headerParametes: [:],
            urlParameters: [:],
            bodyParameters: [:]
        )
    }
    
    static func makeCountriesEndpoint() -> Endpoint<EmptyParameters> {
        Endpoint(
            type: .get,
            scheme: .https,
            host: GlobalStorage.shared.host,
            path: "/api/v2/public/countries",
            headerParametes: [:],
            urlParameters: [:],
            bodyParameters: [:]
        )
    }
    
    static func makeSearchEndpoint(from searchParameters: SearchRequest) -> Endpoint<SearchParameters> {
        Endpoint(
            type: .post,
            scheme: .https,
            host: GlobalStorage.shared.host,
            path: "/api/v2/public/searches",
            headerParametes: [
                .contentType: "application/json",
            ],
            urlParameters: [:],
            bodyParameters: [:],
            codableParameter: searchParameters
        )
    }
    
    static func makeSearchGetInfoEndpoint(from key: String) -> Endpoint<getSearchParameters> {
        Endpoint(
            type: .get,
            scheme: .https,
            host: GlobalStorage.shared.host,
            path: "/api/v2/public/searches/\(key)/results",
            headerParametes: [:],
            urlParameters: [.limit: "3"],
            bodyParameters: [:]
        )
    }

}
