//
//  AdminMenuViewController.swift
//  TestBankApp
//
//  Created by admin on 3/24/22.
//

import UIKit

class AdminMenuViewController: UIViewController {

    @IBOutlet weak var buildQuizOutlet: UIButton!
    @IBOutlet weak var viewUserScoresOutlet: UIButton!
    @IBOutlet weak var blockUsersOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(buildQuizOutlet)
        Utilities.styleFilledButton(viewUserScoresOutlet)
        Utilities.styleFilledButton(blockUsersOutlet)
        
    }
    


}
