//
//  NetworkService.swift
//  Rick and Morty
//
//  Created by Денис Иванов on 23.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import Foundation
import Alamofire

enum MyError: Error {
    case overflow
    case respons
}

class NetworkService {
    
    private var jsonUrlString: String? = "https://rickandmortyapi.com/api/character/"
    
    func getData(completion: @escaping (Result<[Сharacter]?, Error>) -> ()) {
        guard let stringUrl = jsonUrlString else { return }
        guard let url = URL(string: stringUrl) else { return }
        AF.request(url).validate().responseJSON { dataResponse in

            switch dataResponse.result {
            case .success(let value):
                let newСharacters = JSONData.getСharacters(from: value)
                self.jsonUrlString = newСharacters?.info.next
                completion(.success(newСharacters?.results))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

