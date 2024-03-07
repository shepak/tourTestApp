//
//  ToursDTO.swift
//  ToursTest
//
//  Created by r.mustafin on 04.03.2024.
//

import UIKit
struct ToursDTO: Codable {

    let countryName: String?
    let startFrom: String
    let startTo: String
    let adults: Int
    let durationTo: Int
    let key: String
    
    func toDomain() -> Tour {
        .init(countryName: countryName ?? "",
              startFrom: startFrom,
              startTo: startTo,
              adults: adults,
              durationTo: durationTo,
              key: key
        
        )
    }
    
    

}
