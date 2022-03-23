//
//  ResultViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/22/22.
//

import UIKit

class ResultViewController: UIViewController {
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func returnToQuizzSelection(_ sender: Any) {
        transitionToQuizzSelection()
    }
    
    func transitionToQuizzSelection() {
        
        let loginViewController = self.storyboard?.instantiateViewController(identifier: "quizzSelection") as? SelctionQuizzViewController
        
        let transition = CATransition()
        transition.type = .push
        transition.duration = 0.25
        view.window?.layer.add(transition, forKey: kCATransition)
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }

    @IBAction func moveToFeedback(_ sender: Any) {
        
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        let FeedbackViewController = self.storyboard?.instantiateViewController(identifier: "Feedback View") as? FeedbackViewController
        
        window.rootViewController = FeedbackViewController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromRight, animations: nil, completion: nil)    }
}
