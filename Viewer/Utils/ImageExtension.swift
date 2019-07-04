//
//  ImageExtension.swift
//  Viewer
//
//  Created by Dario Suarez on 25/06/2019.
//  Copyright © 2019 Dario Suarez. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String) {
        self.image = nil
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url,
                                   completionHandler: { (data, response, error) -> Void in
                                    
                                    if error != nil {
                                        debugPrint("Error downloading image: " + (error?.localizedDescription ?? "unknown"))
                                        return
                                    }
                                    guard let dataImage = data,
                                        let imageFromData = UIImage(data: dataImage) else { return }
                                    DispatchQueue.main.async(execute: { () -> Void in
                                        self.image = imageFromData
                                    })
        }).resume()
    }
}
