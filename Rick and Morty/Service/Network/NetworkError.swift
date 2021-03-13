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
    case internetNotConnected
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidUrl:
            return "Invalid url. Data cannot be retrieved for display."
        case .dataNotExist:
            return "Data is missing in response."
        case .decodeError:
            return "Json decoding error, invalid format."
        case .internetNotConnected:
            return "There is no internet connection, data download is not possible."
        }
    }
}
