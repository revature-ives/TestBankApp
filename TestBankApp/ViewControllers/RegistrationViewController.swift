//
//  RegistrationViewController.swift
//  TestBankApp
//
//  Created by admin on 3/18/22.
//

import UIKit
import SQLite3

class RegistrationViewController: UIViewController {

    @IBOutlet weak var regLabelOutlet: UILabel!
    @IBOutlet weak var regUsernameTF: UITextField!
    @IBOutlet weak var regEmailTF: UITextField!
    @IBOutlet weak var regPasswordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    var subscription : String = "false"
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var databaseHelper = DBHelper()
        
        var f1 = databaseHelper.prepareDatabaseFile()
        print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        databaseHelper.addQuestionToDatabase(questionAsked: "Is a Framework from IOS", option1: "Spring", option2: "AVFoundation", option3: "Mockito", answer: "option2", quizId: 3)
        
    }
    
    
    
    func validateFields() -> String? {
        
        //firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        //lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
        
        // Check that email and password fields are filled in
        if  regEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            regPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please make sure email and password fields are filled in."
        }
        
        //Check if the email is a valid email
        let cleanedEmail = regEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Validate.isValidEmail(email: cleanedEmail) == false {
            // email isn't proper format
            return "Please make sure your email is formatted correctly."
        }
        
        // Check if the password is secure
        let cleanedPassword = regPasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Validate.isValidPassword(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters and contains a special character."
        }
        
        return nil
    }
    
    
    @IBAction func subSwitch(_ sender: UISwitch) {
        
        if sender.isOn {
            subscription = "true"
        }else{
            subscription = "false"
        }
    }
    
    @IBAction func registrationSubmit(_ sender: Any) {
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            var uname: String?
            // Create cleaned versions of the data
            if let usernameValue = regUsernameTF?.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                uname = usernameValue
            } else { uname = "" }

            let email = regEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = regPasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // check if user with email already exists
            // Replace this : if ModelController.getUsersByEmail(email: email)!.count == 0 {
                // user does not already exist
                // Create the user
               // Replace : ModelController.createUser(firstName: firstName, lastName: lastName, email: email, password: password)
               // transitionLogin()
            //}
           // else {
                // user email already exists
           //     showError("That user with email: \(email) already exists.")
           // }
        }
    }
        func showError(_ message:String) {
            
            errorLabel.text = message
            errorLabel.alpha = 1
        }
        
    func transitionToHome() {
        
        let homeViewController = self.storyboard?.instantiateViewController(identifier: "welcomeNavigation") as? UINavigationController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
     
    }
    
    func transitionLogin() {
        
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "loginView") as? LoginViewController
        
        let transition = CATransition()
        transition.type = .push
        transition.duration = 0.25
        view.window?.layer.add(transition, forKey: kCATransition)
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
        
        
    }
    

