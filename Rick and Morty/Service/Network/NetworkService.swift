//
//  NetworkService.swift
//  Rick and Morty
//
//  Created by Денис Иванов on 23.10.2019.
//  Copyright © 2019 Денис Иванов. All rights reserved.
//

import Foundation

class NetworkService {
    
    func loadData<T: Decodable>(target: ApiTarget, type: T.Type, completion: @escaping ((Result<T, Error>) -> ())) {
        do {
            let requset = try confugureRequest(in: target)
            let task = createSession(type: type, request: requset, completion: completion)
            task.resume()
        } catch {
            completion(.failure(error))
        }
    }
    
    private func configureUrl(in target: ApiTarget) throws -> URL {
        var urlComponets = URLComponents()
        urlComponets.scheme = target.scheme
        urlComponets.host = target.host
        urlComponets.path = target.path
        urlComponets.queryItems = target.parametrs.map { URLQueryItem(name: $0.key, value: $0.value) }
        print(try urlComponets.craeteUrl())
        return try urlComponets.craeteUrl()
    }
    
    private func confugureRequest(in target: ApiTarget) throws -> URLRequest {
        var request = URLRequest(url: try configureUrl(in: target))
        request.httpMethod = target.httpMethod
        return request
    }
    
    private func createSession<T: Decodable>(type: T.Type, request: URLRequest, completion: @escaping ((Result<T, Error>) -> ())) -> URLSessionDataTask {
        URLSession.shared.dataTask(with: request) {
            if let error = $2 {
                completion(.failure(error)) }
            guard let data = $0 else {
                completion(.failure(NetworkError.dataNotExist))
                return
            }
            completion(self.jsonDecode(type: type, dataJson: data))
        }
    }
    
    private func jsonDecode<T: Decodable>(type: T.Type, dataJson: Data) -> Result<T, Error> {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let newData = try! jsonDecoder.decode(type, from: dataJson)
            return .success(newData)
        } catch {
            return .failure(error)
        }
    }
}

extension URLComponents {
    func craeteUrl() throws -> URL {
        guard let url = url else { throw NetworkError.invalidUrl }
        return url
    }
}
