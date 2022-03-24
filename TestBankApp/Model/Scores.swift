//
//  Scores.swift
//  TestBankApp
//
//  Created by admin on 3/23/22.
//


import Foundation


struct Scores {
    var userID : Int
    var quizID: Int
    var dateTaken : String
    var score : Int
  
    
    
    init(userID: Int,quizID: Int, dateTaken: String, score: Int){
        self.userID = userID
        self.quizID = quizID
        self.dateTaken = dateTaken
        self.score = score
     
    }
}
