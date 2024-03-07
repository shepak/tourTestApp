//
//  StackViewExtensions.swift
//  ToursTest
//
//  Created by r.mustafin on 01.03.2024.
//

import Foundation
import UIKit
import SnapKit

extension UIStackView {
    
    func addSeparator(of size: CGFloat){
        let separatorView = UIView()
        separatorView.backgroundColor = .white
        if axis == .vertical {
            separatorView.snp.makeConstraints { make in
                make.height.equalTo(size)
            }
        } else {
            separatorView.snp.makeConstraints { make in
                make.width.equalTo(size)
            }
        }
        addArrangedSubview(separatorView)
    }
}
