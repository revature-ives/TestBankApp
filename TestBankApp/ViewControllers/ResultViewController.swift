//
//  ResultViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/22/22.
//

import UIKit
import SQLite3

class ResultViewController: UIViewController {
    
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var scoreQuizDisplayLabel: UILabel!
    
    //Data Model
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    
    var quizzesTakenByUserLoggedIn = [TakenQuizz]()
    var scoresOfquizzesTaken = [Int()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Display the score of actual quiz
        scoreQuizDisplayLabel.text = String(GlobalVariables.globalQuizzScore)
        
        //Open database
        var f1 = databaseHelper.prepareDatabaseFile()
        
       // print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
         
        
         databaseHelper.fetchQuizzTakenByUser(userID: GlobalVariables.userLoguedIn.id)
        quizzesTakenByUserLoggedIn = databaseHelper.quizzesTakenByUser
        scoresOfquizzesTaken = databaseHelper.scoresForuser
        print("this is the socers: ",scoresOfquizzesTaken)
        averageScoreLabel.text = String(calculateAverageScore())
        
        databaseHelper.updateRankin(userIDtoUpdate: GlobalVariables.userLoguedIn.id, newRanking: calculateAverageScore())
    }
    
    //Function to calculate the average scores for user logged in
    
    func calculateAverageScore() -> Double{
        var averageScore = Double(scoresOfquizzesTaken.reduce(0, +))/Double(scoresOfquizzesTaken.count)
        return averageScore
    }
    
    
    
    @IBAction func returnToQuizzSelection(_ sender: Any) {
        
        //Incremeting the count of quizz attempts
        GlobalVariables.quizzAttempts += 1
        
        //Calling the transition method
        transitionToQuizzSelection()
    }
    
    func transitionToQuizzSelection() {
        
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "quizzSelection") as? SelctionQuizzViewController
        
        let transition = CATransition()
        transition.type = .push
        transition.duration = 0.25
        view.window?.layer.add(transition, forKey: kCATransition)
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }

    @IBAction func moveToFeedback(_ sender: Any) {
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let FeedbackViewController = self.storyboard?.instantiateViewController(identifier: "Feedback View") as? FeedbackViewController
        
        window.rootViewController = FeedbackViewController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)    }
}
