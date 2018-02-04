//
//  CountryListViewController.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class CountryListViewController: UIViewController {

    @IBOutlet weak var countryListTableView: UITableView!
    var countyViemModal:CountryViewModal!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countyViemModal = CountryViewModal()
        
        self.countryListTableView.rowHeight = 50
        self.countryListTableView.estimatedRowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if  isBeingPresented || isMovingToParentViewController {
            countyViemModal.getServerData()
           self.setTableViewDataSource()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension CountryListViewController:UITableViewDelegate {
    
    //binding tableview data source method with the array of country
    func setTableViewDataSource() {
        self.countyViemModal.arrayOfCountry.asObservable()
            .bind(to: countryListTableView.rx.items(cellIdentifier: CountryTableViewCell.identifier!,
                                                    cellType: CountryTableViewCell.self)) {  row, element, cell in
                                                        cell.item = element
            }
            .disposed(by: disposeBag)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //moving to DetailsViewController on cell selection
        let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: String(describing:DetailsViewController.self)) as! DetailsViewController
        detailsViewController.country = self.countyViemModal.getCountryData(atIndex: indexPath.row)
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
}




