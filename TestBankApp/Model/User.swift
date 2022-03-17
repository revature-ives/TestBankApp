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
    var subscribed : Bool
    var ranking : Int
    var quizzez : [Quizz]
    
    init(id: Int,name: String,password: String,subscribed: Bool,ranking: Int,quizzes: [Quizz]){
        self.id = id
        self.name = name
        self.password = password
        self.subscribed = subscribed
        self.ranking = ranking
        self.quizzez = quizzes
    }
    
}
