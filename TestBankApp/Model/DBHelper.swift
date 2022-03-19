//
//  DBHelper.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/19/22.
//

import Foundation
import SQLite3


class DBHelper {
    
    
    // Create a variable to save the C pointer that wrapp the data base
    
    static var dataBase : OpaquePointer?
    
    //creat the arrays to store the entities
    var usersList = [User]()
    var adminsList = [Admin]()
    var quizzesList = [Quizz]()
    var questionsList = [Question]()
    
    
    
    
    //Data base preparation
    
    func prepareDatabaseFile() -> String {
        
        
        //Name of the database
        let fileName: String = "QuizzAppDB.db"

        //This is the path of the data base
        let fileManager:FileManager = FileManager.default
        let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!

        let documentUrl = directory.appendingPathComponent(fileName)
        let bundleUrl = Bundle.main.resourceURL?.appendingPathComponent(fileName)

        // check if file already exists on simulator
        if fileManager.fileExists(atPath: (documentUrl.path)) {
            print("document file exists!")
            return documentUrl.path
        }
        else if fileManager.fileExists(atPath: (bundleUrl?.path)!) {
            print("document file does not exist, copy from bundle!")
            try! fileManager.copyItem(at:bundleUrl!, to:documentUrl)
        }

        return documentUrl.path
    }
    
    
    func addUserToDataBase(name: String,password: String,subscribed: String,ranking: String,mail: String){
        let userName = name as! NSString
        let userPassword = password as! NSString
        let userSubscribed = subscribed as! NSString
        let userRankin = ranking as! NSString
        let userMail = mail as! NSString
        
        
        
        
        var stmt: OpaquePointer?
       // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Users (Name,Password, Rakin,Subscribed,Email) VALUES (?,?,?,?,?)"
       
        
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        if sqlite3_bind_text(stmt, 1, userName.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_text(stmt, 2, userPassword.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_text(stmt, 3, userSubscribed.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_text(stmt, 4, userRankin.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        if sqlite3_bind_text(stmt, 5, userMail.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        
        print("data save")
        
    }
    
    
    func addQuizz(technology: String){
        
        let tech = technology as! NSString
        
        
        
        var stmt: OpaquePointer?
       // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Quizzes (technology) VALUES (?)"
       
        
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        if sqlite3_bind_text(stmt, 1, tech.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
      
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        
        print("data save")
        
    }
    
    func addQuestionToDatabase(questionAsked: String,option1: String,option2: String,option3: String,answer: String,quizId: Int){
       
        
        let askedQuestion = questionAsked as! NSString
        let opt1 = option1 as! NSString
        let opt2 = option2 as! NSString
        let opt3 = option3 as! NSString
        let answerRight = answer as! NSString
        let quizz = quizId
        
        
        
        
        var stmt: OpaquePointer?
       // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Question (QuestionAsked,option1,option2,option3,answer,QuizzID) VALUES (?,?,?,?,?,?)"
       
        
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        if sqlite3_bind_text(stmt, 1, askedQuestion.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_text(stmt, 2, opt1.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_text(stmt, 3, opt2.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_text(stmt, 4, opt3.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        if sqlite3_bind_text(stmt, 5, answerRight.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_int(stmt, 6, Int32(quizz)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        
        print("Question added to quiz \(quizId)")
        
    }
  
    
    
}