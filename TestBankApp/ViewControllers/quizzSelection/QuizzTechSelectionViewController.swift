//
//  QuizzTechSelectionViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/19/22.
//

import UIKit
import SQLite3

class QuizzTechSelectionViewController: UIViewController {
    
    
    let technologiesList = ["IOS","Swift","X-code"]
    var indexTechSelected = " "
    
    var rankingsIOS = [(String,String)]()
    var rankingsXcode = [(String,String)]()
    var rankingsSwift = [(String,String)]()
    
    
    // data for collection
    var iosQuizzesTaked = [TakenQuizz]()
    var swiftQuizzesTaked = [TakenQuizz]()
    var xcodeQuizzesTaked = [TakenQuizz]()
    
    var databaseHelper = DBHelper()
    var database = DBHelper.dataBase
    //UIB Outlets
    
    @IBOutlet weak var technologyPicker: UIPickerView!
    @IBOutlet weak var thecnologyLogo: UIImageView!
    
    @IBOutlet weak var technologyLabel: UILabel!
    
    @IBOutlet weak var quizzSelectionCollection: UICollectionView!
    
    @IBOutlet weak var rankingsTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Assing picker view delegates
        technologyPicker.dataSource = self
        technologyPicker.delegate = self
        
        //Asaing collection delegates
        quizzSelectionCollection.dataSource = self
        quizzSelectionCollection.delegate = self
        quizzSelectionCollection.isHidden = false
        
        rankingsTable.delegate = self
        rankingsTable.dataSource = self
        
        technologyLabel.text = "apple"
        
        var f1 = databaseHelper.prepareDatabaseFile()
        
       // print("Data base phat is :", f1)
       // var url = URL(string: f1)
        //Open the Data base or create it
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        //Load Lists of Quizzes
        
       // databaseHelper.fetchUserByEmail(emailToFetch: "swift")
        databaseHelper.rankingBytechnologyIOS()
       
        rankingsIOS = databaseHelper.rankingTupleByTechIOS
        
        databaseHelper.rankingBytechnologySwift()
       
        rankingsSwift = databaseHelper.rankingTupleByTechSwift
        
        databaseHelper.rankingBytechnologyXcode()
       
        rankingsXcode = databaseHelper.rankingTupleByTechXcode
        
        //Load quizess taken by UserLogged in
        
        databaseHelper.viewQuizzScoreByIdandTech(userID: GlobalVariables.userLoguedIn.id, tech: "IOS")
        iosQuizzesTaked = databaseHelper.quizzesTakenByUser
        databaseHelper.quizzesTakenByUser = [TakenQuizz]()
        databaseHelper.viewQuizzScoreByIdandTech(userID: GlobalVariables.userLoguedIn.id, tech: "swift")
        swiftQuizzesTaked = databaseHelper.quizzesTakenByUser
        databaseHelper.quizzesTakenByUser = [TakenQuizz]()
        databaseHelper.viewQuizzScoreByIdandTech(userID: GlobalVariables.userLoguedIn.id, tech: "xcode")
        xcodeQuizzesTaked = databaseHelper.quizzesTakenByUser
        databaseHelper.quizzesTakenByUser = [TakenQuizz]()
    }

    
    
    
    
    

}

extension QuizzTechSelectionViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        technologiesList.count
      
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return technologiesList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        indexTechSelected = technologiesList[row]
        print("tehc selected : ",indexTechSelected)
        quizzSelectionCollection.reloadData()
        rankingsTable.reloadData()
        technologyLabel.text = technologiesList[row]
        thecnologyLogo.image = UIImage(named: technologiesList[row])
    }
    

}

extension QuizzTechSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        switch indexTechSelected {
        case "IOS":
           
            return iosQuizzesTaked.count
          
        case "Swift":
            
            return swiftQuizzesTaked.count
        case "X-code":
            
            return xcodeQuizzesTaked.count
        default:
           
            return 0
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizzCell", for: indexPath) as! QuizzCollectionViewCell
        switch indexTechSelected {
        case "IOS":
           
        
            //set id of the quiz
            cell.quizzIDLabel.text = ("ID: \(String(iosQuizzesTaked[indexPath.item].quizzID))")
            //set tech logo
            cell.rankinglabel.text = ("score: \(String(iosQuizzesTaked[indexPath.item].score))")
            cell.dateTakedLabel.text = iosQuizzesTaked[indexPath.item].dateTakeb
            quizzSelectionCollection.reloadData()
            print("list ranking to display ios")
             return cell
        case "Swift":
            cell.quizzIDLabel.text = ("ID: \(String(swiftQuizzesTaked[indexPath.item].quizzID))")
            //set tech logo
            cell.rankinglabel.text = ("score: \(String(swiftQuizzesTaked[indexPath.item].score))")
            cell.dateTakedLabel.text = swiftQuizzesTaked[indexPath.item].dateTakeb
            print("list ranking to display swift")
            quizzSelectionCollection.reloadData()
            return cell
        case "X-code":
            
            cell.quizzIDLabel.text = ("ID: \(String(xcodeQuizzesTaked[indexPath.item].quizzID))")
            cell.rankinglabel.text = ("score: \(String(xcodeQuizzesTaked[indexPath.item].score))")
            cell.dateTakedLabel.text = xcodeQuizzesTaked[indexPath.item].dateTakeb
            print("list ranking to display xcode")
            quizzSelectionCollection.reloadData()
            return cell
        default:
            cell.quizzIDLabel.text = rankingsIOS[indexPath.item].0
            //set tech logo
            cell.rankinglabel.text = rankingsIOS[indexPath.item].1
            
            quizzSelectionCollection.reloadData()
            return cell
        }
   }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("cell to select quizz tapped")
        
        //Get a cell from the indext path
        let cell = collectionView.cellForItem(at: indexPath) as! QuizzCollectionViewCell
        print(indexPath.item)
        //set the Quizz Id on the la
        
    }
    
    
}

extension QuizzTechSelectionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch indexTechSelected {
        case "IOS":
            print("this ios")
            return rankingsIOS.count
          
          
        case "Swift":
            print("this swift")
            return rankingsSwift.count
        case "X-code":
            print("this xcode")
            return rankingsXcode.count
        default:
            print("this 0")
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingTableCell", for: indexPath) as! RankinTableViewCell
        
         
        
        switch indexTechSelected {
        case "IOS":
           
            cell.nameLabel.text = rankingsIOS[indexPath.item].0
          
          cell.averageScoreLabel.text = rankingsIOS[indexPath.item].1
          
            
            
          return cell
        case "Swift":
            
            cell.nameLabel.text = rankingsSwift[indexPath.item].0
          
            cell.averageScoreLabel.text = rankingsSwift[indexPath.item].1
            
            return cell
            
            
        case "X-code":
            
            cell.nameLabel.text = rankingsXcode[indexPath.item].0
          
            cell.averageScoreLabel.text = rankingsXcode[indexPath.item].1
            return cell
            
        default:
            cell.nameLabel.text = rankingsIOS[indexPath.item].0
          
          cell.averageScoreLabel.text = rankingsIOS[indexPath.item].1
            return cell
        }
    }
    
    
}
