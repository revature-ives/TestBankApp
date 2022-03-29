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
    //Outlet block for Buttons and label.
    @IBOutlet weak var submitButtonOutlet: UIButton!
    @IBOutlet weak var feedbackButtonOutlet: UIButton!
    @IBOutlet weak var label: UILabel!
    //Objects to hold references to various classes needed for the Feedback.
    let audioEng = AVAudioEngine()
    let speechR = SFSpeechRecognizer()
    let req = SFSpeechAudioBufferRecognitionRequest()
    var rTask : SFSpeechRecognitionTask!
    var isStart = false
    //Variable to hold the count of how many times the button is pressed.
    var SubmitButtonCount = 0
    //Object to hold the DBHelper class.
    var databaseHelper = DBHelper()
    //Global variable to get the user information.
    var userLoggedIn = GlobalVariables.userLoguedIn
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //Variable to hold the database path.
        let f1 = databaseHelper.prepareDatabaseFile()
        //sets the label to have nothing in it.
        label.text = ""
        //Open the Data base or create it
        if sqlite3_open(f1, &DBHelper.dataBase) != SQLITE_OK{
             print("Can not open data base")
         }
        //Styles the Buttons.
        Utilities.styleFilledButton(submitButtonOutlet)
        Utilities.styleFilledButton(feedbackButtonOutlet)
    }
    //Function to capture user voice and write to the Label.
    func startSpeechRec(){
        //Object to hold the input for the audioEngine.
        let nd = audioEng.inputNode
        let recF = nd.outputFormat(forBus: 0)
        nd.installTap(onBus: 0, bufferSize: 1024, format: recF) { (buffer, _ ) in
            self.req.append(buffer)
        }
        //Prepares the audio engine to read the voice.
        audioEng.prepare()
        do {
            try audioEng.start()
        }
        catch let err {
            print(err)
        }
        //speach recognition setup.
        rTask = speechR?.recognitionTask(with: req, resultHandler: { (resp , error) in
            guard let rsp = resp else{
                print(error.debugDescription)
                return
            }
            //Writes the information into the label.
            let msg = resp?.bestTranscription.formattedString
            self.label.text = msg!
       })
        
    }
    // Stops the speech rocognizer and audio engine.
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
   //Button to start the feedback
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
    //Button to submit the feedack to the database.
    @IBAction func SubmitFeedback(_ sender: Any) {
        //if statement to allow the button to change after you submit the feedback.
        if SubmitButtonCount == 0 {
            //Variable to hold the text from the lael and the user id.
            let feedbackText = label.text!
            let id = userLoggedIn.id
            //Insert the feedback into the feedback table.
            databaseHelper.addFeedback(feedback: feedbackText, userID: id )
            //Changes the label the button and hides the start/stop feedback button.
            label.text = "Thank you for your Feedback!"
            submitButtonOutlet.setTitle("To Home", for: .normal)
            feedbackButtonOutlet.isHidden = true
            //increments the count so the next time you hit the button it goes back to home.
            SubmitButtonCount += 1
        }else if SubmitButtonCount == 1 {
            //Transition to the Home Screen navigation controller.
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate, let window = sceneDelegate.window else {
                return
            }
            //holds the view to go to.
            let HomeViewController = self.storyboard?.instantiateViewController(identifier: "Home Nav Controller") as? UINavigationController
            //Actually does the transition.
            window.rootViewController = HomeViewController
            window.makeKeyAndVisible()
            //Transition information.
            UIView.transition(with: window, duration: 0.25, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
}
