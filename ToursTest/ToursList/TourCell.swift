//
//  TourCell.swift
//  ToursTest
//
//  Created by r.mustafin on 04.03.2024.
//

import Foundation
import UIKit

final class TourCell: UITableViewCell, CellContentConfiguatorProtocol {

    typealias ViewModel = Offer

    var tour: ViewModel? {
        didSet {
            guard let tour = tour else { return }
            nameLabel.text = tour.hotelName
            priceLabel.text = "от \(tour.totalPrice.total) за \(tour.adults)-x"
            infoLabel.setupInfo(startDate: FormatDate.formateDate(fromDateFormat: "YYYY-MM-dd", date: tour.startDate, toDateFormat: "dd.MM EEE"), duration: tour.duration)
            starLabel.numberOfStars = 5
//            sequenceLabel.text = rvm.sequenceNumber.romanNumeral()
//            nameLabel.text = rvm.model.name
//            scoreLabel.text = rvm.model.scoresCount.description
        }
    }

    // UI
    private lazy var hotelImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.layer.cornerRadius = 14
        view.image = UIImage(named: "Hotel1")
        view.clipsToBounds = true
        return view
    }()

    private lazy var frontView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 24
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()


    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .black
        return label
    }()

    private lazy var lineLabel: LabelWithPadding  = {
        let label = LabelWithPadding()
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "1 Линия"
        label.customize(color: Specs.Color.lightGray)
        return label
    }()

    private lazy var wifiLabel: LabelWithPadding  = {
        let label = LabelWithPadding()
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.text = "Бесплатный WiFi"
        label.customize(color: Specs.Color.lightGray)
        return label
    }()
    
    
    
    private lazy var distanceToBeachLabel: LabelWithPadding  = {
        let label = LabelWithPadding()
        label.textAlignment = .natural
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.customize(color: Specs.Color.lightGray)
        label.text = "200 м до пляжа"
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
//        label.text = "от 123123 за 2-х"
        return label
    }()
    
    private lazy var infoLabel: CustomInfoLabel = {
        let label = CustomInfoLabel()
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private var starLabel = StarRatingLabel()

    func setup(with viewModel: ViewModel) {
        setupUI()
        tour = viewModel
    }

    // MARK: - Private

    private func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(frontView)
        frontView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(3)
            $0.bottom.equalToSuperview().offset(-3)
            $0.left.right.equalToSuperview()
        }

        frontView.addSubview(hotelImage)
        frontView.addSubview(starLabel)
        frontView.addSubview(nameLabel)
        frontView.addSubview(lineLabel)
        frontView.addSubview(wifiLabel)
        frontView.addSubview(distanceToBeachLabel)
        frontView.addSubview(infoLabel)
        frontView.addSubview(priceLabel)

        hotelImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.height.equalTo(160)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }
        
        starLabel.snp.makeConstraints {
            $0.top.equalTo(hotelImage.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
        }


        nameLabel.snp.makeConstraints {
            $0.top.equalTo(starLabel.snp.bottom)
            $0.left.equalToSuperview().offset(16)
            $0.right.equalToSuperview().offset(-16)
        }

        lineLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
        }

        distanceToBeachLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.left.equalTo(lineLabel.snp.right).offset(8)
        }
        
        wifiLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
            $0.left.equalTo(distanceToBeachLabel.snp.right).offset(8)
        }


        infoLabel.snp.makeConstraints {
            $0.top.equalTo(distanceToBeachLabel.snp.bottom).offset(8)
            $0.left.equalToSuperview().offset(16)
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
            $0.bottom.equalToSuperview().offset(-16)
        }


    }
    
}
