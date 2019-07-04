//
//  SearchResultItem.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//
/*{
 "id": "MLA789222754",
 "site_id": "MLA",
 "title": "iPod 3 Generación - 16 Gb",
 "seller": {},
 "price": 1500,
 "currency_id": "ARS",
 "available_quantity": 1,
 "sold_quantity": 0,
 "buying_mode": "buy_it_now",
 "listing_type_id": "gold_special",
 "stop_time": "2039-06-05T15:14:44.000Z",
 "condition": "used",
 "permalink": "https://articulo.mercadolibre.com.ar/MLA-789222754-ipod-3-generacion-16-gb-_JM",
 "thumbnail": "http://mla-s1-p.mlstatic.com/790854-MLA31038058005_062019-I.jpg",
 "accepts_mercadopago": true,
 "installments": {},
 "address": {},
 "shipping": {},
 "seller_address": {},
 "attributes": [],
 "original_price": null,
 "category_id": "MLA32614",
 "official_store_id": null,
 "catalog_product_id": null,
 "reviews": {},
 "tags": [
 "good_quality_picture",
 "immediate_payment",
 "cart_eligible"
 ]
 }*/
struct SearchResultItem: Codable {
    let id: String
    let siteId: String?
    let title: String?
    let seller: Seller?
    let price: Double?
    let currencyId: String?
    let availableQuantity: Int?
    let soldQuantity: Int?
    let buyingMode: String?
    let listeningTypeId: String?
    let stopTime: String?
    let condition: String?
    let permalink: String?
    let thumbnail: String?
    let acceptsMercadoPago: Bool?
    let installments: Installments?
    let address: Address?
    let shipping: Shipping?
    let sellerAddress: SellerAddress?
    let attributes: [Attribute]?
    let originalPrice: Int?
    let categoryId: String?
    let officialStoreId: Int?
    let catalogProductId: String?
    //let reviews
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case siteId = "site_id"
        case title = "title"
        case seller = "seller"
        case price = "price"
        case currencyId = "currency_id"
        case availableQuantity = "available_quantity"
        case soldQuantity = "sold_quantity"
        case buyingMode = "buying_mode"
        case listeningTypeId = "listing_type_id"
        case stopTime = "stop_time"
        case condition = "condition"
        case permalink = "permalink"
        case thumbnail = "thumbnail"
        case acceptsMercadoPago = "accepts_mercadopago"
        case installments = "installments"
        
        case address = "address"
        case shipping = "shipping"
        case sellerAddress = "seller_address"
        case attributes = "attributes"
        
        case originalPrice = "original_price"
        case categoryId = "category_id"
        case officialStoreId = "official_store_id"
        case catalogProductId = "catalog_product_id"
    }
}
