//
//  RegistrationViewController.swift
//  TestBankApp
//
//  Created by admin on 3/18/22.
//

import UIKit
import SQLite3

class RegistrationViewController: UIViewController {

    
    //outlets for the elements ont the screen
    @IBOutlet weak var regLabelOutlet: UILabel!
    @IBOutlet weak var regUsernameTF: UITextField!
    @IBOutlet weak var regEmailTF: UITextField!
    @IBOutlet weak var regPasswordTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var registrationButtonOut: UIButton!
    
    // variable to hold the subscription information.
    var subscription : String = "no"
    // object to hold the Database helper class to access the SQL Database
    var databaseHelper = DBHelper()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //calls the function to find or create the database, stores the path in f1
        var f1 = databaseHelper.prepareDatabaseFile()
        //prints the database to the console so we can find it, if needed.
        print("Data base phat is :", f1)
        //Open the Data base or create it
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Styling the various buttons and Text Fields
        Utilities.styleFilledButton(registrationButtonOut)
        Utilities.styleTextField(regUsernameTF, placeHolderString: "enter Username")
        Utilities.styleTextField(regEmailTF, placeHolderString: "enter Email")
        Utilities.styleTextField(regPasswordTF, placeHolderString: "enter Password")
        Utilities.styleErrorLabel(errorLabel)
        
    }
    
    
    //function to validate the Text Fields
    func validateFields() -> String? {
        
        // Check that email and password fields are filled in
        if  regEmailTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            regPasswordTF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //error message in case fields are empty
            return "Please make sure email and password fields are filled in."
        }
        
        //Check if the email is a valid email
        let cleanedEmail = regEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Validate.isValidEmail(email: cleanedEmail) == false {
            // email isn't proper format error
            return "Please make sure your email is formatted correctly."
        }
        
        // Check if the password is secure
        let cleanedPassword = regPasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Validate.isValidPassword(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters and contains a special character."
        }
        //default return for function
        return nil
    }
    
    //action for the Subscriber Switch, an be on or off
    @IBAction func subSwitch(_ sender: UISwitch) {
        //Sets the subscription variable to yes if on, no if off
        if sender.isOn {
            subscription = "yes"
        }else{
            subscription = "no"
        }
    }
    //action for the submit button
    @IBAction func registrationSubmit(_ sender: Any) {
        //checks the fields and returns an error message if there are issues. Otherwise it is nil.
        let error = validateFields()
        //if there is an error, display the error.
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
            // creates clean versions of the email and password
            let email = regEmailTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = regPasswordTF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
                // Create the user
            databaseHelper.addUserToDataBase(name: uname!, password: password,ranking: "0",subscribed: subscription,  mail: email, blocked: "false")
            // moves back to the login page
            transitionLogin()
        }
    }
        //function to display the error messages and show the error label
        func showError(_ message:String) {
            errorLabel.text = message
            errorLabel.alpha = 1
        }
    // function to move the screen back to the login screen.
    func transitionLogin() {
        //sets the view to transition to.
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "User Login") as? LoginViewController
        //configures the transition information
        let transition = CATransition()
        transition.type = .push
        transition.duration = 0.25
        view.window?.layer.add(transition, forKey: kCATransition)
        //moves the view to the view controller specified.
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }
        
        
}
    

