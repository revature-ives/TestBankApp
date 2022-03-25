//
//  AdminBlockViewController.swift
//  TestBankApp
//
//  Created by admin on 3/21/22.
//

import UIKit
import SQLite3

class AdminBlockViewController: UIViewController {

    @IBOutlet weak var BlockButtonOutlet: UIButton!
    @IBOutlet weak var blockUserTF: UITextField!
    
    var databaseHelper = DBHelper()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var f1 = databaseHelper.prepareDatabaseFile()
        
        print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        Utilities.styleFilledButton(BlockButtonOutlet)
        Utilities.styleTextField(blockUserTF, placeHolderString: "User Email")
        
    }
    
    @IBAction func blockUser(_ sender: Any) {
        
        let email = blockUserTF.text!
        
        var userToLogin = User(id: 0, name: "", password: "", subscribed: "", ranking: "", email: "", blocked: "")
        
        databaseHelper.fetchUserByEmail(emailToFetch: email)
        
        for list in databaseHelper.usersList{
            userToLogin = User(id: list.id, name: list.name, password: list.password, subscribed: list.subscribed, ranking: list.ranking, email: list.email, blocked: list.blocked)
        }
        
        databaseHelper.blockUser(email: String(userToLogin.email))
    }
    
    

}
