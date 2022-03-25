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
    
    @IBOutlet weak var exitButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        Utilities.styleFilledButton(buildQuizOutlet)
        Utilities.styleFilledButton(viewUserScoresOutlet)
        Utilities.styleFilledButton(blockUsersOutlet)
        Utilities.styleFilledButton(exitButtonOutlet)
        
    }
    

    @IBAction func goToHome(_ sender: Any) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "Home Nav Controller") as? UINavigationController
        
        window.rootViewController = HomeViewController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)    }
    
}
