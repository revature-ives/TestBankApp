//
//  UserMenuViewController.swift
//  TestBankApp
//
//  Created by admin on 3/24/22.
//

import UIKit

class UserMenuViewController: UIViewController {

    @IBOutlet weak var exitButtonOutlet: UIButton!
    @IBOutlet weak var viewRankingsOutlet: UIButton!
    @IBOutlet weak var takeQuizzesOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(viewRankingsOutlet)
        Utilities.styleFilledButton(takeQuizzesOutlet)
        Utilities.styleFilledButton(exitButtonOutlet)
    }
    

   
    @IBAction func returnToHome(_ sender: Any) {
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "Home Nav Controller") as? UINavigationController
        
        window.rootViewController = HomeViewController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)    }
    
}
