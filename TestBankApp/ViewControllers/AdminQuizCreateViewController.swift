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
    
    @IBOutlet weak var answer3TF: UITextField!
    @IBOutlet weak var answer2TF: UITextField!
    @IBOutlet weak var answer1TF: UITextField!
    @IBOutlet weak var CorrectAnswerTF: UITextField!
    @IBOutlet weak var SubmitButtonOutlet: UIButton!
    
    var tempQuiz : Quizz = Quizz(id: 0, tech: "")
    var ButtonCount = 0
    
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
        
        Utilities.styleTextField(answer3TF, placeHolderString: "answer 3")
        Utilities.styleTextField(answer2TF, placeHolderString: "answer 2")
        Utilities.styleTextField(answer1TF, placeHolderString: "answer 1")
        Utilities.styleTextField(QuizNameTF, placeHolderString: "iOS,swift,xcode")
        Utilities.styleTextField(CorrectAnswerTF, placeHolderString: "correct answer (ex.opt1)")
        Utilities.styleFilledButton(SubmitButtonOutlet)
        
    }
    

    @IBAction func CreateQuiz(_ sender: Any) {
        
        let technology = QuizNameTF.text!
        
        
        
        if ButtonCount == 0{
        
        databaseHelper.addQuizz(technology: QuizNameTF.text!)
        
        databaseHelper.retrieveLastQuizInfo()
        
        for list in databaseHelper.quizzesList{
            tempQuiz = Quizz(id: list.id, tech: list.technology)
            }
        
            ButtonCount += 1
            QuizBuildLabel.text = "You must enter  5 Questions"
            QuestionTF.isHidden = false
            answer1TF.isHidden = false
            answer2TF.isHidden = false
            answer3TF.isHidden = false
            CorrectAnswerTF.isHidden = false
            QuizNameTF.isHidden = true
            
        }else if ButtonCount == 1{
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            
            ButtonCount += 1
            
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 2"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
            
        }else if ButtonCount == 2{
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            
            ButtonCount += 1
            
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 3"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
            
        }else if ButtonCount == 3{
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            
            ButtonCount += 1
            
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 4"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
            
        }else if ButtonCount == 4{
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            
            ButtonCount += 1
            
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 5"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
            
        }else if ButtonCount == 5{
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            
            ButtonCount += 1
            
            QuestionTF.isHidden = true
            answer1TF.isHidden = true
            answer2TF.isHidden = true
            answer3TF.isHidden = true
            CorrectAnswerTF.isHidden = true
            QuizBuildLabel.text = "The Quiz has been created"
            SubmitButtonOutlet.setTitle("Exit to Menu", for: .normal)
            
        }else if ButtonCount == 6{
            
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                return
            }
            let AdminViewController = self.storyboard?.instantiateViewController(identifier: "Admin Nav Controller") as? UINavigationController
            
            window.rootViewController = AdminViewController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
            
        }
        
    }


}
