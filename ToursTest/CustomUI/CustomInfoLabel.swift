//
//  CustomInfoLabel.swift
//  ToursTest
//
//  Created by r.mustafin on 06.03.2024.
//

import UIKit

class CustomInfoLabel: UILabel {
    
    func setupInfo(startDate: String, duration: Int) {
        let attributedText = NSMutableAttributedString()
        
        let goToText = NSAttributedString(string: "Туда", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedText.append(goToText)
     
        let startDateText = NSAttributedString(string: " \(startDate)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(startDateText)
        
        let separatorText = NSAttributedString(string: " • ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedText.append(separatorText)
        
        let backText = NSAttributedString(string: "Обратно", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedText.append(backText)
        
        let endDateText = NSAttributedString(string: " \(startDate)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(endDateText)
        
        attributedText.append(separatorText)
        
        let nights = NSAttributedString(string: "Ночей", attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributedText.append(nights)
        
        let nightsCount = NSAttributedString(string: " \(duration)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedText.append(nightsCount)
        
        self.attributedText = attributedText
    }
    
    func setupInfoNavigation(startDate: String, duration: Int, people: Int) {
        let attributedText = NSMutableAttributedString()
     
        var nightsLabel = ""
        
        let startDateText = NSAttributedString(string: " \(startDate)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(startDateText)
        
        let separatorText = NSAttributedString(string: " • ", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(separatorText)
        
        let nightsCount = NSAttributedString(string: " \(duration)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(nightsCount)
        
        switch duration{
        case 1:
            nightsLabel = " ночь"
        case 2...4:
            nightsLabel = " ночи"
        default:
            nightsLabel = " ночей"
        }
        
        let nights = NSAttributedString(string: nightsLabel, attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(nights)
        
        attributedText.append(separatorText)
        
        let peopleCount = NSAttributedString(string: " \(people)", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(nightsCount)
        
        let people = NSAttributedString(string: " чел", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedText.append(people)
        
        self.attributedText = attributedText
    }
}
