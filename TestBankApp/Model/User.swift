//
//  User.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/17/22.
//

import Foundation

class User{
    let id: Int
    let name: String
    var password : String
    var subscribed : String
    var ranking : String
    var email: String
    var quizzes :[Quizz]
    
    init(id: Int,name: String,password: String,subscribed: String,ranking: String,email: String){
        self.id = id
        self.name = name
        self.password = password
        self.subscribed = subscribed
        self.ranking = ranking
        self.email = email
        self.quizzes = [Quizz]()
    }
    
}
