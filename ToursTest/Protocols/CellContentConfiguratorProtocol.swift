//
//  CellContentConfiguratorProtocol.swift
//  ToursTest
//
//  Created by r.mustafin on 04.03.2024.
//

import Foundation
protocol CellContentConfiguatorProtocol {
    associatedtype ViewModel
    func setup(with viewModel: ViewModel)
}
