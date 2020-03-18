//
//  DateFormaterService.swift
//  Ricky and Morty
//
//  Created by Denis Ivanov on 15.03.2020.
//  Copyright © 2020 Денис Иванов. All rights reserved.
//

import Foundation

class DateFormaterService {
    func creatDateString(stringJson: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = dateFormatter.date(from: stringJson.corectStringDate()) else { return ""}
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        
        return "\(components.day!).\(components.month!).\(components.year!) \(components.hour!):\(components.minute!)"
    }
}

extension String {
    func corectStringDate() -> String {
        var string = ""
        for character in self {
            if string.count != 19 {
                 string.append(character)
            }
        }
        return string
    }
}
