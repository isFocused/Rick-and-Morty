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
    let status: Status?
    let species: Species?
    let gender: Gender?
    let image: String?
    
    init(characterDictionary: [String: Any]) {
        id = characterDictionary["id"] as? Int
        name = characterDictionary["name"] as? String
        status = (characterDictionary["status"] as? Status.RawValue).map { Status(rawValue: $0) } ?? .unknown
        species = (characterDictionary["species"] as? Species.RawValue).map { Species(rawValue: $0) } ?? .unknown
        gender = (characterDictionary["gender"] as? Gender.RawValue).map { Gender(rawValue: $0) } ?? .unknown
        image = characterDictionary["image"] as? String
    }
    
    static func getСharacters(from value: Any) -> [Сharacter]? {
        guard let jsonData = value as? Array<[String: Any]> else { return nil }
        return jsonData.compactMap { Сharacter(characterDictionary: $0) }
    }
}

enum Gender: String, Decodable {
    case female = "Female"
    case genderless = "Genderless"
    case male = "Male"
    case unknown
}

enum Species: String, Decodable {
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
    case unknown
}


enum Status: String, Decodable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown
}
