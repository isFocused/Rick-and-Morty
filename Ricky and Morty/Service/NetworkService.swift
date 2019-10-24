//
//  NetworkService.swift
//  Ricky and Morty
//
//  Created by Денис Иванов on 23.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import Alamofire

class NetworkService {
    
    private var jsonUrlString = "https://rickandmortyapi.com/api/character/"
    
    func getData(completion: @escaping ([Сharacter]?) -> ()){
        generateRandomId(urlString: &jsonUrlString)
        
        guard let url = URL(string: jsonUrlString) else { return }
        request(url).validate().responseJSON { dataResponse in
            
            switch dataResponse.result {
            case .success(let value):
                let newСharacters = Сharacter.getСharacters(from: value)
                completion(newСharacters)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /*
     Добавил генерацию случайных айди, при каждом новом запуске, персонажи будут загружаться случайно, а не одни и теже, как было до этого.
     */
    
    private func generateRandomId(urlString: inout String) {
        var newStringValues = ""
        var quantity = 20
        
        (1...20).forEach { _ in
            quantity -= 1
            let stringValue = Int.random(in: 1...493)
            quantity != 0 ? newStringValues.append(contentsOf: "\(stringValue),") :
                            newStringValues.append(contentsOf: "\(stringValue)")
        }
        urlString += newStringValues
    }
}

