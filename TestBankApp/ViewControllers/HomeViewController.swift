//
//  HomeViewController.swift
//  TestBankApp
//
//  Created by admin on 3/20/22.
//

import UIKit

class HomeViewController: UIViewController {
    //Outlet block for the view.
    @IBOutlet weak var HomeLabel: UILabel!
    @IBOutlet weak var toAdminLoginBtn: UIButton!
    @IBOutlet weak var toUserLoginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Styles the Buttons on the screen.
        Utilities.styleFilledButton(toUserLoginBtn)
        Utilities.styleFilledButton(toAdminLoginBtn)
    }
    


}
