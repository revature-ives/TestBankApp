//
//  Admin.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/17/22.
//

import Foundation


struct Admin {
    
    let id: Int
    let name: String
    let email: String
    let password: String
    
    init(id: Int,name: String, email: String, password: String){
        self.id = id
        self.name = name
        self.email = email
        self.password = password
    }
    
}
