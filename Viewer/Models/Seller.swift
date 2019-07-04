//
//  Seller.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

/*
 {
 "id": 95074740,
 "power_seller_status": null,
 "car_dealer": false,
 "real_estate_agency": false,
 "tags": []
 }
 */

struct Seller: Codable {
    let id: Int64
    let carDealer: Bool?
    let realEstateAgency: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case carDealer = "car_dealer"
        case realEstateAgency = "real_estate_agency"
    }
}
