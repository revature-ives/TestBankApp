//
//  AdminQuizCreateViewController.swift
//  TestBankApp
//
//  Created by admin on 3/23/22.
//

import UIKit
import SQLite3


class AdminQuizCreateViewController: UIViewController {
    //Outlet Block.
    @IBOutlet weak var QuizBuildLabel: UILabel!
    @IBOutlet weak var QuizNameTF: UITextField!
    @IBOutlet weak var QuestionTF: UITextField!
    @IBOutlet weak var answer3TF: UITextField!
    @IBOutlet weak var answer2TF: UITextField!
    @IBOutlet weak var answer1TF: UITextField!
    @IBOutlet weak var CorrectAnswerTF: UITextField!
    @IBOutlet weak var SubmitButtonOutlet: UIButton!
    //Object to hold the Quiz info.
    var tempQuiz : Quizz = Quizz(id: 0, tech: "")
    //counter to let the button change things on click.
    var ButtonCount = 0
    //Pulls the global variable.
    var userLoggedIn = GlobalVariables.userLoguedIn
    //Object of DBHelper class.
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Holds the database path.
        let f1 = databaseHelper.prepareDatabaseFile()
         //Open the Data base or create it
         if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
             print("Can not open data base")
         }
        //Styles the Text Field and buttons.
        Utilities.styleTextField(answer3TF, placeHolderString: "answer 3")
        Utilities.styleTextField(answer2TF, placeHolderString: "answer 2")
        Utilities.styleTextField(answer1TF, placeHolderString: "answer 1")
        Utilities.styleTextField(QuizNameTF, placeHolderString: "iOS,swift,xcode")
        Utilities.styleTextField(CorrectAnswerTF, placeHolderString: "correct answer (ex.opt1)")
        Utilities.styleFilledButton(SubmitButtonOutlet)
        
    }
    //Action for the CreateQuiz button.
    @IBAction func CreateQuiz(_ sender: Any) {
        //Holds the Text Field data.
        let technology = QuizNameTF.text!
        //Checks the count variable.
        if ButtonCount == 0{
        //Add the quiz to the quiz table in the database.
        databaseHelper.addQuizz(technology: QuizNameTF.text!)
        //Gets the Quiz info of the newly created quiz.
        databaseHelper.retrieveLastQuizInfo()
        //Puts the quiz info in the object.
        for list in databaseHelper.quizzesList{
            tempQuiz = Quizz(id: list.id, tech: list.technology)
            }
            //increments the counter.
            ButtonCount += 1
            //Changes the instruction labe.
            QuizBuildLabel.text = "You must enter  5 Questions"
            //Show the question Text Fields.
            QuestionTF.isHidden = false
            answer1TF.isHidden = false
            answer2TF.isHidden = false
            answer3TF.isHidden = false
            CorrectAnswerTF.isHidden = false
            //Hides the Quiz Name Text Field.
            QuizNameTF.isHidden = true
         //Checks the counter.
        }else if ButtonCount == 1{
            //stores the information put in the Text Fields.
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            //Inserts the question into the database.
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            //Increments the counter.
            ButtonCount += 1
            //Resets the Text Fields and changes the placeholder.
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 2"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
         //Checks the counter.
        }else if ButtonCount == 2{
            //stores the Text Field Data.
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            //Inserts the question into the database.
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            //Increments the counter.
            ButtonCount += 1
            //Resests the Text Fields and changes the placeholder.
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 3"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
         //Checks the counter.
        }else if ButtonCount == 3{
            //stores the Text Field data.
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            //Inserts the question into the database.
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            //increments the counter.
            ButtonCount += 1
            //Resets the Text Fields and changes the placeholder.
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 4"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
         //Checks the counter.
        }else if ButtonCount == 4{
            //Stores the Text Field data.
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            //Inserts the question into the database.
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            //Increments the counter.
            ButtonCount += 1
            //Resets the Text Fields and changes the placeholder.
            QuestionTF.text = ""
            QuestionTF.placeholder = "Question 5"
            answer1TF.text = ""
            answer2TF.text = ""
            answer3TF.text = ""
            CorrectAnswerTF.text = ""
         //Checks the counter.
        }else if ButtonCount == 5{
            //Stores the Text Field data.
            var question = QuestionTF.text!
            var answer1 = answer1TF.text!
            var answer2 = answer2TF.text!
            var answer3 = answer3TF.text!
            var correct = CorrectAnswerTF.text!
            //Inserts the question into the database.
            databaseHelper.addQuestionToDatabase(questionAsked: question, option1: answer1, option2: answer2, option3: answer3, answer: correct, quizId: tempQuiz.id)
            //Increments the counter.
            ButtonCount += 1
            //Hides the Text Fields, changes the instruction label and the button.
            QuestionTF.isHidden = true
            answer1TF.isHidden = true
            answer2TF.isHidden = true
            answer3TF.isHidden = true
            CorrectAnswerTF.isHidden = true
            QuizBuildLabel.text = "The Quiz has been created"
            SubmitButtonOutlet.setTitle("Exit to Menu", for: .normal)
         //Checks the counter.
        }else if ButtonCount == 6{
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                return
            }
            //Holds the view to go to.
            let AdminViewController = self.storyboard?.instantiateViewController(identifier: "Admin Nav Controller") as? UINavigationController
            //Goes to the view.
            window.rootViewController = AdminViewController
            window.makeKeyAndVisible()
            //Transition information.
            UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        
    }


}
