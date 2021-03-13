//
//  ApiTarget.swift
//  Ricky and Morty
//
//  Created by Denis Ivanov on 13.03.2021.
//  Copyright © 2021 Денис Иванов. All rights reserved.
//

enum ApiTarget {
    case character(Int)
    
    var httpMethod: String {
        switch self {
        case .character:
            return "GET"
        }
    }
    
    var scheme: String { "https" }
    
    var host: String { "rickandmortyapi.com" }
    
    var path: String {
        switch self {
        case .character:
            return "/api/character/"
        }
    }
    
    var parametrs: [String: String] {
        switch self {
        case let .character(value):
            return ["page": "\(value)"]
        }
    }
}
