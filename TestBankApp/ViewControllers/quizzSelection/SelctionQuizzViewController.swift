//
//  SelctionQuizzViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/21/22.
//

import UIKit
import SQLite3

class SelctionQuizzViewController: UIViewController {
    
    
    
    
    
    //User loggedIn Information
    //IB outlets
    
    
    @IBOutlet weak var nameUserLoggedIn: UILabel!
    
    @IBOutlet weak var quizzAttemptsByUserLoggedIn: UILabel!
    
    
    @IBOutlet weak var backgroundButton: UIButton!
    
   
    @IBOutlet weak var sunbscritonStatusOfUserLoggedIn: UILabel!
    
    
    
    func setUserLOggedInInformation() {
        
        nameUserLoggedIn.text = GlobalVariables.userLoguedIn.name
       // quizzAttemptsByUserLoggedIn
        sunbscritonStatusOfUserLoggedIn.text = GlobalVariables.userLoguedIn.subscribed
        
    }
    
    
    
    
    //IB outlets
    
    @IBOutlet weak var iosQuizzesCollection: UICollectionView!
    
    
    @IBOutlet weak var swiftQuizzesCollection: UICollectionView!
    
    
    
    @IBOutlet weak var xcodeQuizzesCollection: UICollectionView!
    
    
    
    
    
    
    //Model Data
    //Database
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    
    //Lists of quizzes by technology
     var iosQuizzes = [Quizz]()
     var swiftQuizzes = [Quizz]()
     var xcodeQuizzes = [Quizz]()
    var resetQuizzes = [Quizz]()
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utilities.styleFilledButton(backgroundButton)
        backgroundButton.setTitle("", for: .normal)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        //Set delegates and datasources to self
        iosQuizzesCollection.delegate = self
        iosQuizzesCollection.dataSource = self
        swiftQuizzesCollection.delegate = self
        swiftQuizzesCollection.dataSource = self
        xcodeQuizzesCollection.delegate = self
        xcodeQuizzesCollection.dataSource = self
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 60, width: view.frame.size.width, height: 40))
        view.addSubview(navBar)
        
    
        let navItem = UINavigationItem(title: "")
        var leftBarBackButton : UIBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(goToRoot))
        navItem.leftBarButtonItem = leftBarBackButton
        
        navBar.setItems([navItem], animated: false)
        navBar.backgroundColor = UIColor.clear
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
        
        
        //Set user logged in information
        quizzAttemptsByUserLoggedIn.text = "0"
        
        
        setUserLOggedInInformation()
        
        //Open database
        var f1 = databaseHelper.prepareDatabaseFile()
        
       // print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Load Lists of Quizzes
        
       // databaseHelper.fetchUserByEmail(emailToFetch: "swift")
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "IOS")
       iosQuizzes = databaseHelper.quizzesList
       // print("IOS QUIZZES")
      //  print("   ")
       // print(iosQuizzes)
        databaseHelper.quizzesList = resetQuizzes
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "swift")
        swiftQuizzes = databaseHelper.quizzesList
       // print("SWIFT QUIZZES")
       // print("   ")
       // print(swiftQuizzes)
        
        databaseHelper.quizzesList = resetQuizzes
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "xcode")
        
       xcodeQuizzes = databaseHelper.quizzesList
       
      
    }
    
    @objc func goToRoot(){
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
            return
        }
        
        
        
        let userViewController = self.storyboard?.instantiateViewController(identifier: "User Nav Controller") as? UINavigationController
        
        window.rootViewController = userViewController
        window.makeKeyAndVisible()
        
        UIView.transition(with: window, duration: 0.20, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        quizzAttempts()
        quizzAttemptsByUserLoggedIn.text = String(GlobalVariables.quizzAttempts)
    }
    
    
    
    //function to check the accounts of quizz attempts
    func quizzAttempts(){
        
        //check if the user is subscribe
        if GlobalVariables.userLoguedIn.subscribed == "no" && GlobalVariables.quizzAttempts >= 2{
            
            showAlertView(msg: "You complete your attemps for today ")
            iosQuizzesCollection.allowsSelection = false
            
        }
        
        
    }
    
    
    //function to display alert
    
    func showAlertView(msg: String){
        let alertController = UIAlertController(title: "Free User Attempts", message: msg, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okButton)
        present(alertController, animated: true, completion: nil)
    }


}

extension SelctionQuizzViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
       
       
        switch collectionView {
                  
                  //count of ios quizzes
                  case iosQuizzesCollection:
                      return iosQuizzes.count
                      //return 8
                  //count of swift quizzes
                  case swiftQuizzesCollection:
                      return swiftQuizzes.count
                     // return 6
                //count of xcode quizzess
                 case xcodeQuizzesCollection:
                     return xcodeQuizzes.count
               //  return 10
                  default:
                      return 1
                  }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewwLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/3.5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     //   var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIOSQuizz", //for: //indexPath) as! QuizzIOSCollectionViewCell
        
        
        
        
       // cell.idLabel.text = "IOS"
        //return cell
        
        //Creating the cell for quizzes
                  switch collectionView {

                      //IOS
                      case iosQuizzesCollection:
                          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIOSQuizz", for: indexPath) as! QuizzIOSCollectionViewCell
                          //print("ios quizz \(iosQuizzes[indexPath.item].id)  and tehc is  \(iosQuizzes[indexPath.item].technology)")
                      
                      cell.idLabel.text = "Quiz \(iosQuizzes[indexPath.item].id)"
                      
                          return cell
                      
                      
                      //Swift
                       case swiftQuizzesCollection:
                           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! QuizzSwiftCollectionViewCell
                           
                         //  print("swift quizz \(swiftQuizzes[indexPath.item].id)  and tehc is  \(swiftQuizzes[indexPath.item].technology)")
                        
                      cell.quizzIDlabel.text = "Quiz \(swiftQuizzes[indexPath.item].id)"
                      
                           return cell
                      
                  
                      
                      //Xcode
                  case xcodeQuizzesCollection:
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellXcodeQuizz", for: indexPath) as! QuizzXcodeCollectionViewCell

                    //  print("xcode quizz \(xcodeQuizzes[indexPath.item].id)  and tehc is  \(xcodeQuizzes[indexPath.item].technology)")
                      
                      cell.quizzIDLabel.text = "Quiz \(xcodeQuizzes[indexPath.item].id)"
                      
                         
                      return cell


                  

                 



                  default:
                      
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! QuizzIOSCollectionViewCell
                      return cell
                  }

        
        
        
        
        
    }
    
    
    
    
    
    
    fileprivate func setGlobalQuizzId(_ indexPath: IndexPath,quizzesList: [Quizz]) {
        print("the quiz selected whit id ",quizzesList[indexPath.item].id)
        GlobalVariables.quizzSelected.id = quizzesList[indexPath.item].id
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        quizzAttempts()
        
        switch collectionView {

             //Xcode
               case xcodeQuizzesCollection:
            let cell = collectionView.cellForItem(at: indexPath) as! QuizzXcodeCollectionViewCell
                   setGlobalQuizzId(indexPath, quizzesList: xcodeQuizzes)
                     
                   //transition to Quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                 
               //IOS
               case iosQuizzesCollection:
                 
                 let cell = collectionView.cellForItem(at: indexPath) as! QuizzIOSCollectionViewCell
                 setGlobalQuizzId(indexPath, quizzesList: iosQuizzes)
            
                   //transition to quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                 

              //Swift
               case swiftQuizzesCollection:

            let cell = collectionView.cellForItem(at: indexPath) as! QuizzSwiftCollectionViewCell
                   setGlobalQuizzId(indexPath, quizzesList: swiftQuizzes)
                   //transition to quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                   



               default:
                 //  let cell = collectionView.cellForItem(at: indexPath) as! QuizzIOSCollectionViewCell
                   //setGlobalQuizzId(indexPath)\
                  print("no data")
               }
    }
    
}
