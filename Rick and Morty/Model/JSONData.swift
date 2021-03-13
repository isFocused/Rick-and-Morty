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
}
