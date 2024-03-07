//
//  DataDelegate.swift
//  ToursTest
//
//  Created by r.mustafin on 03.03.2024.
//

import Foundation
protocol SelectionListDelegate: AnyObject {
    func didSelectCity(name: String, id: Int)
    func didSelectCountry(name: String)
}
