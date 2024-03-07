//
//  CounriesDTO.swift
//  ToursTest
//
//  Created by r.mustafin on 03.03.2024.
//

import Foundation

struct CountriesDTO: Codable {

    let id: Int
    let name: String
    
    func toDomain() -> Country {
        .init(
            id: id,
            name: name
            )
    }

}
