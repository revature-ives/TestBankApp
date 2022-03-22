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

}
