//
//  SelectionQuizzViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/20/22.





//

import UIKit
import SQLite3

class SelectionQuizzViewController: UIViewController {
    
    //IB Outlets
    
    @IBOutlet weak var iosQuizzesCollection: UICollectionView!
    
    @IBOutlet weak var swiftQuizzesCollection: UICollectionView!
    
    @IBOutlet weak var xcodeQuizzesCollection: UICollectionView!
    
    
    //DAta model
    
    var quizzesList = [Quizz]()
    var quizzesIOSList = [Quizz]()
    var quizzesSwiftList = [Quizz]()
    var quizzesXcodeList = [Quizz]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set datasource and delegate for quizzes collections
        
        iosQuizzesCollection.dataSource = self
        iosQuizzesCollection.delegate = self
        swiftQuizzesCollection.dataSource = self
        swiftQuizzesCollection.delegate = self
        xcodeQuizzesCollection.dataSource = self
       xcodeQuizzesCollection.delegate = self
        
        
        //Prepare databe
        
        var databaseHelper = DBHelper()
        
        var f1 = databaseHelper.prepareDatabaseFile()
        print("Data base phat is :", f1)
       
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Fetch quizzes
        
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "IOS")
        
        //Should be 3 queries to get 3 differen list for each technology
        quizzesList = databaseHelper.quizzesList
        //
        
    }
    

   

}


//Extension to controll IOS Quizzes Collection
extension SelectionQuizzViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

    
    //Numbers of quizzes displayed
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
          
          //Defining the size of the quizzes collections
          
          
          switch collectionView {
           //count of xcode quizzess
          case xcodeQuizzesCollection:
              return quizzesList.count
           
          //count of ios quizzes
          case iosQuizzesCollection:
              return quizzesList.count
            
          //count of swift quizzes
          case swiftQuizzesCollection:
              return quizzesList.count
          
          default:
              return 1
          }
          
      }

    
      // the quizz image
    
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
          //Creating the cell for quizzes
          switch collectionView {
              
        //Xcode
          case xcodeQuizzesCollection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellXcodeQuizz", for: indexPath) as! XcodeCollectionViewCell
            
              return cell
             
              
          //IOS
          case iosQuizzesCollection:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIOSQuizz", for: indexPath) as! IOSCollectionViewCell
              return cell
              
         //Swift
          case swiftQuizzesCollection:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellSwiftQuizz", for: indexPath) as! SwiftCollectionViewCell
              return cell
              
       
              
          default:
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellIOSQuizz", for: indexPath) as! IOSCollectionViewCell
              
              return cell
          }
          
          
          
      }
    
    
    
    
    
    //Action when a quizz is selected
    //Should proont an alert message to confirm the quizz to atempt
    //If the confirmation is ok transitio to QuizzTest View and sen the id of the quizz to take whit the user ho is going to take
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell to select quizz tapped")
        
      //  if quizzAttemps < allowedQuizzAttempts {
        
        //Get a cell from the indext path
        
        
      
        
        switch collectionView {
            
      //Xcode
        case xcodeQuizzesCollection:
            let cell = collectionView.cellForItem(at: indexPath) as! XcodeCollectionViewCell
            
            //transition to Quizz builder
            performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
            print("xcode quizz selected")
        //IOS
        case iosQuizzesCollection:
            let cell = collectionView.cellForItem(at: indexPath) as! IOSCollectionViewCell
            
            //transition to quizz builder
            performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
            print("ios quizz selected")
            
       //Swift
        case swiftQuizzesCollection:
            
            let cell = collectionView.cellForItem(at: indexPath) as! SwiftCollectionViewCell
            
            //transition to quizz builder
            performSegue(withIdentifier: "segueSelectedtoAttempt", sender: self)
            print("swift quizz selected")
            
     
            
        default:
            let cell = collectionView.cellForItem(at: indexPath) as! XcodeCollectionViewCell

            
        }
      
        
    }
    
}

