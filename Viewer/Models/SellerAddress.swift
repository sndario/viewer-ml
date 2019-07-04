//
//  SellerAddress.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

/*
 {
 "id": "",
 "comment": "",
 "address_line": "",
 "zip_code": "",
 "country": {
 "id": "AR",
 "name": "Argentina"
 },
 "state": {
 "id": "AR-B",
 "name": "Buenos Aires"
 },
 "city": {
 "id": null,
 "name": "San Isidro, Martinez"
 },
 "latitude": "",
 "longitude": ""
 }*/

struct SellerAddress: Codable {
    let id: String
    let comment: String?
    let zipCode: String?
    let latitude: String?
    let longitude: String?
    let addressLine: String?
    let city: City?
    let state: State?
    let country: Country?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case comment = "comment"
        case addressLine = "address_line"
        case zipCode = "zip_code"
        case latitude = "latitude"
        case longitude = "longitude"
        case city = "city"
        case state = "state"
        case country = "country"
    }
    
}
