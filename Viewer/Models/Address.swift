//
//  Address.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

/*{
 "state_id": "AR-B",
 "state_name": "Buenos Aires",
 "city_id": null,
 "city_name": "San Isidro, Martinez"
 }*/

struct Address: Codable {
    let stateId: String
    let stateName: String?
    let cityId: String?
    let cityName: String?
    
    private enum CodingKeys: String, CodingKey {
        case stateId = "state_id"
        case stateName = "state_name"
        case cityId = "city_id"
        case cityName = "city_name"
    }
}
