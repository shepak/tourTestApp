//
//  DepartCitiesDTO.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import Foundation

struct DepartCitiesDTO: Codable {

    let id: Int
    let name: String
    let countryId: Int
    let countryName: String
    let pathIds: [Int]
    
    func toDomain() -> DepartCity {
        .init(
            id: id,
            name: name,
            countryId: countryId,
            countryName: countryName,
            pathIds: pathIds)
    }

}
