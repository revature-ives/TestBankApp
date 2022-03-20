//
//  HomeViewController.swift
//  TestBankApp
//
//  Created by admin on 3/20/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var HomeLabel: UILabel!
    
    @IBOutlet weak var labelBackgroundBtn: UIButton!
    @IBOutlet weak var toAdminLoginBtn: UIButton!
    @IBOutlet weak var toUserLoginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(toUserLoginBtn)
        Utilities.styleFilledButton(toAdminLoginBtn)
       //labelBackgroundBtn.setTitle("", for: .normal)
       //Utilities.styleFilledButton(labelBackgroundBtn)
        
    }
    


}
