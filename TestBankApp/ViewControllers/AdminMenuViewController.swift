//
//  AdminMenuViewController.swift
//  TestBankApp
//
//  Created by admin on 3/24/22.
//

import UIKit

class AdminMenuViewController: UIViewController {
    //Outlet Block.
    @IBOutlet weak var buildQuizOutlet: UIButton!
    @IBOutlet weak var viewUserScoresOutlet: UIButton!
    @IBOutlet weak var blockUsersOutlet: UIButton!
    @IBOutlet weak var exitButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Styles the Buttons.
        Utilities.styleFilledButton(buildQuizOutlet)
        Utilities.styleFilledButton(viewUserScoresOutlet)
        Utilities.styleFilledButton(blockUsersOutlet)
        Utilities.styleFilledButton(exitButtonOutlet)
        
    }
    //Function to go back to the Home Screen Navigation Controller.
    @IBAction func goToHome(_ sender: Any) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        //Holds the view to go to.
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "Home Nav Controller") as? UINavigationController
        //Goes to the view.
        window.rootViewController = HomeViewController
        window.makeKeyAndVisible()
        //Transition information.
        UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)
    }
}
