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
    
    //MARK: create the arrays to store the entities
    var usersList = [User]()
    var adminList = [Admin]()
    var quizzesList = [Quizz]()
    var questionsList = [Question]()
    var quizzesTakenByUser = [TakenQuizz]()
    var scoresList = [Scores]()
    //MARK: Tuples for the ranking screen.
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
    
    
    //MARK: Data base preparation
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
        //return the path to the databse.
        return documentUrl.path
    }
    
    //MARK: Method to change blocked attribute for a user
    func blockUser(email: String){
        //stores the email provided to the function.
        let userEmail = email as NSString
        //Holds the query to the database. Looks for the user based on Email and changes their "Blocked" attribute.
        let query = "UPDATE Users SET Blocked = 'true' WHERE Email = '\(userEmail)'"
        //Holds the OpaquePointer to the database.
        var stmt: OpaquePointer?
        //Sends the Query to the database and checks if it is successful.
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
    
    
    
    //MARK: Method to add users to database
    func addUserToDataBase(name: String,password: String,ranking: String,subscribed: String,mail: String,blocked: String){

        //Variables to hold the information for the User
        let userName = name as NSString
        let userPassword = password as NSString
        let userSubscribed = subscribed as NSString
        let userRankin = ranking as NSString
        let userMail = mail as NSString
        let userBlocked = blocked as NSString
        //holds the OpaquePointer

        var stmt: OpaquePointer?
       // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Users (Name,Password, Rakin,Subscribed,Email,Blocked) VALUES (?,?,?,?,?,?)"
       
        //Sends the query to the database.
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //binds the Name
        if sqlite3_bind_text(stmt, 1, userName.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //binds the Password
        if sqlite3_bind_text(stmt, 2, userPassword.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //binds the Ranking
        if sqlite3_bind_text(stmt, 3, userRankin.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the subscribed attribute.
        if sqlite3_bind_text(stmt, 4, userSubscribed.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //binds the Email
        if sqlite3_bind_text(stmt, 5, userMail.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the Blocked attribute.
        if sqlite3_bind_text(stmt, 6, userBlocked.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Checks if the bindings succeeded.
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Prints to the console.
        print("data save")
        
    }
    
    
    //MARK: Method to add feedback to the database
    func addFeedback(feedback: String, userID: Int){
        //Holds the data proviced to the function.
        let feed = feedback as NSString
        let id = userID

        //Holds the pointer for the database.
        var stmt: OpaquePointer?
        //Holds the Query for the database.
        let query = "INSERT INTO Feedback (UserID,Feedback) VALUES (?,?)"
       //Sends teh query to the database.

        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //binds the user ID
        if sqlite3_bind_int(stmt, 1, Int32(id)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //binds the Feedback
        if sqlite3_bind_text(stmt, 2, feed.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Check if the action succeeded.
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //prints to console.
        print("Feedback added to database")
        
    }
    
    //MARK: Method to add a quizz to the database
    func addQuizz(technology: String){

        //Holds the technology selected.
        let tech = technology as NSString
        //Holds the database pointer.

        var stmt: OpaquePointer?
        // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Quizzes (technology) VALUES (?)"
        //Queries the database.
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the Technology to the table.
        if sqlite3_bind_text(stmt, 1, tech.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }

        //Checks if the action succeeded.

        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Print to console to signify the action is done.
        print("quizz added to database")
    }
    
    
    //MARK: Method to add questions to the dta base
    func addQuestionToDatabase(questionAsked: String,option1: String,option2: String,option3: String,answer: String,quizId: Int){
        //Holds the variables for the questions.
        let askedQuestion = questionAsked as NSString
        let opt1 = option1 as NSString
        let opt2 = option2 as NSString
        let opt3 = option3 as NSString
        let answerRight = answer as NSString
        let quizz = quizId
        // Holds the pointer for the database.
        var stmt: OpaquePointer?
        // let query = "insert into Users (name, cours) values (?,?)"
        let query = "INSERT INTO Question (QuestionAsked,option1,option2,option3,answer,QuizzID) VALUES (?,?,?,?,?,?)"
        // queries the database
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //binds the Question Asked
        if sqlite3_bind_text(stmt, 1, askedQuestion.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            
        }
        //Binds answer 1
        if sqlite3_bind_text(stmt, 2, opt1.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds answer 2
        if sqlite3_bind_text(stmt, 3, opt2.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds answer 3
        if sqlite3_bind_text(stmt, 4, opt3.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds answer 4
        if sqlite3_bind_text(stmt, 5, answerRight.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the correct answer.
        if sqlite3_bind_int(stmt, 6, Int32(quizz)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Checks that the aciton completed.
        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Prints to verify the action completed.
        print("Question added to quiz \(quizId)")
        
    }
    
    //MARK: Method to fetch user by email.
    func fetchUserByEmail(emailToFetch: String){
        //Holds the email to use.
        let emailFetch = emailToFetch as NSString
        //Holds the query.
        let query = "SELECT * FROM Users WHERE email = '\(emailFetch)'"
        //Holds the database pointer.
        var stmt: OpaquePointer?
        //Queries the database.
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            //holds any possible errors.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            //prints the error to the console.
            print(err)
            return
            
        }
        //Bind the requested email
        let index : Int = Int (sqlite3_bind_parameter_index(stmt, "emailFetch"))
        if sqlite3_bind_text(stmt,Int32(index),emailFetch.utf8String,-1,nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }

        //While loop to enter the infomation into the array.

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //Holds the information pulled from the database.
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let password = String(cString: sqlite3_column_text(stmt, 2))
            let Rakin = String(cString: sqlite3_column_text(stmt, 3))
            let subscribed = String(cString: sqlite3_column_text(stmt, 4))
            let email = String(cString: sqlite3_column_text(stmt, 5))
            let blocked = String(cString: sqlite3_column_text(stmt, 6))
            //Appends the information into the Class Array.
            usersList.append(User(id: Int(id), name: name, password: password, subscribed: subscribed, ranking: Rakin, email: email, blocked: blocked))
        }
        //Prints the information retrieved onto the console.
        for list in usersList{
            print("ID is \(list.id) the name is \(list.name) password \(list.password) subscribed \(list.subscribed) rankin \(list.ranking) emai is : \(list.email) blocked is \(list.blocked)")
        }
    }
  
    //MARK: Fetch Quizzes By technology
    func fetchQuizessByTechnoilogy(technologyToFetch: String){
        //Holds the technology to fetch with.
        let tech = technologyToFetch as NSString
        //Holds the query for the database.
        let query = "SELECT * FROM Quizzes WHERE Technology = '\(tech)'"
        //Holds the database pointer.
        var stmt: OpaquePointer?
        //quries the database.
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            //Holds and prints possible errors.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }
        //Bind the requested tech ad print possible errors.
        let index : Int = Int (sqlite3_bind_parameter_index(stmt, "tech"))
        if sqlite3_bind_text(stmt,Int32(index),tech.utf8String,-1,nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }

        //While loop to add the information to the array.

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //Holds the data retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let techy = String(cString: sqlite3_column_text(stmt, 1))
            //Appends the data to the Class Array.
            quizzesList.append(Quizz(id: Int(id), tech: techy))
        }
    }
    
    //MARK: function to get the last quiz in the table based on ID.
    func retrieveLastQuizInfo(){
        //Holds the query.
        let query = "select * from Quizzes order by ID desc limit 1"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.
        if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }

            //While loop to add the information to the array.
            while(sqlite3_step(stmt) == SQLITE_ROW) {
                //Variables to hold the data retrieved.

                let id = sqlite3_column_int(stmt, 0)
                let techy = String(cString: sqlite3_column_text(stmt, 1))
                //Appends the data to the array.
                quizzesList.append(Quizz(id: Int(id), tech: techy))
            }

    }
    //MARK: function to retrieve the Admin information.

    func retrieveAdminInfo(){
        //Holds the query.
        let query = "select * from admin"
        //Holds the pointer.
        var stmt : OpaquePointer?
        //Queries the database and prints any error.
        if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }
        //While loop to add information to the array.
        while(sqlite3_step(stmt) == SQLITE_ROW){
            //variables to hold the information retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt,1))
            let email = String(cString: sqlite3_column_text(stmt, 2))
            let password = String(cString: sqlite3_column_text(stmt, 3))
            //Appends the information to the array.
            adminList.append(Admin(id: Int(id), name: name, email: email, password: password))
        }

    }
    //MARK: function to get the question information.
    func Questions(quizId: Int){
           //Holds the id provided to the function.
           let idOfQuizzToTake = quizId as Int
           //Holds the query.

           let query = "SELECT * FROM Question WHERE QuizzID == '\(quizId)'"
          //Holds the database pointer.
          var stmt: OpaquePointer?
          //Queries the database.
          if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK {
            //Holds and prints any error.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
          }
        
        //Binds the Quizz ID and prints any errors.
         let index : Int = Int (sqlite3_bind_parameter_index(stmt, "idOfQuizzToTake"))
         if sqlite3_bind_int(stmt,Int32(index),Int32(idOfQuizzToTake)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
             print(err)
        }

        //While loop to store the information in the array.

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //varaibles to hold the infomration retrieved.
            let id = sqlite3_column_int(stmt, 0)
            let questionAsked = String(cString: sqlite3_column_text(stmt, 1))
            let answer1 = String(cString: sqlite3_column_text(stmt, 2))
            let answer2 = String(cString: sqlite3_column_text(stmt, 3))
            let answer3 = String(cString: sqlite3_column_text(stmt, 4))
            let rightAnswer = String(cString: sqlite3_column_text(stmt, 5))
            let userId = sqlite3_column_int(stmt, 6)

            //Appends the data to the class array.
            questionsList.append(Question(id: Int(id), question: questionAsked, opt1: answer1, opt2: answer2, opt3: answer3, ans: rightAnswer,quizId: Int(userId)))
        }

    }
    //MARK: function to add the Quizzes the user has taken.
    func addQuizzTaken(userId: Int,quizzId: Int, dateTaked: String, score: Int){

        //Variables to hold the information.
        let userIdLogged = userId as Int
        let idOfQuizzSelected = quizzId as Int
        let dateQuizzTaked = dateTaked as NSString
        let scoreGot = score as Int
        //variable to hold the pointer.
        var stmt: OpaquePointer?
       // Holds the query. let query = "insert into Users (name, cours) values (?,?)"

        let query = "INSERT INTO Users_Quizzes (UserID,QuizzID, DateTaken,Score) VALUES (?,?,?,?)"
        //Queries the database.
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the UserID
        if sqlite3_bind_int(stmt, 1, Int32(userIdLogged)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the QuizzID
        if sqlite3_bind_int(stmt, 2, Int32(idOfQuizzSelected)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the DateTaken
        if sqlite3_bind_text(stmt, 3, dateQuizzTaked.utf8String, -1, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Binds the Score
        if sqlite3_bind_int(stmt, 4, Int32(scoreGot)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Checks if these actions succeeded.

        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }

        //Prints to verify the action completed.

        print("data save")
    }

    //MARK: function to retrieve the quizzes taken by the user.

    func fetchQuizzTakenByUser(userID: Int){
        //Holds the UserID
        let userIDtoFetch = userID as Int
        //Holds the query to the database.
        let query = "SELECT * FROM Users_Quizzes WHERE UserID = '\(userIDtoFetch)'"
        //Holds the database pointer.
        var stmt: OpaquePointer?
        //Queries the database.
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            //Holds and prints any error.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }
        
        //Bind the requested ID.
        let index : Int = Int (sqlite3_bind_parameter_index(stmt, "userIDtoFetch"))
        //print("this is the index: " ,index)
        if sqlite3_bind_int(stmt,Int32(index),Int32(userIDtoFetch)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            print("error in biding index")
        }
        //While loop to add the information.
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //variables to hold the information.
            let userId = sqlite3_column_int(stmt, 0)
            let quizzId = sqlite3_column_int(stmt, 1)
            let dateTaked = String(cString: sqlite3_column_text(stmt, 2))
            let score = sqlite3_column_int(stmt, 3)
            //appends the information to the class Array.
            quizzesTakenByUser.append(TakenQuizz(userid: userID, quizzid:Int(quizzId), datetaked: dateTaked, scored: Int(score)))
            scoresForuser.append(Int(score))
        }
        //Prints the information retrieved to the console.
        for list in quizzesTakenByUser{
            print("user took quizz id: \(list.userID)  id of quizz taken:\(list.quizzID)   date taked: \(list.dateTakeb) score achieve: \(list.score)")
        }
    }
    //MARK: function to view the scores of the user.
    func viewUserScores(userID: Int){
           //Holds the userID.
           let id = userID
           //Holds the database query.
           let query = "SELECT * FROM Users_Quizzes WHERE UserID == '\(id)'"
          //Holds the database pointer.
          var stmt: OpaquePointer?
          //Queries the databse.
          if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK {
            //Holds and prints any errors.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
          }
        
        //Binds the userID and prints any errors.
         let index : Int = Int (sqlite3_bind_parameter_index(stmt, "id"))
         if sqlite3_bind_int(stmt,Int32(index),Int32(id)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
             print(err)
        }

        //While loop to enter the information into the array.

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //Variables to hold the information.
            let userID = sqlite3_column_int(stmt, 0)
            let quizID = sqlite3_column_int(stmt, 1)
            let dateTaken = String(cString: sqlite3_column_text(stmt, 2))
            let score = sqlite3_column_int(stmt, 3)

            //Appends the information to the Class Array.

            scoresList.append(Scores(userID: Int(userID), quizID: Int(quizID), dateTaken: dateTaken, score: Int(score)))
        }
    }
    
   

  
    
    //MARK: function to update the rankig
    func updateRankin(userIDtoUpdate: Int, newRanking: Double) {

        //Variables to hold the information.
        let userId = userIDtoUpdate as Int
        let rankin = newRanking as Double
        let rankinText = String(rankin)
        //Holds the database Pointer.

        var stmt: OpaquePointer?
        
        //Holds the query.
        let query = "UPDATE Users SET Rakin = '\(newRanking)' WHERE ID = '\(userId)' "
       
        //Queries the database.
        if sqlite3_prepare_v2(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }

        //Checks if the action completed and prints any errors.

        if sqlite3_step(stmt) != SQLITE_DONE {
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
        }
        //Prints to console to verify completion.
        print("data save")
    }
    //MARK: fucntion to calculate the user ranking.
    func calculateRanking() -> [User] {
        //Holds the query.
        let query = "SELECT * FROM Users ORDER BY Rakin DESC"
        //Holds the database pointer.
        var stmt: OpaquePointer?
        //Queries the database.
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            //Holds and prints any errors.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return rankingsList
            
        }

        //While loop to enter the information into the array.

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //Variables to hold the information.
            let id = sqlite3_column_int(stmt, 0)
            let name = String(cString: sqlite3_column_text(stmt, 1))
            let password = String(cString: sqlite3_column_text(stmt, 2))
            let Rakin = String(cString: sqlite3_column_text(stmt, 3))
            let subscribed = String(cString: sqlite3_column_text(stmt, 4))
            let email = String(cString: sqlite3_column_text(stmt, 5))
            let blocked = String(cString: sqlite3_column_text(stmt, 6))
            //Appends the information into the class array.
            rankingsList.append(User(id: Int(id), name: name, password: password, subscribed: subscribed, ranking: Rakin, email: email, blocked: blocked))
        }
        //Prints out the data retrieved.
        for list in usersList{
            print("ID is \(list.id) the name is \(list.name) password \(list.password) subscribed \(list.subscribed) rankin \(list.ranking) emai is : \(list.email) blocked is \(list.blocked)")
        }
        //returns the array.
        return rankingsList
    }
    
    //MARK: fetches the ranking for the iOS technology.
    func rankingBytechnologyIOS(){
        //Holds the query.
        let query = "select Users.Name,Users.Rakin from Users_Quizzes INNER JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID  INNER  JOIN Users on Users_Quizzes.UserID=Users.ID  where Quizzes.Technology='IOS' order by Users.Rakin DESC"
        //Holds the database pointer.
        var stmt: OpaquePointer?
        //Queries the database.
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            //Holds and prints any errors.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }

        //WHile loop to enter the information.

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //variables to hold the information.
            let name1 = String(cString: sqlite3_column_text(stmt, 0))
            let rakin1 = String(cString: sqlite3_column_text(stmt, 1))
            //Adds the information to the array.
            rankingTupleByTechIOS.append((name1,rakin1))
        }

    }
    //MARK: fecthes the ranking by the Swift technology.
    func rankingBytechnologySwift(){
        //Holds the query.
        let query = "select Users.Name,Users.Rakin from Users_Quizzes INNER JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID  INNER  JOIN Users on Users_Quizzes.UserID=Users.ID  where Quizzes.Technology='swift' order by Users.Rakin DESC"
        //Holds the database pointer.
        var stmt: OpaquePointer?
        //Queries the database.
        if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
            //Holds and prints any errors.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
        }

        //While loop to enter the information.

        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //variables to hold the information.
            let name1 = String(cString: sqlite3_column_text(stmt, 0))
            let rakin1 = String(cString: sqlite3_column_text(stmt, 1))
            //Appends the information to the array.
            rankingTupleByTechSwift.append((name1,rakin1))
        }
    }

        //MARK: function to retrieve the XCode rankings
        func rankingBytechnologyXcode(){
            //Holds the query.

            let query = "select Users.Name,Users.Rakin from Users_Quizzes INNER JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID  INNER  JOIN Users on Users_Quizzes.UserID=Users.ID  where Quizzes.Technology='xcode' order by Users.Rakin DESC"
            //Holds the pointer.
            var stmt: OpaquePointer?
            //Queries the database.
            if sqlite3_prepare(DBHelper.dataBase, query, -1, &stmt, nil) != SQLITE_OK {
                //Holds and prints any errors.
                let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
                print(err)
                return
            }

            //While loop to enter the information.

            while(sqlite3_step(stmt) == SQLITE_ROW) {
                //variable to hold the information.
                let name1 = String(cString: sqlite3_column_text(stmt, 0))
                let rakin1 = String(cString: sqlite3_column_text(stmt, 1))
                //Appends the data to the array.
                rankingTupleByTechXcode.append((name1,rakin1))
            }

            
    }
    //MARK: view the user scores based on Technology and UserID
    func viewQuizzScoreByIdandTech(userID: Int, tech: String){
           //Holds the userID
           let id = userID
           //Holds the query.
           let query = "select * from Users_Quizzes  inner JOIN Quizzes on Users_Quizzes.QuizzID = Quizzes.ID   where Users_Quizzes.UserID = '\(userID)' and  Quizzes.Technology = '\(tech)'"

          //Holds the pointer.

          var stmt: OpaquePointer?
          //Queries the database.
          if sqlite3_prepare(DBHelper.dataBase, query, -2, &stmt, nil) != SQLITE_OK {
            //Holds and prints any errors.
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
            print(err)
            return
          }
        
        //Binds the user id and prints any errors.
         let index : Int = Int (sqlite3_bind_parameter_index(stmt, "id"))
         if sqlite3_bind_int(stmt,Int32(index),Int32(id)) != SQLITE_OK{
            let err = String(cString: sqlite3_errmsg(DBHelper.dataBase)!)
             print(err)
        }
        //While loop to enter the information.
        while(sqlite3_step(stmt) == SQLITE_ROW) {
            //variables to hold the information.
            let userID = sqlite3_column_int(stmt, 0)
            let quizID = sqlite3_column_int(stmt, 1)
            let dateTaken = String(cString: sqlite3_column_text(stmt, 2))
            let score = sqlite3_column_int(stmt, 3)
            //Appends the data to the array.
            quizzesTakenByUser.append(TakenQuizz(userid: Int(userID), quizzid: Int(quizID), datetaked: dateTaken, scored: Int(score)))
        }
    }}
