//
//  DetailsViewController.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var detailsLabel: UILabel!
    var country:Country!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.detailsLabel.text = "1.Rank \t\t  : \t \(country.rank)\n2.Name \t\t  : \t \(country.country)\n3.Population  : \t \(country.population)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  

}
