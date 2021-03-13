//
//  NetworkError.swift
//  Ricky and Morty
//
//  Created by Denis Ivanov on 13.03.2021.
//  Copyright © 2021 Денис Иванов. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case dataNotExist
    case decodeError
}
