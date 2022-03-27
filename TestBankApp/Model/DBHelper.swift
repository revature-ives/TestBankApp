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
    var quizzesTakenByUser = [TakenQuizz]()
    var scoresList = [Scores]()
   
    
    
    var rankingTupleByTechXcode = [(name: String,rankin: String)] ()
    var rankingTupleByTechSwift = [(name: String,rankin: String)] ()
    var rankingTupleByTechIOS = [(name: String,rankin: String)] ()
    var rankingListByTechnology = [User]()
    var rankingsList = [User]()
    var scoresForuser = [Int]()
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
    
    
    func addUserToDataBase(name: String,password: String,ranking: String,subscribed: String,mail: String,blocked: String){
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
    
        if sqlite3_bind_text(stmt, 3, userRankin.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }
        
        if sqlite3_bind_text(stmt, 4, userSubscribed.utf8String, -1, nil) != SQLITE_OK{
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
    
    
    //Method to add feedback to the database
    func addFeedback(feedback: String, userID: Int){
        
        let feed = feedback as! NSString
        let id = userID
        
        
        
        var stmt: OpaquePointer?
        
       
        let query = "INSERT INTO Feedback (UserID,Feedback) VALUES (?,?)"
       
        
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        if sqlite3_bind_text(stmt, 2, feed.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
        
        print("Feedback added to database")
        
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
    
    
    
    
    
    func fetchQuizzTakenByUser(userID: Int){
        
        let userIDtoFetch = userID as! Int
        
        let query = "SELECT * FROM Users_Quizzes WHERE UserID = '\(userIDtoFetch)'"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
        }
        
        //Bind the requeste email
        
        let index : Int = Int (sqlite3_bind_parameter_index(stmt, "userIDtoFetch"))
        //print("this is the index: " ,index)
        if sqlite3_bind_int(stmt,Int32(index),Int32(userIDtoFetch)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print("error in biding index")
        }
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let userId = sqlite3_column_int(stmt, 0)
            let quizzId = sqlite3_column_int(stmt, 1)
            let dateTaked = String(cString: sqlite3_column_text(stmt, 2))
            let score = sqlite3_column_int(stmt, 3)
            
            
            quizzesTakenByUser.append(TakenQuizz(userid: userID, quizzid:Int(quizzId), datetaked: dateTaked, scored: Int(score)))
            scoresForuser.append(Int(score))
            
        }
        
        for list in quizzesTakenByUser{
            print("user took quizz id: \(list.userID)  id of quizz taken:\(list.quizzID)   date taked: \(list.dateTakeb) score achieve: \(list.score)")
        }
        
    }
    
    func viewUserScores(userID: Int){
        
           let id = userID
        
           let query = "SELECT * FROM Users_Quizzes WHERE UserID == '\(id)'"
        
          var stmt: OpaquePointer?
        
          if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
          }
        
        //Bind the requeste email
        
         let index : Int = Int (sqlite3_bind_parameter_index(stmt, "id"))
         if sqlite3_bind_int(stmt,Int32(index),Int32(id)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
             print(err)
            
        }
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let userID = sqlite3_column_int(stmt, 0)
            let quizID = sqlite3_column_int(stmt, 1)
            let dateTaken = String(cString: sqlite3_column_text(stmt, 2))
            let score = sqlite3_column_int(stmt, 3)
            
            
            
            scoresList.append(Scores(userID: Int(userID), quizID: Int(quizID), dateTaken: dateTaken, score: Int(score)))
        }
    
    }
    
    //Fech all users and populater a list whit all the average score
  
    
    //function to update the rankin
    
    func updateRankin(userIDtoUpdate: Int, newRanking: Double) {
        let userId = userIDtoUpdate as! Int
        let rankin = newRanking as! Double
        let rankinText = String(rankin)
        
        
        
        
        var stmt: OpaquePointer?
        
       // "UPDATE Users SET Blocked = 'true' WHERE Email = '\(userEmail)'"
        let query = "UPDATE Users SET Rakin = '\(newRanking)' WHERE ID = '\(userId)' "
       
        
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
     /*   let index : Int = Int (sqlite3_bind_parameter_index(stmt, "userId"))
        print("this is the index to update: ",index)
        if sqlite3_bind_int(stmt,Int32(index),Int32(userId)) != SQLITE_OK{
           let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        
       if sqlite3_bind_text(stmt, 3, rankinText, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
          
            
        }*/
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
       
        
        
        print("data save")
        
    }
    
    func calculateRanking() -> [User] {
       
        
        let query = "SELECT * FROM Users ORDER BY Rakin DESC"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return rankingsList
            
        }
        
        //Bind the requeste email
        
       /* let index : Int = Int (sqlite3_bind_parameter_index(stmt, "emailFetch"))
        if sqlite3_bind_text(stmt,Int32(index),emailFetch.utf8String,-1,nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }*/
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let password = String(cString: sqlite3_column_text(stmt, 2))
            let Rakin = String(cString: sqlite3_column_text(stmt, 3))
            let subscribed = String(cString: sqlite3_column_text(stmt, 4))
            let email = String(cString: sqlite3_column_text(stmt, 5))
            let blocked = String(cString: sqlite3_column_text(stmt, 6))
            
            rankingsList.append(User(id: Int(id), name: name, password: password, subscribed: subscribed, ranking: Rakin, email: email, blocked: blocked))
        }
        
        for list in usersList{
            print("ID is \(list.id) the name is \(list.name) password \(list.password) subscribed \(list.subscribed) rankin \(list.ranking) emai is : \(list.email) blocked is \(list.blocked)")
        }
            
            
          
        return rankingsList
            
        
    }
    
    
    func rankingBytechnologyIOS(){
        
        let query = "select Users.Name,Users.Rakin from Users_Quizzes INNER JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID  INNER  JOIN Users on Users_Quizzes.UserID=Users.ID  where Quizzes.Technology='IOS' order by Users.Rakin DESC"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
        }
        
        //Bind the requeste email
        
       /* let index : Int = Int (sqlite3_bind_parameter_index(stmt, "emailFetch"))
        if sqlite3_bind_text(stmt,Int32(index),emailFetch.utf8String,-1,nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }*/
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
           
            let name1 = String(cString: sqlite3_column_text(stmt, 0))
            
            let rakin1 = String(cString: sqlite3_column_text(stmt, 1))
            
            
            rankingTupleByTechIOS.append((name1,rakin1))
           
        }
        
       
            
            
          
        
            
        
        
    }
  
    func rankingBytechnologySwift(){
        
        let query = "select Users.Name,Users.Rakin from Users_Quizzes INNER JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID  INNER  JOIN Users on Users_Quizzes.UserID=Users.ID  where Quizzes.Technology='swift' order by Users.Rakin DESC"
        
        var stmt: OpaquePointer?
        
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
        }
        
        //Bind the requeste email
        
       /* let index : Int = Int (sqlite3_bind_parameter_index(stmt, "emailFetch"))
        if sqlite3_bind_text(stmt,Int32(index),emailFetch.utf8String,-1,nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            
        }*/
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
           
            let name1 = String(cString: sqlite3_column_text(stmt, 0))
            
            let rakin1 = String(cString: sqlite3_column_text(stmt, 1))
            
            
            rankingTupleByTechSwift.append((name1,rakin1))
           
        }
    }
        
        func rankingBytechnologyXcode(){
            
            let query = "select Users.Name,Users.Rakin from Users_Quizzes INNER JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID  INNER  JOIN Users on Users_Quizzes.UserID=Users.ID  where Quizzes.Technology='xcode' order by Users.Rakin DESC"
            
            var stmt: OpaquePointer?
            
            if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
                
                let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
                print(err)
                return
                
            }
            
            //Bind the requeste email
            
           /* let index : Int = Int (sqlite3_bind_parameter_index(stmt, "emailFetch"))
            if sqlite3_bind_text(stmt,Int32(index),emailFetch.utf8String,-1,nil) != SQLITE_OK{
                let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
                
            }*/
            
            
            
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                
               
                let name1 = String(cString: sqlite3_column_text(stmt, 0))
                
                let rakin1 = String(cString: sqlite3_column_text(stmt, 1))
                
                
                rankingTupleByTechXcode.append((name1,rakin1))
               
            }
    
        
    }
    
    
    func viewQuizzScoreByIdandTech(userID: Int, tech: String){
        
           let id = userID
        
           let query = "select * from Users_Quizzes  inner JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID   where Users_Quizzes.UserID = '\(userID)' and  Quizzes.Technology = '\(tech)'"
        
        
        
        
          var stmt: OpaquePointer?
        
          if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK {
            
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
            
          }
        
        //Bind the requeste email
        
         let index : Int = Int (sqlite3_bind_parameter_index(stmt, "id"))
         if sqlite3_bind_int(stmt,Int32(index),Int32(id)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
             print(err)
            
        }
        
        
        
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            
            let userID = sqlite3_column_int(stmt, 0)
            let quizID = sqlite3_column_int(stmt, 1)
            let dateTaken = String(cString: sqlite3_column_text(stmt, 2))
            let score = sqlite3_column_int(stmt, 3)
            
            
            
            quizzesTakenByUser.append(TakenQuizz(userid: Int(userID), quizzid: Int(quizID), datetaked: dateTaken, scored: Int(score)))
        }
    
    }}
