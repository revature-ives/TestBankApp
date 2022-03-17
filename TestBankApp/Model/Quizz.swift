//
//  Quizz.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/17/22.
//

import Foundation
import Foundation

struct Quizz {
    let id : Int
    let technology : String;
    var questions :[Question]
    
    
    init(id: Int,tech: String,ques: [Question],score: Double){
        self.id = id
        self.technology = tech
        self.questions = ques
        
    }
}
