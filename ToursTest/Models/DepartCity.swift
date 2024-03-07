//
//  DepartCity.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import Foundation

struct DepartCity: SearchableModel {
    var id: Int
    var name: String
    var countryId: Int
    var countryName: String
    var pathIds: [Int]

}
