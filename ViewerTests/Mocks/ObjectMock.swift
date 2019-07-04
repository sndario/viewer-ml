//
//  ObjectMock.swift
//  ViewerTests
//
//  Created by Dario Suarez on 30/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

@testable import Viewer
import UIKit

struct ObjectMock {
    static var searchResultItem: SearchResultItem {
        return SearchResultItem(id: "", siteId: nil, title: nil, seller: nil, price: nil, currencyId: nil, availableQuantity: nil, soldQuantity: nil, buyingMode: nil, listeningTypeId: nil, stopTime: nil, condition: nil, permalink: nil, thumbnail: nil, acceptsMercadoPago: nil, installments: nil, address: nil, shipping: nil, sellerAddress: nil, attributes: nil, originalPrice: nil, categoryId: nil, officialStoreId: nil, catalogProductId: nil)
    }
    
    static var itemDescription: ItemDescription {
        return ItemDescription(text: "text", plainText: "text")
    }
    
    static var searchResult: SearchResult {
        return SearchResult(siteId: "test", query: "test", results: [SearchResultItem(id: "", siteId: nil, title: nil, seller: nil, price: nil, currencyId: nil, availableQuantity: nil, soldQuantity: nil, buyingMode: nil, listeningTypeId: nil, stopTime: nil, condition: nil, permalink: nil, thumbnail: nil, acceptsMercadoPago: nil, installments: nil, address: nil, shipping: nil, sellerAddress: nil, attributes: nil, originalPrice: nil, categoryId: nil, officialStoreId: nil, catalogProductId: nil)])
    }
}
