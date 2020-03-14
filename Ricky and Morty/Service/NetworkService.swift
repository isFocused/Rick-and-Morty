//
//  NetworkService.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 23.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    
    private var jsonUrlString: String? = "https://rickandmortyapi.com/api/character/"
    
    func getData(completion: @escaping ([Сharacter]?) -> ()) {
        guard let stringUrl = jsonUrlString else { return }
        guard let url = URL(string: stringUrl) else { return }
        AF.request(url).validate().responseJSON { dataResponse in

            switch dataResponse.result {
            case .success(let value):
                let newСharacters = Welcome.getСharacters(from: value)
                self.jsonUrlString = newСharacters?.info.next
                completion(newСharacters?.results)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

