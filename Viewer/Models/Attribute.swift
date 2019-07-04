//
//  Attribute.swift
//  Viewer
//
//  Created by Dario Suarez on 13/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//
/*{
 "name": "Marca",
 "value_id": "9344",
 "value_name": "Apple",
 "value_struct": null,
 "attribute_group_id": "OTHERS",
 "attribute_group_name": "Otros",
 "source": 1,
 "id": "BRAND"
 }*/
struct Attribute: Codable {
    let id: String
    let source: Int?
    let name: String?
    let valueId: String?
    let valueName: String?
    let attributeGroupId: String?
    let attributeGroupName: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case source = "source"
        case name = "name"
        case valueId = "value_id"
        case valueName = "value_name"
        case attributeGroupId = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
    }
}
