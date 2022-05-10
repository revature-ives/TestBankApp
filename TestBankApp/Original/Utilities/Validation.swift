//
//  Validation.swift
//  TestBankApp
//
//  Created by admin on 3/18/22.
//

import Foundation


class Validate{
    //MARK: function to check the password text against a format with NSPredicate.
    static func isValidPassword(_ password : String) -> Bool {
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    //MARK: function to check the email matches a format using NSPredicate.
    static func isValidEmail(email: String) -> Bool {
        let emailTest = NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
        return emailTest.evaluate(with: email)
    }
}
