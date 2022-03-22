//
//  QuizzViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/21/22.
//

import UIKit
import SQLite3

class QuizzViewController: UIViewController {
    
    //Question label

    @IBOutlet weak var questionLabel: UILabel!
    
    
    //Answers labels
    
    @IBOutlet weak var answerOneLabel: UILabel!
    
    @IBOutlet weak var answerTwoLabel: UILabel!
    
    @IBOutlet weak var answerThreeLabel: UILabel!
    
    //Answer buttons
    
   
    @IBOutlet weak var answerOneButton: UIButton!
    
    @IBOutlet weak var answerTwoButton: UIButton!
    
    
    @IBOutlet weak var answerThreeButton: UIButton!
    
    
    //Get the user loggedin
    
    var userLoggedIn = GlobalVariables.userLoguedIn
    //Get the id of Quizz selected
    var quizSelectedID = GlobalVariables.quizzSelected.id
    //Get the questions that belong to the quizz fetching questions by quizzid
    
    //Get the answer
    
    //Data model
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    
    //List of Questions
    
    var questionsList = [Question] ()
    
    //Mock Data
 /*
    var question1 = Question(id: 1, question: "What is ios?", opt1: " is a device", opt2: "is an Operating system", opt3: "is Framework", ans: "opt1", quizId: 1)
    var question2 = Question(id: 2, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 1)
    var question3 = Question(id: 3, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 1)
    var question4 = Question(id: 4, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 1)
    var question5 = Question(id: 5, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 1)
    var question6 = Question(id: 6, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
    var question7 = Question(id: 7, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
    var question8 = Question(id: 8, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
    var question9 = Question(id: 9, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
    var question10 = Question(id: 10, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 2)
    var question11 = Question(id: 11, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
    var question12 = Question(id: 12, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
    var question13 = Question(id: 13, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
    var question14 = Question(id: 14, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
    var question115 = Question(id: 15, question: "What is ios", opt1: " is a device", opt2: "is oa OP", opt3: "is acar", ans: "opt1", quizId: 3)
    
    func fillMockData(){
        
        questionsList.append(question1)
        questionsList.append(question2)
        questionsList.append(question3)
        questionsList.append(question4)
        questionsList.append(question5)
        
    }*/
    
    //populate quizz
    
    
    
    //Right answer
    var rightanswer = " "
    
    //Score of the quiz
    //If the answer if right increment the count of score in 1
    var quizzScore = 0
    
    //Quizz to display
    func displayQuizz(){
        
     //   fillMockData()
        
        questionLabel.text = questionsList[0].question
        answerOneLabel.text = questionsList[0].option1
        answerTwoLabel.text = questionsList[0].option2
        answerThreeLabel.text = questionsList[0].option3
        
        rightanswer = questionsList[0].answer
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Open database
       let f1 = databaseHelper.prepareDatabaseFile()
        
       // print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        print("quizz to present whit id \(quizSelectedID)")
        
        databaseHelper.Questions(quizId: quizSelectedID)
        
        questionsList = databaseHelper.questionsList
       
       // print(questionsList)
        
        displayQuizz()
        
    }
    
    
    
    
    //Answer Buttons Actions
    
    var amountToUpdate = 0
    
    fileprivate func updateScore() {
        amountToUpdate = 1
        quizzScore += amountToUpdate
    }
    
    fileprivate func checkRightAnswer(_ option: String) {
        
        if option == rightanswer && amountToUpdate == 0{
            
            updateScore()
            print("Right answer \(option) you get one more point and your new score for the quizz is \(quizzScore)")
        }else if option != rightanswer && amountToUpdate == 1 {
            quizzScore = quizzScore - amountToUpdate
            amountToUpdate = 0
            print("wrong answer \(option) you dont get any point and your new score is \(quizzScore)")
        }else{
            print("wrong answer \(option) you dont get any point and your new score is \(quizzScore)")        }
    }
    
    @IBAction func answerOneButtonPressed(_ sender: Any) {
        
        let option = "opt1"
        checkRightAnswer(option)
        selectButton(answerOneButton, answerTwoButton, answerThreeButton)
        
    }
    
    
    @IBAction func answerTwoButtonPressed(_ sender: Any) {
        let option = "opt2"
        
        checkRightAnswer(option)
        selectButton(answerTwoButton, answerOneButton, answerThreeButton)    }
    
    
    
    @IBAction func answerThreeButtonPressed(_ sender: Any) {
        
        let option = "opt3"
        
        checkRightAnswer(option)
        selectButton(answerThreeButton, answerTwoButton, answerOneButton)
        
    }
    
    //Navigation
    
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
    }
    
    
    //Select a butto amswer
    fileprivate func selectButton(_ selected : UIButton,_ unselected1 : UIButton,_ unselected2: UIButton
    ) {
        selected.backgroundColor = UIColor.darkGray
        unselected1.backgroundColor = UIColor.white
        unselected2.backgroundColor = UIColor.white
    }
    
    
    //funcntion to check if the button selected is the right answer
    
    func chechAnswer(){
        let answer = questionsList[0].answer
    }
    

}
