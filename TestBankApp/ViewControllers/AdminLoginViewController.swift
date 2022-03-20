//
//  AdminLoginViewController.swift
//  TestBankApp
//
//  Created by admin on 3/18/22.
//

import UIKit
import SQLite3

class AdminLoginViewController: UIViewController {
    
    var databaseHelper = DBHelper()
    
    @IBOutlet weak var adminEmailTF: UITextField!
    
    @IBOutlet weak var adminPasswordTF: UITextField!
    
    
    @IBOutlet weak var ErrorLabel: UILabel!
    
    @IBOutlet weak var AdminLoginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var f1 = databaseHelper.prepareDatabaseFile()
        
        print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        Utilities.styleTextField(adminEmailTF, placeHolderString: "enter Email")
        Utilities.styleTextField(adminPasswordTF, placeHolderString: "enter Password")
        Utilities.styleFilledButton(AdminLoginBtn)
        Utilities.styleErrorLabel(ErrorLabel)
        
        
    }
    

    @IBAction func adminLoginButton(_ sender: Any) {
        
        let adminEmail = adminEmailTF.text!
        let adminPassword = adminPasswordTF.text!
        var tempAdmin : Admin = Admin(id: 0, name: "", email: "", password: "")
        
        databaseHelper.retrieveAdminInfo()
        
        for list in databaseHelper.adminList{
            tempAdmin = Admin(id: list.id, name: list.name, email: list.email, password: list.password)
        }
        
        
        
        if adminEmail == tempAdmin.email && adminPassword == tempAdmin.password {
            transitionToAdmin()
        }
        else{
               showError("This information is incorrect")
        }
        
        print("admin info \(tempAdmin.email)  and \(tempAdmin.password)")
        
        
    }
    
    func showError(_ message:String) {
        
        ErrorLabel.text = message
        ErrorLabel.alpha = 1
    }
    
    func transitionToAdmin() {
        
        let startViewController = self.storyboard?.instantiateViewController(identifier: "Admin Nav Controller") as? UINavigationController
        
        let transition = CATransition()
        transition.type = .push
        transition.duration = 0.25
        view.window?.layer.add(transition, forKey: kCATransition)
        
        view.window?.rootViewController = startViewController
        view.window?.makeKeyAndVisible()
    }
    
}
