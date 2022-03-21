//
//  QuizzTechSelectionViewController.swift
//  TestBankApp
//
//  Created by Ives Murillo on 3/19/22.
//

import UIKit

class QuizzTechSelectionViewController: UIViewController {
    
    
    let technologiesList = ["IOS","Swift","X-code"]
    
    let quizzesList = ["quizz1","quizz2","quizz3","quizz4","quizz5","quizz6","quizz7","quizz8"]
    
    
    
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
        thecnologyLogo.image = UIImage(named: technologiesList[row])
    }
    

}

extension QuizzTechSelectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        quizzesList.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //create cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "quizzCell", for: indexPath) as! QuizzCollectionViewCell
        
        //set id of the quiz
        cell.quizzIDLabel.text = quizzesList[indexPath.item]
        //set tech logo
        
        let imageName = technologyLabel.text!
        print(imageName)
        cell.quizzCellImage.image = UIImage(named: imageName )
        return cell
   }
    

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("cell to select quizz tapped")
        
        //Get a cell from the indext path
        let cell = collectionView.cellForItem(at: indexPath) as! QuizzCollectionViewCell
        
        //set the Quizz Id on the la
        
    }
    
    
}
