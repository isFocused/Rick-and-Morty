//
//  Сharacter.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 19.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

struct Сharacter: Decodable {
    let id: Int?
    let name: String?
    let status: Status
    let species: Species
    let gender: Gender
    let image: String?
}

enum Gender: String, Decodable {
    case female = "Female"
    case male = "Male"
    case unknown
    
    init(from decoder: Decoder) throws {
      let label = try decoder.singleValueContainer().decode(String.self)
        self = Gender(rawValue: label) ?? .unknown
    }
}

enum Species: String, Decodable {
    case alien = "Alien"
    case human = "Human"

    init(from decoder: Decoder) throws {
      let label = try decoder.singleValueContainer().decode(String.self)
        self = Species(rawValue: label) ?? .alien
    }
}


enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown

    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = Status(rawValue: label) ?? .unknown
    }
}
