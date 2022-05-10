//
//  TakenQuizz.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/23/22.
//

import Foundation

class TakenQuizz{
    
    
    var userID : Int
    var quizzID : Int
    var dateTakeb : String
    var score : Int
    
    init(userid: Int, quizzid: Int, datetaked: String, scored: Int){
        
        self.userID = userid
        self.quizzID = quizzid
        self.dateTakeb = datetaked
        self.score = scored
        
    }
    
}
