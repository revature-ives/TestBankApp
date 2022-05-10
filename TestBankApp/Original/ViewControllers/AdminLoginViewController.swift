//
//  AdminLoginViewController.swift
//  TestBankApp
//
//  Created by admin on 3/18/22.
//

import UIKit
import SQLite3

class AdminLoginViewController: UIViewController {
    //object created to access DBHelper functions.
    var databaseHelper = DBHelper()
    //Outlet block.
    @IBOutlet weak var adminEmailTF: UITextField!
    @IBOutlet weak var adminPasswordTF: UITextField!
    @IBOutlet weak var ErrorLabel: UILabel!
    @IBOutlet weak var AdminLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Holds the path to the database and copies it into the folder if not there.
        var f1 = databaseHelper.prepareDatabaseFile()
        //prints the path to the database.
        print("Data base phat is :", f1)
        //Opens the Database.
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Styles the Text Fields,Labels, and Buttons.
        Utilities.styleTextField(adminEmailTF, placeHolderString: "enter Email")
        Utilities.styleTextField(adminPasswordTF, placeHolderString: "enter Password")
        Utilities.styleFilledButton(AdminLoginBtn)
        Utilities.styleErrorLabel(ErrorLabel)
    }
    
    //Action for the Login Button.
    @IBAction func adminLoginButton(_ sender: Any) {
        //Variables to hold the Text Field data.
        let adminEmail = adminEmailTF.text!
        let adminPassword = adminPasswordTF.text!
        //Object to hold the Admin info once pulled form the Database.
        var tempAdmin : Admin = Admin(id: 0, name: "", email: "", password: "")
        //Pulls the Admin Info from the database.
        databaseHelper.retrieveAdminInfo()
        //for loop to put the admin info from the List in DBHelper into the object.
        for list in databaseHelper.adminList{
            tempAdmin = Admin(id: list.id, name: list.name, email: list.email, password: list.password)
        }
        //Checks that the admin email and password match. Shows an error if they don't.
        if adminEmail == tempAdmin.email && adminPassword == tempAdmin.password {
            transitionToAdmin()
        }
        else{
               showError("This information is incorrect")
        }
    }
    //function to set the error label text and show it.
    func showError(_ message:String) {
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    //function to move to the Admin Menu.
    func transitionToAdmin() {
        //holds the view we plan to move to.
        let startViewController = self.storyboard?.instantiateViewController(identifier: "Admin Nav Controller") as? UINavigationController
        //Sets the transition informatin.
        let transition = CATransition()
        transition.type = .push
        transition.duration = 0.25
        view.window?.layer.add(transition, forKey: kCATransition)
        //actually moves to the view. 
        view.window?.rootViewController = startViewController
        view.window?.makeKeyAndVisible()
    }
    
}
