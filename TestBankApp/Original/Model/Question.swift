//
//  Question.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/17/22.
//

import Foundation

struct Question {
    let id : Int
    var question : String
    var option1 : String
    var option2 : String
    var option3 : String
    var answer : String
    var quizzId : Int
    
    init(id: Int,question : String,opt1: String,opt2: String,opt3: String,ans: String,quizId: Int){
        self.id = id
        self.question = question
        self.option1 = opt1
        self.option2 = opt2
        self.option3 = opt3
        self.answer = ans
        self.quizzId = quizId
        
    }
    
    
}
