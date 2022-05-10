//
//  UserMenuViewController.swift
//  TestBankApp
//
//  Created by admin on 3/24/22.
//

import UIKit

class UserMenuViewController: UIViewController {
    //Outlet block
    @IBOutlet weak var exitButtonOutlet: UIButton!
    @IBOutlet weak var viewRankingsOutlet: UIButton!
    @IBOutlet weak var takeQuizzesOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Style all the buttons.
        Utilities.styleFilledButton(viewRankingsOutlet)
        Utilities.styleFilledButton(takeQuizzesOutlet)
        Utilities.styleFilledButton(exitButtonOutlet)
    }
    //Fucktion to go back to the Home Screen navigation controller.
    @IBAction func returnToHome(_ sender: Any) {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        //Holds the view to go to.
        let HomeViewController = self.storyboard?.instantiateViewController(identifier: "Home Nav Controller") as? UINavigationController
        //Actually goes to the view.
        window.rootViewController = HomeViewController
        window.makeKeyAndVisible()
        //Sets the transition information.
        UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)    }
}
