//
//  QuizzTechSelectionViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/19/22.
//

import UIKit
import SQLite3

class QuizzTechSelectionViewController: UIViewController {
    
    //varible to keep track of the attempts
    var quizzAttemps = 0
    var allowedQuizzAttempts = 2
    
    //list of technologies
    let technologiesList = ["IOS","Swift","X-code"]
    
    
    //temporally quizzes string
   // let quizzesList = ["quizz1","quizz2","quizz3","quizz4","quizz5","quizz6","quizz7","quizz8"]
    
    
    //User logged in
    var user = User(id: 1, name: "Ives", password: "123", subscribed: "no", ranking: "0", email: "ives@hotmail.com")
    
    
    
    //Get all quizzes
   
    
    
    //List of quizzes by chooseen technoloqy
 /*   var quiz1 = Quizz(id: 1, tech: "IOS")
    var quiz2 = Quizz(id: 2, tech: "IOS")
    var quiz3 = Quizz(id: 3, tech: "IOS")
    var quiz4 = Quizz(id: 4, tech: "IOS")
    var quiz5 = Quizz(id: 5, tech: "IOS")
    
    
    var quiz6 = Quizz(id: 6, tech: "Swift")
    var quiz7 = Quizz(id: 7, tech: "Swift")
    var quiz8 = Quizz(id: 8, tech: "Swift")
    var quiz9 = Quizz(id: 9, tech: "Swift")
    var quiz10 = Quizz(id: 10, tech: "Swift")
    
    
    var quiz11 = Quizz(id: 11, tech: "xcode")
    var quiz12 = Quizz(id: 12, tech: "xcode")
    var quiz13 = Quizz(id: 13, tech: "xcode")
    var quiz14 = Quizz(id: 14, tech: "xcode")
    var quiz15 = Quizz(id: 15, tech: "xcode")
    
    var quizzesObjLists = [Quizz]()
    //Add quizzes to list
    func getIOSQuizz(){
        quizzesObjLists.append(quiz1)
        quizzesObjLists.append(quiz2)
        quizzesObjLists.append(quiz3)
        quizzesObjLists.append(quiz4)
        quizzesObjLists.append(quiz5)
    }
    
    func getSwiftQuizz(){
        
          quizzesObjLists.append(quiz6)
          quizzesObjLists.append(quiz7)
          quizzesObjLists.append(quiz8)
          quizzesObjLists.append(quiz9)
          quizzesObjLists.append(quiz10)
        
    }
        
    func getXcodeQuizz(){
        
        quizzesObjLists.append(quiz11)
        quizzesObjLists.append(quiz12)
        quizzesObjLists.append(quiz13)
        quizzesObjLists.append(quiz14)
        quizzesObjLists.append(quiz15)
        
    }*/
        
        
       //
    var technologySelected = ""
    var quizzesObjLists = [Quizz]()
    
    
    
            
    //UIB Outlets
    
    @IBOutlet weak var technologyPicker: UIPickerView!
    @IBOutlet weak var thecnologyLogo: UIImageView!
    
    @IBOutlet weak var technologyLabel: UILabel!
    
    @IBOutlet weak var quizzSelectionCollection: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Assing picker view delegates
        technologyPicker.dataSource = self
        technologyPicker.delegate = self
        
        //Asaing collection delegates
        quizzSelectionCollection.dataSource = self
        quizzSelectionCollection.delegate = self
        
        technologyLabel.text = "apple"
        technologySelected = "IOS"
        
        var databaseHelper = DBHelper()
        
        var f1 = databaseHelper.prepareDatabaseFile()
        print("Data base phat is :", f1)
       
    
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
            print("Can not open data base")
        }
        
        databaseHelper.fetchQuizessByTechnoilogy(technologyToFetch: "IOS")
        
        quizzesObjLists = databaseHelper.quizzesList
        
        print("List of IOS quizzes")
       // let quizzesIOS: [Quizz] =  quizzFilter(tech: "IOS")
        
    }
    
    func quizzFilter(tech: String){
        let quizz = quizzesObjLists.filter { a -> Bool in
            return a.technology == tech
        }
        
        print(quizz)
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
    
        technologyLabel.text = technologiesList[row]
        technologySelected = technologiesList[row]
       /* switch technologySelected{
         case "IOS":
             getIOSQuizz()
           //  return quizzesObjLists.count
         case "Swift":
             getSwiftQuizz()
           //  return quizzesObjLists.count
         case "xcode":
             getXcodeQuizz()
           //  return quizzesObjLists.count
         default:
             print(" ")
         }*/
        thecnologyLogo.image = UIImage(named: technologiesList[row])
    }
    

}

extension QuizzTechSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

  /*  fileprivate func extractedFunc(tech: String) -> [String] {
        switch tech {
        case "IOS":
           return getIOSQuizz()
        case "Swift":
          return  getSwiftQuizz()
        case "xcode":
           return  getXcodeQuizz()
        default:
            break
        }
        
        
    }*/
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        
        //this select switch if to get the count of the list of quizz selected
        
       /* switch technologySelected{
        case "IOS":
            getIOSQuizz()
            return quizzesObjLists.count
        case "Swift":
            getSwiftQuizz()
            return quizzesObjLists.count
        case "xcode":
            getXcodeQuizz()
            return quizzesObjLists.count
        default:
            return 1
        }*/
        
        return quizzesObjLists.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizzCell", for: indexPath) as! QuizzCollectionViewCell
        
        //Set id of the quiz and technology in the label text
        //cell.quizzIDLabel.text = quizzesList[indexPath.item]
        cell.quizzIDLabel.text = ("Quizz \(String(quizzesObjLists[indexPath.item].id))  \(quizzesObjLists[indexPath.item].technology)")
       
        
        //set tech logo
        
        let imageName = technologyLabel.text!
        print(imageName)
        cell.quizzCellImage.image = UIImage(named: "apple" )
        return cell
   }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("cell to select quizz tapped")
        
        if quizzAttemps < allowedQuizzAttempts {
        
        //Get a cell from the indext path
        let cell = collectionView.cellForItem(at: indexPath) as! QuizzCollectionViewCell
        
        //set the Quizz Id on the la
        }else{
            print("you dont have no more attemprs today")
        }
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        10
    }
    
    
}
