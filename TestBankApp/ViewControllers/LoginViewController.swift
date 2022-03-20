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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Setting up styles for buttons.
        Utilities.styleErrorLabel(errorLabel)
        Utilities.styleFilledButton(loginBtnOut)
        Utilities.styleFilledButton(registerBtnOut)
        Utilities.styleTextField(loginEmailTF, placeHolderString: "enter Email")
        Utilities.styleTextField(loginPasswordTF, placeHolderString: "enter Password")
    }
    
    @IBAction func loginSubmit(_ sender: Any) {
        // Remove whitespace and new lines from email and password textfield values
      /*  let email = loginEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = loginPasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Replace below snippet with query to SQLite
        //var userToLogin: [User]? = ModelController.getUsersByEmail(email: email)
        
        if let userToLoginValue = userToLogin {
            userToLogin = userToLoginValue
            // Email or Password is left blank
            if email == "" || password == "" {
                showError("Please make sure both fields are filled in.")
              // Email is not valid email
            } else if !Validate.isValidEmail(email: email) {
                showError("Please make sure your email is formatted correctly.")
              // User already exists
            } else if userToLogin?.count == 0 {
                showError("That user doesn't exist.")
            } else {
                // User can be created, then go to logged-in home screen
                if userToLogin?[0].password == password {
                    
                    guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                        return
                    }
                    
                    let homeViewController = self.storyboard?.instantiateViewController(identifier: "welcomeNavigation") as? UINavigationController
                    
                    window.rootViewController = homeViewController
                    window.makeKeyAndVisible()
                    
                    UIView.transition(with: window, duration: 1.65, options: .transitionCrossDissolve, animations: nil, completion: nil)
                    
                    
                } else {
                    showError("Incorrect credentials, please try again.")
                }
            }
        }*/
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }

    
    @IBAction func goToRegistration(_ sender: Any) {
        
    }
    
}
