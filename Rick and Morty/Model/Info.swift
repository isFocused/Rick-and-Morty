//
//  Info.swift
//  Rick and Morty
//
//  Created by Denis Ivanov on 14.03.2020.
//  Copyright © 2020 Денис Иванов. All rights reserved.
//

import Foundation

struct Info: Codable {
    let count, pages: Int
    let next: String?
//    let prev: String
}
