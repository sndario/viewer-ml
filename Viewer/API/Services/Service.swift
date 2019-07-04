//
//  NetworkingService.swift
//  Viewer
//
//  Created by Dario Suarez on 17/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import Foundation

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var parameters: [String: Any]? { get }
    var method: HttpMethod { get }
}

extension Service {
    
    private var url: URL? {
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.path = path
        
        if method == .get {
            // add query items to url
            guard let parameters = parameters as? [String: String] else {
                return urlComponents?.url
            }
            urlComponents?.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        return urlComponents?.url
    }
    
    public var urlRequest: URLRequest {
        guard let url = self.url else {
            fatalError("URL could not be built")
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }
    
    
}
