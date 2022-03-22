//
//  LoginViewController.swift
//  TestBankApp
//
//  Created by admin on 3/18/22.
//

import UIKit
import SQLite3

class LoginViewController: UIViewController {

    @IBOutlet weak var loginEmailTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginPasswordTF: UITextField!
    @IBOutlet weak var registerBtnOut: UIButton!
    @IBOutlet weak var loginBtnOut: UIButton!
    
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
        
        
        //Setting up styles for buttons.
        Utilities.styleErrorLabel(errorLabel)
        Utilities.styleFilledButton(loginBtnOut)
        Utilities.styleFilledButton(registerBtnOut)
        Utilities.styleTextField(loginEmailTF, placeHolderString: "enter Email")
        Utilities.styleTextField(loginPasswordTF, placeHolderString: "enter Password")
    }
    
    @IBAction func loginSubmit(_ sender: Any) {
        // Remove whitespace and new lines from email and password textfield values
       let email = loginEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = loginPasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var userToLogin = User(id: 0, name: "", password: "", subscribed: "", ranking: "", email: "", blocked: "")
        
        //allows us to pull user list from database helper
        databaseHelper.fetchUserByEmail(emailToFetch: email)
        
        for list in databaseHelper.usersList{
            userToLogin = User(id: list.id, name: list.name, password: list.password, subscribed: list.subscribed, ranking: list.ranking, email: list.email, blocked: list.blocked)
        }
        
            // Email or Password is left blank
            if email == "" || password == "" {
                showError("Please make sure both fields are filled in.")
              // Email is not valid email
            } else if !Validate.isValidEmail(email: email) {
                showError("Please make sure your email is formatted correctly.")
            
            } else if userToLogin.blocked == "true"{
                showError("You are BLOCKED")
            }else{
                
                // User password matches, then go to logged-in home screen
                if userToLogin.password == password {
                    
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                        return
                    }
                    
                    //Set the global vaariable user to the loggedin user
                    GlobalVariables.userLoguedIn = userToLogin
                    
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: "User Nav Controller") as? UINavigationController
                    
                    window.rootViewController = homeViewController
                    window.makeKeyAndVisible()
                    
                    UIView.transition(with: window, duration: 0.50, options: .transitionCrossDissolve, animations: nil, completion: nil)
                    
                    
                } else {
                    showError("Incorrect credentials, please try again.")
                }
            }
        }
    
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    
    @IBAction func goToRegistration(_ sender: Any) {
        
    }
    
}
