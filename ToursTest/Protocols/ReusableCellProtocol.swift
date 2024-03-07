//
//  ReusableCellProtocol.swift
//  ToursTest
//
//  Created by r.mustafin on 04.03.2024.
//


import UIKit

protocol ReusableCellProtocol {
    static var identifier: String { get }
    static var nib: UINib { get }
}

extension ReusableCellProtocol {
    static var identifier: String {
        String(describing: self)
    }

    static var nib: UINib {
        UINib(nibName: identifier, bundle: nil)
    }
}

extension UITableViewCell: ReusableCellProtocol {}
extension UICollectionViewCell: ReusableCellProtocol {}
