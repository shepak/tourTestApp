//
//  StarRaitingLabel.swift
//  ToursTest
//
//  Created by r.mustafin on 06.03.2024.
//

import UIKit


class StarRatingLabel: UIView {
    
    private var starStackView: UIStackView!
    
    var numberOfStars: Int = 0 {
        didSet {
            updateStars()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    private func setupView() {
        starStackView = UIStackView()
        starStackView.axis = .horizontal
        starStackView.spacing = 2
        addSubview(starStackView)
        
        starStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func updateStars() {
        starStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        for _ in 0..<numberOfStars {
            let starImageView = UIImageView(image: UIImage(systemName: "star.fill"))
            starImageView.tintColor = .systemYellow
            starImageView.contentMode = .scaleAspectFit
            starStackView.addArrangedSubview(starImageView)
        }
    }
}
