//
//  CountryViewModal.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

let url = "http://www.androidbegin.com/tutorial/jsonparsetutorial.txt"

class CountryViewModal {
    let disposeBag = DisposeBag()
    var arrayOfCountry:Variable<[Country]> = Variable([])
    
    init() {
      //do initialization here
    }
    
    /// Api call for gettin list of country data
    func getServerData() {
        _ = HTTP.getRequest(url: url).subscribe(onNext: { status, data in
            
            if status {
                if let response = data as? [String:Any], let array = response["worldpopulation"] as? [[String:Any]] {
                    self.arrayOfCountry.value  = array.map {
                        Country.init(data: $0)
                    }
                }
            }
        }).disposed(by: disposeBag)
    }
    
    /// It will return the country data and should be used whenever a country data needed
    ///
    /// - Parameter atIndex: index of country
    /// - Returns: will return country object if the index is less than the arrayofcountry count
    func getCountryData(atIndex:Int) -> Country {
        if atIndex >= arrayOfCountry.value.count {
            return Country(data: "")
        }
      return arrayOfCountry.value[atIndex]
    }
}


/// Country object
struct Country {
    var rank = 0
    var country = ""
    var population = ""
    var flag = ""
    
    init(data:Any) {
        
        if let data = data as? [String:Any] {
            rank = data["rank"] as! Int
            country = data["country"] as! String
            population = data["population"] as! String
            flag = data["flag"] as! String
        }
        
    }
}
