//
//  Shipping.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

/*{
    "free_shipping": true,
    "mode": "me2",
    "tags": [],
    "logistic_type": "drop_off",
    "store_pick_up": false
}*/

struct Shipping: Codable {
    let freeShipping: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case freeShipping = "free_shipping"
    }
    
}
