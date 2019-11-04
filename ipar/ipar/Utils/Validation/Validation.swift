//
//  Validation.swift
//  ipar
//
//  Created by Costa Bobroff on 04/11/2019.
//  Copyright © 2019 banda. All rights reserved.
//

import Foundation




func validatePassword(password: String, confirmPassword: String) -> (isValid: Bool, error: String?) {
    if password == "" || confirmPassword == "" {
        return (isValid: false, error: "error: You haven't input password")
    }
    if (password != confirmPassword) {
        return (isValid: false, error: "error: Your passwords doesn't match")
    }
    return (isValid: true, error: nil)
}

func validatePhone(phone: String) -> (isValid: Bool, error: String?) {
    if phone == "" {
        return (isValid: false, error: "error: You haven't phone")
    }
    let phoneNumber = Int(phone)
    if phoneNumber != nil {
        return (isValid: true, error: nil)
    }
    return (isValid: false, error: "error: Please, input numbers")
}

func validateEmail(email: String) -> (isValid: Bool, error: String?) {
    let range = NSRange(location: 0, length: email.utf16.count)
    let regex = try! NSRegularExpression(pattern: ".+@.+[.].+")
    let result = regex.firstMatch(in: email, options: [], range: range)
    if result == nil {
        return (isValid: false, error: "error: Doesn't match email scheme")
    }
    return (isValid: true, error: nil)
}
func validateSignup(email: String, password: String, confirmPassword: String, phone: String) -> (isValid: Bool, errors: [String]) {
    var errors = [String]()
    let infoPhone = validatePhone(phone: phone)
    let infoEmail = validateEmail(email: email)
    let infoPassword = validatePassword(password: password, confirmPassword: confirmPassword)
    if !infoEmail.isValid || !infoEmail.isValid || !infoPassword.isValid {
        if infoEmail.error != nil {
            errors.append(infoEmail.error!)
        }
        if infoPhone.error != nil {
            errors.append(infoPhone.error!)
        }
        if infoPassword.error != nil {
            errors.append(infoPassword.error!)
        }
        return (isValid: false, errors: errors)
    }
    return (isValid: true, errors: [])
}
