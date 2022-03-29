//
//  ResultViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/22/22.
//

import UIKit
import SQLite3

class ResultViewController: UIViewController {
    
    
    //MARK: IB Outlets
    
    @IBOutlet weak var averageScoreLabel: UILabel!
    @IBOutlet weak var scoreQuizDisplayLabel: UILabel!
    @IBOutlet weak var quizScoreLabel: UILabel!
   
    @IBOutlet weak var rankingsTable: UITableView!
    
    @IBOutlet weak var returnToQuizzes: UIButton!
    @IBOutlet weak var goToFeedback: UIButton!
    
    //TODO: Data Model variables
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    
    var quizzesTakenByUserLoggedIn = [TakenQuizz]()
    var scoresOfquizzesTaken = [Int()]
    var rankinUsersList = [User]()
    
    
    var positionInRanking = 0
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        

        //set ranking table view datasource and delegate
        rankingsTable.delegate = self
        rankingsTable.dataSource = self
        
        
        Utilities.styleLabel(quizScoreLabel)
        Utilities.styleFilledButton(returnToQuizzes)
        Utilities.styleFilledButton(goToFeedback)
        

        self.navigationItem.setHidesBackButton(true, animated: false)
         
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
        
        GlobalVariables.globalQuizzScore = 0
        //display rnakings
        rankinUsersList = databaseHelper.calculateRanking()
        
        print(databaseHelper.calculateRanking())
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        displayCupon()
    }
    
    
    //MARK: Auxilliar functions
    
    
    
    //This funtion should be extracted to a class
    //Function to calculate the average scores for user logged in
    func calculateAverageScore() -> Double{
        let averageScore = Double(scoresOfquizzesTaken.reduce(0, +))/Double(scoresOfquizzesTaken.count)
        return averageScore
    }
    
    
    
    //This function should be extracte tov a class
    //
    func transitionToQuizzSelection() {
        
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "quizzSelection") as? SelctionQuizzViewController
        
        let transition = CATransition()
        transition.type = .push
        transition.duration = 0.25
        view.window?.layer.add(transition, forKey: kCATransition)
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
    
    //Diplay the cupom
    func displayCupon(){
        if rankinUsersList[0 ].id == GlobalVariables.userLoguedIn.id{
            showAlertView(msg: "you number 1 win cupon 60 days free")
            
        } else if rankinUsersList[1].id == GlobalVariables.userLoguedIn.id{
            
            showAlertView(msg: "you number 2 30 days free")
            
        }else if rankinUsersList[1].id == GlobalVariables.userLoguedIn.id{
            
           showAlertView(msg: "you number 3 15 days free")
        }
        
    }
    
    
    //Should be extractes to a class
    //Didplay an alert
    func showAlertView(msg: String){
        let alertController = UIAlertController(title: "Top Rankings", message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: IB actions
    
    @IBAction func returnToQuizzSelection(_ sender: Any) {
        
        //Incremeting the count of quizz attempts
        GlobalVariables.quizzAttempts += 1
        
        //Calling the transition method
        transitionToQuizzSelection()
    }
    
   

    @IBAction func moveToFeedback(_ sender: Any) {
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let FeedbackViewController = self.storyboard?.instantiateViewController(identifier: "Feedback View") as? FeedbackViewController
        
        window.rootViewController = FeedbackViewController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)
        
    }
    
    
    
    
   
    
}

//MARK:Table view to display the overall ranking

extension ResultViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rankinUsersList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankinCell", for: indexPath) as! RankingTableViewCell
        
        cell.positionLabel.text = String(indexPath.item + 1)
        cell.namelabel.text = rankinUsersList[indexPath.item].name
       
        
        cell.averageScoreLabel.text = rankinUsersList[indexPath.item].ranking
        
        return cell

    }
    
    
}
