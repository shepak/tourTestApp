//
//  NavigationBackButton.swift
//  ToursTest
//
//  Created by r.mustafin on 06.03.2024.
//

import UIKit

class NavigationBackButton: UIButton {
    private let buttonSize: CGFloat = 32.0
    private let circleSize: CGFloat = 32.0
    private let circleRadius: CGFloat = 16.0
    private let circleColor: UIColor = Specs.Color.lightGray
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = circleRadius
        view.backgroundColor = circleColor
        return view
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.left"))
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    private func configureButton() {
        addSubview(circleView)
        circleView.addSubview(arrowImageView)
        
        setupLayout()
        
        snp.makeConstraints {
            $0.width.equalTo(buttonSize)
            $0.height.equalTo(buttonSize)
        }
    }
    
    private func setupLayout() {
        circleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(circleSize)
        }
        
        arrowImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
}
