//
//  ItemService.swift
//  Viewer
//
//  Created by Dario Suarez on 29/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import Foundation

enum ItemService: Service {
    
    case getDescription(id: String)
    
    var baseURL: String {
        return "https://api.mercadolibre.com"
    }
    
    var path: String {
        switch self {
        case .getDescription(let id):
            return "/items/\(id)/description"
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .getDescription:
            return nil
        }
    }
    
    var method: HttpMethod {
        switch self {
        case .getDescription:
            return .get
        }
    }
    
}
