//
//  FormatDate.swift
//  ToursTest
//
//  Created by r.mustafin on 07.03.2024.
//

import Foundation

enum FormatDate {
    
    static func formateDate(fromDateFormat: String, date: String, toDateFormat: String) -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = fromDateFormat
        if let date = dateFormatter.date(from: date) {
                dateFormatter.dateFormat = toDateFormat
                return dateFormatter.string(from: date)
            } else {
                
                return date
            }
    }

    
}
