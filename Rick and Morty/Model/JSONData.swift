//
//  JSONData.swift
//  Rick and Morty
//
//  Created by Denis Ivanov on 14.03.2020.
//  Copyright © 2020 Денис Иванов. All rights reserved.
//

import Foundation

struct JSONData: Codable {
    let info: Info
    let results: [Сharacter]
    
    init(dictionary: [String: Any]) {
        let infoDistionary = dictionary["info"] as! [String: Any]
        let resultsDistionary = dictionary["results"] as! [[String: Any]]
        
        info = Info(infoDistionary: infoDistionary)
        results = resultsDistionary.map { Сharacter(characterDictionary: $0) }
    }
    
    static func getСharacters(from value: Any) -> JSONData? {
        guard let jsonData = value as? [String: Any] else { return nil }
        return JSONData(dictionary: jsonData)
    }
}
