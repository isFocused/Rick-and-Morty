//
//  Сharacter.swift
//  Rick and Morty
//
//  Created by Денис Иванов on 19.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

struct Сharacter: Codable {
    let id: Int
    let name: String
    let status: Status
    let species: Species
    let gender: Gender
    let image: String
    let created: String
    let location: Location
    let episode: [String]
}
