//
//  SelctionQuizzViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/21/22.
//

import UIKit
import SQLite3

class SelctionQuizzViewController: UIViewController {
    

    
    //MARK: IB Outlets
   
    
    
    @IBOutlet weak var nameUserLoggedIn: UILabel!
    
    @IBOutlet weak var quizzAttemptsByUserLoggedIn: UILabel!
    
    
    @IBOutlet weak var backgroundButton: UIButton!
    
   
    @IBOutlet weak var sunbscritonStatusOfUserLoggedIn: UILabel!
    
    
    @IBOutlet weak var iosQuizzesCollection: UICollectionView!
    
    
    @IBOutlet weak var swiftQuizzesCollection: UICollectionView!
    
    
    
    @IBOutlet weak var xcodeQuizzesCollection: UICollectionView!
    
    
    //MARK: Model data
    
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    
    //Lists of quizzes by technology
     var iosQuizzes = [Quizz]()
     var swiftQuizzes = [Quizz]()
     var xcodeQuizzes = [Quizz]()
    //this list is to set the list of quizzes to empty list after populating the list of quizzes
    var resetQuizzes = [Quizz]()
    
   
   
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDelegatesanDataSources()
        setNvigationControls()
        
        quizzAttemptsByUserLoggedIn.text = "0"
        setUserLOggedInInformation()
        connectAndFetchDataBase()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //Counting the number of quizzes ateempted and set up the golbar variable
        quizzAttempts()
        quizzAttemptsByUserLoggedIn.text = String(GlobalVariables.quizzAttempts)
    }
    
    
    //MARK: Auxiliar methods
    
    fileprivate func setDelegatesanDataSources() {
        //TODO: Assigning delegates and datasources
        
        iosQuizzesCollection.delegate = self
        iosQuizzesCollection.dataSource = self
        swiftQuizzesCollection.delegate = self
        swiftQuizzesCollection.dataSource = self
        xcodeQuizzesCollection.delegate = self
        xcodeQuizzesCollection.dataSource = self
    }
    
    fileprivate func setNvigationControls() {
        //TODO: Setting of navigation elements
        
        Utilities.styleFilledButton(backgroundButton)
        backgroundButton.setTitle("", for: .normal)
        
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 60, width: view.frame.size.width, height: 40))
        view.addSubview(navBar)
        
        
        let navItem = UINavigationItem(title: "")
        let leftBarBackButton : UIBarButtonItem = UIBarButtonItem(title: "< Back", style: .plain, target: self, action: #selector(goToRoot))
        navItem.leftBarButtonItem = leftBarBackButton
        
        navBar.setItems([navItem], animated: false)
        navBar.backgroundColor = UIColor.clear
        navBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navBar.shadowImage = UIImage()
    }
    
    
    fileprivate func connectAndFetchDataBase() {
        //TODO: Open dat base and populate model data
        let f1 = databaseHelper.prepareDatabaseFile()
        
        
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "IOS")
        iosQuizzes = databaseHelper.quizzesList
        databaseHelper.quizzesList = resetQuizzes
        
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "swift")
        swiftQuizzes = databaseHelper.quizzesList
        databaseHelper.quizzesList = resetQuizzes
        
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "xcode")
        xcodeQuizzes = databaseHelper.quizzesList
        databaseHelper.quizzesList = resetQuizzes
    }
    
    
    
    
    //This function assign volues to the gloval variables ,in that way we dont need to fect the databse all the time we need those values
    func setUserLOggedInInformation() {
        
        nameUserLoggedIn.text = GlobalVariables.userLoguedIn.name
       // quizzAttemptsByUserLoggedIn
        sunbscritonStatusOfUserLoggedIn.text = GlobalVariables.userLoguedIn.subscribed
        
    }
    
    fileprivate func setGlobalQuizzId(_ indexPath: IndexPath,quizzesList: [Quizz]) {
        print("the quiz selected whit id ",quizzesList[indexPath.item].id)
        GlobalVariables.quizzSelected.id = quizzesList[indexPath.item].id
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
    
    
    //function to check the accounts of quizz attempts
    //if the user is free block the collections views ,no other item can be selected
    func quizzAttempts(){
        
        //check if the user is subscribe
        if GlobalVariables.userLoguedIn.subscribed == "no" && GlobalVariables.quizzAttempts >= 2{
            
            showAlertView(msg: "You complete your attemps for today ")
            iosQuizzesCollection.allowsSelection = false
            swiftQuizzesCollection.allowsSelection = false
            xcodeQuizzesCollection.allowsSelection = false
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

//MARK: Collections views

extension SelctionQuizzViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
                  
                  //count of ios quizzes
                  case iosQuizzesCollection:
                      return iosQuizzes.count
                   
                  //count of swift quizzes
                  case swiftQuizzesCollection:
                      return swiftQuizzes.count
                   
                //count of xcode quizzess
                 case xcodeQuizzesCollection:
                     return xcodeQuizzes.count
               
                  default:
                      return 1
                  }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewwLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/3.5)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Creating the cell for quizzes
                  switch collectionView {

                //IOS
                 case iosQuizzesCollection:
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIOSQuizz", for: indexPath) as! QuizzIOSCollectionViewCell
                      cell.idLabel.text = "Quiz \(iosQuizzes[indexPath.item].id)"
                      return cell
                      
                      
                //Swift
                 case swiftQuizzesCollection:
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! QuizzSwiftCollectionViewCell
                      cell.quizzIDlabel.text = "Quiz \(swiftQuizzes[indexPath.item].id)"
                      return cell
                      
                  //Xcode
                  case xcodeQuizzesCollection:
                      
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellXcodeQuizz", for: indexPath) as! QuizzXcodeCollectionViewCell
                      cell.quizzIDLabel.text = "Quiz \(xcodeQuizzes[indexPath.item].id)"
                      return cell

                  default:
                      
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! QuizzIOSCollectionViewCell
                      return cell
                  }

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          

        quizzAttempts()
        
        switch collectionView {

             //Xcode
               case xcodeQuizzesCollection:
            _ = collectionView.cellForItem(at: indexPath) as! QuizzXcodeCollectionViewCell
                   setGlobalQuizzId(indexPath, quizzesList: xcodeQuizzes)
                     
                   //transition to Quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                 
               //IOS
               case iosQuizzesCollection:
                 
            _ = collectionView.cellForItem(at: indexPath) as! QuizzIOSCollectionViewCell
                  setGlobalQuizzId(indexPath, quizzesList: iosQuizzes)
            
                   //transition to quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                 

              //Swift
               case swiftQuizzesCollection:

            _ = collectionView.cellForItem(at: indexPath) as! QuizzSwiftCollectionViewCell
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

