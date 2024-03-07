//
//  TextFieldWithPadding.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import UIKit

final class TextFieldWithPadding: UITextField {

    var topPaddingForView: CGFloat = 0
    var leftPaddingForView: CGFloat = 0
    var rightPaddingForView: CGFloat = 0
    var textPadding = UIEdgeInsets.zero

    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPaddingForView
        textRect.origin.y += topPaddingForView
        textRect.size.width += leftPaddingForView
        return textRect
    }

    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPaddingForView
        return textRect
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: textPadding)
    }
}
