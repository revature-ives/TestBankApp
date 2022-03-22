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
    
    //Mock Data to Test
    
    let quizzIOS1 = Quizz(id: 1, tech: "IOS")
    let quizzIOS2 = Quizz(id: 2, tech: "IOS")
    let quizzIOS3 = Quizz(id: 3, tech: "IOS")
    let quizzIOS4 = Quizz(id: 4, tech: "IOS")
    let quizzIOS5 = Quizz(id: 5, tech: "IOS")
    let quizzST1 = Quizz(id: 6, tech: "swift")
    let quizzST2 = Quizz(id: 7, tech: "swift")
    let quizzST3 = Quizz(id: 8, tech: "swift")
    let quizzST4 = Quizz(id: 9, tech: "swift")
    let quizzST5 = Quizz(id: 10, tech: "swift")
    let quizzX1 = Quizz(id: 11, tech: "xcode")
    let quizzX2 = Quizz(id: 12, tech: "xcode")
    let quizzX3 = Quizz(id: 13, tech: "xcode")
    let quizzX4 = Quizz(id: 14, tech: "xcode")
    let quizzX5 = Quizz(id: 15, tech: "xcode")
    
    //PopulateLisk whit mock data
    func fillLists(){
        iosQuizzes.append(quizzIOS1)
        iosQuizzes.append(quizzIOS2)
        iosQuizzes.append(quizzIOS3)
        iosQuizzes.append(quizzIOS4)
        iosQuizzes.append(quizzIOS5)
        swiftQuizzes.append(quizzST1)
        swiftQuizzes.append(quizzST2)
        swiftQuizzes.append(quizzST3)
        swiftQuizzes.append(quizzST4)
        swiftQuizzes.append(quizzST5)
        xcodeQuizzes.append(quizzX1)
        xcodeQuizzes.append(quizzX2)
        xcodeQuizzes.append(quizzX3)
        xcodeQuizzes.append(quizzX4)
        xcodeQuizzes.append(quizzX5)
        
    }
    
    
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
        
        print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Load Lists of Quizzes
        
       // databaseHelper.fetchUserByEmail(emailToFetch: "swift")
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "IOS")
      //  iosQuizzes = databaseHelper.quizzesList
       // print(iosQuizzes)
       
        
        
        //Call method to fill whit mock data
        fillLists()
    }
    


}

extension SelctionQuizzViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
       
       
        switch collectionView {
                   //count of xcode quizzess
                  case xcodeQuizzesCollection:
                      return xcodeQuizzes.count
                      //  return 10
                  //count of ios quizzes
                  case iosQuizzesCollection:
                      return iosQuizzes.count
                      //return 8
                  //count of swift quizzes
                  case swiftQuizzesCollection:
                      return swiftQuizzes.count
                     // return 6

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

                //Xcode
                  case xcodeQuizzesCollection:
                        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellXcodeQuizz", for: indexPath) as! QuizzXcodeCollectionViewCell

                      
                         
                      return cell


                  //IOS
                  case iosQuizzesCollection:
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIOSQuizz", for: indexPath) as! QuizzIOSCollectionViewCell
                      
                      cell.quizzImage.backgroundColor = UIColor.cyan
                      cell.idLabel.text = String(iosQuizzes[indexPath.item].id)
                      return cell

                 //Swift
                  case swiftQuizzesCollection:
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! QuizzSwiftCollectionViewCell
                      return cell



                  default:
                      
                      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! QuizzSwiftCollectionViewCell
                      return cell
                  }

        
        
        
        
        
    }
    
    
    
    
    
    
    fileprivate func setGlobalQuizzId(_ indexPath: IndexPath) {
        print("the quiz selected whit id ",iosQuizzes[indexPath.item].id)
        GlobalVariables.quizzSelected.id = iosQuizzes[indexPath.item].id
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {

             //Xcode
               case xcodeQuizzesCollection:
                   let cell = collectionView.cellForItem(at: indexPath) as! QuizzXcodeCollectionViewCell
                   setGlobalQuizzId(indexPath)
                     
                   //transition to Quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                 
               //IOS
               case iosQuizzesCollection:
                 
                 let cell = collectionView.cellForItem(at: indexPath) as! QuizzIOSCollectionViewCell
                 setGlobalQuizzId(indexPath)
            
                   //transition to quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                 

              //Swift
               case swiftQuizzesCollection:

                   let cell = collectionView.cellForItem(at: indexPath) as! QuizzSwiftCollectionViewCell
                   setGlobalQuizzId(indexPath)
                   //transition to quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                   



               default:
                   let cell = collectionView.cellForItem(at: indexPath) as! QuizzIOSCollectionViewCell
                   //setGlobalQuizzId(indexPath)
               }
    }
    
}
