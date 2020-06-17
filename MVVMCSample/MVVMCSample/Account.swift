//
//  Account.swift
//  MVVMCSample
//
//  Created by Ranjeet Singh on 20/05/20.
//  Copyright © 2020 Ranjeet Singh. All rights reserved.
//

import Foundation

struct Address: CustomStringConvertible {
    let street: String
    let state: String
    let country: String
    let pinCode: Int
    
    var description: String {
        return "Address: \(street) \(state) \(country) \(pinCode)"
    }
}
struct User {
    let name: String
    let address: Address
}

enum AccountType {
    case prime
    case gold
    case dimond
}

struct Account {
    let accountNumber: String
    let user: User
    let accountType: AccountType
}
