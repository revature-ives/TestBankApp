//
//  UserMenuViewController.swift
//  TestBankApp
//
//  Created by admin on 3/24/22.
//

import UIKit

class UserMenuViewController: UIViewController {

    @IBOutlet weak var viewRankingsOutlet: UIButton!
    @IBOutlet weak var takeQuizzesOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(viewRankingsOutlet)
        Utilities.styleFilledButton(takeQuizzesOutlet)
    }
    

   

}
