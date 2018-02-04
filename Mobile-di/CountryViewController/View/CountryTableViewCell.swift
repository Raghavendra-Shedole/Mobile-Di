//
//  CountryTableViewCell.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var countryName: UILabel!
    @IBOutlet weak var countryImageView: CustomImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    /// Call this varriable to get the cell reusable identifier
    static var identifier: String? {
        return String(describing:self)
    }
    
    /// Stored property to assign the data to respective label
    var item:Country? {
        didSet {
            countryName.text = item?.country
            countryImageView.setImage(url: (item?.flag)!)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
