//
//  LoginViewController.swift
//  TestBankApp
//
//  Created by admin on 3/18/22.
//

import UIKit
import SQLite3

class LoginViewController: UIViewController {
    //outlets for the Text Fields, Labels, and Buttons
    @IBOutlet weak var loginEmailTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginPasswordTF: UITextField!
    @IBOutlet weak var registerBtnOut: UIButton!
    @IBOutlet weak var loginBtnOut: UIButton!
    //object for the Database Helper class.
    var databaseHelper = DBHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //holds the path of the Database and copies the project database if it's not there.
        var f1 = databaseHelper.prepareDatabaseFile()
        //prints the path to the database.
        print("Data base phat is :", f1)
        //opens the database.
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Setting up styles for buttons, labels, and Text Fields.
        Utilities.styleErrorLabel(errorLabel)
        Utilities.styleFilledButton(loginBtnOut)
        Utilities.styleFilledButton(registerBtnOut)
        Utilities.styleTextField(loginEmailTF, placeHolderString: "enter Email")
        Utilities.styleTextField(loginPasswordTF, placeHolderString: "enter Password")
    }
    // action for the submit button
    @IBAction func loginSubmit(_ sender: Any) {
        // Remove whitespace and new lines from email and password textfield values
       let email = loginEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = loginPasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        //Sets up an object to hold the User information when it is created.
        var userToLogin = User(id: 0, name: "", password: "", subscribed: "", ranking: "", email: "", blocked: "")
        
        //allows us to pull user list from database helper
        databaseHelper.fetchUserByEmail(emailToFetch: email)
        
        //for loop to store the User information from the Array into the object.
        for list in databaseHelper.usersList{
            userToLogin = User(id: list.id, name: list.name, password: list.password, subscribed: list.subscribed, ranking: list.ranking, email: list.email, blocked: list.blocked)
        }
        
            // Email or Password is left blank
            if email == "" || password == "" {
                showError("Please make sure both fields are filled in.")
              // Email is not valid email
            } else if !Validate.isValidEmail(email: email) {
                showError("Please make sure your email is formatted correctly.")
            //Checks to see if the user has been blocked by the admin.
            } else if userToLogin.blocked == "true"{
                showError("You are BLOCKED")
            }else{
                
                // User password matches, then go to logged-in home screen
                if userToLogin.password == password {
                    
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                        return
                    }
                    
                    //Set the global variable user to the loggedin user
                    GlobalVariables.userLoguedIn = userToLogin
                    //Sets the view to move to.
                    let userViewController = self.storyboard?.instantiateViewController(identifier: "User Nav Controller") as? UINavigationController
                    //moves us to the view
                    window.rootViewController = userViewController
                    window.makeKeyAndVisible()
                    //sets the transition information.
                    UIView.transition(with: window, duration: 0.50, options: .transitionCrossDissolve, animations: nil, completion: nil)
                    
                    
                } else {
                    //prints the error message on the screen.
                    showError("Incorrect credentials, please try again.")
                }
            }
        }
    
    //function to change the text of the error message and display it on screen.
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    //action for the Registration Button. Nav controller handles it.
    @IBAction func goToRegistration(_ sender: Any) {
        
    }
    
}
