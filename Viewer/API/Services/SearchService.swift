//
//  SearchService.swift
//  Viewer
//
//  Created by Dario Suarez on 17/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import Foundation

enum SearchService: Service {
    
    case getSearch(query: String)
    
    var baseURL: String {
        return "https://api.mercadolibre.com"
    }
    
    var path: String {
        switch self {
        case .getSearch:
            return "/sites/MLA/search"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getSearch(let query):
            return ["q": query]
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getSearch:
            return .get
        }
    }
    
}
