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
    var adminList = [Admin]()
    var quizzesList = [Quizz]()
    var questionsList = [Question]()
  
    
    //This lists are to test the funcionality whit mock data
    var questionsListIOS = [Question]()
    var questionsListSwift = [Question]()
    var questionsListXcode = [Question]()
    
    
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
           // print("document file exists!")
            return documentUrl.path
        }
        else if fileManager.fileExists(atPath: (bundleUrl?.path)!) {
            print("document file does not exist, copy from bundle!")
            try! fileManager.copyItem(at:bundleUrl!, to:documentUrl)
        }

        return documentUrl.path
    }
    
    //Method to change blocked attribute for a user
    func blockUser(email: String){
        let userEmail = email as! NSString
        let query = "UPDATE Users SET Blocked = 'true' WHERE Email = '\(userEmail)'"
        var stmt: OpaquePointer?
        if sqlite3_prepare_v2(DBHelper.dataBase, query,-1, &stmt, nil) == SQLITE_OK{
            if sqlite3_step(stmt) == SQLITE_DONE{
            print("successfully blocked user")
        }else{
            print("could not block user. ")
            }
        }else{
            print("Update statement not prepared.")
        }
        sqlite3_finalize(stmt)
        }
    
    
    
    //Method to add users to database
    
    
    func addUserToDataBase(name: String,password: String,subscribed: String,ranking: String,mail: String,blocked: String){
        let userName = name as! NSString
        let userPassword = password as! NSString
        let userSubscribed = subscribed as! NSString
        let userRankin = ranking as! NSString
        let userMail = mail as! NSString
        let userBlocked = blocked as! NSString
        
        
        
        
        var stmt: OpaquePointer?
       // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Users (Name,Password, Rakin,Subscribed,Email,Blocked) VALUES (?,?,?,?,?,?)"
       
        
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
        if sqlite3_bind_text(stmt, 6, userBlocked.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        
        print("data save")
        
    }
    
    
    
    //Method to add a quizz to the database
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
        
        
        print("quizz added to database")
        
    }
    
    
    //Method to add questions to the dta base
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
    
    
    //Method to fetch user
    //this method still have a bug not ready
    
    func fetchUserByEmail(emailToFetch: String){
        
        let emailFetch = emailToFetch as! NSString
        
        let query = "SELECT * FROM Users WHERE email = '\(emailFetch)'"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
        }
        
        //Bind the requeste email
        
        let index : Int = Int (sqlite3_bind_parameter_index(stmt, "emailFetch"))
        if sqlite3_bind_text(stmt,Int32(index),emailFetch.utf8String,-1,nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let password = String(cString: sqlite3_column_text(stmt, 2))
            let Rakin = String(cString: sqlite3_column_text(stmt, 3))
            let subscribed = String(cString: sqlite3_column_text(stmt, 4))
            let email = String(cString: sqlite3_column_text(stmt, 5))
            let blocked = String(cString: sqlite3_column_text(stmt, 6))
            
            usersList.append(User(id: Int(id), name: name, password: password, subscribed: subscribed, ranking: Rakin, email: email, blocked: blocked))
        }
        
        for list in usersList{
            print("ID is \(list.id) the name is \(list.name) password \(list.password) subscribed \(list.subscribed) rankin \(list.ranking) emai is : \(list.email) blocked is \(list.blocked)")
        }
        
    }
  
    //Fetch Quizzes By technology
    //This method still have a bug
    func fetchQuizessByTechnoilogy(technologyToFetch: String){
        
       let tech = technologyToFetch as! NSString
        
        let query = "SELECT * FROM Quizzes WHERE Technology = '\(tech)'"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
        }
        
        //Bind the requeste tech
        
        let index : Int = Int (sqlite3_bind_parameter_index(stmt, "tech"))
        if sqlite3_bind_text(stmt,Int32(index),tech.utf8String,-1,nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let id = sqlite3_column_int(stmt, 0)
            let techy = String(cString: sqlite3_column_text(stmt, 1))
            
            
            quizzesList.append(Quizz(id: Int(id), tech: techy))
        }
        
        for list in quizzesList{
            print(" quizz id \(list.id) tech is : \(list.technology)")
        }
        
     /*   //Mock Data to Test
        
        let quizzIOS1 = Quizz(id: 1, tech: "IOS")
        let quizzIOS2 = Quizz(id: 2, tech: "IOS")
        let quizzIOS3 = Quizz(id: 3, tech: "IOS")
        let quizzIOS4 = Quizz(id: 4, tech: "IOS")
        let quizzIOS5 = Quizz(id: 5, tech: "IOS")
        let quizzST1 = Quizz(id: 6, tech: "swift")
        let quizzST2 = Quizz(id: 7, tech: "swift")
        let quizzST3 = Quizz(id: 8, tech: "swift")
        let quizzST4 = Quizz(id: 9, tech: "swift")
        let quizzST5 = Quizz(id: 10, tech: "swift")
        let quizzX1 = Quizz(id: 11, tech: "xcode")
        let quizzX2 = Quizz(id: 12, tech: "xcode")
        let quizzX3 = Quizz(id: 13, tech: "xcode")
        let quizzX4 = Quizz(id: 14, tech: "xcode")
        let quizzX5 = Quizz(id: 15, tech: "xcode")
        
        //PopulateLisk whit mock data
     /*   func fillLists(){
            iosQuizzes.append(quizzIOS1)
            iosQuizzes.append(quizzIOS3)
            iosQuizzes.append(quizzIOS4)
            iosQuizzes.append(quizzIOS5)
            swiftQuizzes.append(quizzST1)
            swiftQuizzes.append(quizzST2)
            swiftQuizzes.append(quizzST3)
            swiftQuizzes.append(quizzST4)
            swiftQuizzes.append(quizzST5)
            xcodeQuizzes.append(quizzX1)
            xcodeQuizzes.append(quizzX2)
            xcodeQuizzes.append(quizzX3)
            xcodeQuizzes.append(quizzX4)
            xcodeQuizzes.append(quizzX5)
            
        }*/*/
    }
    
    func retrieveLastQuizInfo(){
        let query = "select * from Quizzes order by ID desc limit 1"
        var stmt : OpaquePointer?
        
        
        if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }
        
            
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
                let id = sqlite3_column_int(stmt, 0)
                let techy = String(cString: sqlite3_column_text(stmt, 1))
                
                
                quizzesList.append(Quizz(id: Int(id), tech: techy))
            }
        }
    
    
    
    
    
    func retrieveAdminInfo(){
        let query = "select * from admin"
        var stmt : OpaquePointer?
        
        
        if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }
        while(sqlite3_step(stmt) == SQLITE_ROW){
//           var admin = Admin(id: Int(sqlite3_column_int(stmt, 0)), name: String(cString: sqlite3_column_text(stmt,1)), email: String(cString: sqlite3_column_text(stmt, 2)), password: String(cString: sqlite3_column_text(stmt, 3)))
            
            
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt,1))
            let email = String(cString: sqlite3_column_text(stmt, 2))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            
            adminList.append(Admin(id: Int(id), name: name, email: email, password: password))
        }
        
        
        
       
        
        
    }
    
    
    
    
    
    
    func Questions(quizId: Int){
        
           let idOfQuizzToTake = quizId as! Int
        
           let query = "SELECT * FROM Question WHERE QuizzID == '\(quizId)'"
        
          var stmt: OpaquePointer?
        
          if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
          }
        
        //Bind the requeste email
        
         let index : Int = Int (sqlite3_bind_parameter_index(stmt, "idOfQuizzToTake"))
         if sqlite3_bind_int(stmt,Int32(index),Int32(idOfQuizzToTake)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let id = sqlite3_column_int(stmt, 0)
            let questionAsked = String(cString: sqlite3_column_text(stmt, 1))
            let answer1 = String(cString: sqlite3_column_text(stmt, 2))
            let answer2 = String(cString: sqlite3_column_text(stmt, 3))
            let answer3 = String(cString: sqlite3_column_text(stmt, 4))
            let rightAnswer = String(cString: sqlite3_column_text(stmt, 5))
            let userId = sqlite3_column_int(stmt, 6)
            
            
            questionsList.append(Question(id: Int(id), question: questionAsked, opt1: answer1, opt2: answer2, opt3: answer3, ans: rightAnswer,quizId: Int(userId)))
        }
        
        for list in questionsList{
            print("ID is \(list.id) the question asked is \(list.question) option1 \(list.option1)  option 2  \(list.option2) option3   \(list.option3) answeris: \(list.answer)")
        }
        
        
     /* //  Mock data
        let question1 = Question(id: 1, question: "What is ios?", opt1: " is a device", opt2: "is an Operating system", opt3: "is Framework", ans: "opt1", quizId: 1)
        let question2 = Question(id: 2, question: "What is AVFoundantion", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 1)
        let question3 = Question(id: 3, question: "What is CoreData", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 1)
        let question4 = Question(id: 4, question: "What is GCD", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt3", quizId: 1)
        let question5 = Question(id: 5, question: "What is CocoaTouch", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 1)
        let question6 = Question(id: 6, question: "What is Let", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
        let question7 = Question(id: 7, question: "What is var", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt3", quizId: 2)
        let question8 = Question(id: 8, question: "What is optional", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
        let question9 = Question(id: 9, question: "What is protocol", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
        let question10 = Question(id: 10, question: "What is dictionary", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 2)
        let question11 = Question(id: 11, question: "What is navigator", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
        let question12 = Question(id: 12, question: "What is debuguer", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt3", quizId: 3)
        let question13 = Question(id: 13, question: "What is storyboard", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
        let question14 = Question(id: 14, question: "What is simulator", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 3)
        let question15 = Question(id: 15, question: "What is git", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
       
        
        let question16 = Question(id: 16, question: "What ios?", opt1: " is a device", opt2: "is an Operating system", opt3: "is Framework", ans: "opt1", quizId: 4)
        let question17 = Question(id: 17, question: "What AVFoundantion", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 4)
        let question18 = Question(id: 18, question: "What  CoreData", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 4)
        let question19 = Question(id: 19, question: "What  GCD", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt3", quizId: 4)
        let question20 = Question(id: 20, question: "What  CocoaTouch", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 5)
        let question21 = Question(id: 21, question: "What  Let", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 5)
        let question22 = Question(id: 22, question: "What  var", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt3", quizId: 5)
        let question23 = Question(id: 23, question: "What  optional", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 6)
        let question24 = Question(id: 24, question: "What  protocol", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 6)
        let question25 = Question(id: 25, question: "What  dictionary", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 6)
        let question26 = Question(id: 26, question: "What  navigator", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 7)
        let question27 = Question(id: 27, question: "What  debuguer", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt3", quizId: 7)
        let question28 = Question(id: 28, question: "What  storyboard", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 7)
        let question29 = Question(id: 29, question: "What  simulator", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 8)
        let question30 = Question(id: 30, question: "What  git", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 8)
       
        
        let question31 = Question(id: 31, question: "What  navi  gator", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 8)
        let question32 = Question(id: 32, question: "What  debu  guer", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt3", quizId: 8)
        let question33 = Question(id: 33, question: "What  story  board", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 9)
        let question34 = Question(id: 34, question: "What  simul  ator", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt2", quizId: 9)
        let question35 = Question(id: 15, question: "What  git", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 8)
        
        
        
        
        
        
        
        let questionDefaoult = Question(id: 16, question: "What is this", opt1: " why", opt2: "how", opt3: "is acar", ans: "opt3", quizId: 0)
        
        
        
        
      
        
        
       
        
        switch quizId{
        case 1:
           /* questionsList[0] = question1
            questionsList[1] = question2
            questionsList[2] = question3
            questionsList[3] = question4
            questionsList[4] = question5*/
            
            questionsList.append(question1)
            questionsList.append(question2)
            questionsList.append(question3)
            questionsList.append(question4)
            questionsList.append(question5)
            
        
        case 2:
            questionsList.append(question5)
            questionsList.append(question6)
            questionsList.append(question7)
            questionsList.append(question8)
            questionsList.append(question9)
            
           /* questionsList[5] = question6
            questionsList[6] = question7
            questionsList[7] = question8
            questionsList[8] = question9
            questionsList[9] = question10*/
            
            
        case 3:
        
            questionsList.append(question10)
            questionsList.append(question11)
            questionsList.append(question12)
            questionsList.append(question13)
            questionsList.append(question14)
            
            /*questionsList[10] = question11
            questionsList[11] = question12
            questionsList[12] = question13
            questionsList[13] = question14
            questionsList[14] = question15*/
            
            
        case 4:
          questionsList.append(question15)
            questionsList.append(question16)
            questionsList.append(question17)
            questionsList.append(question18)
            questionsList.append(question19)
            
         /*   questionsList[15] = question16
            questionsList[16] = question17
            questionsList[17] = question18
            questionsList[18] = question19
            questionsList[19] = question20*/
        case 5:
            
            questionsList.append(question20)
            questionsList.append(question21)
            questionsList.append(question22)
            questionsList.append(question23)
            questionsList.append(question24)
           /* questionsList[20] = question21
            questionsList[21] = question22
            questionsList[22] = question23
            questionsList[23] = question24
            questionsList[24] = question25*/
            
            
        case 6:
        
            questionsList.append(question25)
            questionsList.append(question26)
            questionsList.append(question27)
            questionsList.append(question28)
            questionsList.append(question29)
            
           /* questionsList[25] = question26
            questionsList[26] = question27
            questionsList[27] = question28
            questionsList[28] = question29
            questionsList[29] = question30*/
            
        case 7:
            questionsList.append(question30)
            questionsList.append(question31)
            questionsList.append(question32)
            questionsList.append(question33)
            questionsList.append(question34)
            
        /*   questionsList[30] = question31
            questionsList[31] = question32
            questionsList[32] = question33
            questionsList[33] = question34
            questionsList[34] = question35*/
            
        case 8:
            
        
            questionsList.append(question35)
            questionsList.append(question11)
            questionsList.append(question12)
            questionsList.append(question13)
            questionsList.append(question14)
            
          /*  questionsList[35] = question6
            questionsList[36] = question7
            questionsList[37] = question8
            questionsList[38] = question9
            questionsList[39] = question10*/
            
            
        default:
            questionsList.append(questionDefaoult)
            questionsList.append(questionDefaoult)
            questionsList.append(questionDefaoult)
            questionsList.append(questionDefaoult)
            questionsList.append(questionDefaoult)
            
            
        }*/
    }
    
    
    //Add query to insert a quizz taken by a user logged in
    
    func addQuizzTaken(userId: Int,quizzId: Int, dateTaked: String, score: Int){
        
        
        let userIdLogged = userId as! Int
        let idOfQuizzSelected = quizzId as! Int
        let dateQuizzTaked = dateTaked as! NSString
        let scoreGot = score as! Int
       // let userMail = mail as! NSString
       // let userBlocked = blocked as! NSString
        
        
        
        
        var stmt: OpaquePointer?
       // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Users_Quizzes (UserID,QuizzID, DateTaken,Score) VALUES (?,?,?,?)"
       
        
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(userIdLogged)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_int(stmt, 2, Int32(idOfQuizzSelected)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
       
        
        if sqlite3_bind_text(stmt, 3, dateQuizzTaked.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_int(stmt, 4, Int32(scoreGot)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
      
        
        
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        
        print("data save")
        
    }
    
    
    
    
    
}
