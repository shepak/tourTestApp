//
//  LabelWithPadding.swift
//  ToursTest
//
//  Created by r.mustafin on 04.03.2024.
//

import Foundation
import UIKit

class LabelWithPadding: UILabel {
    enum Guidelines {
        static let verticalPadding: CGFloat = 4
        static let horizontalPadding: CGFloat = 8
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: Guidelines.verticalPadding, left: Guidelines.horizontalPadding, bottom: Guidelines.verticalPadding, right: Guidelines.horizontalPadding)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(
            width: size.width + Guidelines.horizontalPadding * 2,
            height: size.height + Guidelines.verticalPadding * 2
        )
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - Guidelines.horizontalPadding * 2
            layer.cornerRadius = intrinsicContentSize.height / 2
        }
    }

    func customize(color: UIColor?) {
        backgroundColor = color
        clipsToBounds = true
    }
}
