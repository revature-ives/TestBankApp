//
//  AdminQuizCreateViewController.swift
//  TestBankApp
//
//  Created by admin on 3/23/22.
//

import UIKit
import SQLite3


class AdminQuizCreateViewController: UIViewController {

    @IBOutlet weak var QuizBuildLabel: UILabel!
    @IBOutlet weak var QuizNameTF: UITextField!
    @IBOutlet weak var QuestionTF: UITextField!
    @IBOutlet weak var answer1: UITextField!
    @IBOutlet weak var answer2: UITextField!
    @IBOutlet weak var CorrectAnswerTF: UITextField!
    @IBOutlet weak var SubmitButtonOutlet: UIButton!
    @IBOutlet weak var answer3: UITextField!
    
    var userLoggedIn = GlobalVariables.userLoguedIn
    
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let f1 = databaseHelper.prepareDatabaseFile()
         
        // print("Data base phat is :", f1)
        // var url = URL(string: f1)
         //Open the Data base or create it
     
         if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
             print("Can not open data base")
         }
    }
    

    @IBAction func CreateQuiz(_ sender: Any) {
        
        let technology = QuizNameTF.text!
        
        var tempQuiz : Quizz = Quizz(id: 0, tech: "")
        
        databaseHelper.addQuizz(technology: QuizNameTF.text!)
        
        databaseHelper.retrieveLastQuizInfo()
        
        for list in databaseHelper.quizzesList{
            tempQuiz = Quizz(id: list.id, tech: list.technology)
        }
        
    }


}
