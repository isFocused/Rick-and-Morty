//
//  Status.swift
//  Ricky and Morty
//
//  Created by Denis Ivanov on 13.03.2021.
//  Copyright © 2021 Денис Иванов. All rights reserved.
//

import Foundation

enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
