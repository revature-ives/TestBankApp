//
//  QuizzViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/21/22.
//

import UIKit
import SQLite3

class QuizzViewController: UIViewController {
    
    
    //Information labels
    
    @IBOutlet weak var questionScore: UILabel!
    
    
    @IBOutlet weak var questionCount: UILabel!
    //Question label

    @IBOutlet weak var questionLabel: UILabel!
    
    
    //Answers labels
    
    @IBOutlet weak var answerOneLabel: UILabel!
    
    @IBOutlet weak var answerTwoLabel: UILabel!
    
    @IBOutlet weak var answerThreeLabel: UILabel!
    
   
    
    @IBOutlet weak var quizScoreLabel: UILabel!
    
    
    
    
    //Answer buttons
    
    
    
   
    @IBOutlet weak var answerOneButton: UIButton!
    
    @IBOutlet weak var answerTwoButton: UIButton!
    
    
    @IBOutlet weak var answerThreeButton: UIButton!
    
    //Submit button
    
    @IBOutlet weak var submitQuizzButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
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
    
 
    
    //questionsCount
    
    var questionsCount = 0
    
    
    
    //Right answer
    var rightanswer = " "
    
    //Score of the quESTION
    //If the answer if right increment the count of score in 1
    var quizzScore = 0
    
    //Quizz to display
    func displayQuizz(questionNumber: Int){
        
     //   fillMockData()
        
        questionLabel.text = questionsList[questionNumber].question
        answerOneLabel.text = questionsList[questionNumber].option1
        answerTwoLabel.text = questionsList[questionNumber].option2
        answerThreeLabel.text = questionsList[questionNumber].option3
        
        rightanswer = questionsList[questionNumber].answer
        
        
        
    }
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.setHidesBackButton(true, animated: false)
        
        // Do any additional setup after loading the view.
        //labels information
        
        questionScore.text = "0"
        questionCount.text = "1"
        quizScoreLabel.text = "0"
        
        
        
        //Open database
       let f1 = databaseHelper.prepareDatabaseFile()
        
        print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        print("quizz to present whit id \(quizSelectedID)")
        
        databaseHelper.Questions(quizId: quizSelectedID)
        
        questionsList = databaseHelper.questionsList
       
        //print(questionsList)
        
        displayQuizz(questionNumber: 0)
        
        //Hide subbmit button
        submitQuizzButton.isHidden = true
        
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
            
            //display score
           
            
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
        questionScore.text = String(quizzScore)
    }
    
    
    @IBAction func answerTwoButtonPressed(_ sender: Any) {
        let option = "opt2"
        
        checkRightAnswer(option)
        selectButton(answerTwoButton, answerOneButton, answerThreeButton)
        questionScore.text = String(quizzScore)
        
    }
    
    
    
    @IBAction func answerThreeButtonPressed(_ sender: Any) {
        
        let option = "opt3"
        
        checkRightAnswer(option)
        selectButton(answerThreeButton, answerTwoButton, answerOneButton)
        questionScore.text = String(quizzScore)
        
    }
    
    //Navigation
    //when user pressed next button
    //bug whit the count of questions
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        
        
        
        //decide if is the last question to show the submit button
        if questionsCount == 3{
            submitQuizzButton.isHidden = false
            nextButton.isHidden = true
        }
        
        if questionsCount < 4 {
        questionsCount += 1
        resetButtons(answerOneButton, answerTwoButton, answerThreeButton)
        displayQuizz(questionNumber: questionsCount)
            print("question number ",questionsCount)
            
            GlobalVariables.globalQuizzScore += quizzScore
            print(GlobalVariables.globalQuizzScore)
            quizScoreLabel.text = String(GlobalVariables.globalQuizzScore)
            questionCount.text = String(questionsCount + 1)
            
        }
        
        
        
    }
    
    
    //When user press submit button
    
    @IBAction func submitQuizzPressedAction(_ sender: Any) {
        print("the score of the quizz just taken is : ",GlobalVariables.globalQuizzScore)
        
        databaseHelper.addQuizzTaken(userId: GlobalVariables.userLoguedIn.id, quizzId: quizSelectedID, dateTaked: "3/18/2021 ", score: GlobalVariables.globalQuizzScore)
        
        
        
    }
    
    
    
    
    //Select a butto amswer
    fileprivate func selectButton(_ selected : UIButton,_ unselected1 : UIButton,_ unselected2: UIButton
    ) {
        selected.backgroundColor = UIColor.darkGray
        unselected1.backgroundColor = UIColor.white
        unselected2.backgroundColor = UIColor.white
    }
    
    //Reset answer buttons when a next question is display
    
    fileprivate func resetButtons(_ selected : UIButton,_ unselected1 : UIButton,_ unselected2: UIButton
    ) {
        selected.backgroundColor = UIColor.white
        unselected1.backgroundColor = UIColor.white
        unselected2.backgroundColor = UIColor.white
    }
    
    //funcntion to check if the button selected is the right answer
    
    func chechAnswer(){
        let answer = questionsList[questionsCount].answer
    }
    
    
    
    //function to go back selection quiz
    

}
