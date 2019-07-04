//
//  CustomTableViewCell.swift
//  Viewer
//
//  Created by Dario Suarez on 16/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    func fill(vm: SearchItemResultViewModel) {
        priceLabel.text = vm.price
        titleLabel.text = vm.name
        productImageView.imageFromServerURL(urlString: vm.image)
    }
    
}
