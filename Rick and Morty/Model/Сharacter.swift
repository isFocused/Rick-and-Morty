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
}

enum Gender: String, Codable {
    case female = "Female"
    case genderless = "Genderless"
    case male = "Male"
    case unknown
}

enum Species: String, Codable {
    case alien = "Alien"
    case animal = "Animal"
    case cronenberg = "Cronenberg"
    case disease = "Disease"
    case human = "Human"
    case humanoid = "Humanoid"
    case mytholog = "Mytholog"
    case parasite = "Parasite"
    case poopybutthole = "Poopybutthole"
    case robot = "Robot"
    case vampire = "Vampire"
    case mythologicalCreature = "Mythological Creature"
    case unknown
}


enum Status: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
