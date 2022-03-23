//
//  ViewController.swift
//  SpeechTextDemo
//
//  Created by admin on 3/4/22.
//

import UIKit
import Speech
import SQLite3


class FeedbackViewController: UIViewController {

    
    @IBOutlet weak var submitButtonOutlet: UIButton!
    @IBOutlet weak var feedbackButtonOutlet: UIButton!
    @IBOutlet weak var label: UILabel!
    let audioEng = AVAudioEngine()
    let speechR = SFSpeechRecognizer()
    let req = SFSpeechAudioBufferRecognitionRequest()
    var rTask : SFSpeechRecognitionTask!
    var isStart = false
    
    var SubmitButtonCount = 0
    var databaseHelper = DBHelper()
    var userLoggedIn = GlobalVariables.userLoguedIn
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let f1 = databaseHelper.prepareDatabaseFile()
         
        // print("Data base phat is :", f1)
        // var url = URL(string: f1)
         //Open the Data base or create it
     
         if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
             print("Can not open data base")
         }
    }

    func startSpeechRec(){
        let nd = audioEng.inputNode
        let recF = nd.outputFormat(forBus: 0)
        nd.installTap(onBus: 0, bufferSize: 1024, format: recF) { (buffer, _ ) in
            self.req.append(buffer)
        }
        
        audioEng.prepare()
        do {
            try audioEng.start()
        }
        catch let err {
            print(err)
        }
        
        rTask = speechR?.recognitionTask(with: req, resultHandler: { (resp , error) in
            
            guard let rsp = resp else{
                
                print(error.debugDescription)
                
                
                return
            }
            
            let msg = resp?.bestTranscription.formattedString
            self.label.text = msg!
            
            var str : String = ""
            for seg in resp!.bestTranscription.segments{
                let indexTo = msg!.index(msg!.startIndex, offsetBy: seg.substringRange.location)
                str = String(msg![indexTo...])
            }
            
            switch str{
            case "blue":
                self.view.backgroundColor = .blue
            case "yellow":
                self.view.backgroundColor = .yellow
            default:
                self.view.backgroundColor = .white
            }
            
        })
        
    }
    
    func cancelSpeechRec(){
        rTask.finish()
        rTask.cancel()
        rTask = nil
        req.endAudio()
        audioEng.stop()
        if audioEng.inputNode.numberOfInputs > 0 {
            audioEng.inputNode.removeTap(onBus: 0)
        }
        
    }
    
    
    
    
   
    @IBAction func StartFeedback(_ sender: UIButton) {
        isStart = !isStart
        if isStart {
            startSpeechRec()
            sender.setTitle("stop", for: .normal)
        }else{
            cancelSpeechRec()
            sender.setTitle("start", for: .normal)
        }
        
        
    }
    
    @IBAction func SubmitFeedback(_ sender: Any) {
        
        if SubmitButtonCount == 0 {
            
            let feedbackText = label.text!
            let id = userLoggedIn.id
            
            databaseHelper.addFeedback(feedback: feedbackText, userID: id )
            
            label.text = "Thank you for your Feedback!"
            submitButtonOutlet.setTitle("To Home", for: .normal)
            feedbackButtonOutlet.isHidden = true
            
        }else if SubmitButtonCount == 1 {
            
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                return
            }
            let HomeViewController = self.storyboard?.instantiateViewController(identifier: "Home Nav Controller") as? UINavigationController
            
            window.rootViewController = HomeViewController
            window.makeKeyAndVisible()
            
            UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            
        }
    }
}
