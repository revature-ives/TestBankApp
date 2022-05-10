//
//  AdminBlockViewController.swift
//  TestBankApp
//
//  Created by admin on 3/21/22.
//

import UIKit
import SQLite3

class AdminBlockViewController: UIViewController {
    //Outlet block for the view.
    @IBOutlet weak var BlockButtonOutlet: UIButton!
    @IBOutlet weak var blockUserTF: UITextField!
    //Object for the DBHelper class.
    var databaseHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //variable to hold the
        var f1 = databaseHelper.prepareDatabaseFile()
        //prints path to database
        print("Data base phat is :", f1)
        //Opens up the database
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        //Styles the Button and Text Field
        Utilities.styleFilledButton(BlockButtonOutlet)
        Utilities.styleTextField(blockUserTF, placeHolderString: "User Email")
    }
    //Action for the Button to BLock users.
    @IBAction func blockUser(_ sender: Any) {
        //Stores the data from the Text Field
        let email = blockUserTF.text!
        //Object created to store the User info once pulled from the database
        var userToLogin = User(id: 0, name: "", password: "", subscribed: "", ranking: "", email: "", blocked: "")
        //Pulls the user data from the database using the email provided
        databaseHelper.fetchUserByEmail(emailToFetch: email)
        //Stores the User data into the object created previously.
        for list in databaseHelper.usersList{
            userToLogin = User(id: list.id, name: list.name, password: list.password, subscribed: list.subscribed, ranking: list.ranking, email: list.email, blocked: list.blocked)
        }
        //Changes the "blocked" attribute for the user to "true" in the database.
        databaseHelper.blockUser(email: String(userToLogin.email))
    }
}
