//
//  AdminViewScoreViewController.swift
//  TestBankApp
//
//  Created by admin on 3/23/22.
//

import UIKit
import SQLite3

class AdminViewScoreViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //Outlet block for the Buttons, Text Fields, and TableView.
    @IBOutlet weak var viewScoresBtnOutlet: UIButton!
    @IBOutlet weak var userEmailTF: UITextField!
    @IBOutlet weak var scoresTableView: UITableView!
    
    //Object to hold DBHelper class.
    var databaseHelper = DBHelper()
    //Holds the scoreList from DBHelper.
    var scoreList = [Scores]()
    //Array to hold the data.
    var scoresArray : [String] = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //variable to hold the database path.
        let f1 = databaseHelper.prepareDatabaseFile()
        //Opens the database.
         if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
             print("Can not open data base")
         }
        //Styles the Button and Text Field.
        Utilities.styleFilledButton(viewScoresBtnOutlet)
        Utilities.styleTextField(userEmailTF, placeHolderString: "User Email")
    }
    //Action for the View Scores Button.
    @IBAction func viewScores(_ sender: Any) {
        //Gets and cleans the Email from the Text Field.
        let email = userEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Object to hold the user information.
         var userToView = User(id: 0, name: "", password: "", subscribed: "", ranking: "", email: "", blocked: "")
         //allows us to pull user list from database helper
         databaseHelper.fetchUserByEmail(emailToFetch: email)
         //Puts the user info into the Object created eariler.
         for list in databaseHelper.usersList{
             userToView = User(id: list.id, name: list.name, password: list.password, subscribed: list.subscribed, ranking: list.ranking, email: list.email, blocked: list.blocked)
            }
             //pulls the scores from the database based on the user id.
             databaseHelper.viewUserScores(userID: userToView.id)
             //Puts the score information into the array in this file.
             scoreList = databaseHelper.scoresList
             //Puts the score information into the array.
             for list in scoreList{
                 scoresArray.append("User ID: \(list.userID) Quiz ID: \(list.quizID)  Date Taken: \(list.dateTaken) Score: \(list.score)")
             }
             // Prints the information in the array.
             for n in scoresArray{
                 print("\(scoresArray)")
             }
        //Reloads the tableview.
        self.scoresTableView.reloadData()
         }
    //Function to set the number of rows in the section. Based on the elements of Array scoreList.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList.count
    }
    //Function to Set the cellt to be used on each row.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Sets the cell to use.
        let cell = tableView.dequeueReusableCell(withIdentifier: "Score View Cell", for: indexPath) as! AdminViewScoresTableViewCell
        //Sets the labels in the Table View to display the information.
        cell.userIDLabel.text = " ID: \(scoreList[indexPath.item].userID)"
        cell.quizIDLabel.text = " Quiz: \(scoreList[indexPath.item].quizID)"
        cell.dateTakenLabel.text = "Date: \(scoreList[indexPath.item].dateTaken)"
        cell.scoresLabel.text = "Score: \(scoreList[indexPath.item].score)"
        //Return the cell to use.
        return cell
    }
    //Sets the number of sections. We only need one section.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

