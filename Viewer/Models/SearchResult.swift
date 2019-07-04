//
//  SearchResult.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

struct SearchResult: Codable {
    let siteId: String?
    let query: String?
    let results: [SearchResultItem]?
}
