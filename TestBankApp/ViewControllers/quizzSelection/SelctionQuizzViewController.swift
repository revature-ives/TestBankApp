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
        
        //Set delegates and datasources to self
        iosQuizzesCollection.delegate = self
        iosQuizzesCollection.dataSource = self
        swiftQuizzesCollection.delegate = self
        swiftQuizzesCollection.dataSource = self
        xcodeQuizzesCollection.delegate = self
        xcodeQuizzesCollection.dataSource = self
        
        
        //Set user logged in information
        
        
        
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
    


}

extension SelctionQuizzViewController: UICollectionViewDelegate, UICollectionViewDataSource{
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
                          return cell
                      
                      
                      //Swift
                       case swiftQuizzesCollection:
                           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! QuizzSwiftCollectionViewCell
                           
                         //  print("swift quizz \(swiftQuizzes[indexPath.item].id)  and tehc is  \(swiftQuizzes[indexPath.item].technology)")
                           return cell
                      
                  
                      
                      //Xcode
                  case xcodeQuizzesCollection:
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellXcodeQuizz", for: indexPath) as! QuizzXcodeCollectionViewCell

                    //  print("xcode quizz \(xcodeQuizzes[indexPath.item].id)  and tehc is  \(xcodeQuizzes[indexPath.item].technology)")
                         
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
