//
//  Scores.swift
//  TestBankApp
//
//  Created by admin on 3/23/22.
//


import Foundation

//Struct to hold the score data from the database.
struct Scores {
    var userID : Int
    var quizID: Int
    var dateTaken : String
    var score : Int
  
    //initializer to set the infromation.
    init(userID: Int,quizID: Int, dateTaken: String, score: Int){
        self.userID = userID
        self.quizID = quizID
        self.dateTaken = dateTaken
        self.score = score
     
    }
}
