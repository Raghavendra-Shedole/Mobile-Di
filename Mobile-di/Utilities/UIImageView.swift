//
//  UIImageView.swift
//  Ufy_Store
//
//  Created by Raghavendra Shedole on 31/01/18.
//  Copyright © 2018 Nabeel Gulzar. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher


class CustomImageView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setImage(url:String) {
        let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        indicator.frame = self.bounds
        indicator.color = UIColor.darkGray
        indicator.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.addSubview(indicator)
        indicator.startAnimating()
        let trimmedString = url.trimmingCharacters(in: .whitespaces)
        self.kf.setImage(with: URL(string: trimmedString),
                         placeholder: self.image,
                         options: [.transition(ImageTransition.fade(1))],
                         progressBlock: { receivedSize, totalSize in
        },
                         completionHandler: { image, error, cacheType, imageURL in
                            indicator.stopAnimating()
                            indicator.removeFromSuperview()
        })
    }
}




