//
//  ViewController.swift
//  GuessTheFlag
//
//  Created by José Eduardo Pedron Tessele on 20/08/19.
//  Copyright © 2019 José P Tessele. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var guessText: UILabel!
    @IBOutlet var scoreText: UILabel!
    @IBOutlet var progressText: UILabel!
    var questionNumber = 0
    
    var contries = [String]()
    var score = 0
    var correctAnswer = 0
    var answerMessage = ""
    var MessageTitle = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil){
        contries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        button1.setImage(UIImage(named: contries[0]), for: .normal)
        button2.setImage(UIImage(named: contries[1]), for: .normal)
        button3.setImage(UIImage(named: contries[2]), for: .normal)
        
        title = "Guess The Flag"
        guessText.text = "The \(contries[correctAnswer].uppercased()) flag is"
        progressText.text = "Question: \(questionNumber + 1) / 10"
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        print("! \(questionNumber)")
        if questionNumber < 9 {
            if sender.tag == correctAnswer {
                MessageTitle = "Correct"
                score += 1
                answerMessage = "Continue"
            } else {
                MessageTitle = "Wrong"
                answerMessage = "That's the flag of \(contries[sender.tag])"
            }
            questionNumber += 1
            scoreText.text = "Score: \(score)"
            progressText.text = "Question: \(questionNumber) / 10"
            showAlert()
        } else {
            restartGame()
        }

    }
    
    
    func showAlert(){
            let ac = UIAlertController(title: MessageTitle, message: answerMessage, preferredStyle: .alert)
            
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            
            present(ac, animated: true)
    }
    
    func restartGame(){
        
        let ac = UIAlertController(title: MessageTitle, message: "\(answerMessage == "Continue" ?  " " : answerMessage) \n Your final score was \(score)", preferredStyle: .alert)
        
        ac.addAction(UIAlertAction(title: "Restart", style: .default, handler: nil))
        
        present(ac, animated: true)
        
        questionNumber = 0
        score = 0
        scoreText.text = "Score: \(score)"
        
        askQuestion()
    }
    
}

