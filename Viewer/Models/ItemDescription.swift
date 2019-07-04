//
//  ItemDescription.swift
//  Viewer
//
//  Created by Dario Suarez on 29/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import UIKit

/*
 {
 "text": "",
 "plain_text": "",
 "last_updated": "",
 "date_created": "",
 "snapshot": {
 "url": "",
 "width": 0,
 "height": 0,
 "status": ""
 }
 }
 */

struct ItemDescription: Codable {
    let text: String
    let plainText: String
    
    private enum CodingKeys: String, CodingKey {
        case text = "text"
        case plainText = "plain_text"
    }
}
