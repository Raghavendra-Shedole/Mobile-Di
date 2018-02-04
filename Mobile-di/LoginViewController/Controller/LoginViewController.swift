//
//  LoginViewController.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import UIKit
import RxSwift

class LoginViewController: UIViewController {

    let loginModalView = LoginViewModal()
    @IBOutlet weak var emailTextField: CustomTextField!
    @IBOutlet weak var passwordTextField: CustomTextField!
    @IBOutlet weak var signinButton: CustomButton!
    
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setBinding()
    }
    
    /// Setting the bind of email text field and password text field with respective variable of view modal
    func setBinding()  {
        
        //email binding
        _ = self.emailTextField.rx.text
            //notify the text changed if there is no changed in it in last 0.3 sec
            .debounce(0.3, scheduler: MainScheduler.instance)
            .map{$0 ?? ""}.bind(to: self.loginModalView.email)
        
        //password binding
        _ = self.passwordTextField.rx.text
            //notify the text changed if there is no changed in it in last 0.3 sec
            .debounce(0.3, scheduler: MainScheduler.instance)
            .map{$0 ?? ""}.bind(to: self.loginModalView.password)
        
        //setting signinbutton enabled ionly if the both password and email are valid
        _ = self.loginModalView.validateFields.bind(to: self.signinButton.rx.isEnabled)
        
       _ = self.loginModalView.validateFields
        .debounce(0.3, scheduler: MainScheduler.instance)
        .subscribe(onNext: { [weak self] validate in
            print("Validate : \(validate)")
            self?.signinButton.backgroundColor = validate ? UIColor.green : UIColor.gray
        }).disposed(by: disposeBag)
        
       
        //sign in button action
        _ = self.signinButton.rx.tap.subscribe(onNext: { [weak self] in
            
            if (self?.loginModalView.isValid)! {
                self?.performSegue(withIdentifier: String(describing:CountryListViewController.self), sender: nil)
            }else {
                AlertViewController.share.showAlertView(title: "Failed", message: "Please check your email and password")
            }
    }).disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
