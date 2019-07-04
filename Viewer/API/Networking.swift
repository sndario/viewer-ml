//
//  Networking.swift
//  Viewer
//
//  Created by Dario Suarez on 17/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(ViewerError)
    case empty
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

protocol NetworkingProtocol {
    func call<U>(urlRequest: URLRequest, validStatusCode: [Int], decodingType: U.Type, completion: @escaping (Result<U>) -> Void) where U: Decodable
}

class Networking: NetworkingProtocol {
    
    let parser: ResponseParser
    var session: URLSession
    
    init(session: URLSession = URLSession.shared,
         parser: ResponseParser = ResponseParser()) {
        self.session = session
        self.parser = parser
    }
    
    func call<U>(urlRequest: URLRequest,
                 validStatusCode: [Int] = Array(200..<300),
                 decodingType: U.Type,
                 completion: @escaping (Result<U>) -> Void) where U: Decodable {
        execute(urlRequest: urlRequest,
                validStatusCode: validStatusCode) { (result, response)  in
            switch result {
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            case .success(let data):
                self.parser.decode(data: data,
                                   decodingType: decodingType,
                                   completion: { (obj) in
                                        completion(.success(obj))
                }, failure: { (err) in
                    completion(.failure(err))
                })
            }
        }
    }
   
}

extension Networking {
    
    private func execute(urlRequest: URLRequest,
                         validStatusCode: [Int],
                         queue: DispatchQueue = .main,
                         completion: @escaping (Result<Data>, HTTPURLResponse?) -> Void) {
        session.dataTask(with: urlRequest) { (dataResponse, response, error) in
            let httpResponse = response as? HTTPURLResponse
            if let err = error {
                queue.async {
                    completion(.failure(ViewerError(err)), httpResponse)
                }
                return
            }
            let statusCode = httpResponse?.statusCode ?? 0
            if !validStatusCode.contains(statusCode) {
                let error = ViewerError.wrongStatusCode(code: statusCode,
                                                        userInfo: [NSLocalizedFailureReasonErrorKey: "INVALID_RESPONSE_CODE" as AnyObject])
                queue.async {
                    completion(.failure(error), httpResponse)
                }
                return
            }
            guard let data = dataResponse else {
                queue.async {
                    completion(.empty, httpResponse)
                }
                return
            }
            queue.async {
                completion(.success(data), httpResponse)
            }
        }.resume()
    }
}
