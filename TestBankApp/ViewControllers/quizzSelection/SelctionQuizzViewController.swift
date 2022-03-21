//
//  SelctionQuizzViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/21/22.
//

import UIKit
import SQLite3

class SelctionQuizzViewController: UIViewController {
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set delegates and datasources to self
        iosQuizzesCollection.delegate = self
        iosQuizzesCollection.dataSource = self
        swiftQuizzesCollection.delegate = self
        swiftQuizzesCollection.dataSource = self
        xcodeQuizzesCollection.delegate = self
        xcodeQuizzesCollection.dataSource = self
        
        //Open database
      /*  var f1 = databaseHelper.prepareDatabaseFile()
        
        print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Load Lists of Quizzes
        
       // databaseHelper.fetchUserByEmail(emailToFetch: "swift")
        //databaseHelper.fetchUserByEmail(emailToFetch: "ives@gmail.com")
      //  iosQuizzes = databaseHelper.quizzesList
       // print(iosQuizzes)
       */
    }
    


}

extension SelctionQuizzViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
                   //count of xcode quizzess
                  case xcodeQuizzesCollection:
                     // return xcodeQuizzes.count
                        return 10
                  //count of ios quizzes
                  case iosQuizzesCollection:
                      //return iosQuizzes.count
                      return 8
                  //count of swift quizzes
                  case swiftQuizzesCollection:
                      //return swiftQuizzes.count
                      return 6

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
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {

             //Xcode
               case xcodeQuizzesCollection:
                   let cell = collectionView.cellForItem(at: indexPath) as! QuizzXcodeCollectionViewCell

                   //transition to Quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                   print("xcode quizz selected")
               //IOS
               case iosQuizzesCollection:
                   let cell = collectionView.cellForItem(at: indexPath) as! QuizzIOSCollectionViewCell

                   //transition to quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                   print("ios quizz selected")

              //Swift
               case swiftQuizzesCollection:

                   let cell = collectionView.cellForItem(at: indexPath) as! QuizzSwiftCollectionViewCell

                   //transition to quizz builder
                   performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
                   print("swift quizz selected")



               default:
                   let cell = collectionView.cellForItem(at: indexPath) as! QuizzIOSCollectionViewCell


               }
    }
    
}
