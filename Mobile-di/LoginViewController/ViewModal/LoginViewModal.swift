//
//  LoginViewModal.swift
//  Mobile-di
//
//  Created by Raghavendra Shedole on 04/02/18.
//  Copyright © 2018 Raghavendra Shedole. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class LoginViewModal {
    var email = Variable<String>("")
    var password = Variable<String>("")
    
    
    /// Setting observer on email and password and checking the validation of email and password
    var validateFields:Observable<Bool> {
        return Observable.combineLatest(email.asObservable().distinctUntilChanged(),password.asObservable().distinctUntilChanged()) { email,password in
            self.isValidEmail(email: email) && self.isValidPassword(password:password)
        }
    }
    
    
    /// Checking email validation
    ///
    /// - Parameter email: email
    /// - Returns: true if email is valid else false
    func isValidEmail(email:String?) -> Bool {
        guard email != nil else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        print("valid email = \(emailTest.evaluate(with: email))")
        return emailTest.evaluate(with: email)
    }
    
    /// * Minimum of 6 digit password validation
    ///
    /// - Returns: true is the password contains at least 6 characters
    func isValidPassword(password:String?) -> Bool {
        guard password != nil else { return false }
        let passwordRegex = "^(?=.*[A-Za-z])[A-Za-z]{6,}$"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        print("Valid Password = \(passwordTest.evaluate(with: password))")
        return passwordTest.evaluate(with: password)
    }
    
    /// Checking the combination of email and password is correct or not
    var isValid:Bool! {
        if email.value == "shedole@gmail.com" && password.value == "shedole" {
            return true
        }else {
            return false
        }
    }
    
    
   
}


