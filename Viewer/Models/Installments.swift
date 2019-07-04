//
//  Installments.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

/*
 {
 "quantity": 12,
 "amount": 204.71,
 "rate": 63.77,
 "currency_id": "ARS"
 }
 */

struct Installments: Codable {
    let quantity: Int?
    let amount: Double?
    let rate: Double?
    let currencyId: String?
    
    private enum CodingKeys: String, CodingKey {
        case quantity = "quantity"
        case amount = "amount"
        case rate = "rate"
        case currencyId = "currency_id"
    }
}
